{{ config(
    materialized = "incremental"
) }}

{%- set yaml_metadata -%}

source_model: 'p_stg_customer_order' 
src_pk: CUSTOMER_ORDER_HK 
src_fk:
    - CUSTOMER_HK
    - ORDER_HK
src_ldts: LOAD_DTS 
src_source: SOURCE 

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.link(
    src_pk = metadata_dict['src_pk'],
    src_fk = metadata_dict['src_fk'],
    src_ldts = metadata_dict['src_ldts'],
    src_source = metadata_dict['src_source'],
    source_model = metadata_dict['source_model']
) }}
