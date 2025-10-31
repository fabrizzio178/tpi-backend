package com.tpi.microcontenedores.services;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tpi.microcontenedores.entities.Solicitud;
import com.tpi.microcontenedores.repository.SolicitudRepository;

@Service
public class SolicitudService {
    private final SolicitudRepository repo;
    public SolicitudService(SolicitudRepository repo) {
        this.repo = repo;
    }

    public ResponseEntity<List<Solicitud>> obtenerSolicitudes() {
        List<Solicitud> solicitudes = repo.findAll();
        if (solicitudes.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(solicitudes);
    }

    public ResponseEntity<Solicitud> obtenerSolicitudPorId(Long id){
        try{
            return repo.findById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<Void> registrarSolicitud(Solicitud solicitud){
        try{
            return ResponseEntity.status(HttpStatus.CREATED).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
