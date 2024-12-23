package ar.edu.ubp.das.superrest.Repository;

import ar.edu.ubp.das.superrest.Beans.InfoSucursalesBean;
import ar.edu.ubp.das.superrest.Components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.awt.*;

@Repository//LISTO
public class InfoSucursalesRepository {

    @Autowired
    private SimpleJdbcCallFactory jdbcCallFactory;

    public List<InfoSucursalesBean> getSucursales() {
        return jdbcCallFactory.executeQuery(
                "ObtenerInformacionSucursales",
                "dbo",
                "InfoSucursalesRequest",
                InfoSucursalesBean.class
        );
    }


}
