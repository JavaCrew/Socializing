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
<link href="${pageContext.request.contextPath}/flatlab/css/animate.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/flatlab/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<!-- Custom Styles For This Template -->
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
<link
	href="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.css"
	rel="stylesheet" />
<jq:head locale="es" jqueryui="true" jquerytheme="flick" />
<script
	src="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/jquery-validate/dist/jquery.validate.js"></script>
<script type="text/javascript">
	$(function() {
		if ('<s:property value="mensaje" />' != '') {
			toastr.warning('<s:property value="mensaje" />',
					'<s:property value="titulo" />');
		}
		$("#fLogin").validate({
			rules : {
				"correo" : "required",
				"pwd" : "required"
			},
			messages : {
				"correo" : "¡Ingresa Tu Correo!",
				"pwd" : "¡Ingresa Tu Password!"
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
		<s:form cssClass="form-signin" id="fLogin" action="login"
			method="POST">
			<h2 class="form-signin-heading">
				<img class="animated tada"
					src="${pageContext.request.contextPath}/img/logo.png" width="150"
					height="150"> <br /> Socializing<small> La Nueva Red
					Social</small>
			</h2>
			<div class="login-wrap">
				<s:textfield name="correo" cssClass="form-control"
					placeholder="Correo Electrónico" autofocus="autofocus"
					required="required" />
				<s:password name="pwd" cssClass="form-control"
					placeholder="Contraseña" required="required" />
				<jq:submit id="btnLogin" cssClass="btn btn-lg btn-login btn-block"
					value="Entrar" />
				<div class="registration">
					¿No Estás Registrado Aún? ... ¿¡Qué Esperas!?<a class=""
						href="${pageContext.request.contextPath}/pages/registro.jsp">
						¡Únete Ya! </a>
				</div>
			</div>
		</s:form>
	</div>
</body>
</html>