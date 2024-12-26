package com.empresa.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.empresa.entity.Alumno;
import com.empresa.service.AlumnoService;

@Controller
public class AlumnoController {

	@Autowired
	private AlumnoService service;

	@RequestMapping("/verAlumno")
	public String ver() {
		return "registraAlumno";
	}
	
	@RequestMapping("/verConsultaAlumnoxNombre")
	public String verConsultaxNombre() {
		return "consultaAlumnoxNombre";
	}
	
	@RequestMapping("/registraAlumno")
	@ResponseBody
	public HashMap<String, String> registra(Alumno obj) {
		
		HashMap<String, String> salida = new HashMap<>();
		Alumno objSalida = service.insertaAlumno(obj);
		
		if(objSalida == null) {
			salida.put("MENSAJE", "Error al registrar");
		}else {
			salida.put("MENSAJE", "Registro exitoso");
		}

		return salida;
	}
	
	@RequestMapping("/filtraAlumnoxNombre")
	@ResponseBody
	public List<Alumno> listaAlumnoxNombre(String nombre){
        return service.listaAlumnoxNombre(nombre + "%");
		
	}
}
