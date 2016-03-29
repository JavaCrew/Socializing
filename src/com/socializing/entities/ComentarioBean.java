package com.socializing.entities;

public class ComentarioBean {

	private int comentarioId;
	private String fecha_comentario;
	private String contenido;
	private EstadoBean estado_comentario;
	private UsuarioBean usuario_comentario;

	public int getComentarioId() {
		return comentarioId;
	}
	public void setComentarioId(int comentarioId) {
		this.comentarioId = comentarioId;
	}	
	public String getFecha_comentario() {
		return fecha_comentario;
	}
	public void setFecha_comentario(String fecha_comentario) {
		this.fecha_comentario = fecha_comentario;
	}
	public EstadoBean getEstado_comentario() {
		return estado_comentario;
	}
	public void setEstado_comentario(EstadoBean estado_comentario) {
		this.estado_comentario = estado_comentario;
	}
	public UsuarioBean getUsuario_comentario() {
		return usuario_comentario;
	}
	public void setUsuario_comentario(UsuarioBean usuario_comentario) {
		this.usuario_comentario = usuario_comentario;
	}
	public String getContenido() {
		return contenido;
	}
	public void setContenido(String contenido) {
		this.contenido = contenido;
	}		
}
