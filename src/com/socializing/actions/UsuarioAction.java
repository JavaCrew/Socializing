package com.socializing.actions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.dispatcher.SessionMap;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.socializing.entities.AlbumBean;
import com.socializing.entities.AmistadBean;
import com.socializing.entities.ComentarioBean;
import com.socializing.entities.ComentarioFotoBean;
import com.socializing.entities.EstadoBean;
import com.socializing.entities.FotoBean;
import com.socializing.entities.LikeBean;
import com.socializing.entities.UsuarioBean;
import com.socializing.services.UsuarioService;
import com.socializing.services.UsuarioServiceImp;

@ParentPackage(value = "s")
@SuppressWarnings("rawtypes")
@InterceptorRefs({ @InterceptorRef(value = "json", params = { "enableSMD", "true" }),
		@InterceptorRef("jsonValidationWorkflowStack"), @InterceptorRef("fileUpload"), @InterceptorRef("defaultStack")})
public class UsuarioAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static final Log log = LogFactory.getLog(UsuarioAction.class);
	private Map<String, Object> session = (Map<String, Object>) ActionContext.getContext().getSession();
	private SessionMap session_x = (SessionMap) ActionContext.getContext().getSession();
	private HttpServletResponse response = ServletActionContext.getResponse();
	UsuarioService service = new UsuarioServiceImp();
	private String correo;
	private String pwd;
	private String titulo;
	private String mensaje;
	private ArrayList<EstadoBean> lista_estados;
	private ArrayList<AmistadBean> lista_amigos;
	private ArrayList<EstadoBean> lista_estado_amigos;
	private ArrayList<AlbumBean> lista_albumes;
	private ArrayList<FotoBean> lista_fotos;
	private ArrayList<UsuarioBean> lista_usuarios;
	private ArrayList<AmistadBean> lista_solicitudes_amistad;
	private ArrayList<AlbumBean> galeria;
	private ArrayList<ComentarioFotoBean> lista_comentario_foto;
	private UsuarioBean u = new UsuarioBean();
	private EstadoBean e = new EstadoBean();
	private AlbumBean a = new AlbumBean();
	private LikeBean l = new LikeBean();
	private AmistadBean m = new AmistadBean();
	private ComentarioBean c = new ComentarioBean();
	private ComentarioFotoBean cf = new ComentarioFotoBean();
	private InputStream foto_perfil;
	private InputStream foto;
	private int id_album;
	private int id_estado;
	private int id_foto;
	private int usuario_solicitud;
	private int amigo_solicitud;
	private String nombre_album;
	private String term;
	private int flag;

	@Action(value = "/login", results = { @Result(location = "t_inicio", name = "success", type = "tiles"),
			@Result(location = "/index.jsp", name = "login") })
	public String Login() throws Exception {
		log.info("En Login - USUARIOACTION");
		log.info(correo);
		log.info(pwd);
		UsuarioBean bean = new UsuarioBean();
		bean.setCorreo(correo);
		bean.setPwd(pwd);
		UsuarioBean usuario = service.Login(bean);
		if (usuario == null) {
			titulo = "¡Datos Incorrectos!";
			mensaje = "Revisa tu USUARIO o PASSWORD";
			return LOGIN;
		} else {
			session.put("logged", usuario);
			return SUCCESS;
		}
	}

	@Action(value = "/verFotoPerfil", results = {
			@Result(params = { "inputName", "foto_perfil" }, name = "success", type = "stream") })
	public String VerFotoPerfil() throws Exception {
		try {
			UsuarioBean bean = (UsuarioBean) session.get("logged");
			foto_perfil = new ByteArrayInputStream(bean.getFoto_perfilBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(value = "/logout", results = { @Result(location = "/index.jsp", name = "success") })
	public String Logout() throws Exception {
		session_x.invalidate();
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		titulo = "¡Adiós!";
		mensaje = "Vuelve Pronto ... ";

		return SUCCESS;
	}

	@Action(value = "/cargarEstados", results = { @Result(name = "success", type = "json") })
	public String CargarEstados() throws Exception {
		log.info("En CargarEstados - USUARIOACTION");
		lista_estados = service.CargarEstados(((UsuarioBean) session.get("logged")).getUsuarioId());
		return SUCCESS;
	}

	@Action(value = "/cargarComentariosFoto", results = { @Result(name = "success", type = "json") })
	public String CargarComentariosFoto() throws Exception {
		log.info("En CargarComentariosFoto - USUARIOACTION");
		lista_comentario_foto = service.CargarComentariosFoto(id_foto);
		return SUCCESS;
	}

	@Action(value = "/cargarAmigos", results = { @Result(name = "success", type = "json") })
	public String CargarAmigos() throws Exception {
		log.info("En CargarAmigos - USUARIOACTION");
		lista_amigos = service.CargarAmigos(((UsuarioBean) session.get("logged")).getUsuarioId());
		session.put("lista_amigos", lista_amigos);
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Action(value = "/cargarEstadosAmigos", results = { @Result(name = "success", type = "json") })
	public String CargarEstadosAmigos() throws Exception {
		CargarAmigos();
		log.info("En CargarEstadosAmigos - USUARIOACTION");
		Map<String, Object> mapx = new HashMap<String, Object>();
		UsuarioBean user_logged = (UsuarioBean) session.get("logged");
		Set<Integer> ids = new HashSet<Integer>();
		for (AmistadBean x : (ArrayList<AmistadBean>) session.get("lista_amigos")) {
			ids.add(x.getAmigo().getUsuarioId());
			ids.add(x.getUsuario().getUsuarioId());
		}
		if (!ids.isEmpty()) {
			ids.add(user_logged.getUsuarioId());
			mapx.put("listado", ids);
			lista_estado_amigos = service.CargarEstadosAmigos(mapx);
		} else {
			ids.add(user_logged.getUsuarioId());
			mapx.put("listado", ids);
			lista_estado_amigos = service.CargarEstadosAmigos(mapx);
		}
		return SUCCESS;
	}

	@Action(value = "/registrarUsuario", results = {
			@Result(name = "success", type = "redirect", location = "login", params = { "correo", "${correo}", "pwd",
					"${pwd}" }) })
	public String RegistrarUsuario() throws Exception {
		log.info("En RegistrarUsuario - USUARIOACTION");
		service.RegistrarUsuario(u);
		correo = u.getCorreo();
		pwd = u.getPwd();
		return SUCCESS;
	}

	@Action(value = "/nuevoEstado", results = { @Result(name = "success", location = "t_inicio", type = "tiles"),
			@Result(name = "invalid.token", location = "t_inicio", type="tiles") })
	public String NuevoEstado() throws Exception {
		log.info("En NuevoEstado - USUARIOACTION");
		service.NuevoEstado(e);
		return SUCCESS;
	}

	@Action(value = "/nuevoComentario", results = { @Result(name = "success", type = "json") })
	public String NuevoComentario() throws Exception {
		log.info("En NuevoComentario - USUARIOACTION");
		e = service.NuevoComentario(c);
		return SUCCESS;
	}

	@Action(value = "/nuevoComentarioFoto", results = { @Result(name = "success", type = "json") })
	public String NuevoComentarioFoto() throws Exception {
		log.info("En NuevoComentarioFoto - USUARIOACTION");
		service.NuevoComentarioFoto(cf);
		return SUCCESS;
	}

	@Action(value = "/nuevoAlbum", results = { @Result(name = "success", location = "t_fotos", type = "tiles") })
	public String NuevoAlbum() throws Exception {
		log.info("En NuevoAlbum - USUARIOACTION");
		service.NuevoAlbum(a);
		return SUCCESS;
	}

	@Action(value = "/like", results = { @Result(name = "success", type = "json") })
	public String Like() throws Exception {
		log.info("En Like - USUARIOACTION");
		e = service.Like(l);
		return SUCCESS;
	}

	@Action(value = "/dislike", results = { @Result(name = "success", type = "json") })
	public String Dislike() throws Exception {
		log.info("En Dislike - USUARIOACTION");
		e = service.Dislike(l);
		return SUCCESS;
	}

	@Action(value = "/cargarGaleria", results = { @Result(name = "success", type = "json") })
	public String CargarGaleria() throws Exception {
		log.info("En CargarGaleria - USUARIOACTION");
		UsuarioBean x = (UsuarioBean) session.get("logged");
		galeria = service.CargarGaleria(x.getUsuarioId());
		return SUCCESS;
	}

	@Action(value = "/cargarFotosPorGaleria", results = {
			@Result(location = "t_albumes", name = "success", type = "tiles") })
	public String CargarFotosPorGaleria() throws Exception {
		log.info("En CargarFotosPorGaleria - USUARIOACTION");
		UsuarioBean x = (UsuarioBean) session.get("logged");
		lista_fotos = service.CargarFotoPorGaleria(x.getUsuarioId(), id_album);
		return SUCCESS;
	}

	@Action(value = "/buscarAmigos", results = { @Result(name = "success", type = "json") })
	public String BuscarAmigos() throws Exception {
		log.info("En BuscarAmigos - USUARIOACTION");
		lista_usuarios = service.BuscarAmigos(term);
		return SUCCESS;
	}

	@Action(value = "/irPerfil", results = { @Result(location = "t_perfil", name = "success", type = "tiles") })
	public String IrPerfil() throws Exception {
		log.info("En IrPerfil - USUARIOACTION");
		usuario_solicitud = ((UsuarioBean) session.get("logged")).getUsuarioId();
		u = service.BuscarUsuario(amigo_solicitud);
		m = service.ValidarAmistad(usuario_solicitud, amigo_solicitud);
		return SUCCESS;
	}

	@Action(value = "/enviarSolicitudAmistad", results = {
			@Result(name = "success", type = "redirect", location = "irPerfil", params = { "amigo_solicitud",
					"${amigo_solicitud}" }) })
	public String EnviarSolicitudAmistad() throws Exception {
		log.info("En EnviarSolicitudAmistad - USUARIOACTION");
		usuario_solicitud = ((UsuarioBean) session.get("logged")).getUsuarioId();
		service.EnviarSolicitudAmistad(usuario_solicitud, amigo_solicitud, flag);
		return SUCCESS;
	}

	@Action(value = "/cancelarSolicitudAmistad", results = {
			@Result(name = "success", type = "redirect", location = "irPerfil", params = { "amigo_solicitud",
					"${amigo_solicitud}" }) })
	public String CancelarSolicitudAmistad() throws Exception {
		log.info("En CancelarSolicitudAmistad - USUARIOACTION");
		service.CancelarSolicitudAmistad(m);
		return SUCCESS;
	}

	@Action(value = "/aceptarSolicitudAmistad", results = {
			@Result(name = "success", type = "redirect", location = "irPerfil", params = { "amigo_solicitud",
					"${amigo_solicitud}" }) })
	public String AceptarSolicitudAmistad() throws Exception {
		log.info("En AceptarSolicitudAmistad - USUARIOACTION");
		service.AceptarSolicitudAmistad(m);
		return SUCCESS;
	}

	@Action(value = "/buscarSolicitudAmistad", results = { @Result(name = "success", type = "json") })
	public String BuscarSolicitudAmistad() throws Exception {
		log.info("En BuscarSolicitudAmistad - USUARIOACTION");
		UsuarioBean x = (UsuarioBean) session.get("logged");
		lista_solicitudes_amistad = service.BuscarSolicitudesAmistad(x.getUsuarioId());
		return SUCCESS;
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

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public ArrayList<EstadoBean> getLista_estados() {
		return lista_estados;
	}

	public void setLista_estados(ArrayList<EstadoBean> lista_estados) {
		this.lista_estados = lista_estados;
	}

	public ArrayList<AmistadBean> getLista_amigos() {
		return lista_amigos;
	}

	public void setLista_amigos(ArrayList<AmistadBean> lista_amigos) {
		this.lista_amigos = lista_amigos;
	}

	public ArrayList<EstadoBean> getLista_estado_amigos() {
		return lista_estado_amigos;
	}

	public void setLista_estado_amigos(ArrayList<EstadoBean> lista_estado_amigos) {
		this.lista_estado_amigos = lista_estado_amigos;
	}

	public UsuarioBean getU() {
		return u;
	}

	public void setU(UsuarioBean u) {
		this.u = u;
	}

	public EstadoBean getE() {
		return e;
	}

	public void setE(EstadoBean e) {
		this.e = e;
	}

	public InputStream getFoto_perfil() {
		return foto_perfil;
	}

	public void setFoto_perfil(InputStream foto_perfil) {
		this.foto_perfil = foto_perfil;
	}

	public InputStream getFoto() {
		return foto;
	}

	public void setFoto(InputStream foto) {
		this.foto = foto;
	}

	public ArrayList<AlbumBean> getGaleria() {
		return galeria;
	}

	public void setGaleria(ArrayList<AlbumBean> galeria) {
		this.galeria = galeria;
	}

	public AlbumBean getA() {
		return a;
	}

	public void setA(AlbumBean a) {
		this.a = a;
	}

	public ArrayList<AlbumBean> getLista_albumes() {
		return lista_albumes;
	}

	public void setLista_albumes(ArrayList<AlbumBean> lista_albumes) {
		this.lista_albumes = lista_albumes;
	}

	public ArrayList<FotoBean> getLista_fotos() {
		return lista_fotos;
	}

	public void setLista_fotos(ArrayList<FotoBean> lista_fotos) {
		this.lista_fotos = lista_fotos;
	}

	public int getId_album() {
		return id_album;
	}

	public void setId_album(int id_album) {
		this.id_album = id_album;
	}

	public String getNombre_album() {
		return nombre_album;
	}

	public void setNombre_album(String nombre_album) {
		this.nombre_album = nombre_album;
	}

	public int getId_estado() {
		return id_estado;
	}

	public void setId_estado(int id_estado) {
		this.id_estado = id_estado;
	}

	public LikeBean getL() {
		return l;
	}

	public void setL(LikeBean l) {
		this.l = l;
	}

	public ArrayList<UsuarioBean> getLista_usuarios() {
		return lista_usuarios;
	}

	public void setLista_usuarios(ArrayList<UsuarioBean> lista_usuarios) {
		this.lista_usuarios = lista_usuarios;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public int getUsuario_solicitud() {
		return usuario_solicitud;
	}

	public void setUsuario_solicitud(int usuario_solicitud) {
		this.usuario_solicitud = usuario_solicitud;
	}

	public int getAmigo_solicitud() {
		return amigo_solicitud;
	}

	public void setAmigo_solicitud(int amigo_solicitud) {
		this.amigo_solicitud = amigo_solicitud;
	}

	public ComentarioBean getC() {
		return c;
	}

	public void setC(ComentarioBean c) {
		this.c = c;
	}

	public AmistadBean getM() {
		return m;
	}

	public void setM(AmistadBean m) {
		this.m = m;
	}

	public ArrayList<AmistadBean> getLista_solicitudes_amistad() {
		return lista_solicitudes_amistad;
	}

	public void setLista_solicitudes_amistad(ArrayList<AmistadBean> lista_solicitudes_amistad) {
		this.lista_solicitudes_amistad = lista_solicitudes_amistad;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public ArrayList<ComentarioFotoBean> getLista_comentario_foto() {
		return lista_comentario_foto;
	}

	public void setLista_comentario_foto(ArrayList<ComentarioFotoBean> lista_comentario_foto) {
		this.lista_comentario_foto = lista_comentario_foto;
	}

	public int getId_foto() {
		return id_foto;
	}

	public void setId_foto(int id_foto) {
		this.id_foto = id_foto;
	}

	public ComentarioFotoBean getCf() {
		return cf;
	}

	public void setCf(ComentarioFotoBean cf) {
		this.cf = cf;
	}
}
