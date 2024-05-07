package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class RetornoPagamentoCartaoJuno implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String transactionId;
	private String installments;

	private List<PaymentsCartaoCredito> payments = new ArrayList<PaymentsCartaoCredito>();

	private List<Links> _links = new ArrayList<Links>();

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getInstallments() {
		return installments;
	}

	public void setInstallments(String installments) {
		this.installments = installments;
	}

	public List<PaymentsCartaoCredito> getPayments() {
		return payments;
	}

	public void setPayments(List<PaymentsCartaoCredito> payments) {
		this.payments = payments;
	}

	public List<Links> get_links() {
		return _links;
	}

	public void set_links(List<Links> _links) {
		this._links = _links;
	}

}
