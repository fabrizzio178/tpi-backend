package com.tpi.microcontenedores.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tpi.microcontenedores.entities.Solicitud;

public interface SolicitudRepository extends JpaRepository<Solicitud, Long> {}

