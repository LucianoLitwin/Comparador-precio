package ar.edu.ubp.das.indecrest.batch;

import ar.edu.ubp.das.indecrest.IndecRestApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ApplicationContext;

import java.util.Scanner;

public class PreciosProductos {

    public static void main(String[] args) {
        ApplicationContext context = new SpringApplicationBuilder(IndecRestApplication.class)
                .web(WebApplicationType.NONE)
                .run(args);

        Methods methods = context.getBean(Methods.class);
        Scanner scanner = new Scanner(System.in);

        System.out.println("=== Bienvenido al proceso de actualización por lotes del comparador de precios del INDEC ===\n");


        // Actualización de precios
        System.out.println("\n[CARGANDO] Comenzando el proceso de actualización de precios...");
        methods.BatchPrecios();
        System.out.println("[COMPLETADO] Los precios han sido actualizados correctamente.\n");

        // Finalización
        System.out.println("El proceso por lotes ha terminado. Gracias por utilizar el sistema.");

        scanner.close();
    }
}
