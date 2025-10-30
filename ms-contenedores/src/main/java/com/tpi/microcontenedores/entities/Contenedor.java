package com.tpi.microcontenedores.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "contenedor", schema = "logistica")
public class Contenedor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_contenedor", nullable = false)
    private Long id;

    @Column(name = "peso", nullable = false)
    private Integer peso;

    @Column(name = "altura", nullable = false)
    private Integer altura;

    @Column(name = "ancho", nullable = false)
    private Integer ancho;

    @Column(name = "largo", nullable = false)
    private Integer largo;

    @ManyToOne
    @JoinColumn(name = "id_estado", foreignKey = @ForeignKey(name = "id_estado"))
    private Estado estado; 

    @Column(name = "id_cliente", nullable = false)
    private Long idCliente;

    

}
