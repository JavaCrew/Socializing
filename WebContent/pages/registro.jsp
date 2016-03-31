<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Socializing - La Nueva Red Social</title>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/img/logo.png">
<!-- Bootstrap Core CSS -->
<link
	href="${pageContext.request.contextPath}/flatlab/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/css/bootstrap-reset.css"
	rel="stylesheet">
<!--External CSS-->
<link
	href="${pageContext.request.contextPath}/flatlab/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<!-- Custom Styles For This Template -->
<jq:head jqueryui="true" jquerytheme="flick" />
<link
	href="${pageContext.request.contextPath}/flatlab/assets/css3-slideshow/css/demo.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/assets/css3-slideshow/css/style2.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/flatlab/css/style.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/css/style-responsive.css"
	rel="stylesheet" />
<jq:head jqueryui="true" jquerytheme="flick" />
<script
	src="${pageContext.request.contextPath}/flatlab/assets/jquery-validate/dist/jquery.validate.js"></script>
<script type="text/javascript">
	$(function() {
		jQuery.validator.addMethod("lettersonly", function(value, element) {
			return this.optional(element) || /^[a-z]+$/i.test(value);
		}, "¡Ingresa Sólo Letras!");

		$("#fRegistro").validate({
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
				"u.pwd" : "required",
				"re_pwd" : {
					equalTo : "#pwd"
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
				"u.pwd" : "¡Ingresa Tu Password!",
				"re_pwd" : "¡Ingresa El Mismo Password De Nuevo!"
			}
		});
	});
</script>
</head>
<body class="login-body">
	<ul class="cb-slideshow">
		<li><span>Image 01</span>
			<div>
				<h3>EX·PRE·SA·TE</h3>
			</div></li>
		<li><span>Image 02</span>
			<div>
				<h3>VI·VE</h3>
			</div></li>
		<li><span>Image 03</span>
			<div>
				<h3>SIEN·TE</h3>
			</div></li>
		<li><span>Image 04</span>
			<div>
				<h3>RI·E</h3>
			</div></li>
		<li><span>Image 05</span>
			<div>
				<h3>COM.PAR·TE</h3>
			</div></li>
		<li><span>Image 06</span>
			<div>
				<h3>CO·NO·CE</h3>
			</div></li>
	</ul>
	<div class="container">
		<form class="form-signin" id="fRegistro" method="POST"
			action="registrarUsuario">
			<h2 class="form-signin-heading">¡Regístrate Ahora!</h2>
			<div class="login-wrap">
				<p>Ingresa Tu Información Personal Aquí</p>
				<br /> <input type="text" name="u.nombres" class="form-control"
					placeholder="Nombre Completo" required /> <input type="text"
					name="u.apellidos" class="form-control"
					placeholder="Apellido Completo" required /> <input type="text"
					name="u.correo" class="form-control"
					placeholder="Correo Electrónico" required /> <input type="text"
					id="pwd" name="u.pwd" class="form-control" placeholder="Contraseña"
					required /> <input type="text" name="re_pwd" class="form-control"
					placeholder="Confirmar Contraseña" />
				<jq:datepicker placeholder="Fecha de Nacimiento"
					cssClass="form-control" name="u.fecha_nacimiento" showOn="focus"
					displayFormat="yy-mm-dd" changeMonth="true" changeYear="true"
					showAnim="slideDown" duration="slow" value="today" yearRange="1905:2016" maxDate="0"/>
				<input id="btnRegistro" class="btn btn-lg btn-login btn-block"
					type="submit" value="¡Terminé!" />
				<div class="registration">
					¿Ya Estás Registrado?. <a class=""
						href="<s:url value="/index.jsp" />"> Loguéate </a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>