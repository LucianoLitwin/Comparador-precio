
package ar.edu.ubp.das.supersoap.services.jaxws;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlType;

@XmlRootElement(name = "ObtenerPreciosRequest", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ObtenerPreciosRequest", namespace = "http://services.supersoap2.das.ubp.edu.ar/")
public class ObtenerPrecios {

    @XmlElement(name = "json", namespace = "")
    private String json;

    /**
     * 
     * @return
     *     returns String
     */
    public String getJson() {
        return this.json;
    }

    /**
     * 
     * @param json
     *     the value for the json property
     */
    public void setJson(String json) {
        this.json = json;
    }

}
