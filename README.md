# trino_dbt_bigquery


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