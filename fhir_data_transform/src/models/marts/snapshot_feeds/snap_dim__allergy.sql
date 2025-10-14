SELECT 
    code as AllergyCode
    ,code_display as AllergyDisplay
    ,code_text as AllergyText
FROM {{ ref('int_allergyintolerance_final') }}