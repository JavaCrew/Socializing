package com.socializing.entities;

import java.io.Serializable;

@SuppressWarnings("serial")
public class AmistadBean implements Serializable{

	private int amistadId;	
	private UsuarioBean usuario;	
	private UsuarioBean amigo;	
	private int flag;
	private String fecha_amistad;

	public int getAmistadId() {
		return amistadId;
	}
	public void setAmistadId(int amistadId) {
		this.amistadId = amistadId;
	}
	public UsuarioBean getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioBean usuario) {
		this.usuario = usuario;
	}	
	public UsuarioBean getAmigo() {
		return amigo;
	}
	public void setAmigo(UsuarioBean amigo) {
		this.amigo = amigo;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}	
	public String getFecha_amistad() {
		return fecha_amistad;
	}
	public void setFecha_amistad(String fecha_amistad) {
		this.fecha_amistad = fecha_amistad;
	}
	@Override
	public String toString() {
		return amistadId + "/" + usuario.getUsuarioId() + "/" + amigo.getUsuarioId();
	}
}
