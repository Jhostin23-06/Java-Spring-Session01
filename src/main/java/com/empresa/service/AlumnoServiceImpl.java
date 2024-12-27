package com.empresa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.empresa.entity.Alumno;
import com.empresa.repository.AlumnoRepository;

@Service
public class AlumnoServiceImpl implements AlumnoService {
	
	@Autowired
	private AlumnoRepository repository;

	@Override
	public Alumno insertaAlumno(Alumno obj) {
		// TODO Auto-generated method stub
		return repository.save(obj);
	}
	
	@Override
	public List<Alumno> listaAlumnoxNombre(String nombre) {
		// TODO Auto-generated method stub
		return repository.findByNombreLike(nombre);
	}

}
