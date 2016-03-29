<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
<link href="${pageContext.request.contextPath}/flatlab/css/main.css"
	rel="stylesheet" />
<style type="text/css">
.ui-state-focus {
	background: none !important;
	background-color: none !important;
	border: none !important;
	border-radius: 10px;
	overflow: hidden;
}

#results {
	position: absolute;
	background-color: white;
}

#results ul {
	top: 41px !important;
	left: -309px !important;
	width: 500px !important;
}
</style>
<script src="${pageContext.request.contextPath}/flatlab/js/lodash.js"></script>
<script type="text/javascript">
	$
			.subscribe(
					'tpSolicitudesPendientes',
					function(event, data) {
						var foto_remitente;
						var array = event.originalEvent.data.lista_solicitudes_amistad;
						var solicitudes = '<li><p class="red">TIENES '
								+ _.size(array) + ' SOLICITUD(ES)</p></li>';

						$
								.each(
										array,
										function(k, v) {
											foto_remitente = (v.usuario.foto_perfilBase64 != null) ? '<img src="data:image/jpg;base64,'+ v.usuario.foto_perfilBase64 +'" />'
													: '<img src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png" border="0" width="100" height="100" />';

											solicitudes += '<li>'
													+ '<a id="btnSolicitud'
													+ v.usuario.usuarioId
													+ '" href="irPerfil?amigo_solicitud='
													+ v.usuario.usuarioId
													+ '">'
													+ '<span class="photo">'
													+ foto_remitente
													+ '</span>'
													+ '<span class="subject">'
													+ '<span class="from">'
													+ v.usuario.nombres
													+ " "
													+ v.usuario.apellidos
													+ '</span>'
													+ '<span class="time">Just now</span>'
													+ '</span>'
													+ '<span class="message">¡Hola!, Quiero Ser Tu Amigo.</span>'
													+ '</a></li>';
										});

						$("#contador_solicitud_amistad").text(_.size(array));
						$(data).html(solicitudes);
					});

	$(function() {
		$("#txtBuscarAmigos").autocomplete({
			minLength : 3,
			appendTo : "#results",
			source : function(request, response) {
				$.ajax({
					type : "POST",
					url : "buscarAmigos",
					data : JSON.stringify({
						term : '%' + request.term + '%'
					}),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						response($.map(data.lista_usuarios, function(u) {
							return {
								value : u.usuarioId,
								label : u.nombres + " " + u.apellidos,
								correo : u.correo,
								desc : u.ocupacion,
								foto : u.foto_perfilBase64
							}
						}));
					},
					error : function(a, b, c) {
						alert(c);
					}
				});
			},
			focus : function(event, ui) {
				event.preventDefault();
				$("#txtBuscarAmigos").val(ui.item.label);
			},
			select : function(event, ui) {
				event.preventDefault();
				$("#txtUsuarioId").val(ui.item.value);
				$("#txtBuscarAmigos").val(ui.item.label);
				$("#f1").submit();
			},
			response : function(event, ui) {
				if (!ui.content.length) {
					var noResult = {
						value : "",
						label : "Búsqueda Sin Resultados",
						correo : "_@",
						desc : "Prueba Intentando Con Otros Nombres"
					};
					ui.content.push(noResult);
				}
			}
		}).autocomplete("instance")._renderItem = function(ul, item) {
			var foto = (item.foto == null) ? "/Socializing/flatlab/img/green-silhouette.png"
					: "data:image/jpg;base64," + item.foto + "\"";
			return $("<li class='animated lightSpeedIn'>")
					.append(
							'<form id="f1" method="POST" action="irPerfil">'
									+ '<div class="ProfileCard u-cf Typeahead-suggestion Typeahead-selectable">'
									+ '<img class="ProfileCard-avatar" src="' + foto + '" />'
									+ '<div class="ProfileCard-details">'
									+ '<div class="ProfileCard-realName">'
									+ item.label
									+ '</div>'
									+ '<div class="ProfileCard-screenName">&nbsp;&nbsp;@'
									+ item.correo
									+ '</div>'
									+ '<div class="ProfileCard-description">'
									+ item.desc
									+ '</div>'
									+ '</div>'
									+ '<div class="ProfileCard-stats">'
									+ '<div class="ProfileCard-stat">'
									+ '<span class="ProfileCard-stat-label">Amigos:</span>14</div>'
									+ '<div class="ProfileCard-stat">'
									+ '<span class="ProfileCard-stat-label">Followers:</span>909</div>'
									+ '</div>'
									+ '</div>'
									+ '<input type="hidden" name="amigo_solicitud" value="'+ item.value +'" />'
									+ '</form>').appendTo(ul);
		};
	});
</script>
<s:push value="#session.logged">
	<header class="header light-green-bg">
		<div class="sidebar-toggle-box">
			<div data-original-title="Toggle Navigation" data-placement="right"
				class="tooltips">
				<img src="${pageContext.request.contextPath}/img/logo.png"
					width="40" height="40" />
			</div>
		</div>
		<!--logo start-->
		<div>
			<a href="#" class="logo-white">OCIALIZING</a>
		</div>
		<!--logo end-->
		<div class="nav notify-row" id="top_menu">
			<!--  Notification Bar Start -->
			<ul class="nav top-menu">
				<!-- Inbox Start-->
				<li id="header_inbox_bar" class="dropdown"><a
					style="background-color: white;" data-toggle="dropdown"
					class="dropdown-toggle" href="#" aria-expanded="false"> <i
						class="fa fa-users"></i> <span id="contador_solicitud_amistad"
						class="badge bg-important">0</span>
				</a>
					<ul class="dropdown-menu extended inbox animated flipInY">
						<div class="notify-arrow notify-arrow-red"></div>
						<s:url id="uCargarSolicitudesPendientes"
							value="buscarSolicitudAmistad" />
						<sj:div id="rCargarSolicitudesPendientes"
							href="%{uCargarSolicitudesPendientes}" indicator="indicator"
							dataType="json" onSuccessTopics="tpSolicitudesPendientes">
							<i id="indicator"
								class="fa fa-spinner fa-pulse fa-3x fa-fw margin-bottom"></i>
						</sj:div>
					</ul></li>
				<!-- Inbox End -->
				<!-- Solicitudes Start -->
				<li class="dropdown"><a style="background-color: white;"
					data-toggle="dropdown" class="dropdown-toggle" href="#"
					aria-expanded="true"> <i class="fa fa-inbox"></i> <span
						class="badge bg-success">0</span>
				</a>
					<ul class="dropdown-menu extended tasks-bar animated flipInY">
						<div class="notify-arrow notify-arrow-green"></div>
						<li>
							<p class="green">You have 6 pending tasks</p>
						</li>
						<li><a href="#">
								<div class="task-info">
									<div class="desc">Dashboard v1.3</div>
									<div class="percent">40%</div>
								</div>
								<div class="progress progress-striped">
									<div class="progress-bar progress-bar-success"
										role="progressbar" aria-valuenow="40" aria-valuemin="0"
										aria-valuemax="100" style="width: 40%">
										<span class="sr-only">40% Complete (success)</span>
									</div>
								</div>
						</a></li>
						<li class="external"><a href="#">See All Tasks</a></li>
					</ul></li>
				<!-- Solicitudes End -->
				<!-- Notification Start-->
				<li id="header_notification_bar" class="dropdown"><a
					style="background-color: white;" data-toggle="dropdown"
					class="dropdown-toggle" href="#" aria-expanded="false"> <i
						class="fa fa-bell-o"></i> <span class="badge bg-warning">0</span>
				</a>
					<ul class="dropdown-menu extended notification animated flipInY">
						<div class="notify-arrow notify-arrow-yellow"></div>
						<li>
							<p class="yellow">You have 7 new notifications</p>
						</li>
						<li><a href="#"> <span class="label label-danger"><i
									class="fa fa-bolt"></i></span> Server #3 overloaded. <span
								class="small italic">34 mins</span>
						</a></li>
						<li><a href="#">See all notifications</a></li>
					</ul></li>
				<!-- Notification End -->
			</ul>
			<!--  Notification Bar End-->
		</div>
		<div class="top-nav ">
			<!--Busqueda Amigos & UserBox Start-->
			<ul class="nav pull-right top-menu">
				<li><input type="hidden" id="txtUsuarioId" /> <input
					id="txtBuscarAmigos" type="text" class="form-control search"
					placeholder="Buscar Amigos"></li>
				<div id="results"></div>
				<!-- user login dropdown start-->
				<li class="dropdown"><a data-toggle="dropdown"
					class="dropdown-toggle" href="#"> <s:if
							test="#session.logged.foto_perfilBytes != null">
							<img src="<s:url value="verFotoPerfil" />" border="0" width="29"
								height="29" />
						</s:if> <s:else>
							<img
								src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png"
								border="0" width="29" height="29" />
						</s:else> <span class="username"><s:property value="nombres" /> <s:property
								value="apellidos" /></span> <b class="caret"></b>
				</a>
					<ul class="dropdown-menu extended logout animated flipInX">
						<div class="log-arrow-up"></div>
						<li><a href="#"><i class=" fa fa-suitcase"></i>Perfil</a></li>
						<li><a href="#"><i class="fa fa-cog"></i> Configuración</a></li>
						<li><a href="#"><i class="fa fa-bell-o"></i>
								Notificaciones</a></li>
						<li><a href="<s:url value="logout" />"><i
								class="fa fa-key"></i> Cerrar Session</a></li>
					</ul></li>
				<!-- <li class="sb-toggle-right"><i class="fa  fa-align-right"></i></li> -->
				<!-- user login dropdown end -->
			</ul>
			<!--Busqueda Amigos & UserBox End-->
		</div>
	</header>
</s:push>
