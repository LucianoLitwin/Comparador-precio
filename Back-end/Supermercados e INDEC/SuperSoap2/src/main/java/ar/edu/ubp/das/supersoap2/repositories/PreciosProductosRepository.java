package ar.edu.ubp.das.supersoap2.repositories;

import ar.edu.ubp.das.supersoap2.beans.InfoSucursalesBean;
import ar.edu.ubp.das.supersoap2.beans.PreciosProductosBean;
import ar.edu.ubp.das.supersoap2.components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.awt.*;

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