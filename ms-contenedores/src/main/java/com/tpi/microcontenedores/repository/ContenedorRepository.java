package com.tpi.microcontenedores.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tpi.microcontenedores.entities.Contenedor;

@Repository
public interface ContenedorRepository extends JpaRepository<Contenedor, Long> {
    List<Contenedor> findByEstadoNombre(String nombre);
}
