package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class EmpresaTransporteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String nome;
	private String valor;
	private String empresa;
	private String picture;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public String getEmpresa() {
		return empresa;
	}

	public void setEmpresa(String empresa) {
		this.empresa = empresa;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public boolean dadosOK() {
		
		if (id != null && empresa != null && valor != null && nome != null) {
			return true;
		}
		
		return false;
	}

}
