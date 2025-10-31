{{
  config(
    materialized = 'table',
    schema = 'transformed',
    database = 'intermediate',
    alias = 'patient'
    )
}}
SELECT
 id as PatientID
,name_family as LastName
,name_given as FirstName
,gender 
FROM {{ ref('int_patient_explode') }}