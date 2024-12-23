package ar.edu.ubp.das.supersoap.repositories;

import ar.edu.ubp.das.supersoap.beans.InfoSucursalesBean;
import ar.edu.ubp.das.supersoap.components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class InfoSucursalesRepository {
    @Autowired
    private SimpleJdbcCallFactory jdbcCallFactory;
    public List<InfoSucursalesBean> getSucursales() {
        return jdbcCallFactory.executeQuery(
                "ObtenerInformacionSucursales",
                "dbo",
                "ObtenerSucursalesRequest",
                InfoSucursalesBean.class);
    }
}
