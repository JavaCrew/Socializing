package com.socializing.dao;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.socializing.entities.AlbumBean;
import com.socializing.entities.AmistadBean;
import com.socializing.entities.ComentarioBean;
import com.socializing.entities.ComentarioFotoBean;
import com.socializing.entities.EstadoBean;
import com.socializing.entities.FotoBean;
import com.socializing.entities.LikeBean;
import com.socializing.entities.UsuarioBean;
import com.socializing.util.Constantes;

public class UsuarioDAOImp implements UsuarioDAO {	
	SqlSessionFactory sqlMapper = null;
	{
		String archivo = "ConfiguracionIbatis.xml";
		try {
			Reader reader = Resources.getResourceAsReader(archivo);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public UsuarioBean Login(UsuarioBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		UsuarioBean x = null;
		try {
			x = (UsuarioBean) session.selectOne("s.SQL_LOGIN", bean);
			return x;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	@SuppressWarnings("unchecked")	
	public ArrayList<EstadoBean> CargarEstados(int id) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<EstadoBean> listado = null;
		try {
			listado =  (ArrayList<EstadoBean>)session.selectList("s.SQL_CARGAR_ESTADOS", id);
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<AmistadBean> CargarAmigos(int id) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<AmistadBean> listado = null;
		try {
			listado =  (ArrayList<AmistadBean>)session.selectList("s.SQL_CARGAR_AMIGOS", id);
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<EstadoBean> CargarEstadosAmigos(Map<String, Object> map)
			throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<EstadoBean> listado = null;
		try {		
			listado =  (ArrayList<EstadoBean>)session.selectList("s.SQL_CARGAR_ESTADOS_AMIGOS", map);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	public int RegistrarUsuario(UsuarioBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {		
			flag = session.insert("s.SQL_REGISTRA_USUARIO",bean);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;	
	}


	@Override
	public int NuevaFoto(FotoBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {	
			bean.setFotoBytes(Constantes.getBytesFromFile(bean.getFoto()));
			flag = session.insert("s.SQL_NUEVA_FOTO",bean);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;
	}

	@Override
	public int ActualizarUsuario(UsuarioBean bean) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int NuevoEstado(EstadoBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {		
			flag = session.insert("s.SQL_NUEVO_ESTADO",bean);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;	
	}

	@Override
	public int NuevaFotoPerfil(UsuarioBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {		
			bean.setFoto_perfilBytes(Constantes.getBytesFromFile(bean.getFoto_perfil()));
			flag = session.insert("s.SQL_NUEVA_FOTO_PERFIL",bean);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;
	}	

	@Override
	public int NuevaFotoPortada(UsuarioBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {			
			bean.setFoto_portadaBytes(Constantes.getBytesFromFile(bean.getFoto_portada()));
			flag = session.insert("s.SQL_NUEVA_FOTO_PORTADA",bean);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;
	}

	@Override
	@SuppressWarnings("unchecked")	
	public ArrayList<AlbumBean> CargarGaleria(int id) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<AlbumBean> listado = null;
		try {		
			listado =  (ArrayList<AlbumBean>)session.selectList("s.SQL_CARGAR_GALERIA",id);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	public int NuevoAlbum(AlbumBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		int flag = 0;
		try {		
			flag = session.insert("s.SQL_NUEVO_ALBUM",bean);
			session.commit();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return flag;	
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<FotoBean> CargarFotoPorGaleria(int id, int id_album) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<FotoBean> listado = null;
		Map<String, Object> mapx = new HashMap<String, Object>();
		mapx.put("id", id);
		mapx.put("id_album", id_album);		
		try {		
			listado =  (ArrayList<FotoBean>)session.selectList("s.SQL_CARGAR_FOTOS_X_GALERIA", mapx);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public EstadoBean Like(LikeBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		EstadoBean esb = null;
		int id = 0;
		try {		
			session.insert("s.SQL_LIKE", bean);
			id = bean.getEstado_like().getEstadoId();
			esb = (EstadoBean)session.selectOne("s.SQL_CARGAR_ESTADO_LIKE",id);			
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return esb;
	}

	@Override
	public EstadoBean Dislike(LikeBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		EstadoBean esb = null;
		int id = 0;
		try {		
			session.insert("s.SQL_DISLIKE", bean);
			id = bean.getEstado_like().getEstadoId();
			esb = (EstadoBean)session.selectOne("s.SQL_CARGAR_ESTADO_LIKE",id);			
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return esb;
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<UsuarioBean> BuscarAmigos(String term) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<UsuarioBean> listado = null;
		try {		
			listado =  (ArrayList<UsuarioBean>)session.selectList("s.SQL_BUSCAR_AMIGOS",term);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	public UsuarioBean BuscarUsuario(int id) throws Exception {
		SqlSession session = sqlMapper.openSession();
		UsuarioBean u = null;
		try {		
			u = (UsuarioBean)session.selectOne("s.SQL_BUSCAR_USUARIO",id);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return u;
	}

	@Override
	public EstadoBean NuevoComentario(ComentarioBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();
		EstadoBean esb = null;
		int id = 0;
		try {		
			session.insert("s.SQL_NUEVO_COMENTARIO",bean);
			id = bean.getEstado_comentario().getEstadoId();
			esb = (EstadoBean)session.selectOne("s.SQL_CARGAR_ESTADO_LIKE", id);
			session.commit();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return esb;	
	}

	@Override
	public AmistadBean ValidarAmistad(int u, int a) throws Exception {
		SqlSession session = sqlMapper.openSession();
		Map<String, Object> mapx = new HashMap<String, Object>();		
		mapx.put("u", u);
		mapx.put("a", a);
		AmistadBean x = null;
		try {		
			x = (AmistadBean)session.selectOne("s.SQL_VALIDAR_AMISTAD",mapx);			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return x;
	}

	@Override
	public int EnviarSolicitudAmistad(int u, int a, int flag) throws Exception {
		SqlSession session = sqlMapper.openSession();
		Map<String, Object> mapx = new HashMap<String, Object>();
		mapx.put("u", u);
		mapx.put("a", a);		
		mapx.put("flag", flag);
		int x = 0;
		try {		
			x = session.insert("s.SQL_ENVIAR_SOLICITUD_AMISTAD",mapx);	
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return x;
	}

	@Override
	public int CancelarSolicitudAmistad(AmistadBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();		
		int x = 0;
		try {		
			x = session.delete("s.SQL_CANCELAR_SOLICITUD_AMISTAD", bean);	
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return x;
	}

	@Override
	@SuppressWarnings("unchecked")	
	public ArrayList<AmistadBean> BuscarSolicitudesAmistad(int id)
			throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<AmistadBean> listado = null;
		try {		
			listado =  (ArrayList<AmistadBean>)session.selectList("s.SQL_BUSCAR_SOLICITUDES_AMISTAD", id);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	public int AceptarSolicitudAmistad(AmistadBean bean) throws Exception {
		SqlSession session = sqlMapper.openSession();		
		int x = 0;
		try {		
			x = session.update("s.SQL_ACEPTAR_SOLICITUD_AMISTAD", bean);	
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}			
		return x;
	}

	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<AmistadBean> CargarDirectorio(int id) throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<AmistadBean> listado = null;
		try {		
			listado =  (ArrayList<AmistadBean>)session.selectList("s.SQL_CARGAR_DIRECTORIO", id);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	@SuppressWarnings("unchecked")	
	public ArrayList<ComentarioFotoBean> CargarComentariosFoto(int id)
			throws Exception {
		SqlSession session = sqlMapper.openSession();
		ArrayList<ComentarioFotoBean> listado = null;
		try {		
			listado =  (ArrayList<ComentarioFotoBean>)session.selectList("s.SQL_CARGAR_COMENTARIOS_FOTO",id);		
			return listado;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	@Override
	public int NuevoComentarioFoto(ComentarioFotoBean bean) throws Exception {		
		SqlSession session = sqlMapper.openSession();		
		int vr = 0;
		try {
			vr = session.insert("s.SQL_NUEVO_COMENTARIO_FOTO", bean);
			session.commit();			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return vr;

	}	
}
