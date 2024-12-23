package ar.edu.ubp.das.superrest2.Controller;

import ar.edu.ubp.das.superrest2.Beans.InfoSucursalesBean;
import ar.edu.ubp.das.superrest2.Beans.PreciosProductosBean;
import ar.edu.ubp.das.superrest2.Repository.InfoSucursalesRepository;
import ar.edu.ubp.das.superrest2.Repository.PreciosProductosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/super")
public class SuperController {
    @Autowired
    private InfoSucursalesRepository infoSucursalesRepository;

    @Autowired
    private PreciosProductosRepository preciosProductosRepository;

    @GetMapping("/sucursales")//LISTO
    public ResponseEntity<List<InfoSucursalesBean>> getSucursales() {
        List<InfoSucursalesBean> Sucursales = infoSucursalesRepository.getSucursales();
        return ResponseEntity.ok(Sucursales);
    }

    @PostMapping("/productos")//LISTO
    public ResponseEntity<List<PreciosProductosBean>> getPreciosProductos(@RequestBody String json) {
        List<PreciosProductosBean> Precios = preciosProductosRepository.getPrecios(json);
        return ResponseEntity.ok(Precios);
    }
}
