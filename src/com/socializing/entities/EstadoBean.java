package com.socializing.entities;

import java.util.ArrayList;

public class EstadoBean {

	private int estadoId;
	private String descripcion;
	private String fecha_estado;
	private UsuarioBean usuario_estado;
	private ArrayList<LikeBean> likes;
	private ArrayList<ComentarioBean> comentarios;

	public int getEstadoId() {
		return estadoId;
	}
	public void setEstadoId(int estadoId) {
		this.estadoId = estadoId;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}		
	public String getFecha_estado() {
		return fecha_estado;
	}
	public void setFecha_estado(String fecha_estado) {
		this.fecha_estado = fecha_estado;
	}
	public UsuarioBean getUsuario_estado() {
		return usuario_estado;
	}
	public void setUsuario_estado(UsuarioBean usuario_estado) {
		this.usuario_estado = usuario_estado;
	}
	public ArrayList<LikeBean> getLikes() {
		return likes;
	}
	public void setLikes(ArrayList<LikeBean> likes) {
		this.likes = likes;
	}
	public ArrayList<ComentarioBean> getComentarios() {
		return comentarios;
	}
	public void setComentarios(ArrayList<ComentarioBean> comentarios) {
		this.comentarios = comentarios;
	}	
}
