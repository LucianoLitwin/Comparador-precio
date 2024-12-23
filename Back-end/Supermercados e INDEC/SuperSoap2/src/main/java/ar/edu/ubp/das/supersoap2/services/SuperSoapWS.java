package ar.edu.ubp.das.supersoap2.services;
import ar.edu.ubp.das.supersoap2.repositories.InfoSucursalesRepository;
import ar.edu.ubp.das.supersoap2.beans.InfoSucursalesBean;
import ar.edu.ubp.das.supersoap2.beans.PreciosProductosBean;
import ar.edu.ubp.das.supersoap2.repositories.PreciosProductosRepository;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebResult;
import jakarta.jws.WebService;
import jakarta.xml.ws.RequestWrapper;
import jakarta.xml.ws.ResponseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@WebService(serviceName = "SuperSoapWS", targetNamespace = "http://services.supersoap2.das.ubp.edu.ar/")
public class SuperSoapWS {

    @Autowired
    private InfoSucursalesRepository infoSucursalesRepository;

    @WebMethod(operationName = "ObtenerSucursales")
    @RequestWrapper(localName = "ObtenerSucursalesRequest")
    @ResponseWrapper(localName = "ObtenerSucursalesResponse")
    @WebResult(name = "SucursalesResponse")
    public List<InfoSucursalesBean> obtenerSucursales() {
        return infoSucursalesRepository.getSucursales();
    }

    @Autowired
    private PreciosProductosRepository preciosProductosRepository;

    @WebMethod(operationName = "ObtenerPrecios")
    @RequestWrapper(localName = "ObtenerPreciosRequest")
    @ResponseWrapper(localName = "ObtenerPreciosResponse")
    @WebResult(name = "PreciosResponse")
    public List<PreciosProductosBean> obtenerPrecios(@WebParam(name = "json")String json) {
        return preciosProductosRepository.getPrecios(json);
    }

}

