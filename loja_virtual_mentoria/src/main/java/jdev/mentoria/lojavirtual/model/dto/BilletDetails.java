package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class BilletDetails implements Serializable {

	private static final long serialVersionUID = 1L;

	private String bankAccount;
	private String ourNumber;
	private String barcodeNumber;
	private String portfolio;

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getOurNumber() {
		return ourNumber;
	}

	public void setOurNumber(String ourNumber) {
		this.ourNumber = ourNumber;
	}

	public String getBarcodeNumber() {
		return barcodeNumber;
	}

	public void setBarcodeNumber(String barcodeNumber) {
		this.barcodeNumber = barcodeNumber;
	}

	public String getPortfolio() {
		return portfolio;
	}

	public void setPortfolio(String portfolio) {
		this.portfolio = portfolio;
	}

}
