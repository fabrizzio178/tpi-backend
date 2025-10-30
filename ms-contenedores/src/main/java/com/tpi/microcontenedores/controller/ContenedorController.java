package com.tpi.microcontenedores.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tpi.microcontenedores.entities.Contenedor;
import com.tpi.microcontenedores.services.ContenedorService;

@RestController
@RequestMapping("/api/contenedores")
public class ContenedorController {
    private final ContenedorService service;

    public ContenedorController(ContenedorService service) {
        this.service = service;
    }

    @GetMapping
    public List<Contenedor> obtenerContenedores(){
        try{
            return service.findAll();
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener contenedores\n: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    @GetMapping("/{id}")
    public Contenedor obtenerContenedorPorId(@PathVariable Long id){
        try{
            return service.findById(id);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener contenedor por ID\n: " + e.getMessage());
            return null;
        }
    }

}
