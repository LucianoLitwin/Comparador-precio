package ar.edu.ubp.das.indecrest.batch;

import ar.edu.ubp.das.indecrest.utils.Httpful;
import jakarta.ws.rs.HttpMethod;
import org.springframework.stereotype.Service;

@Service
public class Methods {
    private final Httpful httpClient = new Httpful("http://localhost:8081/api/v1/indec");

    public void BatchPrecios() {

        Batch("/BatchPrecios");
    }

    public void BatchSucursales() {
        Batch("/BatchSucursales");
    }

    private void Batch(String path) {
        try {

            httpClient.path(path)
                    .method(HttpMethod.POST)
                    .execute(Void.class);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
