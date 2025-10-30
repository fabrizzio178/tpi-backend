package com.tpi.microcontenedores.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tpi.microcontenedores.entities.Contenedor;

@Repository
public interface ContenedorRepository extends JpaRepository<Contenedor, Long> {}
