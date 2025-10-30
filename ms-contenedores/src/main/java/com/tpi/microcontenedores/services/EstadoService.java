package com.tpi.microcontenedores.services;

import java.util.List;

import com.tpi.microcontenedores.entities.Estado;
import com.tpi.microcontenedores.repository.EstadoRepository;

public class EstadoService {
    private final EstadoRepository repo;

    public EstadoService(EstadoRepository repo) {
        this.repo = repo;
    }

    public List<Estado> findAll(){
        return repo.findAll();
    }
    
}
