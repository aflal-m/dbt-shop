{{ config(
    materialized = 'view'
) }}

{%- set yaml_metadata -%}

source_model: 'r_stg_customer_order' 
derived_columns: 
  SOURCE: "!snowflake"
  LOAD_DTS: "ORDER_DATE"
hashed_columns:
  CUSTOMER_HK: "CUSTOMER_ID"
  ORDER_HK: "ORDER_ID"
  CUSTOMER_ORDER_HK:
    - "CUSTOMER_ID"
    - "ORDER_ID"
  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
        - "CUSTOMER_ID"
        - "ORDER_DATE"
        - "SHIP_DATE"
        - "SHIP_MODE"
        - "QUANTITY"
        - "DISCOUNT"
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
        - "CUSTOMER_NAME"
        - "SEGMENT"
        - "SOURCE"
        - "LOAD_DTS"
  PRODUCT_HASHDIFF:
    is_hashdiff: true
    columns:
        - "PRODUCT_ID"
        - "PRODUCT_NAME"
        - "CATEGORY"
        - "SUB_CATEGORY"
  ADDRESS_HASHDIFF:
    is_hashdiff: true
    columns:
        - "CITY"
        - "COUNTRY"
        - "STATE"
        - "REGION"
        - "POSTAL_CODE"


{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(
    include_source_columns = true,
    source_model = metadata_dict ['source_model'],
    derived_columns = metadata_dict ['derived_columns'],
    null_columns = none,
    hashed_columns = metadata_dict ['hashed_columns'],
    ranked_columns = none
) }}
