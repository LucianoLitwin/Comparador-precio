package ar.edu.ubp.das.indecrest.repositories;

import ar.edu.ubp.das.indecrest.beans.*;
import ar.edu.ubp.das.indecrest.components.SimpleJdbcCallFactory;
import ar.edu.ubp.das.indecrest.factory.OperationType;
import ar.edu.ubp.das.indecrest.factory.Super;
import ar.edu.ubp.das.indecrest.factory.SuperRest;
import ar.edu.ubp.das.indecrest.factory.SuperSoap;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class IndecRepository {

    private static final Logger logger = LoggerFactory.getLogger(IndecRepository.class);

    @Autowired
    private SimpleJdbcCallFactory jdbcCallFactory;
    private final Gson gson = new Gson();

    public List<RubroBean> getRubros(String codIdioma) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("cod_idioma", codIdioma);
        return jdbcCallFactory.executeQuery("get_rubros", "dbo", params, "rubros", RubroBean.class);

    }//LISTO

    public List<CategoriaBean> getCategorias(String codIdioma, List<Integer> nroRubros) {
        // Convertir la lista de IDs a JSON
        String jsonRubros = gson.toJson(nroRubros.stream()
                .map(rubro -> new RubroJson(rubro))
                .toList());

        // Parámetros para el Stored Procedure
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("cod_idioma", codIdioma)
                .addValue("json", jsonRubros);

        return jdbcCallFactory.executeQuery(
                "get_categorias",
                "dbo",
                params,
                "categorias",
                CategoriaBean.class
        );
    }

    // Clase auxiliar para el formato JSON
    private static class RubroJson {
        private final int nro_rubro;

        public RubroJson(int nro_rubro) {
            this.nro_rubro = nro_rubro;
        }
    }

    public List<TipoProductoBean> getTiposProductos(String codIdioma, List<Integer> nroCategoria) {
        String jsonCategorias = gson.toJson(nroCategoria.stream()
                .map(categoria -> new CategoriaJson(categoria))
                .toList());

        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("cod_idioma", codIdioma)
                .addValue("json", jsonCategorias);
        return jdbcCallFactory.executeQuery("get_tipos_productos", "dbo", params, "tiposProductos", TipoProductoBean.class);

    }//LISTO

    // Clase auxiliar para el formato JSON
    private static class CategoriaJson {
        private final int nro_categoria;

        public CategoriaJson(int nro_categoria) {
            this.nro_categoria = nro_categoria;
        }
    }

    public List<MarcaBean> getMarcas(List<Integer> nroTipoProducto) {
        // Convertir la lista de tipos de producto a JSON
        String jsonTiposProductos = gson.toJson(nroTipoProducto.stream()
                .map(tipoProducto -> new TipoProductoJson(tipoProducto))
                .toList());

        // Parámetros para el SP
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("json", jsonTiposProductos);

        return jdbcCallFactory.executeQuery(
                "get_marcas_productos",
                "dbo",
                params,
                "marcas",
                MarcaBean.class
        );
    }

    private static class TipoProductoJson {
        private final int nro_tipo_producto;

        public TipoProductoJson(int nro_tipo_producto) {
            this.nro_tipo_producto = nro_tipo_producto;
        }
    }

    private String convertListToJson(List<Integer> list, String key) {
        if (list == null || list.isEmpty()) {
            return null; // Retorna null si la lista está vacía
        }
        // Convertir la lista a un JSON estructurado
        return gson.toJson(list.stream()
                .map(value -> Map.of(key, value)) // Crear un objeto con la clave
                .toList());
    }

    public ProductoResponseBean getProductos(String codIdioma, RequestBean criteria) {
        // Convertir las listas a JSON estructurado
        String jsonRubros = convertListToJson(criteria.getNroRubros(), "nro_rubro");
        String jsonCategorias = convertListToJson(criteria.getNroCategorias(), "nro_categoria");
        String jsonTiposProductos = convertListToJson(criteria.getNroTiposProductos(), "nro_tipo_producto");
        String jsonMarcas = convertListToJson(criteria.getNroMarcas(), "nro_marca");

        // Configurar los parámetros para el SP
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("cod_idioma", codIdioma)
                .addValue("json_rubros", jsonRubros)
                .addValue("json_categorias", jsonCategorias)
                .addValue("json_tipos", jsonTiposProductos)
                .addValue("json_marcas", jsonMarcas)
                .addValue("page_number", criteria.getPageNumber())
                .addValue("page_size", criteria.getPageSize())
                .addValue("barra_busqueda", criteria.getBarraBusqueda());

        // Llama al SP y obtiene los resultados
        Map<String, Object> results = jdbcCallFactory.executeQueryWithMultipleOutputs(
                "get_productos_filtrados", "dbo", params, "productos", "TotalCount", ProductoBean.class
        );

        // Procesar los resultados
        List<ProductoBean> productos = (List<ProductoBean>) results.get("productos");
        List<Map<String, Object>> totalCountList = (List<Map<String, Object>>) results.get("#result-set-2");
        Integer totalCount = null;
        if (totalCountList != null && !totalCountList.isEmpty()) {
            totalCount = (Integer) totalCountList.get(0).get("TotalCount");
        }

        // Manejar casos nulos
        if (productos == null) {
            productos = new ArrayList<>();
        }

        // Preparar la respuesta
        ProductoResponseBean response = new ProductoResponseBean();
        response.setProductos(productos);
        response.setTotalCount(totalCount != null ? totalCount : 0);

        return response;
    }


    public List<ProvinciaBean> getProvincias() {
        return jdbcCallFactory.executeQuery("get_provincias", "dbo", "provincias", ProvinciaBean.class);
    }//LISTO

    public List<LocalidadBean> getLocalidades(int cod_provincia) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("cod_provincia", cod_provincia);
        return jdbcCallFactory.executeQuery("get_localidades", "dbo", params, "localidades", LocalidadBean.class);
    }//LISTO

    public List<SucursalBean> getSucursales(int nro_localidad, String supermercado) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("nro_localidad", nro_localidad)
                .addValue("supermercado", supermercado == null ? "" : supermercado); // Si supermercado es null, pasa una cadena vacía.
        return jdbcCallFactory.executeQuery("get_sucursales", "dbo", params, "sucursales", SucursalBean.class);
    }


    public List<PrecioResponseBean> getPreciosComparados(List<String> codigosBarra, int localidad) {
        // Convertir la lista de códigos de barra a formato JSON
        String codigosBarraJson = new Gson().toJson(codigosBarra);

        // Crear los parámetros para el procedimiento almacenado
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("CodigosBarra", codigosBarraJson)
                .addValue("Localidad", localidad);

        // Ejecutar el procedimiento y obtener los resultados
        return jdbcCallFactory.executeQuery(
                "CompararPreciosProductos", // Nombre del procedimiento almacenado
                "dbo", // Esquema
                params, // Parámetros
                "resultados", // Alias del conjunto de resultados esperado
                PrecioResponseBean.class // Clase a mapear
        );
    }



    //-----------------BATCH------------------

    public List<ServicioSupermercadoBean> obtenerServiciosSupermercados() {
        return jdbcCallFactory.executeQuery("get_servicios_supermercados", "dbo", "serviciosSupermercados", ServicioSupermercadoBean.class);
    }//LISTO

    private List<Super> obtenerServiciosSupermercados(OperationType operacion) {
        List<Super> supers = new ArrayList<>();
        List<ServicioSupermercadoBean> servicios = obtenerServiciosSupermercados();

        for (ServicioSupermercadoBean servicio : servicios) {
            switch (servicio.getTipo_servicio()) {
                case "REST" -> supers.add(new SuperRest(
                        servicio.getUrl_servicio(),
                        servicio.getNro_supermercado(),
                        servicio.getUsuario(),
                        servicio.getClave()
                ));
                case "SOAP" -> supers.add(new SuperSoap(
                        servicio.getUrl_servicio(),
                        servicio.getNro_supermercado(),
                        operacion,
                        servicio.getUsuario(),
                        servicio.getClave()
                ));
                default -> throw new IllegalArgumentException("Servicio Invalido: " + servicio.getTipo_servicio());
            }
        }
        return supers;
    }//LISTO

    public void actualizarPrecios(String jsonResponse,int nroSupermercado) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("json", jsonResponse)
                .addValue("nro_supermercado", nroSupermercado);
        jdbcCallFactory.execute("act_precios_productos", "dbo", params);
    }//LISTO

    public void actualizarInformacion(String jsonResponse,int nroSupermercado) {
        SqlParameterSource params = new MapSqlParameterSource()
                .addValue("json", jsonResponse)
                .addValue("nro_supermercado", nroSupermercado);
        jdbcCallFactory.execute("act_informacion_sucursales", "dbo", params);
    }//LISTO

    public List<ProductoBean> getTodosProductos() {
        return jdbcCallFactory.executeQuery("get_productos", "dbo", "productos", ProductoBean.class);
    }//LISTO

    public void obtenerBatchPrecios() {
        List<Super> servicios = obtenerServiciosSupermercados(OperationType.OBTENER_PRECIOS);
        List<ProductoBean> ProductoBean = getTodosProductos();


        for (Super i : servicios) {
            try {
                List<PrecioBatchBean> precios = i.getPreciosProductos(ProductoBean);
                String jsonResponse = gson.toJson(precios);
                actualizarPrecios(jsonResponse, i.getNroSuper());
                logger.info("El Super {} actualizó sus precios correctamente", i.getNroSuper());
            } catch (Exception e) {
                logger.error("El Super {} falló al actualizar sus precios: {}",
                        i.getNroSuper(), e.getMessage());
            }
        }
    }//LISTO

    public void obtenerBatchSucursales() {
        List<Super> apis = obtenerServiciosSupermercados(OperationType.OBTENER_SUCURSALES);

        for (Super i : apis) {
            try {
                List<InfoSucursalesBean> info = i.getSucursales();
                String jsonResponse = gson.toJson(info);
                actualizarInformacion(jsonResponse, i.getNroSuper());
                logger.info("El Super {} actualizó sus sucursales correctamente", i.getNroSuper());
            } catch (Exception e) {
                logger.error("El Super {} falló al actualizar sus sucursales: {}",
                        i.getNroSuper(), e.getMessage());
            }
        }
    }//LISTO



}

