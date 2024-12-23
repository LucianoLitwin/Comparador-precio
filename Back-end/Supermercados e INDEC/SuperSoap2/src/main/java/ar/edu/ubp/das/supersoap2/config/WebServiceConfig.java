package ar.edu.ubp.das.supersoap2.config;

import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.ws.config.annotation.EnableWs;
import org.springframework.ws.soap.SoapVersion;
import org.springframework.ws.soap.saaj.SaajSoapMessageFactory;
import org.springframework.ws.transport.http.MessageDispatcherServlet;
import org.springframework.ws.wsdl.wsdl11.DefaultWsdl11Definition;
import org.springframework.xml.xsd.SimpleXsdSchema;
import org.springframework.xml.xsd.XsdSchema;

@EnableWs
@Configuration
public class WebServiceConfig {

    @Bean
    public ServletRegistrationBean<MessageDispatcherServlet> messageDispatcherServlet(ApplicationContext applicationContext) {
        MessageDispatcherServlet servlet = new MessageDispatcherServlet();
        servlet.setApplicationContext(applicationContext);
        servlet.setTransformWsdlLocations(true);
        return new ServletRegistrationBean<>(servlet, "/services/*");
    }

    @Bean(name = "SuperSoapWS")
    public DefaultWsdl11Definition SuperSoapWSWsdlDefinition(XsdSchema SuperSoapWSSchema) {
        DefaultWsdl11Definition wsdl11Definition = new DefaultWsdl11Definition();
        wsdl11Definition.setPortTypeName("SuperSoapWSPort");
        wsdl11Definition.setLocationUri("/services");
        wsdl11Definition.setTargetNamespace("http://services.supersoap2.das.ubp.edu.ar/");
        wsdl11Definition.setSchema(SuperSoapWSSchema);
        return wsdl11Definition;
    }

    @Bean
    public XsdSchema SuperSoapWSSchema() {
        return new SimpleXsdSchema(new ClassPathResource("SuperSoapWS_schema1.xsd"));
    }

    @Bean
    public SaajSoapMessageFactory messageFactory() {
        SaajSoapMessageFactory messageFactory = new SaajSoapMessageFactory();
        messageFactory.setSoapVersion(SoapVersion.SOAP_11);
        return messageFactory;
    }
}