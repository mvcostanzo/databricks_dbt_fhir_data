{{
  config(
    materialized = 'ephemeral',
    schema = '1_expanded',
    database = 'intermediate'
    )
}}
WITH expansion AS (
  select
    resourcetype
    ,id
    ,explode(meta_profile) as meta_profile
    ,explode(clinicalStatus_coding.system) as clinicalStatus_coding_system
    ,explode(clinicalStatus_coding.code) as clinicalStatus_coding_code
    ,explode(verificationStatus_coding.system) as verificationStatus_coding_system
    ,explode(verificationStatus_coding.code) as verificationStatus_coding_code
    ,type
    ,explode(category) as category
    ,criticality
    ,explode(code_coding.system) as code_coding_system
    ,explode(code_coding.code) as code_coding_code
    ,explode(code_coding.display) as code_coding_display
    ,text
    ,patient_reference
    ,recordeddate
    ,explode(reaction.manifestation) as reaction_manifestation
    ,explode(reaction.severity) as reaction_severity
  from {{ ref('stg_fhir__allergyintolerance') }},
  LATERAL explode(clinicalStatus_coding) clinicalStatus_coding,
  LATERAL explode(verificationStatus_coding) verificationStatus_coding,
  LATERAL explode(code_coding) code_coding,
  LATERAL explode(reaction) reaction
)
SELECT
  resourcetype
  ,id AS allergyintolerance_id
  ,meta_profile
  ,clinicalStatus_coding_system
  ,clinicalStatus_coding_code
  ,verificationStatus_coding_code
  ,verificationStatus_coding_system
  ,type
  ,category
  ,criticality
  ,code_coding_system
  ,code_coding_code
  ,code_coding_display
  ,expansion.text as text
  ,patient_reference
  ,recordeddate
  ,reaction_manifestation_inline_coding.system  as reaction_manifestation_inline_coding_system
  ,reaction_manifestation_inline_coding.code as reaction_manifestation_inline_coding_code
  ,reaction_manifestation_inline_coding.display  as reaction_manifestation_inline_coding_display
  ,reaction_manifestation_inline.text as reaction_manifestation_text
  ,reaction_severity
FROM expansion,
LATERAL inline(reaction_manifestation) reaction_manifestation_inline, 
LATERAL inline(reaction_manifestation_inline.coding) reaction_manifestation_inline_coding