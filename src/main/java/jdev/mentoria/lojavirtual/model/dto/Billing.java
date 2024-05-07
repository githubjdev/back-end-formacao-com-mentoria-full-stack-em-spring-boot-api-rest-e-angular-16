package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class Billing implements Serializable {

	private static final long serialVersionUID = 1L;

	private String name;
	private String document;
	private String email;

	private String phone;

	private boolean notify = true;

	public String getName() {
		return name;
	}

	public void setName(String nome) {
		this.name = nome;
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean isNotify() {
		return notify;
	}

	public void setNotify(boolean notify) {
		this.notify = notify;
	}

}
