package com.socializing.dao;

public abstract class FabricaDAO {
	public static final int MYSQL = 1;

	public abstract UsuarioDAO getUsuarioDao();

	public static FabricaDAO getFactorty(int bd) {
		switch (bd) {
		case MYSQL:
			return new FabricaMySQL();
		}
		return null;
	}

}
