package com.socializing.entities;

import java.io.File;
import java.io.Serializable;

import org.apache.commons.codec.binary.Base64;

@SuppressWarnings("serial")
public class FotoBean implements Serializable{

	private int fotoId;
	private String descripcion_foto;
	private String fecha_creacion_foto;
	private File foto;
	private String fotoFileName;
	private String fotoContentType;
	private byte[] fotoBytes;
	private AlbumBean album;	
	private String fotoBase64;	
	
	public int getFotoId() {
		return fotoId;
	}
	public void setFotoId(int fotoId) {
		this.fotoId = fotoId;
	}	
	public String getDescripcion_foto() {
		return descripcion_foto;
	}
	public void setDescripcion_foto(String descripcion_foto) {
		this.descripcion_foto = descripcion_foto;
	}		
	public String getFecha_creacion_foto() {
		return fecha_creacion_foto;
	}
	public void setFecha_creacion_foto(String fecha_creacion_foto) {
		this.fecha_creacion_foto = fecha_creacion_foto;
	}
	public AlbumBean getAlbum() {
		return album;
	}
	public void setAlbum(AlbumBean album) {
		this.album = album;
	}
	public File getFoto() {
		return foto;
	}
	public void setFoto(File foto) {
		this.foto = foto;
	}
	public String getFotoFileName() {
		return fotoFileName;
	}
	public void setFotoFileName(String fotoFileName) {
		this.fotoFileName = fotoFileName;
	}
	public String getFotoContentType() {
		return fotoContentType;
	}
	public void setFotoContentType(String fotoContentType) {
		this.fotoContentType = fotoContentType;
	}
	public byte[] getFotoBytes() {
		return fotoBytes;
	}
	public void setFotoBytes(byte[] fotoBytes) {
		this.fotoBytes = fotoBytes;
		setFotoBase64(new Base64().encodeToString(fotoBytes));
	}	
	public String getFotoBase64() {
		return fotoBase64;
	}
	public void setFotoBase64(String fotoBase64) {
		this.fotoBase64 = fotoBase64;
	}		
}
