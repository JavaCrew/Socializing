package com.socializing.entities;

import java.io.File;
import java.io.Serializable;

import org.apache.commons.codec.binary.Base64;

@SuppressWarnings("serial")
public class UsuarioBean implements Serializable{

	private int usuarioId;
	private String nombres;
	private String apellidos;
	private String correo;
	private String pwd;
	private String fecha_nacimiento;
	private String movil;
	private String fijo;
	private String pais;
	private String ocupacion;
	private String fecha_creacion;
	private String presentacion;
	private File foto_perfil;
	private String foto_perfilFileName;
	private String foto_perfilContentType;
	private byte[] foto_perfilBytes;
	private String foto_perfilBase64;
	private File foto_portada;
	private String foto_portadaFileName;
	private String foto_portadaContentType;
	private byte[] foto_portadaBytes;
	private String foto_portadaBase64;	

	public int getUsuarioId() {
		return usuarioId;
	}
	public void setUsuarioId(int usuarioId) {		
		this.usuarioId = usuarioId;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getCorreo() {
		return correo;
	}
	public void setCorreo(String correo) {
		this.correo = correo;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}	
	public String getMovil() {
		return movil;
	}
	public void setMovil(String movil) {
		this.movil = movil;
	}
	public String getFijo() {
		return fijo;
	}
	public void setFijo(String fijo) {
		this.fijo = fijo;
	}
	public String getPais() {
		return pais;
	}
	public void setPais(String pais) {
		this.pais = pais;
	}
	public String getOcupacion() {
		return ocupacion;
	}
	public void setOcupacion(String ocupacion) {
		this.ocupacion = ocupacion;
	}
	public String getFecha_nacimiento() {
		return fecha_nacimiento;
	}
	public void setFecha_nacimiento(String fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}
	public String getFecha_creacion() {
		return fecha_creacion;
	}
	public void setFecha_creacion(String fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}
	public String getPresentacion() {
		return presentacion;
	}
	public void setPresentacion(String presentacion) {
		this.presentacion = presentacion;
	}
	public File getFoto_perfil() {
		return foto_perfil;
	}
	public void setFoto_perfil(File foto_perfil) {
		this.foto_perfil = foto_perfil;
	}
	public String getFoto_perfilFileName() {
		return foto_perfilFileName;
	}
	public void setFoto_perfilFileName(String foto_perfilFileName) {
		this.foto_perfilFileName = foto_perfilFileName;
	}
	public String getFoto_perfilContentType() {
		return foto_perfilContentType;
	}
	public void setFoto_perfilContentType(String foto_perfilContentType) {
		this.foto_perfilContentType = foto_perfilContentType;
	}
	public byte[] getFoto_perfilBytes() {
		return foto_perfilBytes;
	}
	public void setFoto_perfilBytes(byte[] foto_perfilBytes) {
		this.foto_perfilBytes = foto_perfilBytes;
		setFoto_perfilBase64(new Base64().encodeToString(foto_perfilBytes));
	}
	public File getFoto_portada() {
		return foto_portada;
	}
	public void setFoto_portada(File foto_portada) {
		this.foto_portada = foto_portada;
	}
	public String getFoto_portadaFileName() {
		return foto_portadaFileName;
	}
	public void setFoto_portadaFileName(String foto_portadaFileName) {
		this.foto_portadaFileName = foto_portadaFileName;
	}
	public String getFoto_portadaContentType() {
		return foto_portadaContentType;
	}
	public void setFoto_portadaContentType(String foto_portadaContentType) {
		this.foto_portadaContentType = foto_portadaContentType;
	}
	public byte[] getFoto_portadaBytes() {
		return foto_portadaBytes;
	}
	public void setFoto_portadaBytes(byte[] foto_portadaBytes) {
		this.foto_portadaBytes = foto_portadaBytes;
		setFoto_portadaBase64(new Base64().encodeToString(foto_portadaBytes));
	}	
	public String getFoto_perfilBase64() {
		return foto_perfilBase64;
	}
	public void setFoto_perfilBase64(String foto_perfilBase64) {
		this.foto_perfilBase64 = foto_perfilBase64;
	}
	public String getFoto_portadaBase64() {
		return foto_portadaBase64;
	}
	public void setFoto_portadaBase64(String foto_portadaBase64) {
		this.foto_portadaBase64 = foto_portadaBase64;
	}
	@Override
	public String toString() {
		return nombres + " " + apellidos + " " + correo + " " + pwd + " " + fecha_nacimiento;
	}
}
