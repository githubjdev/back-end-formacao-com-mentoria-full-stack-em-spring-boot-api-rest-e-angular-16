package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class CatgoriaProdutoDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;

	private String nomeDesc;

	private String empresa;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNomeDesc() {
		return nomeDesc;
	}

	public void setNomeDesc(String nomeDesc) {
		this.nomeDesc = nomeDesc;
	}

	public String getEmpresa() {
		return empresa;
	}

	public void setEmpresa(String empresa) {
		this.empresa = empresa;
	}

}
