package com.socializing.entities;

import java.io.Serializable;
import java.util.ArrayList;

@SuppressWarnings("serial")
public class AlbumBean implements Serializable{
	
	private int albumId;
	private String descripcion;
	private String fecha_creacion;
	private UsuarioBean usuario;
	private ArrayList<FotoBean> fotos;
	
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getFecha_creacion() {
		return fecha_creacion;
	}
	public void setFecha_creacion(String fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}
	public UsuarioBean getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioBean usuario) {
		this.usuario = usuario;
	}
	public ArrayList<FotoBean> getFotos() {
		return fotos;
	}
	public void setFotos(ArrayList<FotoBean> fotos) {
		this.fotos = fotos;
	}	
}
