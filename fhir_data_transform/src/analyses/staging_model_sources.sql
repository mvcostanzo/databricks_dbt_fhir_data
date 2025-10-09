{{ codegen.generate_source(
    schema_name= 'fhir',
    database_name= 'staging',
    generate_columns= 'true',
    include_data_types = 'true',
    exclude = '__mat'
    ) 
}}