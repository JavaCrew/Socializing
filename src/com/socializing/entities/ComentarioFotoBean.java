package com.socializing.entities;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ComentarioFotoBean implements Serializable{

	private int comentarioFotoId;
	private String descripcion;
	private String fecha;
	private UsuarioBean usuario_comentario_foto;
	private FotoBean foto_comentario;
	
	public int getComentarioFotoId() {
		return comentarioFotoId;
	}
	public void setComentarioFotoId(int comentarioFotoId) {
		this.comentarioFotoId = comentarioFotoId;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public UsuarioBean getUsuario_comentario_foto() {
		return usuario_comentario_foto;
	}
	public void setUsuario_comentario_foto(UsuarioBean usuario_comentario_foto) {
		this.usuario_comentario_foto = usuario_comentario_foto;
	}
	public FotoBean getFoto_comentario() {
		return foto_comentario;
	}
	public void setFoto_comentario(FotoBean foto_comentario) {
		this.foto_comentario = foto_comentario;
	}	
}
