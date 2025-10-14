SELECT DISTINCT
reaction_manifestation_code
,reaction_manifestation_display
,reaction_manifestation_text
FROM {{ ref('int_allergyintolerance_final') }}