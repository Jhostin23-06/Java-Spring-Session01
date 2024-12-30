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
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<!-- SweetAlert2 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

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
			<button type="button" class="btn btn-success" data-toggle="modal"
				data-target="#registerModal">Registrar</button>
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

	<!-- Estructura del Modal -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog"
		aria-labelledby="registerModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="registerModalLabel">Registrar
						Alumno</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Formulario para registrar un alumno -->
					<form id="registerForm">
						<div class="form-group">
							<label for="nombre">Nombre:</label> <input type="text"
								class="form-control" id="nombre" name="nombre" required>
						</div>
						<div class="form-group">
							<label for="dni">DNI:</label> <input type="text"
								class="form-control" id="dni" name="dni" required>
						</div>
						<div class="form-group">
							<label for="correo">Correo:</label> <input type="email"
								class="form-control" id="correo" name="correo" required>
						</div>
						<div class="form-group">
							<label for="fechaNacimiento">Fecha de Nacimiento:</label> <input
								type="date" class="form-control" id="fechaNacimiento"
								name="fechaNacimiento" required>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Cerrar</button>
					<button type="button" class="btn btn-primary" id="saveButton">Guardar</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		$(document).ready(function() {
			// Llamada AJAX para obtener todos los datos al cargar la página
		    $.getJSON("filtraAlumnoxNombre", {
		        "nombre": ""
		    }, function(lista) {
		        agregarGrilla(lista);
		    });
			
			$("#defaultForm").submit(function(event) {
				event.preventDefault(); // Prevenir el envío del formulario

				var filtro = $("#id_nombre").val();

				$.getJSON("filtraAlumnoxNombre", {
					"nombre" : filtro
				}, function(lista) {
					agregarGrilla(lista);
				});
			});
			$('#saveButton').click(function() {
				var formData = {
				        nombre: $('#nombre').val(),
				        dni: $('#dni').val(),
				        correo: $('#correo').val(),
				        fechaNacimiento: $('#fechaNacimiento').val()
				};
				
				$.ajax({
			        type: 'POST',
			        url: 'registraAlumno', // Ajusta la URL según tu controlador
			        data: formData,
			        success: function(response) {
			        	if (response.MENSAJE === 'Registro exitoso') {
		                    $('#registerModal').modal('hide');
		                    Swal.fire({
		                        icon: 'success',
		                        title: response.MENSAJE,
		                        showConfirmButton: true
		                    }).then(() => {
		                    	// que se actualice la tabla
		                    	$.getJSON("filtraAlumnoxNombre", { "nombre": "" }, function(lista) {
                                    agregarGrilla(lista);
		                    	});
		                    });
		                } else {
		                    Swal.fire({
		                        icon: 'error',
		                        title: response.MENSAJE,
		                        showConfirmButton: true
		                    });
		                }
			        },
			        error: function(error) {
			        	Swal.fire({
		                    icon: 'error',
		                    title: 'Error al registrar el alumno',
		                    showConfirmButton: true
		                });
			        }
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
				pageLength : 15,
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