<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	src="${pageContext.request.contextPath}/flatlab/assets/bootstrap-fileupload/bootstrap-fileupload.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/modernizr.custom.js"></script>
<script
	src="${pageContext.request.contextPath}/flatlab/js/toucheffects.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".fancybox").fancybox();
		$.subscribe('tpGaleria', function(event, data) {
			var cadena_albumes = "";
			var cadena_fotos = "";
			var galley = event.originalEvent.data.galeria;
			if(galley.length > 0){
				$.each(galley, function(k, v) {						
					$("#cboAlbumes").append(
							"<option value='"+ v.albumId +"'>"
									+ v.descripcion + "</option>");						
					cadena_albumes = 
						'<li>'
						+ '<figure>'
						+ '<div class="tile-wide" data-role="tile">'
						+ '<div class="tile-content image-set">';
						
						$.each(v.fotos,function(k,v){
							if(v.fotoBase64 != null){								
								cadena_albumes += '<img src="data:image/jpg;base64,'+ v.fotoBase64 +'" />';								
								
								cadena_fotos = 
									'<div class="animated fadeIn element design development item view view-tenth" data-zlname="reverse-effect">'
									+ '<img src="data:image/jpg;base64,'+ v.fotoBase64 +'" />'
									+ '<div class="mask">'
									+ '<h2>'
									+ v.descripcion_foto
									+ '</h2>'
									+ '<a data-zl-popup="link" href="javascript:;"> <i class="fa fa-heart"></i></a>'
									+ '<a data-zl-popup="link2" class="fancybox" rel="group" href="data:image/jpg;base64,'+ v.fotoBase64 +'"><i class="fa fa-eye"></i></a>'
									+ '</div>'
									+ '</div>';
									
								$("#foto_galley").append(cadena_fotos);	
								
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
							}
						});							
						
						cadena_albumes +=
						'</div>'						
						+ '</div>'						
						+ '<figcaption>'
						+ '<h3>'
						+ v.descripcion
						+ '</h3>'
						+ '<span>'
						+ v.fecha_creacion
						+ '</span>'
						+ '<form id="f1" method="POST" action="cargarFotosPorGaleria">'
						+ '<input type="hidden" name="nombre_album" value="'+ v.descripcion +'" />'
						+ '<input type="hidden" name="id_album" value="'+ v.albumId +'" />'
						+ '<a><input type="submit" class="btn btn-shadow btn-danger pull-right" value="¡Chequéalo!"></a>'
						+ '</form>'
						+ '</figcaption>'
						+ '</figure>'
						+ '</li>';						
						
						$("#album_galley").append(cadena_albumes);
				});	
			}else{
				$("#foto_galley").empty().append("<h1>No Tienes Fotos Para Mostrar :(</h1>");
				$("#album_galley").empty().append("<h1>No Has Creado Ningún Album Aún :(</h1>");
			}
		}); //End Suscribe
	});
</script>
<s:push value="#session.logged">
	<s:url id="uCargarGaleria" value="cargarGaleria" />
	<jq:div id="rCargarGaleria" href="%{uCargarGaleria}"
		indicator="indicator" dataType="json" onSuccessTopics="tpGaleria">
		<section class="panel">
			<header class="panel-heading tab-bg-dark-navy-blue tab-right ">
				<ul class="nav nav-tabs pull-right">
					<li class="active"><a data-toggle="tab" href="#home-3">Fotos
					</a></li>
					<li class=""><a data-toggle="tab" href="#about-3">Albumes
					</a></li>
					<li class=""><a data-toggle="tab" href="#contact-3"> <i
							class="fa fa-plus-square" style="font-size: 1.5em;"></i>
					</a></li>
				</ul>
				<span class="hidden-sm wht-color">Galería</span>
			</header>
			<div class="panel-body">
				<div class="tab-content">
					<div id="home-3" class="tab-pane active">
						<i id="indicator"
							class="fa fa-spinner fa-pulse fa-3x fa-fw margin-bottom"></i>
						<div id="foto_galley" class="col-4"></div>
					</div>
					<div id="about-3" class="tab-pane">
						<ul id="album_galley" class="grid cs-style-3">
						</ul>
					</div>
					<div id="contact-3" class="tab-pane">
						<s:form method="POST" action="subirFoto"
							enctype="multipart/form-data">
							<div class="form-group">
								<s:textfield name="f.descripcion_foto" cssClass="form-control"
									placeholder="Descripcion" />
								<input type="hidden" name="f.fecha_creacion_foto"
									value='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(new Date())%>' />
							</div>
							<div class="form-group">
								<div class="fileupload fileupload-new"
									data-provides="fileupload">
									<div class="fileupload-new thumbnail"
										style="width: 200px; height: 150px;">
										<img
											src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=SIN+IMAGEN"
											alt="" />
									</div>
									<div class="fileupload-preview fileupload-exists thumbnail"
										style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
									<div>
										<span class="btn btn-white btn-file"> <span
											class="fileupload-new"><i class="fa fa-paperclip"></i>
												Seleccionar Imagen</span> <span class="fileupload-exists"><i
												class="fa fa-undo"></i> Cambiar</span> <input name="f.foto"
											type="file" class="default" />
										</span> <a href="#" class="btn btn-danger fileupload-exists"
											data-dismiss="fileupload"><i class="fa fa-trash"></i>
											Quitar</a>
									</div>
								</div>
								<span class="label label-danger">¡OJO!</span> <span> Sólo
									Puedes Subir Imágenes Con Las Siguientes Extensiones : *.JPEG,
									*.JPG, *.PNG Y *.GIF</span> <br /> <br />
							</div>
							<div class="form-group">
								<select id="cboAlbumes" class="form-control"
									name="f.album.albumId"></select> <a data-toggle="modal"
									data-target="#myModal" class="btn btn-white"> <i
									class="fa fa-plus"></i>
								</a>
							</div>
							<s:submit cssClass="btn btn-shadow btn-info" value="¡Subir Foto!" />
						</s:form>
					</div>
				</div>
			</div>
		</section>
	</jq:div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<s:form method="POST" action="nuevoAlbum">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Crear Nuevo Album</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" name="a.usuario.usuarioId"
							value='<s:property value="usuarioId" />' />
						<s:textfield name="a.descripcion" cssClass="form-control"
							placeholder="Nombre De Album" />
						<input type="hidden" name="a.fecha_creacion"
							value='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
							.format(new Date())%>' />
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-shadow btn-default"
							data-dismiss="modal">Salir</button>
						<s:submit cssClass="btn btn-shadow btn-danger" value="¡Listo!" />
					</div>
				</div>
			</div>
		</s:form>
	</div>
	<!-- Modal -->
</s:push>