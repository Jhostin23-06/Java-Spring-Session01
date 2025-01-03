package com.empresa.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.empresa.entity.Alumno;

public interface AlumnoRepository extends JpaRepository<Alumno, Integer> {

	public List<Alumno> findByNombreLike(String nombre);

	public boolean existsByDni(String dni);

	public boolean existsByCorreo(String correo);

}
