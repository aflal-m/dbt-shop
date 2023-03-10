{{ config(
    materialized = "incremental"
) }}

{%- set yaml_metadata -%}

source_model: 'p_stg_customer_order' 
src_pk: CUSTOMER_HK 
src_nk: CUSTOMER_ID 
src_ldts: LOAD_DTS 
src_source: SOURCE 

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.hub(
    src_pk = metadata_dict ["src_pk"],
    src_nk = metadata_dict ["src_nk"],
    src_ldts = metadata_dict ["src_ldts"],
    src_source = metadata_dict ["src_source"],
    source_model = metadata_dict ["source_model"]
) }}
