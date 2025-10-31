package com.tpi.microcontenedores.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tpi.microcontenedores.entities.Solicitud;
import com.tpi.microcontenedores.services.SolicitudService;

@RestController
@RequestMapping("/api/solicitudes")
public class SolicitudController {
    private final SolicitudService service;
    public SolicitudController(SolicitudService service) {
        this.service = service;
    }
    @GetMapping()
    public ResponseEntity<List<Solicitud>> obtenerSolicitudes(){
        try{
            return service.obtenerSolicitudes();
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener solicitudes\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Solicitud> obtenerSolicitudPorId(@PathVariable Long id){
        try{
            return service.obtenerSolicitudPorId(id);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al obtener solicitud por ID\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping()
    public ResponseEntity<Void> registrarSolicitud(Solicitud solicitud){
        try{
            return service.registrarSolicitud(solicitud);
        } catch (Exception e) {
            // Manejo de excepciones
            System.out.println("\nError al registrar solicitud\n: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
