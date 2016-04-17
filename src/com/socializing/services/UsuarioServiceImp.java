package com.socializing.services;

import java.util.ArrayList;
import java.util.Map;

import com.socializing.dao.FabricaDAO;
import com.socializing.dao.UsuarioDAO;
import com.socializing.entities.AlbumBean;
import com.socializing.entities.AmistadBean;
import com.socializing.entities.ComentarioBean;
import com.socializing.entities.ComentarioFotoBean;
import com.socializing.entities.EstadoBean;
import com.socializing.entities.FotoBean;
import com.socializing.entities.LikeBean;
import com.socializing.entities.UsuarioBean;

public class UsuarioServiceImp implements UsuarioService {

	FabricaDAO factoria = FabricaDAO.getFactorty(FabricaDAO.MYSQL);
	UsuarioDAO dao = factoria.getUsuarioDao();

	@Override
	public UsuarioBean Login(UsuarioBean bean) throws Exception {
		return dao.Login(bean);
	}

	@Override
	public ArrayList<EstadoBean> CargarEstados(int id) throws Exception {
		return dao.CargarEstados(id);
	}

	@Override
	public ArrayList<AmistadBean> CargarAmigos(int id) throws Exception {
		return dao.CargarAmigos(id);
	}

	@Override
	public ArrayList<EstadoBean> CargarEstadosAmigos(Map<String, Object> map) throws Exception {
		return dao.CargarEstadosAmigos(map);
	}

	@Override
	public int RegistrarUsuario(UsuarioBean bean) throws Exception {
		return dao.RegistrarUsuario(bean);
	}

	@Override
	public int NuevoEstado(EstadoBean bean) throws Exception {
		return dao.NuevoEstado(bean);
	}

	@Override
	public int NuevaFoto(FotoBean bean) throws Exception {
		return dao.NuevaFoto(bean);
	}

	@Override
	public int NuevaFotoPerfil(UsuarioBean bean) throws Exception {
		return dao.NuevaFotoPerfil(bean);
	}

	@Override
	public int NuevaFotoPortada(UsuarioBean bean) throws Exception {
		return dao.NuevaFotoPortada(bean);
	}

	@Override
	public ArrayList<AlbumBean> CargarGaleria(int id) throws Exception {
		return dao.CargarGaleria(id);
	}

	@Override
	public int NuevoAlbum(AlbumBean bean) throws Exception {
		return dao.NuevoAlbum(bean);
	}

	@Override
	public ArrayList<FotoBean> CargarFotoPorGaleria(int id, int id_album) throws Exception {
		return dao.CargarFotoPorGaleria(id, id_album);
	}

	@Override
	public EstadoBean Like(LikeBean bean) throws Exception {
		return dao.Like(bean);
	}

	@Override
	public EstadoBean Dislike(LikeBean bean) throws Exception {
		return dao.Dislike(bean);
	}

	@Override
	public ArrayList<UsuarioBean> BuscarAmigos(String term) throws Exception {
		return dao.BuscarAmigos(term);
	}

	@Override
	public UsuarioBean BuscarUsuario(int id) throws Exception {
		return dao.BuscarUsuario(id);
	}

	@Override
	public EstadoBean NuevoComentario(ComentarioBean bean) throws Exception {
		return dao.NuevoComentario(bean);
	}

	@Override
	public AmistadBean ValidarAmistad(int u, int a) throws Exception {
		return dao.ValidarAmistad(u, a);
	}

	@Override
	public int EnviarSolicitudAmistad(int u, int a, int flag) throws Exception {
		return dao.EnviarSolicitudAmistad(u, a, flag);
	}

	@Override
	public int CancelarSolicitudAmistad(AmistadBean bean) throws Exception {
		return dao.CancelarSolicitudAmistad(bean);
	}

	@Override
	public ArrayList<AmistadBean> BuscarSolicitudesAmistad(int id) throws Exception {
		return dao.BuscarSolicitudesAmistad(id);
	}

	@Override
	public int AceptarSolicitudAmistad(AmistadBean bean) throws Exception {
		return dao.AceptarSolicitudAmistad(bean);
	}

	@Override
	public ArrayList<AmistadBean> CargarDirectorio(int id) throws Exception {
		return dao.CargarDirectorio(id);
	}

	@Override
	public ArrayList<ComentarioFotoBean> CargarComentariosFoto(int id) throws Exception {
		return dao.CargarComentariosFoto(id);
	}

	@Override
	public int NuevoComentarioFoto(ComentarioFotoBean bean) throws Exception {
		return dao.NuevoComentarioFoto(bean);
	}

	@Override
	public int ContarAmigos(int id) throws Exception {
		return dao.ContarAmigos(id);
	}

	@Override
	public int ContarEstados(int id) throws Exception {
		return dao.ContarEstados(id);
	}

	@Override
	public int EditarPerfil(UsuarioBean bean) throws Exception {
		return dao.EditarPerfil(bean);
	}

	@Override
	public int ValidarPassword(UsuarioBean bean) throws Exception {
		return dao.ValidarPassword(bean);
	}

	@Override
	public int CambiarPassword(UsuarioBean bean) throws Exception {
		return dao.CambiarPassword(bean);
	}
}
