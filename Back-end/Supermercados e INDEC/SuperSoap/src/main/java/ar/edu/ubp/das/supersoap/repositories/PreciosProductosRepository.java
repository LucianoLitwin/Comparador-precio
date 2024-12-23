package ar.edu.ubp.das.supersoap.repositories;

import ar.edu.ubp.das.supersoap.beans.PreciosProductosBean;
import ar.edu.ubp.das.supersoap.components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class PreciosProductosRepository {

    @Autowired
    private SimpleJdbcCallFactory jdbcCallFactory;

    public List<PreciosProductosBean> getPrecios(String json) {
        SqlParameterSource params = new MapSqlParameterSource().addValue("json",json);
        return jdbcCallFactory.executeQuery(
                "ObtenerPreciosProductos",
                "dbo",
                params,
                "PreciosProductosRequest",
                PreciosProductosBean.class
        );
    }
}