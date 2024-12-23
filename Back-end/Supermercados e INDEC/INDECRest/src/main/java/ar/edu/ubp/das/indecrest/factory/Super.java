package ar.edu.ubp.das.indecrest.factory;

import ar.edu.ubp.das.indecrest.beans.InfoSucursalesBean;
import ar.edu.ubp.das.indecrest.beans.PrecioBatchBean;
import ar.edu.ubp.das.indecrest.beans.ProductoBean;

import java.util.List;

public interface Super {
    int getNroSuper();
    List<InfoSucursalesBean> getSucursales();
    List<PrecioBatchBean> getPreciosProductos(List<ProductoBean> criteria);
}

