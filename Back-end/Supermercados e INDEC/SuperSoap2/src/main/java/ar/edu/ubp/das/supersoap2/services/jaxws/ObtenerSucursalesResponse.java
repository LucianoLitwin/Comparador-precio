
package ar.edu.ubp.das.supersoap2.services.jaxws;

import java.util.List;
import ar.edu.ubp.das.supersoap2.beans.InfoSucursalesBean;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlType;

@XmlRootElement(name = "ObtenerSucursalesResponse", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ObtenerSucursalesResponse", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
public class ObtenerSucursalesResponse {

    @XmlElement(name = "SucursalesResponse", namespace = "")
    private List<InfoSucursalesBean> sucursalesResponse;

    /**
     * 
     * @return
     *     returns List<InfoSucursalesBean>
     */
    public List<InfoSucursalesBean> getSucursalesResponse() {
        return this.sucursalesResponse;
    }

    /**
     * 
     * @param sucursalesResponse
     *     the value for the sucursalesResponse property
     */
    public void setSucursalesResponse(List<InfoSucursalesBean> sucursalesResponse) {
        this.sucursalesResponse = sucursalesResponse;
    }

}
