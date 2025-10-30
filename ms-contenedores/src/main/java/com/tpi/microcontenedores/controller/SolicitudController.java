package com.tpi.microcontenedores.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tpi.microcontenedores.entities.Solicitud;
import com.tpi.microcontenedores.services.SolicitudService;

@RestController

public class SolicitudController {
    private final SolicitudService service;
    public SolicitudController(SolicitudService service) {
        this.service = service;
    }
    @GetMapping("/api/solicitudes")
    public List<Solicitud> obtenerSolicitudes(){
        try{
            return service.obtenerSolicitudes();
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener solicitudes\n: " + e.getMessage());
            return List.of();

        }
    }

}
