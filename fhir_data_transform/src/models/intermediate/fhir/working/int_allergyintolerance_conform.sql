{{
  config(
    materialized = 'ephemeral',
    schema = '2_conformed',
    database = 'intermediate',
    tblproperties = {
       'delta.enableDeletionVectors': 'true',
       'delta.enableRowTracking' : 'true',
       'delta.enableChangeDataFeed' : 'true'
    }
  )
}}
SELECT DISTINCT
  allergyintolerance_id
  ,clinicalStatus_coding_code as clinicalStatus
  ,verificationStatus_coding_code as verificationStatus
  ,type
  ,category
  ,criticality
  ,code_coding_code as code
  ,code_coding_display as code_display
  ,text as code_text
  ,substring(patient_reference, 9) as patient_id
  ,recordeddate
  ,reaction_manifestation_inline_coding_code as reaction_manifestation_code 
  ,reaction_manifestation_inline_coding_display as reaction_manifestation_display
  ,reaction_manifestation_text
  ,reaction_severity
FROM {{ ref('int_allergyintolerance_explode') }}