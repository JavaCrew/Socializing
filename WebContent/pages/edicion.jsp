<%@page import="com.socializing.entities.UsuarioBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edición de Perfil | Socializing</title>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/jquery-validate/dist/jquery.validate.js"></script>
<script type="text/javascript">
	$(function() {
		jQuery.validator.addMethod("lettersonly", function(value, element) {
			return this.optional(element)
					|| /^[a-zA-ZÑñáéíóúÁÉÍÓÚ ]+$/i.test(value);
		}, "¡Ingresa Sólo Letras!");

		$.validator.addMethod("legal_age", function(value, element) {
			console.log($("#fecnac").val());
			var day = $("#fecnac").val().split("-")[2];
			var month = $("#fecnac").val().split("-")[1];
			var year = $("#fecnac").val().split("-")[0];
			var age = 18;

			var mydate = new Date();
			mydate.setFullYear(year, month - 1, day);

			var currdate = new Date();
			currdate.setFullYear(currdate.getFullYear() - age);

			return currdate > mydate;

		}, "¡Debes Tener Por Lo Menos 18 Años De Edad!");

		$("#fEdicion").validate({
			rules : {
				"u.nombres" : {
					lettersonly : true
				},
				"u.apellidos" : {
					lettersonly : true
				},
				"u.correo" : {
					email : true
				},
				"u.fecha_nacimiento" : {
					legal_age : true
				}
			},
			messages : {
				"u.nombres" : {
					required : "¡Ingresa Tus Nombres!"
				},
				"u.apellidos" : {
					required : "¡Ingresa Tus Apellidos!"
				},
				"u.correo" : {
					required : "¡Ingresa Tu ID!",
					email : "¡Ingresa Una Dirección Válida!"
				},
				"u.pais" : {
					required : "¡Ingresa Tu País!"
				},
				"u.fecha_nacimiento" : {
					required : "¡Ingresa Tu Fecha de Nacimiento!"
				},
				"u.ocupacion" : {
					required : "¡Ingresa Tu Ocupación!"
				},
				"u.correo" : {
					required : "¡Ingresa Tu Correo!"
				},
				"u.movil" : {
					required : "¡Ingresa Tu Teléfono Móvil!"
				},
				"u.fijo" : {
					required : "¡Ingresa Tu Teléfono Fijo!"
				}
			}
		});
	});
</script>
</head>
<body>
	<div class="animated fadeIn">
		<s:push value="#session.logged">
			<div class="row">
				<aside class="profile-nav col-lg-3"> <section class="panel">
				<div class="user-heading round">
					<a href="#" data-toggle="modal" data-target="#myModal"> <s:if
							test="#session.logged.foto_perfilBytes != null">
							<img src="<s:url value="verFotoPerfil" />" border="0" width="100"
								height="100" />
						</s:if> <s:else>
							<img
								src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png"
								border="0" width="100" height="100" />
						</s:else>
					</a>
					<h1>
						<s:property value="nombres" />
						<s:property value="apellidos" />
					</h1>
					<p>
						<s:property value="correo" />
					</p>
				</div>
				<ul class="nav nav-pills nav-stacked">
					<li class="active"><a> <i class="fa fa-edit"></i> Editar
							Perfil
					</a></li>
				</ul>
				</section> </aside>
				<form id="fEdicion" method="POST" action="editarPerfil">
					<aside class="profile-info col-lg-9"> <section
						class="panel">
					<div class="bio-graph-heading">
						¡Preséntate al Mundo!
						</textarea>
					</div>
					<div class="panel-body bio-graph-info">
						<h1>Bio Graph</h1>
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-2"></div>
						</div>
						<div class="row">
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Nombres </span>:
									</div>
									<div class="col-md-9">
										<input type="hidden" name="u.usuarioId"
											value="<s:property value="usuarioId" />" /> <input
											name="u.nombres" class="form-control" type="text"
											value="<s:property value="nombres" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Apellidos </span>:
									</div>
									<div class="col-md-9">
										<input name="u.apellidos" class="form-control" type="text"
											value="<s:property value="apellidos" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>País </span>:
									</div>
									<div class="col-md-9">
										<input name="u.pais" class="form-control" type="text"
											value="<s:property value="pais" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Cumple </span>:
									</div>
									<div class="col-md-9">
										<input id="fecnac" class="form-control" type="date"
											value="<s:property value="fecha_nacimiento" />"
											name="u.fecha_nacimiento" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Ocupación </span>:
									</div>
									<div class="col-md-9">
										<input name="u.ocupacion" class="form-control" type="text"
											value="<s:property value="ocupacion" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Email </span>:
									</div>
									<div class="col-md-9">
										<input name="u.correo" class="form-control" type="text"
											value="<s:property value="correo" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Tlf. Móvil </span>:
									</div>
									<div class="col-md-9">
										<input name="u.movil" class="form-control" type="text"
											value="<s:property value="movil" />" required />
									</div>
								</div>
							</div>
							<div class="bio-row">
								<div class="row">
									<div class="col-md-3">
										<span>Tlf. Fijo </span>:
									</div>
									<div class="col-md-9">
										<input name="u.fijo" class="form-control" type="text"
											value="<s:property value="fijo" />" required />
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6"></div>
							<div class="col-md-6">
								<input id="btnEdicion"
									class="btn btn-shadow btn-info pull-right" type="submit"
									value="Guardar Cambios" />
							</div>
						</div>
					</div>
					</section></aside>
				</form>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<s:form method="POST" action="subirFotoPerfil"
					enctype="multipart/form-data">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
								<h4 class="modal-title" id="myModalLabel">Subir Nueva Foto
									De Perfil</h4>
							</div>
							<div class="modal-body">
								<input type="hidden" name="u.usuarioId"
									value='<s:property value="usuarioId" />' />
								<s:file name="u.foto_perfil" />
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-shadow btn-default"
									data-dismiss="modal">Salir</button>
								<s:submit cssClass="btn btn-shadow btn-danger"
									value="¡Subir Foto!" />
							</div>
						</div>
					</div>
				</s:form>
			</div>
			<!-- Modal -->
		</s:push>
	</div>
</body>
</html>