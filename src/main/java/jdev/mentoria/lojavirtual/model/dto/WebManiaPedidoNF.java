package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class WebManiaPedidoNF implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 1 é prazo e 0 a vista*/
	private Integer pagamento;
	
	/*2 é pela internet*/
	private Integer presenca;
	private Integer modalidade_frete;
	private String frete;
	private String desconto;
	private String total;

	public Integer getPagamento() {
		return pagamento;
	}

	public void setPagamento(Integer pagamento) {
		this.pagamento = pagamento;
	}

	public Integer getPresenca() {
		return presenca;
	}

	public void setPresenca(Integer presenca) {
		this.presenca = presenca;
	}

	public Integer getModalidade_frete() {
		return modalidade_frete;
	}

	public void setModalidade_frete(Integer modalidade_frete) {
		this.modalidade_frete = modalidade_frete;
	}

	public String getFrete() {
		return frete;
	}

	public void setFrete(String frete) {
		this.frete = frete;
	}

	public String getDesconto() {
		return desconto;
	}

	public void setDesconto(String desconto) {
		this.desconto = desconto;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

}
