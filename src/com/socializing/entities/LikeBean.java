package com.socializing.entities;

public class LikeBean {
	private int likeId;
	private String fecha_like;
	private UsuarioBean usuario_like;
	private EstadoBean estado_like;

	public int getLikeId() {
		return likeId;
	}
	public void setLikeId(int likeId) {
		this.likeId = likeId;
	}
	public String getFecha_like() {
		return fecha_like;
	}
	public void setFecha_like(String fecha_like) {
		this.fecha_like = fecha_like;
	}
	public UsuarioBean getUsuario_like() {
		return usuario_like;
	}
	public void setUsuario_like(UsuarioBean usuario_like) {
		this.usuario_like = usuario_like;
	}
	public EstadoBean getEstado_like() {
		return estado_like;
	}
	public void setEstado_like(EstadoBean estado_like) {
		this.estado_like = estado_like;
	}			
}
