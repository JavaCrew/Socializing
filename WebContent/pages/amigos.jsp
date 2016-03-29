<%@ taglib uri="/struts-tags" prefix="s"%>
<link
	href="${pageContext.request.contextPath}/flatlab/css/bootstrap-social.css"
	rel="stylesheet" />
<ul class="directory-list">
	<li><a href="#">a</a></li>
	<li><a href="#">b</a></li>
	<li><a href="#">c</a></li>
	<li><a href="#">d</a></li>
	<li><a href="#">e</a></li>
	<li><a href="#">f</a></li>
	<li><a href="#">g</a></li>
	<li><a href="#">h</a></li>
	<li><a href="#">i</a></li>
	<li><a href="#">j</a></li>
	<li><a href="#">k</a></li>
	<li><a href="#">l</a></li>
	<li><a href="#">m</a></li>
	<li><a href="#">n</a></li>
	<li><a href="#">o</a></li>
	<li><a href="#">p</a></li>
	<li><a href="#">q</a></li>
	<li><a href="#">r</a></li>
	<li><a href="#">s</a></li>
	<li><a href="#">t</a></li>
	<li><a href="#">u</a></li>
	<li><a href="#">v</a></li>
	<li><a href="#">w</a></li>
	<li><a href="#">x</a></li>
	<li><a href="#">y</a></li>
	<li><a href="#">z</a></li>
</ul>
<div class="directory-info-row">
	<div class="row">
		<s:iterator value="directorio">
			<s:if test="#session.logged.usuarioId == amigo.usuarioId">
				<div class="col-md-6 col-sm-6">
					<div class="panel">
						<div class="panel-body">
							<div class="media">
								<a class="pull-left" href="#"> <s:if
										test="usuario.foto_perfilBase64 != null">
										<img class="thumb media-object"
											src="data:image/jpg;base64,<s:property value="usuario.foto_perfilBase64" />" />
									</s:if> <s:else>
										<img class="thumb media-object"
											src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png" />
									</s:else>
								</a>
								<div class="media-body">
									<h4>
										<s:property value="usuario.nombres" />
										<s:property value="usuario.apellidos" />
										<span class="text-muted small"> - @<s:property
												value="usuario.correo" /></span>
									</h4>
									<a class="btn btn-social-icon btn-facebook"><span
										class="fa fa-facebook"></span></a> <a
										class="btn btn-social-icon btn-twitter"><span
										class="fa fa-twitter"></span></a> <a
										class="btn btn-social-icon btn-google"><span
										class="fa fa-google-plus"></span></a> <a
										class="btn btn-social-icon btn-linkedin"><span
										class="fa fa-linkedin"></span></a> <a
										class="btn btn-social-icon btn-facebook"><span
										class="fa fa-facebook"></span></a>
									<address>
										<strong><s:property value="usuario.ocupacion" /></strong><br>
										Amigos Desde:<br>
										<s:property value="fecha_amistad" />
									</address>
								</div>
							</div>
						</div>
					</div>
				</div>
			</s:if>
			<s:else>
				<div class="col-md-6 col-sm-6">
					<div class="panel">
						<div class="panel-body">
							<div class="media">
								<a class="pull-left" href="#"> <s:if
										test="amigo.foto_perfilBase64 != null">
										<img class="thumb media-object"
											src="data:image/jpg;base64,<s:property value="amigo.foto_perfilBase64" />" />
									</s:if> <s:else>
										<img class="thumb media-object"
											src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png" />
									</s:else>
								</a>
								<div class="media-body">
									<h4>
										<s:property value="amigo.nombres" />
										<s:property value="amigo.apellidos" />
										<span class="text-muted small"> - @<s:property
												value="amigo.correo" /></span>
									</h4>
									<a class="btn btn-social-icon btn-facebook"><span
										class="fa fa-facebook"></span></a> <a
										class="btn btn-social-icon btn-twitter"><span
										class="fa fa-twitter"></span></a> <a
										class="btn btn-social-icon btn-google"><span
										class="fa fa-google-plus"></span></a> <a
										class="btn btn-social-icon btn-linkedin"><span
										class="fa fa-linkedin"></span></a> <a
										class="btn btn-social-icon btn-facebook"><span
										class="fa fa-facebook"></span></a>
									<address>
										<strong><s:property value="amigo.ocupacion" /></strong><br>
										Amigos Desde:<br>
										<s:property value="fecha_amistad" />
									</address>
								</div>
							</div>
						</div>
					</div>
				</div>
			</s:else>
		</s:iterator>
	</div>
</div>