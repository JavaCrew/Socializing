package com.socializing.actions;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.socializing.entities.FotoBean;
import com.socializing.entities.UsuarioBean;
import com.socializing.services.UsuarioService;
import com.socializing.services.UsuarioServiceImp;

@ParentPackage(value = "s")
@InterceptorRefs({
	@InterceptorRef("jsonValidationWorkflowStack"),
	@InterceptorRef("fileUpload")
})
public class FotoAction extends ActionSupport implements ServletRequestAware{

	private static final long serialVersionUID = 1L;	
	private File archivo;
	private String archivoContentType;
	private String archivoFileName;
	private HttpServletRequest servletRequest;
	private Map<String, Object> session = (Map<String, Object>)ActionContext.getContext().getSession();
	UsuarioService service = new UsuarioServiceImp();	
	UsuarioBean u = new UsuarioBean();	
	FotoBean f = new FotoBean();
	private static final Log log = LogFactory.getLog(UsuarioAction.class);

	@Override
	public String execute() throws Exception {	
		log.info("En Execute[SubirNuevaFoto] - FOTOACTION");
		service.NuevaFotoPerfil(u);
		UsuarioBean x = (UsuarioBean)session.get("logged");
		x.setFoto_perfilBytes(u.getFoto_perfilBytes());
		session.put("logged",x);
		return SUCCESS;
	}

	public String NuevaFoto() throws Exception{
		log.info("En NuevaFoto - FOTOACTION");
		log.info(f);		
		service.NuevaFoto(f);		
		return SUCCESS;
	}	
	
	public String NuevaFotoPortada() throws Exception{
		log.info("En NuevaFotoPortada - FOTOACTION");		
		service.NuevaFotoPortada(u);
		UsuarioBean x = (UsuarioBean)session.get("logged");
		x.setFoto_portadaBytes(u.getFoto_portadaBytes());
		session.put("logged",x);
		u = service.BuscarUsuario(((UsuarioBean)session.get("logged")).getUsuarioId());
		log.info("nuev por"+u);
		return SUCCESS;
	}	

	public UsuarioBean getU() {
		return u;
	}
	public void setU(UsuarioBean u) {
		this.u = u;
	}
	public File getArchivo() {
		return archivo;
	}

	public void setArchivo(File archivo) {
		this.archivo = archivo;
	}

	public String getArchivoContentType() {
		return archivoContentType;
	}

	public void setArchivoContentType(String archivoContentType) {
		this.archivoContentType = archivoContentType;
	}

	public String getArchivoFileName() {
		return archivoFileName;
	}

	public void setArchivoFileName(String archivoFileName) {
		this.archivoFileName = archivoFileName;
	}

	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}

	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}

	public FotoBean getF() {
		return f;
	}

	public void setF(FotoBean f) {
		this.f = f;
	}	
}
