<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<link
	href="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/flatlab/assets/toastr-master/toastr.js"></script>
<script src="${pageContext.request.contextPath}/flatlab/js/app.js"></script>
<script src="${pageContext.request.contextPath}/flatlab/js/lodash.js"></script>
<script type="text/javascript">
	var u = {
		usuarioId : '<s:property value="#session.logged.usuarioId" />',
		nombres : '<s:property value="#session.logged.nombres" />',
		apellidos : '<s:property value="#session.logged.apellidos" />',
		foto_perfilBase64 : '<s:property value="#session.logged.foto_perfilBase64" />'
	}

	sessionStorage.logged = JSON.stringify(u);

	$
			.subscribe(
					'tpEstadosAmigos',
					function(event, data) {
						var cadena_html = "";
						var ajax_data = event.originalEvent.data.lista_estado_amigos;
						var likes, liked, i_like, _like_id, personas_like, comments, personas_comment;
						if (ajax_data.length > 0) {
							$
									.each(
											ajax_data,
											function(index, value) {
												likes = _
														.size(_
																.filter(
																		value.likes,
																		function(
																				o) {
																			return o.likeId != 0;
																		}));

												comments = _
														.size(_
																.filter(
																		value.comentarios,
																		function(
																				o) {
																			return o.comentarioId != 0;
																		}));

												personas_like = MostrarLikers(
														value.likes, false);

												personas_comment = MostrarCommenters(
														value.estadoId,
														value.comentarios);

												liked = _
														.filter(
																value.likes,
																function(x) {
																	return x.usuario_like.usuarioId == '<s:property value="#session.logged.usuarioId" />';
																});

												i_like = (liked.length > 0) ? "text-heart"
														: "";

												_like_id = (typeof (liked[0]) == "undefined") ? 0
														: liked[0].likeId;

												var bits = (value.fecha_estado)
														.split(/\D/);
												var fecha_creacion = new Date(
														bits[0], --bits[1],
														bits[2], bits[3],
														bits[4]).getTime();
												var hoy = new Date().getTime();
												var foto_estado = (value.usuario_estado.foto_perfilBase64 != null) ? '<img src="data:image/jpg;base64,'+ value.usuario_estado.foto_perfilBase64 +'" />'
														: '<img src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png" border="0" width="100" height="100" />';
												cadena_html += '<section class="panel animated zoomIn">'
														+ '<div class="panel-body">'
														+ '<div class="fb-user-thumb">'
														+ foto_estado
														+ '</div>'
														+ '<div class="fb-user-details">'
														+ '<h3>'
														+ '<a href="#" class="#">'
														+ value.usuario_estado.nombres
														+ " "
														+ value.usuario_estado.apellidos
														+ '</a>'
														+ '</h3>'
														+ '<p>HACE '
														+ humanizeDuration(
																hoy
																		- fecha_creacion,
																{
																	language : "es",
																	largest : 2,
																	delimiter : " y ",
																	units : [
																			"d",
																			"h",
																			"m" ],
																	round : true
																})
														+ '</p>'
														+ '</div>'
														+ '<div class="clearfix">'
														+ '</div>'
														+ '<p class="fb-user-status">'
														+ value.descripcion
														+ '</p>'
														+ '<div class="fb-status-container-actions fb-border">'
														+ '<div class="fb-time-action">'
														+ '<div class="nav notify-row action-row">'
														+ '<ul class="nav top-menu">'
														+ '<li>'
														+ '<a id="btnLike'
														+ value.estadoId
														+ '" data-estado="'
														+ value.estadoId
														+ '" data-usuario="<s:property value="#session.logged.usuarioId" />" data-like="'
														+ _like_id
														+ '" href="#">'
														+ '<i class="fa fa-heart fa-2x '+ i_like +'"></i>'
														+ '<span class="badge bg-important">'
														+ likes
														+ '</span>'
														+ '</a>'
														+ '</li>'
														+ '<li><a><i class="fa fa-comments-o fa-2x"></i><span class="badge bg-comment">'
														+ comments
														+ '</span></a></li>'
														+ '</ul>'
														+ '</div>'
														+ '</div>'
														+ '</div>'
														+ '<div class="fb-status-container fb-border fb-gray-bg">'
														+ '<div id="personas_like'+ value.estadoId +'" class="fb-time-action like-info">'
														+ personas_like
														+ '</div>'
														+ '</div>'
														+ '<ul id="comentarios'+ value.estadoId +'" class="fb-comments">'
														+ personas_comment
														+ '</ul>'
														+ '<div class="clearfix"></div>'
														+ '</div>'
														+ '</div>'
														+ '</section>';

											});
						} else {
							cadena_html = '<div class="alert alert-success alert-block fade in">'
									+ '<button data-dismiss="alert" class="close close-sm" type="button">'
									+ '<i class="fa fa-times"></i>'
									+ '</button>'
									+ '<h4><i class="fa fa-ok-sign"></i>¡Felicitaciones!</h4>'
									+ '<p>Ya Estás Registrado, Aquí Aparecerán Las Noticias, Mindbits (Estados De Ánimo) & Novedades De Tus Amigos, Aún No Tienes Ninguno, Búscalos & Agrégalos.</p>'
									+ '</div>';
						}
						$(data).html(cadena_html);
					});

	$.subscribe('tpConteo', function(event, data) {
		var num_estados = event.originalEvent.data.num_estados;
		var num_amigos = event.originalEvent.data.num_amigos;
		$("#cMindBits").text(num_estados);
		$("#cAmigos").text(num_amigos);
	});
</script>
<s:push value="#session.logged">
	<div class="row">
		<aside class="profile-nav col-lg-3">
			<!--widget start-->
			<section class="panel animated fadeIn">
				<div class="twt-feed blue-bg">
					<h1>
						<s:property value="nombres" />

						<s:property value="apellidos" />
					</h1>
					<p>
						<s:property value="correo" />
					</p>
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
				</div>
				<div class="weather-category twt-category">
					<s:url id="uConteo" value="conteo" />
					<jq:div id="rConteo" href="%{uConteo}" indicator="indicator"
						dataType="json" onSuccessTopics="tpConteo">
						<center>
							<i id="indicator"
								class="fa fa-spinner fa-pulse fa-3x fa-fw margin-bottom"></i>
						</center>
						<ul>
							<li class="active">
								<h5>
									<span id="cMindBits"></span>
								</h5> Mindbits
							</li>
							<li>
								<h5>
									<span id="cAmigos"></span>
								</h5> Amigos
							</li>
							<li>
								<h5>0</h5> Seguidores
							</li>
						</ul>
					</jq:div>
				</div>
				<s:form id="fMindbit" method="POST" action="nuevoEstado">
					<div class="twt-write col-sm-12">
						<input type="hidden" name="e.usuario_estado.usuarioId"
							value='<s:property value="usuarioId" />' /> <input type="hidden"
							name="e.fecha_estado"
							value='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%>' />
						<textarea name="e.descripcion" class="form-control t-text-area"
							required="required" rows="2" placeholder="¿Qué Estás Pensando?"></textarea>
					</div>
					<footer class="twt-footer">
						<button class="btn btn-space btn-white" data-toggle="button">
							<i class="fa fa-camera"></i>
						</button>
						<s:submit cssClass="btn btn-shadow btn-danger pull-right"
							value="¡Publicar!" />
					</footer>
				</s:form>
				<ul class="nav nav-pills nav-stacked" style="display:none;">
					<li><a href="javascript:;"> <i class="fa fa-clock-o"></i>
							Inbox <span class="label label-primary pull-right r-activity">19</span></a></li>
					<li><a href="javascript:;"> <i class="fa fa-calendar"></i>
							Actividad Reciente <span
							class="label label-info pull-right r-activity">11</span></a></li>
					<li><a href="javascript:;"> <i class="fa fa-bell-o"></i>
							Notificaciones <span
							class="label label-warning pull-right r-activity">03</span></a></li>
					<li><a href="javascript:;"> <i class="fa fa-envelope-o"></i>
							Alertas <span class="label label-success pull-right r-activity">10</span></a></li>
				</ul>
			</section>
			<!--widget end-->
		</aside>
		<aside id="aside_estados_amigos" class="profile-info col-lg-9">
			<s:url id="uCargarEstadosAmigos" value="cargarEstadosAmigos" />
			<jq:div id="rCargarEstadosAmigos" href="%{uCargarEstadosAmigos}"
				indicator="indicator" dataType="json"
				onSuccessTopics="tpEstadosAmigos">
				<center>
					<i id="indicator"
						class="fa fa-spinner fa-pulse fa-3x fa-fw margin-bottom"></i> <br>
					ESPERA, ESTAMOS CARGANDO TUS MINBITS ...
				</center>
			</jq:div>
		</aside>
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
						<h4 class="modal-title" id="myModalLabel">Subir Nueva Foto De
							Perfil</h4>
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




