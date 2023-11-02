{{ config(materialized='incremental',
views_enabled=false

 ) }}


select *,
current_timestamp(6) as ingestion_datetime
  from {{ source('sales', 'sale') }}


{% if is_incremental() %}
  where date_sale > (select max(date_sale) from {{ this }})
{% endif %}


