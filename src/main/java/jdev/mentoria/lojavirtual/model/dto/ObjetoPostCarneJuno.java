package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class ObjetoPostCarneJuno implements Serializable {

	private static final long serialVersionUID = 1L;

	/* Descrição da cobrança */
	private String description;

	/* Nome do comprador ou cliente */
	private String payerName;

	/* Fone do cliente comprador */
	private String payerPhone;

	/* Valor da compra ou parcela */
	private String totalAmount;

	/* Quantidade de parcelas */
	private String installments;

	/* Referncia para produto da loja ou codigo do produto */
	private String reference;
	
	private String payerCpfCnpj;
	
	private String email;
	
	private Long idVenda;
	
	public void setIdVenda(Long idVenda) {
		this.idVenda = idVenda;
	}
	
	public Long getIdVenda() {
		return idVenda;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	public String getEmail() {
		return email;
	}
	
	public void setPayerCpfCnpj(String payerCpfCnpj) {
		this.payerCpfCnpj = payerCpfCnpj;
	}
	
	public String getPayerCpfCnpj() {
		return payerCpfCnpj;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPayerName() {
		return payerName;
	}

	public void setPayerName(String payerName) {
		this.payerName = payerName;
	}

	public String getPayerPhone() {
		return payerPhone;
	}

	public void setPayerPhone(String payerPhone) {
		this.payerPhone = payerPhone;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getInstallments() {
		return installments;
	}

	public void setInstallments(String installments) {
		this.installments = installments;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

}
