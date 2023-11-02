{{ config(materialized='table',
    on_table_exists='drop'
) }}

SELECT
  product_id,
  SUM(amount) as total_sales
FROM
  {{ ref('sale') }}
GROUP BY
  product_id
ORDER BY
  product_id DESC