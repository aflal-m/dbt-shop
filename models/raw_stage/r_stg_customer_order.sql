{{ config(
  materialized = 'table'
) }}

WITH customers AS (

  SELECT
    *
  FROM
    assembly_dev.dbt_sj_pc.test_customers
),
orders AS (
  SELECT
    *
  FROM
    assembly_dev.dbt_sj_pc.test_orders
)
SELECT
  *
FROM
  customers
  JOIN orders USING(CUSTOMER_ID)
