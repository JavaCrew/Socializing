<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="sj"%>
<script type="text/javascript">
	$(function() {
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
						<img src="flatlab/img/fb-img.jpg" alt="">
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
					<s:if test="m == null">
						<s:form id="fSolicitudAmistad" method="POST"
							action="enviarSolicitudAmistad" cssClass="pull-right">
							<input type="hidden" name="flag" value="0" />
							<input type="hidden" name="amigo_solicitud"
								value="<s:property value="u.usuarioId" />" />
							<button class="btn btn-primary btn-round btn-shadow">
								<i class="fa fa-plus-circle"></i>&nbsp;&nbsp;Agregar Amigo
							</button>
						</s:form>
					</s:if>
					<s:elseif test="m.flag == 1">
						<div class="btn-group pull-right">
							<button data-toggle="dropdown"
								class="btn btn-primary btn-round btn-shadow dropdown-toggle"
								type="button">
								<i class="fa fa-check-circle"></i>&nbsp;&nbsp;Son
								Amigos&nbsp;&nbsp;<span class="caret"></span>
							</button>
							<ul role="menu" class="dropdown-menu">
								<li><sj:a href="#" formIds="fCancelarSolicitudAmistad">Romper Lazo</sj:a></li>
							</ul>
						</div>
					</s:elseif>
					<s:else>
						<s:if test="m.usuario.usuarioId == #session.logged.usuarioId">
							<s:form id="fCancelarSolicitudAmistad" method="POST"
								action="cancelarSolicitudAmistad" cssClass="pull-right">
								<input type="hidden" name="amigo_solicitud"
									value="<s:property value="m.amigo.usuarioId" />">
								<input type="hidden" name="m.amistadId"
									value="<s:property value="m.amistadId" />">
								<div class="btn-group pull-right">
									<button data-toggle="dropdown"
										class="btn btn-primary btn-round btn-shadow dropdown-toggle"
										type="button">
										<i class="fa fa-envelope"></i>&nbsp;&nbsp;Solicitud De Amistad
										Enviada&nbsp;&nbsp;<span class="caret"></span>
									</button>
									<ul role="menu" class="dropdown-menu">
										<li><sj:a href="#" formIds="fCancelarSolicitudAmistad">Cancelar Solicitud</sj:a></li>
									</ul>
								</div>
							</s:form>
						</s:if>
						<s:else>
							<s:form id="fResponderSolicitudAmistad" method="POST"
								cssClass="pull-right">
								<input type="hidden" name="amigo_solicitud"
									value="<s:property value="m.usuario.usuarioId" />">
								<input type="hidden" name="m.amistadId"
									value="<s:property value="m.amistadId" />">
								<div class="btn-group pull-right">
									<button data-toggle="dropdown"
										class="btn btn-primary btn-round btn-shadow dropdown-toggle"
										type="button">
										<i class="fa fa-envelope"></i>&nbsp;&nbsp;Responder Solicitud
										De Amistad &nbsp;&nbsp;<span class="caret"></span>
									</button>
									<ul role="menu" class="dropdown-menu">
										<li><a id="btnAceptarSolicitud" href="#">Aceptar
												Solicitud</a></li>
										<li><a id="btnRechazarSolicitud" href="#">Rechazar
												Solicitud</a></li>
									</ul>
								</div>
							</s:form>
						</s:else>
					</s:else>
				</div>
			</section>
			<section class="panel">
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
			</section>
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
		</div>
	</div>
	<!-- page end-->
</div>