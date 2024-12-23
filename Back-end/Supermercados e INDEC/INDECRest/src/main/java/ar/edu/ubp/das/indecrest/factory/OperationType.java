package ar.edu.ubp.das.indecrest.factory;

public enum OperationType {
    OBTENER_PRECIOS("ObtenerPreciosRequest"),
    OBTENER_SUCURSALES("ObtenerSucursalesRequest");

    private final String operationName;

    OperationType(String operationName) {
        this.operationName = operationName;
    }

    public String getOperationName() {
        return operationName;
    }
}
