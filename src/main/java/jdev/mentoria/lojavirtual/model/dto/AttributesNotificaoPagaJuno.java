package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class AttributesNotificaoPagaJuno implements Serializable {

	private static final long serialVersionUID = 1L;

	private String createdOn;
	private String date;
	private String releaseDate;
	private String amount;
	private String fee;
	private String status;
	private String type;

	private ChargeNotificaoPagApiJuno charge = new ChargeNotificaoPagApiJuno();

	private PixChargeJuno pix = new PixChargeJuno();

	private String digitalAccountId;

	public PixChargeJuno getPix() {
		return pix;
	}

	public void setPix(PixChargeJuno pix) {
		this.pix = pix;
	}

	public String getDigitalAccountId() {
		return digitalAccountId;
	}

	public void setDigitalAccountId(String digitalAccountId) {
		this.digitalAccountId = digitalAccountId;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public ChargeNotificaoPagApiJuno getCharge() {
		return charge;
	}

	public void setCharge(ChargeNotificaoPagApiJuno charge) {
		this.charge = charge;
	}

}
