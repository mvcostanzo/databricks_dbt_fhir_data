SELECT DISTINCT
    {{dbt_utils.generate_surrogate_key(['category'])}} as AllergyCategoryID,
    category as AllergyCategory
FROM {{ ref('int_allergyintolerance_final') }}