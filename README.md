Order Management System (OMS) Analytics Pipeline


An end to end ELT pipeline built with dbt core(v2) and Snowflake to transform raw operational data into centralised, audit-ready commercial layers.


Architechture

 L1 (Landing): Raw ingestion of data into Snowflake
 
 L2 (Processing): Cleaned, modular staging views for formatting
 
 L3 (Consumption): Centralised financial performance and regional sales tables for business decisions


Tech Stack

 Infrastructure: Snowflake Data Warehouse + dbtcore(v2)
 
 Language: SQL & Jinja


Automated Testing

  Macros: string_not_empty
  
  Threshold Validation: record_count_check
