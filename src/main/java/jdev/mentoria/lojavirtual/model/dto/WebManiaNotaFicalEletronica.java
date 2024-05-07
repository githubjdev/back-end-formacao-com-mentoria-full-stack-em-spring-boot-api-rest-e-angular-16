package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class WebManiaNotaFicalEletronica implements Serializable {

	private static final long serialVersionUID = 1L;

	private String ID;

	private String url_notificacao;
	
	/*1 é saíd e 0 é entrada*/
	private Integer operacao;
	private String natureza_operacao;
	private String modelo;
	private Integer finalidade;
	
	
	/* 1 é Produção e 2 Homologação*/
	private Integer ambiente;

	private WebManiaClienteNF cliente = new WebManiaClienteNF();

	private List<WebManiaProdutoNF> produtos = new ArrayList<WebManiaProdutoNF>();

	private WebManiaPedidoNF pedido = new WebManiaPedidoNF();

	public WebManiaClienteNF getCliente() {
		return cliente;
	}

	public void setCliente(WebManiaClienteNF cliente) {
		this.cliente = cliente;
	}

	public List<WebManiaProdutoNF> getProdutos() {
		return produtos;
	}

	public void setProdutos(List<WebManiaProdutoNF> produtos) {
		this.produtos = produtos;
	}

	public WebManiaPedidoNF getPedido() {
		return pedido;
	}

	public void setPedido(WebManiaPedidoNF pedido) {
		this.pedido = pedido;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getUrl_notificacao() {
		return url_notificacao;
	}

	public void setUrl_notificacao(String url_notificacao) {
		this.url_notificacao = url_notificacao;
	}

	public Integer getOperacao() {
		return operacao;
	}

	public void setOperacao(Integer operacao) {
		this.operacao = operacao;
	}

	public String getNatureza_operacao() {
		return natureza_operacao;
	}

	public void setNatureza_operacao(String natureza_operacao) {
		this.natureza_operacao = natureza_operacao;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public Integer getFinalidade() {
		return finalidade;
	}

	public void setFinalidade(Integer finalidade) {
		this.finalidade = finalidade;
	}

	public Integer getAmbiente() {
		return ambiente;
	}

	public void setAmbiente(Integer ambiente) {
		this.ambiente = ambiente;
	}

}
