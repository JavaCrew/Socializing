package com.socializing.dao;

import java.util.ArrayList;
import java.util.Map;

import com.socializing.entities.AlbumBean;
import com.socializing.entities.AmistadBean;
import com.socializing.entities.ComentarioBean;
import com.socializing.entities.ComentarioFotoBean;
import com.socializing.entities.EstadoBean;
import com.socializing.entities.FotoBean;
import com.socializing.entities.LikeBean;
import com.socializing.entities.UsuarioBean;

public interface UsuarioDAO {
	public UsuarioBean Login(UsuarioBean bean) throws Exception;
	public ArrayList<EstadoBean> CargarEstados(int id) throws Exception;
	public ArrayList<AmistadBean> CargarAmigos(int id) throws Exception;
	public ArrayList<EstadoBean> CargarEstadosAmigos(Map<String, Object> map) throws Exception;
	public int RegistrarUsuario(UsuarioBean bean) throws Exception;
	public int NuevoEstado(EstadoBean bean) throws Exception;
	public int NuevaFoto(FotoBean bean) throws Exception;
	public int NuevaFotoPerfil(UsuarioBean bean) throws Exception;
	public int NuevaFotoPortada(UsuarioBean bean) throws Exception;
	public ArrayList<AlbumBean> CargarGaleria(int id) throws Exception;
	public ArrayList<FotoBean> CargarFotoPorGaleria(int id, int id_album) throws Exception;
	public int NuevoAlbum(AlbumBean bean) throws Exception;
	public EstadoBean Like(LikeBean bean) throws Exception;
	public EstadoBean Dislike(LikeBean bean) throws Exception;
	public ArrayList<UsuarioBean> BuscarAmigos(String term) throws Exception;
	public UsuarioBean BuscarUsuario(int id) throws Exception;
	public EstadoBean NuevoComentario(ComentarioBean bean) throws Exception;
	public int NuevoComentarioFoto(ComentarioFotoBean bean) throws Exception;
	public AmistadBean ValidarAmistad(int u, int a) throws Exception;	
	public int EnviarSolicitudAmistad(int u, int a, int flag) throws Exception;
	public int CancelarSolicitudAmistad(AmistadBean bean) throws Exception;
	public ArrayList<AmistadBean> BuscarSolicitudesAmistad(int id) throws Exception;
	public int AceptarSolicitudAmistad (AmistadBean bean) throws Exception;
	public ArrayList<AmistadBean> CargarDirectorio(int id) throws Exception;
	public ArrayList<ComentarioFotoBean> CargarComentariosFoto(int id) throws Exception;
	public int ContarAmigos(int id) throws Exception;
	public int ContarEstados(int id) throws Exception;
	public int EditarPerfil(UsuarioBean bean) throws Exception;
	public int ValidarPassword(UsuarioBean bean) throws Exception;
	public int CambiarPassword(UsuarioBean bean) throws Exception;
}
