{{
  config(
    materialized = 'table',
    schema = 'transformed',
    database = 'intermediate',
    alias = 'allergyintolerance'
    )
}}
SELECT * 
FROM {{ ref('int_allergyintolerance_conform') }}