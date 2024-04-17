package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class ProductsDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private String id;
	private String width;
	private String height;
	private String length;
	private String weight;
	private String insurance_value;
	private String quantity;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getLength() {
		return length;
	}

	public void setLength(String length) {
		this.length = length;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getInsurance_value() {
		return insurance_value;
	}

	public void setInsurance_value(String insurance_value) {
		this.insurance_value = insurance_value;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

}
