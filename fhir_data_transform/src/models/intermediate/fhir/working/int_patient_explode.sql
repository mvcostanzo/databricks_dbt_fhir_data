{{
  config(
    materialized = 'ephemeral',
    schema = '1_expanded',
    database = 'intermediate'
    )
}}
select
    resourceType
    ,id
    ,explode(meta_profile) as meta_profile
    ,text_status
    ,text_div
    ,extension_inline.url as extension_url
    ,extension_inline.valueString as extension_valueString
    ,extension_inline.ValueCode as extension_valueCode
    ,extension_inline.ValueDecimal as extension_valueDecimal
    ,extension_inline.valueAddress.city as extension_valueAddress_city
    ,ext_inline_2.url as ext2_url
    ,ext_inline_2.valuestring as ext2_valueString
    ,name_inline.use as name_use
    ,name_inline.family as name_family
    ,explode(name_inline.given) as name_given
    ,gender
    ,birthDate
    ,maritalStatus_text
    ,multipleBirthBoolean
    ,comm_inline.text as communcation_text
    ,comm_coding.system as communication_coding_system
from {{ ref('stg_fhir__patient') }},
LATERAL inline (extension) extension_inline,
LATERAL inline (extension_inline.extension) ext_inline_2,
LATERAL inline (name) name_inline,
LATERAL inline (communication.language) comm_inline,
LATERAL inline (comm_inline.coding) comm_coding
