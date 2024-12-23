package ar.edu.ubp.das.supersoap2.endpoints;
import ar.edu.ubp.das.supersoap2.beans.*;
import ar.edu.ubp.das.supersoap2.services.SuperSoapWS;
import ar.edu.ubp.das.supersoap2.services.jaxws.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;
import java.util.List;

@Endpoint
public class SuperSoapEndpoint {
    private static final String NAMESPACE_URI = "http://services.supersoap2.das.ubp.edu.ar/";

    @Autowired
    private SuperSoapWS soapService;


    @PayloadRoot(namespace = NAMESPACE_URI, localPart = "ObtenerSucursalesRequest")
    @ResponsePayload
    public ObtenerSucursalesResponse obtenerSucursales() {
        List<InfoSucursalesBean> sucursales = soapService.obtenerSucursales();
        ObtenerSucursalesResponse response = new ObtenerSucursalesResponse();
        response.setSucursalesResponse(sucursales);
        return response;
    }

    @PayloadRoot(namespace = NAMESPACE_URI, localPart = "ObtenerPreciosRequest")
    @ResponsePayload
    public ObtenerPreciosResponse obtenerPrecios(@RequestPayload ObtenerPrecios request) {
        String json = request.getJson();
        List<PreciosProductosBean> precios = soapService.obtenerPrecios(json);
        ObtenerPreciosResponse response = new ObtenerPreciosResponse();
        response.setPreciosResponse(precios);
        return response;
    }

}