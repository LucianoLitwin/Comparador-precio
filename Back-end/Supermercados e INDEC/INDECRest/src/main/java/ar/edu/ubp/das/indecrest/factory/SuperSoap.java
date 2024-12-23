package ar.edu.ubp.das.indecrest.factory;

import ar.edu.ubp.das.indecrest.beans.InfoSucursalesBean;
import ar.edu.ubp.das.indecrest.beans.PrecioBatchBean;
import ar.edu.ubp.das.indecrest.beans.ProductoBean;
import ar.edu.ubp.das.indecrest.utils.SOAPClient;
import com.google.gson.Gson;

import java.util.List;
import java.util.Map;

public class SuperSoap implements Super {
    private final String wsdlUrl;
    private SOAPClient client;
    private final int nroSuper;
    private final OperationType operation;
    private final String usuario;
    private final String clave;

    public SuperSoap(String wsdlUrl, int nroSuper, OperationType operation, String usuario, String clave) {
        this.wsdlUrl = wsdlUrl;
        this.nroSuper = nroSuper;
        this.operation = operation;
        this.usuario = usuario;
        this.clave = clave;
        initClient();
    }

    private void initClient() {
        this.client = new SOAPClient.SOAPClientBuilder()
                .wsdlUrl(wsdlUrl)
                .namespace("http://services.supersoap2.das.ubp.edu.ar/")
                .serviceName("SuperSoapWSPortService")
                .portName("SuperSoapWSPortSoap11")
                .operationName(operation.getOperationName())
                .username(usuario)
                .password(clave)
                .build();
    }

    @Override
    public int getNroSuper() {
        return nroSuper;
    }

    @Override
    public List<PrecioBatchBean> getPreciosProductos(List<ProductoBean> json) {
        Map<String, Object> params = Map.of("json", new Gson().toJson(json));
        return client.callServiceForList(PrecioBatchBean.class, "ObtenerPreciosResponse", params);
    }

    @Override
    public List<InfoSucursalesBean> getSucursales() {
        return client.callServiceForList(InfoSucursalesBean.class, "ObtenerSucursalesResponse");
    }
}

