{{
  config(
    materialized = 'view',
    schema = 'fhir_base',
    database ='staging'
    )
}}
with source as (
        select * from {{ source('fhir', 'patient') }}
  ),
  renamed as (
      select
        {{ adapter.quote("resourceType") }},
        {{ adapter.quote("id") }},
        {{ adapter.quote("meta") }}.profile as meta_profile,
        {{ adapter.quote("text") }}.status as text_status,
        {{ adapter.quote("text") }}.div as text_div
        {{ adapter.quote("extension") }},
        {{ adapter.quote("identifier") }},
        {{ adapter.quote("name") }},
        {{ adapter.quote("telecom") }},
        {{ adapter.quote("gender") }},
        {{ adapter.quote("birthDate") }},
        {{ adapter.quote("address") }},
        {{ adapter.quote("maritalStatus") }}.coding as maritalStatus_coding,
        {{ adapter.quote("maritalStatus") }}.text as maritalStatus_text,
        {{ adapter.quote("multipleBirthBoolean") }},
        {{ adapter.quote("communication") }},
        {{ adapter.quote("deceasedDateTime") }},
        {{ adapter.quote("multipleBirthInteger") }},
        {{ adapter.quote("_rescued_data") }}

      from source
  )
  select * from renamed
    