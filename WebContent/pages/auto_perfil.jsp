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
<<<<<<< HEAD
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

=======
			<!--<section class="panel">
				<div class="panel-body">
					<div class="fb-user-thumb">
						<img src="flatlab/img/pro-ac-1.png" alt="">
					</div>
					<div class="fb-user-details">
						<h3>
							<a href="#" class="#">Margarita Elina</a>
						</h3>
						<p>7 minutes ago near Alaska, USA</p>
					</div>
					<div class="clearfix"></div>
					<p class="fb-user-status">John is world famous professional
						photographer. with forward thinking clients to create beautiful,
						honest and amazing things that bring positive results. John is
						world famous professional photographer. with forward thinking
						clients to create beautiful, honest and amazing things that bring
						positive results.</p>
					<div class="fb-status-container fb-border">
						<div class="fb-time-action">
							<a href="#" title="Like this">Like</a> <span>-</span> <a href="#"
								title="Leave a comment">Comments</a> <span>-</span> <a href="#"
								title="Send this to friend or post it on your time line">Share</a>
						</div>
					</div>
					<div class="fb-status-container fb-border fb-gray-bg">
						<div class="fb-time-action like-info">
							<a href="#">Jhon Due,</a> <a href="#">Danieal Kalion</a> <span>and</span>
							<a href="#">40 more</a> <span>like this</span>
						</div>

						<ul class="fb-comments">
							<li><a href="#" class="cmt-thumb"> <img
									src="flatlab/img/mail-avatar.jpg" alt="">
							</a>
								<div class="cmt-details">
									<a href="#">Jhone due</a> <span> is world famous
										professional photographer. with forward thinking clients to
										create beautiful, </span>
									<p>
										40 minutes ago - <a href="#" class="like-link">Like</a>
									</p>
								</div></li>
							<li><a href="#" class="cmt-thumb"> <img
									src="flatlab/img/follower-avatar.jpg" alt="">
							</a>
								<div class="cmt-details">
									<a href="#">Tawseef</a> <span> is world famous
										professional photographer. with forward thinking clients to
										create beautiful, </span>
									<p>
										34 minutes ago - <a href="#" class="like-link">Like</a>
									</p>
								</div></li>

							<li><a href="#" class="cmt-thumb"> <img
									src="flatlab/img/mail-avatar.jpg" alt="">
							</a>
								<div class="cmt-details">
									<a href="#">Jhone due</a> <span> is world famous
										professional photographer. </span>
									<p>
										15 minutes ago - <a href="#" class="like-link">Like</a>
									</p>
								</div></li>
							<li><a href="#" class="cmt-thumb"> <img
									src="flatlab/img/follower-avatar.jpg" alt="">
							</a>
								<div class="cmt-details">
									<a href="#">Tawseef</a> <span> thinking clients to
										create beautiful world famous professional photographer. </span>
									<p>
										2 minutes ago - <a href="#" class="like-link">Like</a>
									</p>
								</div></li>
							<li><a href="#" class="cmt-thumb"> <img
									src="flatlab/img/follower-avatar.jpg" alt="">
							</a>
								<div class="cmt-form">
									<textarea class="form-control" placeholder="Write a comment..."
										name=""></textarea>
								</div></li>
						</ul>
						<div class="clearfix"></div>
					</div>
				</div>
			</section>
			<section class="panel">
				<div class="panel-body">
					<div class="fb-user-thumb">
						<img alt="" src="flatlab/img/pro-ac-2.png">
					</div>
					<div class="fb-user-details">
						<h3>
							<a class="#" href="#">Jasica Rosario</a>
						</h3>
						<p>7 minutes ago near Alaska, USA</p>
					</div>
					<div class="clearfix"></div>
					<p class="fb-user-status">John is world famous professional
						photographer. with forward thinking clients to create beautiful,
						honest and amazing things that bring positive results. John is
						world famous professional photographer. with forward thinking
						clients to create beautiful, honest and amazing things that bring
						positive results.</p>
					<div class="fb-time-action">
						<a href="#" title="Like this">Like</a> <span>-</span> <a href="#"
							title="Leave a comment">Comments</a> <span>-</span> <a href="#"
							title="Send this to friend or post it on your time line">Share</a>
					</div>


					<div class="fb-status-container fb-border fb-gray-bg">
						<div class="fb-time-action like-info">
							<a href="#">Jhon Due,</a> <a href="#">Danieal Kalion</a> <span>and</span>
							<a href="#">40 more</a> <span>like this</span>
						</div>

						<ul class="fb-comments">
							<li><a class="cmt-thumb" href="#"> <img alt=""
									src="flatlab/img/mail-avatar.jpg">
							</a>
								<div class="cmt-details">
									<a href="#">Jhone due</a> <span> is world famous
										professional photographer. with forward thinking clients to
										create beautiful, </span>
									<p>
										23 minutes ago - <a class="like-link" href="#"
											title="Like this">Like</a>
									</p>
								</div></li>
							<li><a class="cmt-thumb" href="#"> <img alt=""
									src="flatlab/img/follower-avatar.jpg">
							</a>
								<div class="cmt-details">
									<a href="#">Tawseef</a> <span> is world famous
										professional photographer. with forward thinking clients to
										create beautiful, </span>
									<p>
										45 minutes ago - <a class="like-link" href="#"
											title="Like this">Like</a>
									</p>
								</div></li>


							<li><a class="cmt-thumb" href="#"> <img alt=""
									src="flatlab/img/follower-avatar.jpg">
							</a>
								<div class="cmt-form">
									<textarea name="" placeholder="Write a comment..."
										class="form-control"></textarea>
								</div></li>
						</ul>
						<div class="clearfix"></div>
					</div>
				</div>
			</section>-->
		</div>
		<div class="col-md-3" style="display:none;">
			<div class="fb-timeliner">
				<h2 class="recent-highlight">Recent</h2>
				<ul>
					<li class="active"><a href="#">December</a></li>
					<li><a href="#">November</a></li>
					<li><a href="#">October</a></li>
					<li><a href="#">September</a></li>
					<li><a href="#">August</a></li>
					<li><a href="#">July</a></li>
					<li><a href="#">June</a></li>
					<li><a href="#">May</a></li>
					<li><a href="#">April</a></li>
					<li><a href="#">March</a></li>
					<li><a href="#">February</a></li>
					<li><a href="#">January</a></li>
				</ul>
			</div>
			<div class="fb-timeliner">
				<h2>2012</h2>
				<ul>
					<li><a href="#">August</a></li>
					<li><a href="#">July</a></li>
					<li><a href="#">June</a></li>
					<li><a href="#">May</a></li>
					<li><a href="#">April</a></li>
					<li><a href="#">March</a></li>
					<li><a href="#">February</a></li>
					<li><a href="#">January</a></li>
				</ul>
			</div>

			<div class="fb-timeliner">
				<h2>2011</h2>
				<ul>
					<li><a href="#">May</a></li>
					<li><a href="#">April</a></li>
					<li><a href="#">March</a></li>
					<li><a href="#">February</a></li>
					<li><a href="#">January</a></li>
				</ul>
			</div>
>>>>>>> origin/master
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