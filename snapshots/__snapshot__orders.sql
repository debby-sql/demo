{% snapshot __snapshot__orders %}
    {{
        config(
          unique_key='order_id',
          strategy='timestamp',
          updated_at='order_date',
          target_schema="snapshots"
        )
    }}
    
    select * from {{ ref('orders') }}
{% endsnapshot %}