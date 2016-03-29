$("body").on('click','button[id^=btnComentarFoto]',function(e){
	e.preventDefault();

	var id_foto = $(this).data('foto');

	var data = 
	{
			cf: {
				descripcion:$(id_foto).val(),
				usuario_comentario_foto : { 
					usuarioId:$(this).data('usuario') 
				},
				foto_comentario: { 
					usuarioId:$(this).data('foto')
				}
			}

	};

	$.ajax(
			{
				type: 'POST', 
				url: 'nuevoComentarioFoto', 
				data: JSON.stringify(data),
				dataType: 'json',
				async: true ,
				contentType: 'application/json; charset=utf-8',
				success: function(obj){	
					alert('ready');
				}
			});

	alert($(this).data('foto'));
});

$("body").on('keypress','textarea[id^=btnComentario]',function(e){	
	if(e.which == 13) {
		if($(this).val().trim() != ""){
			e.preventDefault();
			var data = 
			{
					c: {
						contenido:$(this).val(),
						estado_comentario: {
							estadoId:$(this).data('estado')
						},
						usuario_comentario: {
							usuarioId:$(this).data('usuario') }
					}
			};
			$.ajax(
					{
						type: 'POST', 
						url: 'nuevoComentario', 
						data: JSON.stringify(data),
						dataType: 'json',
						async: true ,
						contentType: 'application/json; charset=utf-8',
						success: function(obj){	
							var ea = obj.e;						
							$("#comentarios"+ ea.estadoId).empty().append(MostrarCommenters(ea.estadoId, ea.comentarios));
							$("#comentarios"+ ea.estadoId).children(":nth-child("+ _.size(ea.comentarios) +")").addClass('animated slideInRight')
						}
					});
			$(this).val("");
		}else {
			toastr.warning('¡Ingresa un mensaje!',
			'Nada para comentar ...');
		}
	}
});

$("body").on('click','a[id^=btnLike]',function(e){
	e.preventDefault();
	if($(this).children("i").hasClass("text-heart")){
		var data = {l: {likeId: $(this).data('like'), estado_like: {estadoId: $(this).data('estado')}}};
		$.ajax(
				{
					type: 'POST', 
					url: 'dislike', 
					data: JSON.stringify(data),
					dataType: 'json',
					async: true ,
					contentType: 'application/json; charset=utf-8',
					success: function(obj){		
						var ea = obj.e;
						var likes = _.size(_.filter(ea.likes,
								function(o) {
							return o.likeId != 0;
						}));						
						$("#btnLike" + ea.estadoId + " span").text(likes).removeClass().addClass("badge bg-important animated shake");
						$("#btnLike" + ea.estadoId + " i").removeClass("text-heart");						
						$("#personas_like"+ ea.estadoId).empty().append(MostrarLikers(ea.likes, true));
					}
				});		
	}else{
		var data = {l: {fecha_like : moment().format("YYYY-MM-DD hh:mm:ss"), estado_like: {estadoId: $(this).data('estado')}, usuario_like: {usuarioId: $(this).data('usuario')} }};
		$.ajax(
				{
					type: 'POST', 
					url: 'like', 
					data: JSON.stringify(data),
					dataType: 'json',
					async: true ,
					contentType: 'application/json; charset=utf-8',
					success: function(obj){		
						var ea = obj.e;
						var likes = _.size(_.filter(ea.likes,
								function(o) {
							return o.likeId != 0;
						}));
						$("#btnLike" + ea.estadoId).data("like",ea.likes[0].likeId);
						$("#btnLike" + ea.estadoId + " span").text(likes).removeClass().addClass("badge bg-important animated bounce");
						$("#btnLike" + ea.estadoId + " i").addClass("text-heart");						
						$("#personas_like"+ ea.estadoId).empty().append(MostrarLikers(ea.likes, true));
					}
				});		
	}
});


function MostrarLikers(array, efecto){
	if(array.length == 0){
		return "<span> ¡Epa! Ningún <span class='badge bg-important'>ME GUSTA</span> Aún ... ¡Vamos! Sé El Primero En Hacerlo </span>";
	}else{
		var u = JSON.parse(sessionStorage.logged);
		var likers = "A ";
		var plural = "LES";

		var a = _.map(array,function(w){
			return (w.usuario_like.usuarioId == u.usuarioId) ? ":TI"
					: w.usuario_like.nombres
					+ " "
					+ w.usuario_like.apellidos;					
		}).sort();


		if(_.size(a) > 3)
		{			
			likers += _.map(_.take(a,3),function(w){
				return "&nbsp<a href='#'>" + w + "</a>";
			}).toString().replace(":","") + "Y " + (_.size(a)-3) + " PERSONAS MÁS ";

		}
		else
		{
			likers += _.map(a, function(n){
				if(_.size(a) == 1){
					plural = (n.indexOf("TI") > -1)? "TE" : "LE";	
				}
				return "&nbsp<a href='#'>" + n + "</a>";
			}).toString().replace(":","");


		}

		likers += plural;
		likers += " GUSTA ESTO."

			var ef = (efecto)? "class='animated tada'": "";

		return "<span "+ ef + ">" + likers + "</span>";
	}	
}

function MostrarCommenters(estado, array){
	var commenters = "";
	var foto_comentarista = "";
	var u = JSON.parse(sessionStorage.logged);	
	var bits, fecha_creacion, hoy;
	$.each(array,function(key,value){

		bits = (value.fecha_comentario).split(/\D/);
		fecha_creacion = new Date(bits[0], --bits[1],
				bits[2], bits[3],
				bits[4]).getTime();
		hoy = new Date().getTime();

		foto_comentarista = (value.usuario_comentario.foto_perfilBase64 != null) ? '<img src="data:image/jpg;base64,'+ value.usuario_comentario.foto_perfilBase64 +'" />'
				: '<img src="/Socializing/flatlab/img/green-silhouette.png"/>';
		commenters += '<li>'
			+ '<a href="#" class="cmt-thumb">'
			+ foto_comentarista
			+ '</a>'
			+ '<div class="cmt-details">'
			+ '<a href="#">'+ value.usuario_comentario.nombres + " " + value.usuario_comentario.apellidos +'</a>'
			+ '&nbsp;&nbsp;<span>' + value.contenido + '</span>'
			+ '<p>Hace '
			+ humanizeDuration(
					hoy
					- fecha_creacion,
					{
						language : "es",
						largest: 2,
						delimiter: " y ", 
						units : ["d","h","m"],
						round : true
					})
					+'</p>'
					+ '</div>'
					+ '</li>';
	});

	foto_comentarista = (u.foto_perfilBase64 != "") ? '<img src="data:image/jpg;base64,'+ u.foto_perfilBase64 +'" />'
			: '<img src="/Socializing/flatlab/img/green-silhouette.png"/>';

	commenters += 
		'<li>'
		+   '<a href="#" class="cmt-thumb">'
		+ foto_comentarista
		+	'</a>'
		+'<div class="cmt-form">'
		+'<textarea id="btnComentario'+ estado +'" data-usuario="'+ u.usuarioId +'" data-estado="'+ estado +'" class="form-control" placeholder="Deja Tu Comentario ..."></textarea>'	
		+'</div>'
		+'</li>';

	return commenters;
}