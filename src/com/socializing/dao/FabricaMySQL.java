package com.socializing.dao;

public class FabricaMySQL extends FabricaDAO{

	@Override
	public UsuarioDAO getUsuarioDao() {
		return new UsuarioDAOImp();
	}

}
