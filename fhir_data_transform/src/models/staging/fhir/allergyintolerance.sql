{{
  config(
    materialized = 'view',
    schema = 'fhir_base',
    database ='staging'
    )
}}
with source as (
        select * from {{ source('fhir', 'allergyintolerance') }}
  ),
  renamed as (
      select
          resourcetype
          ,id
          ,meta.profile as meta_profile
          ,clinicalStatus.coding as clinicalStatus_coding
          ,verificationStatus.coding as verificationStatus_coding
          ,type
          ,category
          ,criticality
          ,code.coding as code_coding
          ,code.text
          ,patient.reference as patient_reference
          ,recordeddate
          ,reaction
      from source
  )
  select * from renamed
    