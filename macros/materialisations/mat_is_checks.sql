{%- macro is_any_incremental() -%}
    {%- ifdbtvault_scalefree.is_vault_insert_by_period() ordbtvault_scalefree.is_vault_insert_by_rank() ordbtvault_scalefree.is_pit_incremental() ordbtvault_scalefree.is_bridge_incremental() or is_incremental() -%}
        {%- do return(true) -%}
    {%- else -%}
        {%- do return(false) -%}
    {%- endif -%}
{%- endmacro -%}



{% macro is_vault_insert_by_period() %}
    {% if not execute %}
        {{ return(False) }}
    {% else %}
        {% set relation = adapter.get_relation(this.database, this.schema, this.table) %}

            {{ return(relation is not none
                      and relation.type == 'table'
                      and model.config.materialized == 'vault_insert_by_period'
                      and not flags.FULL_REFRESH) }}
    {% endif %}
{% endmacro %}



{% macro is_vault_insert_by_rank() %}
    {#-- do not run introspective queries in parsing #}
    {% if not execute %}
        {{ return(False) }}
    {% else %}
        {% set relation = adapter.get_relation(this.database, this.schema, this.table) %}

            {{ return(relation is not none
                      and relation.type == 'table'
                      and model.config.materialized == 'vault_insert_by_rank'
                      and not flags.FULL_REFRESH) }}
    {% endif %}
{% endmacro %}



{% macro is_bridge_incremental() %}
    {#-- do not run introspective queries in parsing #}
    {% if not execute %}
        {{ return(False) }}
    {% else %}
        {% set relation = adapter.get_relation(this.database, this.schema, this.table) %}

            {{ return(relation is not none
                      and relation.type == 'table'
                      and model.config.materialized == 'bridge_incremental'
                      and not flags.FULL_REFRESH) }}
    {% endif %}
{% endmacro %}



{% macro is_pit_incremental() %}
    {#-- do not run introspective queries in parsing #}
    {% if not execute %}
        {{ return(False) }}
    {% else %}
        {% set relation = adapter.get_relation(this.database, this.schema, this.table) %}

            {{ return(relation is not none
                      and relation.type == 'table'
                      and model.config.materialized == 'pit_incremental'
                      and not flags.FULL_REFRESH) }}
    {% endif %}
{% endmacro %}