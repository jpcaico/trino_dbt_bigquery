# Using trino-dbt as a data ingestion tool
This repo tries to ingest data to bigquery using `dbt-trino`. Data is captured from a `postgresql` database with incremental loading strategy and loaded into bigquery.

After that, you can proceed with the ETL using the same `trino` connector for dbt or use a different `bigquery` connector. Trino has some limitations such as not being able to create views. 

:point_down: :point_down: :point_down: :point_down: :point_down:
> I wrote a complete explanation blog post on Medium. Click [here]() for accessing.

:point_up: :point_up: :point_up: :point_up: :point_up:
### Configuring Trino and Postgres

1. Inside `docker/catalog` create your `.properties` files. For this example we are connecting to `postgresql` and `bigquery`

2. Run `docker-compose up -d` to start local `postgres` and `trino`. Postgresql is populated with scripts in `sql` folder.

3. For more details on trino config access [here](https://docs.starburst.io/blog_dbt/2022-11-30-dbt1-trino-setup.html).

4. For more details on postgres config and code access [here] (https://levelup.gitconnected.com/creating-and-filling-a-postgres-db-with-docker-compose-e1607f6f882f)

### Configuring dbt

1. After initiating the project, make sure:


`psql -h localhost -U postgres -d postgres -p 15432`

```

-- Insert 3 records into the `sale` table 
INSERT INTO sale (sale_id, amount, date_sale, product_id, user_id, store_id)
VALUES
    (gen_random_uuid(), 600.25, NOW(), 5, 10, 2),
    (gen_random_uuid(), 850.50, NOW(), 3, 7, 1),
    (gen_random_uuid(), 425.75, NOW(), 2, 5, 3);

-- Insert 3 records into the `order_status` table 
INSERT INTO order_status (order_status_id, update_at, sale_id, status_name_id)
VALUES
    (gen_random_uuid(), NOW(), (SELECT sale_id FROM sale WHERE amount = 600.25), 1),
    (gen_random_uuid(), NOW(), (SELECT sale_id FROM sale WHERE amount = 850.50), 2),
    (gen_random_uuid(), NOW(), (SELECT sale_id FROM sale WHERE amount = 425.75), 3);



```

connector does not support creating views

-- {{ config(materialized='table',
--     on_table_exists='drop'
-- ) }}