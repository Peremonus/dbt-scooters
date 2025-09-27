{% macro escape_reserved_words(column_name) %}
    {% set reserved_words = ['group', 'order', 'select', 'where', 'from'] %}
    {% if column_name.lower() in reserved_words %}
        "\"{{ column_name }}\""
    {% else %}
        "{{ column_name }}"
    {% endif %}
{% endmacro %}