package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class WebManiaProdutoNF implements Serializable {

	private static final long serialVersionUID = 1L;

	private String nome;
	private String codigo;
	private String ncm;
	private String cest;
	private Integer quantidade;
	private String unidade;
	private String peso;
	private Integer origem;
	private String subtotal;
	private String total;
	private String classe_imposto;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNcm() {
		return ncm;
	}

	public void setNcm(String ncm) {
		this.ncm = ncm;
	}

	public String getCest() {
		return cest;
	}

	public void setCest(String cest) {
		this.cest = cest;
	}

	public Integer getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}

	public String getUnidade() {
		return unidade;
	}

	public void setUnidade(String unidade) {
		this.unidade = unidade;
	}

	public String getPeso() {
		return peso;
	}

	public void setPeso(String peso) {
		this.peso = peso;
	}

	public Integer getOrigem() {
		return origem;
	}

	public void setOrigem(Integer origem) {
		this.origem = origem;
	}

	public String getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(String subtotal) {
		this.subtotal = subtotal;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getClasse_imposto() {
		return classe_imposto;
	}

	public void setClasse_imposto(String classe_imposto) {
		this.classe_imposto = classe_imposto;
	}

}
