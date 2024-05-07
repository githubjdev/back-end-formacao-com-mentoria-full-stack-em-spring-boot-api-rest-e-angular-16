package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class LeadCampanhaGetResponseCastrado implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String campaignId;

	public String getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}

}
