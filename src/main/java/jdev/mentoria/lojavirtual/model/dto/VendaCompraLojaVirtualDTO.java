package jdev.mentoria.lojavirtual.model.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import jdev.mentoria.lojavirtual.model.Endereco;
import jdev.mentoria.lojavirtual.model.Pessoa;

public class VendaCompraLojaVirtualDTO {

	private Long id;

	private BigDecimal valorTotal = BigDecimal.ZERO;

	private BigDecimal valorDesc = BigDecimal.ZERO;

	private Pessoa pessoa;

	private Endereco cobranca;

	private Endereco entrega;

	private BigDecimal valorFrete = BigDecimal.ZERO;

	private List<ItemVendaDTO> itemVendaLoja = new ArrayList<ItemVendaDTO>();

	public void setItemVendaLoja(List<ItemVendaDTO> itemVendaLoja) {
		this.itemVendaLoja = itemVendaLoja;
	}

	public List<ItemVendaDTO> getItemVendaLoja() {
		return itemVendaLoja;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setValorFrete(BigDecimal valorFrete) {
		this.valorFrete = valorFrete;
	}

	public BigDecimal getValorFrete() {
		return valorFrete;
	}

	public BigDecimal getValorDesc() {
		
		if (valorDesc == null) {
			return BigDecimal.ZERO;
		}
		
		return valorDesc;
	}

	public void setValorDesc(BigDecimal valorDesc) {
		this.valorDesc = valorDesc;
	}

	public Endereco getCobranca() {
		return cobranca;
	}

	public void setCobranca(Endereco cobranca) {
		this.cobranca = cobranca;
	}

	public Endereco getEntrega() {
		return entrega;
	}

	public void setEntrega(Endereco entrega) {
		this.entrega = entrega;
	}

	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}

	public Pessoa getPessoa() {
		return pessoa;
	}

	public void setValorTotal(BigDecimal valorTotal) {
		this.valorTotal = valorTotal;
	}

	public BigDecimal getValorTotal() {
		return valorTotal;
	}

}
