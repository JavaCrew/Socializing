<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<s:head />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cambio de Contraseña | Socializing</title>
<link
	href="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/jquery-validate/dist/jquery.validate.js"></script>
<script type="text/javascript">
	$(function() {
		$("#fCambioPwd").validate({
			rules : {
				"u.pwd" : "required",
				"re_pwd" : {
					equalTo : "#pwd"
				}
			},
			messages : {
				"#current_pwd" : "¡Ingresa Tu Password!",
				"u.pwd" : "¡Ingresa Un Nuevo Password!",
				"re_pwd" : "¡Ingresa El Mismo Password De Nuevo!"
			}
		});
		$("#current_pwd")
				.blur(
						function() {
							var data = {
								u : {
									usuarioId : '<s:property value="#session.logged.usuarioId" />',
									pwd : $(this).val()
								}

							};
							$
									.ajax({
										type : 'POST',
										url : 'validarPassword',
										data : JSON.stringify(data),
										dataType : 'json',
										async : true,
										contentType : 'application/json; charset=utf-8',
										success : function(obj) {
											if (obj.flag2 == 1) {
												$("#btnEdicion").removeClass(
														"disabled");
											} else {
												$("#btnEdicion").addClass(
														"disabled");
												toastr
														.warning(
																"Para Activar El Botón De Guardar Tus Cambios.",
																"¡Ingresa Tu Contraseña Actual Correcta!",
																{
																	positionClass : "toast-bottom-right"
																});
											}
										}
									});
						});
	});
</script>
</head>
<body>
	<div class="animated fadeIn">
		<s:push value="#session.logged">
			<form class="form-signin" id="fCambioPwd" method="POST"
				action="cambiarPassword">
				<h2 class="form-signin-heading">¡Mejora Tu Seguridad!</h2>
				<div class="login-wrap">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label>Password Actual</label> <input class="form-control"
									type="hidden" name="u.usuarioId"
									value="<s:property value="usuarioId" />" /> <input
									class="form-control" id="current_pwd" type="text"
									required />
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>Nueva Contraseña</label> <input id="pwd"
									class="form-control" name="u.pwd" type="password" />
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>Confirma Contraseña</label> <input class="form-control"
									name="re_pwd" type="password" />
							</div>
						</div>
						<div class="col-md-12">
							<input id="btnEdicion"
								class="btn btn-shadow btn-info pull-right disabled"
								type="submit" value="Guardar Cambios" />
						</div>
					</div>
				</div>
			</form>
		</s:push>
	</div>
</body>
</html>