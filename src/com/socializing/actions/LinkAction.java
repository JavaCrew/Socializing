package com.socializing.actions;

import java.util.ArrayList;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.socializing.entities.AmistadBean;
import com.socializing.entities.UsuarioBean;
import com.socializing.services.UsuarioService;
import com.socializing.services.UsuarioServiceImp;

public class LinkAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	private UsuarioBean u = new UsuarioBean();
	private Map<String, Object> session = (Map<String, Object>)ActionContext.getContext().getSession();
	private ArrayList<AmistadBean> directorio;
	UsuarioService service = new UsuarioServiceImp();	
	private static final Log log = LogFactory.getLog(UsuarioAction.class);	
	public String inicio()
	{
		log.info("INICIO");
		return "inicio";		
	}
	
	public String cambio_password()
	{
		log.info("CAMBIO PASSWORD");
		return "cambio_password";		
	}

	public String perfil()
	{
		log.info("PERFIL");
		try {
			u = service.BuscarUsuario(((UsuarioBean)session.get("logged")).getUsuarioId());			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return "perfil";		
	}

	public String auto_perfil()
	{
		log.info("AUTO_PERFIL");
		try {
			u = service.BuscarUsuario(((UsuarioBean)session.get("logged")).getUsuarioId());			
		} catch (Exception e) {			
			e.printStackTrace();
		}
		return "auto_perfil";		
	}

	public String amigos()
	{	

		log.info("En Amigos - LINKACTION");
		try {
			UsuarioBean x = (UsuarioBean)session.get("logged");
			directorio = service.CargarDirectorio(x.getUsuarioId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "amigos";		
	}

	public String edicion(){
		return "edicion";
	}

	public String fotos()
	{
		return "fotos";		
	}

	public UsuarioBean getU() {
		return u;
	}

	public void setU(UsuarioBean u) {
		this.u = u;
	}

	public ArrayList<AmistadBean> getDirectorio() {
		return directorio;
	}

	public void setDirectorio(ArrayList<AmistadBean> directorio) {
		this.directorio = directorio;
	}		
}
