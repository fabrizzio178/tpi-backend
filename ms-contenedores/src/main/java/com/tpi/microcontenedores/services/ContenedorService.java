package com.tpi.microcontenedores.services;

import java.util.List;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    public ResponseEntity<List<Contenedor>> findAll(){
        List<Contenedor> contenedores = repo.findAll();
        try{
            if(contenedores.isEmpty()){
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(contenedores);
        } catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<Contenedor> findById(Long id){
        return repo.findById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    public ResponseEntity<Estado> getEstadoById(Long id){
        Contenedor contenedor = repo.findById(id).orElse(null);
        if(contenedor != null){
            return ResponseEntity.ok(contenedor.getEstado());
        }
        return ResponseEntity.notFound().build();
    }

    public ResponseEntity<Contenedor> registrarContenedor(Contenedor contenedor){
        if(contenedor == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }

        try{
            Contenedor saved = repo.save(contenedor);
            return ResponseEntity.status(HttpStatus.CREATED).body(saved);
        } catch (DataIntegrityViolationException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        } catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
