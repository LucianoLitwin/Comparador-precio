package ar.edu.ubp.das.indecrest.beans;

import java.util.List;

public class ProductoResponseBean {
    private List<ProductoBean> productos;
    private Integer totalCount;

    // Getters and setters
    public List<ProductoBean> getProductos() {
        return productos;
    }

    public void setProductos(List<ProductoBean> productos) {
        this.productos = productos;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}
