<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/struts-jquery-tags" prefix="jq"%>
<link href="${pageContext.request.contextPath}/flatlab/css/metro.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/flatlab/css/style_isotope.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/flatlab/css/gallery.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/flatlab/assets/fancybox/source/jquery.fancybox.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/flatlab/assets/bootstrap-fileupload/bootstrap-fileupload.css"
	rel="stylesheet" />
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.isotope.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.easing.min.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/link-hover.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/assets/fancybox/source/jquery.fancybox.pack.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/jquery.flexslider.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/modernizr.custom.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/toucheffects.js"></script>
	<script src="${pageContext.request.contextPath}/flatlab/js/app.js"></script>
<style type="text/css">
.fancybox-sidebar {
	float: right;
	width: 33%;
}

.fancybox-inner {
	overflow: auto !important;
	width: auto !important;
	height: auto !important;
}

div[id^=test] {
	float: left;
}

.activity .activity-desk {
	margin-left: 5px;
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						function loadComments(id) {
							var data = {
								id_foto : id
							};
							$
									.ajax({
										type : 'POST',
										url : 'cargarComentariosFoto',
										data : JSON.stringify(data),
										dataType : 'json',
										async : true,
										contentType : 'application/json; charset=utf-8',
										success : function(obj) {
											var html = '<section class="panel">'
													+ '<header class="panel-heading">Comentarios '
													+ '<span class="tools pull-right">'
													+ '<a class="fa fa-chevron-down" href="javascript:;">'
													+ '</a><a class="fa fa-times" href="javascript:;"></a></span>'
													+ '</header>'
													+ '<div class="panel-body">'
													+ '<div class="timeline-messages">';
											$
													.each(
															obj.lista_comentario_foto,
															function(k, v) {
																var bits = (v.fecha)
																		.split(/\D/);
																var fecha_creacion = new Date(
																		bits[0],
																		--bits[1],
																		bits[2],
																		bits[3],
																		bits[4])
																		.getTime();
																var hoy = new Date()
																		.getTime();

																var foto_comentario = (v.usuario_comentario_foto.foto_perfilBase64 != null) ? '<img class="avatar" src="data:image/jpg;base64,'+ v.usuario_comentario_foto.foto_perfilBase64 +'" alt="" />'
																		: '<img class="avatar" src="${pageContext.request.contextPath}/flatlab/img/green-silhouette.png" alt="" />';

																html += '<div class="msg-time-chat">'
																		+ '<a href="#" class="message-img">'
																		+ foto_comentario
																		+ '</a>'
																		+ '<div class="message-body msg-in">'
																		+ '<span class="arrow"></span>'
																		+ '<div class="text">'
																		+ '<p class="attribution">'
																		+ '<a href="#">'
																		+ v.usuario_comentario_foto.nombres
																		+ ' '
																		+ v.usuario_comentario_foto.apellidos
																		+ '</a>'
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
																		+ '<p>'
																		+ v.descripcion
																		+ '</p>'
																		+ '</div>'
																		+ '</div>'
																		+ '</div>';

															});
											html +=
											'<div class="chat-form">'
													+ '<div class="input-cont ">'
													+ '<input id="'+id+'" type="text" class="form-control col-lg-12" placeholder="Ingresa Tu Comentario Aquí ...">'
													+ '</div>'
													+ '<div class="form-group">'
													+ '<div class="pull-right chat-features">'
													+ '<button id="btnComentarFoto'+id+'" class="btn btn-danger btn-shadow" data-foto="'+ id +'" data-usuario="<s:property value="#session.logged.usuarioId" />">Enviar</button>'
													+ '</div>' + '</div>' +
													'</div>' +
													'</div>' + '</div>'
													+ '</section>';
											$('.fancybox-sidebar').append(html);
										}
									});
						}

						$(".fancybox")
								.fancybox(
										{
											helpers : {
												title : {
													type : 'inside',
													position : 'top'
												}
											},
											nextEffect : 'fade',
											prevEffect : 'fade',
											beforeShow : function() {
												loadComments(this.href.replace(
														'#test', ''));
											},
											tpl : {
												wrap : '<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"><div class="fancybox-sidebar"></div></div></div></div></div>'
											}
										}

								);
						$('[data-zlname = reverse-effect]').mateHover({
							position : 'y-reverse',
							overlayStyle : 'rolling',
							overlayBg : '#fff',
							overlayOpacity : 0.7,
							overlayEasing : 'easeOutCirc',
							rollingPosition : 'top',
							popupEasing : 'easeOutBack',
							popup2Easing : 'easeOutBack'
						});
					});
</script>
<section class="panel">
	<header class="panel-heading">
		<s:property value="nombre_album" />
	</header>
	<div class="panel-body">
		<s:push value="#session.logged">
			<div id="foto_galley" class="col-4">
				<s:iterator value="lista_fotos">
					<div
						class="animated flipInX element design development item view view-tenth"
						data-zlname="reverse-effect">
						<img src="data:image/jpg;base64,<s:property value="fotoBase64" />" />
						<div class="mask">
							<h2>
								<s:property value="descripcion_foto" />
							</h2>
							<a data-zl-popup="link" href="javascript:;"> <i
								class="fa fa-heart"></i></a> <a data-zl-popup="link2"
								class="fancybox" rel="group"
								href="#test<s:property value="fotoId" />"><i
								class="fa fa-eye"></i></a>
							<div id="test<s:property value="fotoId" />"
								style="display: none;">
								<img
									src="data:image/jpg;base64,<s:property value="fotoBase64" />"
									width="650" />
							</div>
						</div>
					</div>
				</s:iterator>
			</div>
		</s:push>
	</div>
</section>