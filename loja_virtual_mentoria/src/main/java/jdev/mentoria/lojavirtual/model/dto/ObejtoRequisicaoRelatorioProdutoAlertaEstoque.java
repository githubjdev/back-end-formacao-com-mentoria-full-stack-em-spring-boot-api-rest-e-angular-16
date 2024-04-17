package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

import javax.validation.constraints.NotEmpty;

public class ObejtoRequisicaoRelatorioProdutoAlertaEstoque implements Serializable {

	private static final long serialVersionUID = 1L;

	private String nomeProduto = "";

	@NotEmpty(message = "Informa a data inicial")
	private String dataInicial;

	@NotEmpty(message = "Informa a data final")
	private String dataFinal;
	private String codigoNota = "";
	private String codigoProduto = "";
	private String valorVendaProduto = "";
	private String quantidadeComprada = "";
	private String codigoFornecedor = "";
	private String nomeFornecedor = "";
	private String dataCompra = "";
	private String qtdEstoque;
	private String qtdAlertaEstoque;

	public String getQtdEstoque() {
		return qtdEstoque;
	}

	public void setQtdEstoque(String qtdEstoque) {
		this.qtdEstoque = qtdEstoque;
	}

	public String getQtdAlertaEstoque() {
		return qtdAlertaEstoque;
	}

	public void setQtdAlertaEstoque(String qtdAlertaEstoque) {
		this.qtdAlertaEstoque = qtdAlertaEstoque;
	}

	public String getValorVendaProduto() {
		return valorVendaProduto;
	}

	public void setValorVendaProduto(String valorVendaProduto) {
		this.valorVendaProduto = valorVendaProduto;
	}

	public String getQuantidadeComprada() {
		return quantidadeComprada;
	}

	public void setQuantidadeComprada(String quantidadeComprada) {
		this.quantidadeComprada = quantidadeComprada;
	}

	public String getCodigoFornecedor() {
		return codigoFornecedor;
	}

	public void setCodigoFornecedor(String codigoFornecedor) {
		this.codigoFornecedor = codigoFornecedor;
	}

	public String getNomeFornecedor() {
		return nomeFornecedor;
	}

	public void setNomeFornecedor(String nomeFornecedor) {
		this.nomeFornecedor = nomeFornecedor;
	}

	public String getDataCompra() {
		return dataCompra;
	}

	public void setDataCompra(String dataCompra) {
		this.dataCompra = dataCompra;
	}

	public String getNomeProduto() {
		return nomeProduto;
	}

	public void setNomeProduto(String nomeProduto) {
		this.nomeProduto = nomeProduto;
	}

	public String getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(String dataInicial) {
		this.dataInicial = dataInicial;
	}

	public String getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(String dataFinal) {
		this.dataFinal = dataFinal;
	}

	public String getCodigoNota() {
		return codigoNota;
	}

	public void setCodigoNota(String codigoNota) {
		this.codigoNota = codigoNota;
	}

	public String getCodigoProduto() {
		return codigoProduto;
	}

	public void setCodigoProduto(String codigoProduto) {
		this.codigoProduto = codigoProduto;
	}

}
