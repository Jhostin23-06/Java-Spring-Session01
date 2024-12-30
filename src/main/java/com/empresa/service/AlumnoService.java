package com.empresa.service;

import java.util.List;


import com.empresa.entity.Alumno;


public interface AlumnoService {

	public Alumno insertaAlumno(Alumno obj);
	
	public abstract List<Alumno> listaAlumnoxNombre(String nombre);

	boolean existsByDni(String dni);

	boolean existsByCorreo(String correo);
	
}
