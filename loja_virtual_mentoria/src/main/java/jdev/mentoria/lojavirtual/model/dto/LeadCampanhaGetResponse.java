package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class LeadCampanhaGetResponse implements Serializable {

	private static final long serialVersionUID = 1L;

	private String name;
	private String email;
	private String dayOfCycle = "0";
	private String scoring;
	//private String ipAddress;

	private LeadCampanhaGetResponseCastrado campaign = new LeadCampanhaGetResponseCastrado();

	private List<String> tags = new ArrayList<String>();

	private List<CustomFieldValuesGetResponse> customFieldValues = new ArrayList<CustomFieldValuesGetResponse>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDayOfCycle() {
		return dayOfCycle;
	}

	public void setDayOfCycle(String dayOfCycle) {
		this.dayOfCycle = dayOfCycle;
	}

	public String getScoring() {
		return scoring;
	}

	public void setScoring(String scoring) {
		this.scoring = scoring;
	}

	/*public String getIpAddress() {
		return ipAddress;
	}*/

	/*public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}*/

	public LeadCampanhaGetResponseCastrado getCampaign() {
		return campaign;
	}

	public void setCampaign(LeadCampanhaGetResponseCastrado campaign) {
		this.campaign = campaign;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public List<CustomFieldValuesGetResponse> getCustomFieldValues() {
		return customFieldValues;
	}

	public void setCustomFieldValues(List<CustomFieldValuesGetResponse> customFieldValues) {
		this.customFieldValues = customFieldValues;
	}

}
