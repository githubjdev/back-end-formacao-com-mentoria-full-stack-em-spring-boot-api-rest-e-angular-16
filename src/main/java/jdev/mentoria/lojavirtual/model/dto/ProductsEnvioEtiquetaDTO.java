package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class ProductsEnvioEtiquetaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String name;
	private String quantity;
	private String unitary_value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getUnitary_value() {
		return unitary_value;
	}

	public void setUnitary_value(String unitary_value) {
		this.unitary_value = unitary_value;
	}

}
