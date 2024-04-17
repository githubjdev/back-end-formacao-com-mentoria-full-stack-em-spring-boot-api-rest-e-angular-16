package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class PagamentoCartaoCredito implements Serializable {

	private static final long serialVersionUID = 1L;

	private String chargeId = "";

	private BillingCartaoCredito billing = new BillingCartaoCredito();

	private CreditCardDetails creditCardDetails = new CreditCardDetails();

	public String getChargeId() {
		return chargeId;
	}

	public void setChargeId(String chargeId) {
		this.chargeId = chargeId;
	}

	public BillingCartaoCredito getBilling() {
		return billing;
	}

	public void setBilling(BillingCartaoCredito billing) {
		this.billing = billing;
	}

	public CreditCardDetails getCreditCardDetails() {
		return creditCardDetails;
	}

	public void setCreditCardDetails(CreditCardDetails creditCardDetails) {
		this.creditCardDetails = creditCardDetails;
	}

}
