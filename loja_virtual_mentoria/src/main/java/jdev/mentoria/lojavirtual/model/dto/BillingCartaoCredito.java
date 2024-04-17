package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class BillingCartaoCredito implements Serializable {

	private static final long serialVersionUID = 1L;

	private String email = "";

	private boolean delayed = false;

	private AddressCartaoCredito address = new AddressCartaoCredito();

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isDelayed() {
		return delayed;
	}

	public void setDelayed(boolean delayed) {
		this.delayed = delayed;
	}

	public AddressCartaoCredito getAddress() {
		return address;
	}

	public void setAddress(AddressCartaoCredito address) {
		this.address = address;
	}

}
