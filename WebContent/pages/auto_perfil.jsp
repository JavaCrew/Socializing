<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
<script src="${pageContext.request.contextPath}/flatlab/js/app.js"></script>
<script src="${pageContext.request.contextPath}/flatlab/js/lodash.js"></script>
<script type="text/javascript">
	$(function() {
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
													var hoy = new Date()
															.getTime();
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
															+ '<li><a><i class="fa fa-share-alt fa-2x"></i><span class="badge bg-warning">0</span></a></li>'
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
		$("#btnAceptarSolicitud").click(
				function(e) {
					e.preventDefault();
					$("#fResponderSolicitudAmistad").attr('action',
							'aceptarSolicitudAmistad').submit();
				});
		$("#btnRechazarSolicitud").click(
				function(e) {
					e.preventDefault();
					$("#fResponderSolicitudAmistad").attr('action',
							'cancelarSolicitudAmistad').submit();
				});
	});
</script>
<div class="animated slideInDown">
	<!-- page start-->
	<div class="row">
		<div class="col-md-12">
			<section class="panel">
				<div class="cover-photo">
					<div class="fb-timeline-img">
						<a href="#" data-toggle="modal" data-target="#myModal"> <s:if
								test="u.foto_portadaBase64 != null">
								<img
									src="data:image/jpg;base64,<s:property value="u.foto_portadaBase64" />"
									alt="" width="837" height="258" />
							</s:if> <s:else>
								<img
									src="${pageContext.request.contextPath}/flatlab/img/fb-img.jpg"
									alt="" />
							</s:else>
						</a>
					</div>
					<div class="fb-name">
						<h2>
							<a href="#"><s:property value="u.nombres" /> <s:property
									value="u.apellidos" /></a>
						</h2>
					</div>
				</div>
				<div class="panel-body">
					<div class="profile-thumb">
						<s:if test="u.foto_perfilBase64 != null">
							<img
								src="data:image/jpg;base64,<s:property value="u.foto_perfilBase64" />"
								border="0" width="100" height="100" />
						</s:if>
						<s:else>
							<img
								src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png"
								border="0" width="100" height="100" />
						</s:else>
					</div>
					<a href="#" class="fb-user-mail"><s:property value="u.correo" /></a>
					<div class="pull-right">
						<a class="btn btn-primary btn-round btn-shadow"
							href="<s:url action="edicionLink"/>">Editar Perfil</a>
					</div>
				</div>
			</section>
			<aside id="aside_estados_amigos" class="profile-info col-lg-12">
				<s:url id="uCargarEstadosAmigos" value="cargarEstadosAmigos" />
				<sj:div id="rCargarEstadosAmigos" href="%{uCargarEstadosAmigos}"
					indicator="indicator" dataType="json"
					onSuccessTopics="tpEstadosAmigos">
					<center>
						<i id="indicator"
							class="fa fa-spinner fa-pulse fa-3x fa-fw margin-bottom"></i> <br>
						ESPERA, ESTAMOS CARGANDO TUS MINBITS ...
					</center>
				</sj:div>
			</aside>

		</div>
	</div>
	<!-- page end-->
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<s:form method="POST" action="subirFotoPortada"
		enctype="multipart/form-data">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Subir Nueva Foto De
						Portada</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" name="u.usuarioId"
						value='<s:property value="u.usuarioId" />' />
					<s:file name="u.foto_portada" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-shadow btn-default"
						data-dismiss="modal">Salir</button>
					<s:submit cssClass="btn btn-shadow btn-danger" value="¡Subir Foto!" />
				</div>
			</div>
		</div>
	</s:form>
</div>
<!-- Modal -->