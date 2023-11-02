{{ config(
    materialized='incremental',
    views_enabled=false
) }}

select so.*,
current_timestamp(6) as ingestion_datetime
from {{ source('sales', 'order_status') }} so

{% if is_incremental() %}
    where so.update_at > (select max(so.update_at) from {{ this }})
{% endif %}



