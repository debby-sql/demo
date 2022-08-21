use role useradmin;

create user demo with password='TOPSECRET';
create role if not exists demo_transformer;
create role if not exists demo_transformer_prod;
grant role demo_transformer to user demo;
grant role demo_transformer_prod to user demo;

use role sysadmin;

create database demo;
create schema demo.prod;
create schema demo.dev;
grant usage on database demo to role demo_transformer;
grant usage on database demo to role demo_transformer_prod;
grant ownership on schema demo.prod to role demo_transformer_prod;
grant ownership on schema demo.dev to role demo_transformer;

create or replace warehouse demo with 
    AUTO_SUSPEND=60
    STATEMENT_TIMEOUT_IN_SECONDS=60
    WAREHOUSE_SIZE='XSmall'
;

grant usage on warehouse demo to role demo_transformer;
grant monitor on warehouse demo to role demo_transformer;
grant usage on warehouse demo to role demo_transformer_prod;
grant monitor on warehouse demo to role demo_transformer_prod;

use role accountadmin;
grant imported privileges on database snowflake to role demo_transformer;
grant imported privileges on database snowflake to role demo_transformer_prod;
