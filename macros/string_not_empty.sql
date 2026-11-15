/* This is a generic test set up for checking empty string value */
{% test string_not_empty(model, column_name) %}
    select {{ column_name }}
    from {{ model }}
    where TRIM({{ column_name }}) = '' 
{% endtest %}