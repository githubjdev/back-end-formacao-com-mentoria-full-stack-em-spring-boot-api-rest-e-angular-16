package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class CampanhaGetResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	private String description;
	private String campaignId;
	private String name;
	private String techName;
	private String languageCode;
	private String isDefault;
	private String createdOn;
	private String href;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCampaignId() {
		return campaignId;
	}

	public void setCampaignId(String campaignId) {
		this.campaignId = campaignId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTechName() {
		return techName;
	}

	public void setTechName(String techName) {
		this.techName = techName;
	}

	public String getLanguageCode() {
		return languageCode;
	}

	public void setLanguageCode(String languageCode) {
		this.languageCode = languageCode;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	@Override
	public String toString() {
		return "CampanhaGetResponse [description=" + description + ", campaignId=" + campaignId + ", name=" + name
				+ ", techName=" + techName + ", languageCode=" + languageCode + ", isDefault=" + isDefault
				+ ", createdOn=" + createdOn + ", href=" + href + "]";
	}

}
