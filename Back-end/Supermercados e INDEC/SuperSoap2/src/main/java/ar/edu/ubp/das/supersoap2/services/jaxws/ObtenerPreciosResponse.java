
package ar.edu.ubp.das.supersoap2.services.jaxws;

import java.util.List;
import ar.edu.ubp.das.supersoap2.beans.PreciosProductosBean;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlType;

@XmlRootElement(name = "ObtenerPreciosResponse", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ObtenerPreciosResponse", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
public class ObtenerPreciosResponse {

    @XmlElement(name = "PreciosResponse", namespace = "")
    private List<PreciosProductosBean> preciosResponse;

    /**
     * 
     * @return
     *     returns List<PreciosProductosBean>
     */
    public List<PreciosProductosBean> getPreciosResponse() {
        return this.preciosResponse;
    }

    /**
     * 
     * @param preciosResponse
     *     the value for the preciosResponse property
     */
    public void setPreciosResponse(List<PreciosProductosBean> preciosResponse) {
        this.preciosResponse = preciosResponse;
    }

}
