package com.tpi.microcontenedores.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tpi.microcontenedores.entities.Estado;

@Repository
public interface EstadoRepository extends JpaRepository<Estado, Long> {}
