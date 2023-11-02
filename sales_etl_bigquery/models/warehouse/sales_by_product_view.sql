{{ config(materialized='view'
) }}

SELECT
  product_id,
  SUM(amount) as total_sales
FROM
  {{ source('sales', 'sale') }}
GROUP BY
  product_id
ORDER BY
  product_id DESC