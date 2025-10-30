package com.tpi.microcontenedores.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tpi.microcontenedores.entities.Solicitud;
import com.tpi.microcontenedores.repository.SolicitudRepository;

@Service
public class SolicitudService {
    private final SolicitudRepository repo;
    public SolicitudService(SolicitudRepository repo) {
        this.repo = repo;
    }

    public List<Solicitud> obtenerSolicitudes() {
        return repo.findAll();
    }
}
