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
<script type="text/javascript"
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />

<title>Consulta de alumnos</title>
</head>
<body>

	<div class="container">

		<h2 class="text-center">Buscar Alumno</h2>

		<!-- Formulario para ingresar el nombre -->
		<form action="filtraAlumno" class="simple_form" id="defaultForm">
			<div class="form-group">
				<label for="nombre">Nombre:</label> <input type="text"
					id="id_nombre" class="form-control" name="filtro"
					placeholder="Ingrese el nombre">
			</div>
			<button type="submit" id="id_filtro" class="btn btn-primary">Buscar</button>
		</form>

		<h3 class="text-center">Resultados de la Búsqueda:</h3>

		<div class="table-container">
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


	<script type="text/javascript">
		$(document).ready(function() {
			$("#defaultForm").submit(function(event) {
				event.preventDefault(); // Prevenir el envío del formulario

				var filtro = $("#id_nombre").val();

				$.getJSON("filtraAlumnoxNombre", {
					"nombre" : filtro
				}, function(lista) {
					agregarGrilla(lista);
				});
			});
		});

		function agregarGrilla(lista) {
			$('#id_table').DataTable().clear();
			$('#id_table').DataTable().destroy();
			$('#id_table').DataTable({
				data: lista.map(item => {
			      item.fechaNacimiento = formatDate(item.fechaNacimiento);
			      return item;
				}),
				rowId: 'idAlumno',
				searching : false,
				ordering : true,
				processing : true,
				pageLength : 10,
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
			});
		}
		
		function formatDate(dateString) {
			  const date = moment(dateString);
			  if (!date.isValid()) {
			    console.error("Invalid date:", dateString); // Log invalid date strings
			    return dateString; // Return the original string if it's not a valid date
			  }
			  return date.format('DD/MM/YYYY');
			}
	</script>
</body>
</html>