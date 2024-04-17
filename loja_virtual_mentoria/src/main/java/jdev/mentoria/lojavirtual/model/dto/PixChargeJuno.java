package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class PixChargeJuno implements Serializable {

	private static final long serialVersionUID = 1L;

	private String txid;
	private String endToEndId;

	public String getTxid() {
		return txid;
	}

	public void setTxid(String txid) {
		this.txid = txid;
	}

	public String getEndToEndId() {
		return endToEndId;
	}

	public void setEndToEndId(String endToEndId) {
		this.endToEndId = endToEndId;
	}

}
