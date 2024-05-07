package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class CreditCardDetails implements Serializable {

	private static final long serialVersionUID = 1L;

	private String creditCardId = "";
	private String creditCardHash = "";

	public String getCreditCardId() {
		return creditCardId;
	}

	public void setCreditCardId(String creditCardId) {
		this.creditCardId = creditCardId;
	}

	public String getCreditCardHash() {
		return creditCardHash;
	}

	public void setCreditCardHash(String creditCardHash) {
		this.creditCardHash = creditCardHash;
	}

}
