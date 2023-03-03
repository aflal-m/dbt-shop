{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "p_stg_customer_order"
src_pk: "CUSTOMER_HK"
src_hashdiff: 
  source_column: "CUSTOMER_HASHDIFF"
  alias: "HASHDIFF"
src_payload:
  - "CUSTOMER_NAME"
  - "SEGMENT"
src_ldts: "LOAD_DTS"
src_source: "SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}
