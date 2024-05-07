package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class CobrancaJunoAPI implements Serializable {

	private static final long serialVersionUID = 1L;

	private Charge charge = new Charge();

	private Billing billing = new Billing();

	public Charge getCharge() {
		return charge;
	}

	public void setCharge(Charge charge) {
		this.charge = charge;
	}

	public Billing getBilling() {
		return billing;
	}

	public void setBilling(Billing billing) {
		this.billing = billing;
	}

}
