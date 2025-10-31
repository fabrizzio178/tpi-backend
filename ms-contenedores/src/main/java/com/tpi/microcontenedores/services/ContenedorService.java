package com.tpi.microcontenedores.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tpi.microcontenedores.entities.Contenedor;
import com.tpi.microcontenedores.entities.Estado;
import com.tpi.microcontenedores.repository.ContenedorRepository;

@Service
public class ContenedorService {
    private final ContenedorRepository repo;

    public ContenedorService(ContenedorRepository repo) {
        this.repo = repo;
    }

    public List<Contenedor> findAll(){
        return repo.findAll();
    }

    public Contenedor findById(Long id){
        return repo.findById(id).orElse(null);
    }

    public Estado getEstadoById(Long id){
        Contenedor contenedor = repo.findById(id).orElse(null);
        if(contenedor != null){
            return contenedor.getEstado();
        }
        return null;
    }

}
