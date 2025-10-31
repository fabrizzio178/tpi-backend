package com.tpi.microcontenedores.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tpi.microcontenedores.entities.Contenedor;
import com.tpi.microcontenedores.entities.Estado;
import com.tpi.microcontenedores.services.ContenedorService;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api/contenedores")
public class ContenedorController {
    private final ContenedorService service;

    public ContenedorController(ContenedorService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Contenedor>> obtenerContenedores(){
        try{
            return service.findAll();
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener contenedores\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Contenedor> obtenerContenedorPorId(@PathVariable Long id){
        try{
            return service.findById(id);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener contenedor por ID\n: " + e.getMessage());
            return null;
        }
    };

    @GetMapping("{id}/estado")
    public ResponseEntity<Estado> obtenerEstadoContenedor(@PathVariable Long id){
        try{
            return service.getEstadoById(id);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener estado del contenedor\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping(params = "estado")
    public ResponseEntity<List<Contenedor>> obtenerContenedoresPorEstado(@RequestParam String estado){
        try{
            return service.consultarEstadoPendiente(estado);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener contenedores por estado\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    

}
