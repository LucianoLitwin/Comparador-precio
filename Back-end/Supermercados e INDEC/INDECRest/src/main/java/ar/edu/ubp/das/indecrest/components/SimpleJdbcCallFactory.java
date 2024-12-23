package ar.edu.ubp.das.indecrest.components;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.ColumnMapRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;

import java.sql.Types;
import java.util.List;
import java.util.Map;

@Component
public class SimpleJdbcCallFactory {

    @Autowired
    private JdbcTemplate jdbcTpl;

    public <T> Map<String, Object> executeQueryWithOutputs(String procedureName, String schemaName, SqlParameterSource params, String resultSetName, Class<T> mappedClass) {
        SimpleJdbcCall jdbcCall = createCall(procedureName, schemaName)
                .returningResultSet(resultSetName, BeanPropertyRowMapper.newInstance(mappedClass));
        return jdbcCall.execute(params);
    }

    public <T> List<T> executeQuery(String procedureName, String schemaName, SqlParameterSource params, String resultSetName, Class<T> mappedClass) {
        Map<String, Object> out = executeQueryWithOutputs(procedureName, schemaName, params, resultSetName, mappedClass);
        return (List<T>) out.get(resultSetName);
    }

    public <T> List<T> executeQuery(String procedureName, String schemaName, String resultSetName, Class<T> mappedClass) {
        return executeQuery(procedureName, schemaName, new MapSqlParameterSource(), resultSetName, mappedClass);
    }

    public <T> Map<String, Object> executeWithOutputs(String procedureName, String schemaName, SqlParameterSource params) {
        SimpleJdbcCall jdbcCall = createCall(procedureName, schemaName);
        return jdbcCall.execute(params);
    }

    public void execute(String procedureName, String schemaName, SqlParameterSource params) {
        executeWithOutputs(procedureName, schemaName, params);
    }

    public void execute(String procedureName, String schemaName) {
        execute(procedureName, schemaName, new MapSqlParameterSource());
    }

    private SimpleJdbcCall createCall(String procedureName, String schemaName) {
        return new SimpleJdbcCall(jdbcTpl)
                .withProcedureName(procedureName)
                .withSchemaName(schemaName);
    }

    public List<Map<String, Object>> executeQueryWithResulset(String procedureName, String schemaName, SqlParameterSource params, String resultSetName) {
        SimpleJdbcCall jdbcCall = createCall(procedureName, schemaName)
                .returningResultSet(resultSetName, new ColumnMapRowMapper());
        Map<String, Object> out = jdbcCall.execute(params);
        return (List<Map<String, Object>>) out.get(resultSetName);
    }


    public Map<String, Object> executeQueryWithMultipleOutputs(
            String procedureName,
            String schemaName,
            SqlParameterSource params,
            String resultSetName,
            String outputName,
            Class<?> mappedClass) {
        SimpleJdbcCall jdbcCall = createCall(procedureName, schemaName)
                .returningResultSet(resultSetName, new BeanPropertyRowMapper<>(mappedClass))
                .declareParameters(
                        new SqlParameter(outputName, Types.INTEGER)
                );

        // Ejecuta el procedimiento almacenado y obtiene el resultado como un Map
        Map<String, Object> results = jdbcCall.execute(params);
        System.out.println("results: " + results);

        // Verifica si hay resultados de salida para el TotalCount
        if (!results.containsKey(outputName)) {
            // Lógica de manejo en caso de que no se reciba el TotalCount
            System.out.println("TotalCount no encontrado en los resultados");
        }
        return results;
    }

}
