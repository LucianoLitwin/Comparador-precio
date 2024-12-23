package ar.edu.ubp.das.superrest2.Repository;

import ar.edu.ubp.das.superrest2.Beans.InfoSucursalesBean;
import ar.edu.ubp.das.superrest2.Components.SimpleJdbcCallFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

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
