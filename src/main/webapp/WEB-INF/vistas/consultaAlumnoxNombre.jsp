<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" />
<script type="text/javascript"
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<title>Consulta de alumnos</title>
</head>
<body>
	<h2>Buscar Alumno por Nombre</h2>

	<!-- Formulario para ingresar el nombre -->
	<form action="filtraAlumno" class="simple_form" id="defaultForm">
		<label for="nombre">Nombre:</label> <input type="text" id="id_nombre"
			class="form-control" name="filtro" placeholder="Ingrese el nombre">
		<button type="submit" id="id_filtro" class="btn btn-primary">Buscar</button>
	</form>

	<h3>Resultados de la Búsqueda:</h3>

	<div class="row">
		<div class="col-md-12">
			<div class="content">

				<table id="id_table"
					class="table table-striped table-bordered table-hover table-sm">
					<thead class="thead-dark">
						<tr>
							<th>ID Alumno</th>
							<th>Nombre</th>
							<th>DNI</th>
							<th>Correo</th>
							<th>Fecha Nacimiento</th>
						</tr>
					</thead>
					<tbody>
						<!-- Aquí se insertarán los datos dinámicamente desde JSP o JavaScript -->
					</tbody>
				</table>

			</div>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function() {
	    $("#defaultForm").submit(function(event) {
	      event.preventDefault(); // Prevenir el envío del formulario

	      var filtro = $("#id_nombre").val();

	      $.getJSON("filtraAlumnoxNombre", {
	        "nombre": filtro
	      }, function(lista) {
	        agregarGrilla(lista);
	      });
	    });
	  });

		function agregarGrilla(lista) {
			$('#id_table').DataTable().clear();
			$('#id_table').DataTable().destroy();
			$('#id_table').DataTable({
				data : lista,
				searching : false,
				ordering : true,
				processing : true,
				pageLength : 5,
				lengthChange : false,
				columns : [ {
					data : 'idAlumno'
				}, {
					data : 'nombre'
				}, {
					data : 'dni'
				}, {
					data : 'correo'
				}, {
					data : 'fechaNacimiento'
				} ]
			})
		}
	</script>
</body>
</html>