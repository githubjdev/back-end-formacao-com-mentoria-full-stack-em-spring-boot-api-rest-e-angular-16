package jdev.mentoria.lojavirtual.model.dto;

import java.util.ArrayList;

public class SendSettings {

	private ArrayList<String> selectedCampaigns = new ArrayList<String>();
	private ArrayList<String> selectedSegments = new ArrayList<String>();
	private ArrayList<String> selectedSuppressions = new ArrayList<String>();
	private ArrayList<String> excludedCampaigns = new ArrayList<String>();
	private ArrayList<String> excludedSegments = new ArrayList<String>();
	private ArrayList<String> selectedContacts = new ArrayList<String>();
	private String timeTravel = "false";
	private String perfectTiming = "false";

	public ArrayList<String> getSelectedCampaigns() {
		return selectedCampaigns;
	}

	public void setSelectedCampaigns(ArrayList<String> selectedCampaigns) {
		this.selectedCampaigns = selectedCampaigns;
	}

	public ArrayList<String> getSelectedSegments() {
		return selectedSegments;
	}

	public void setSelectedSegments(ArrayList<String> selectedSegments) {
		this.selectedSegments = selectedSegments;
	}

	public ArrayList<String> getSelectedSuppressions() {
		return selectedSuppressions;
	}

	public void setSelectedSuppressions(ArrayList<String> selectedSuppressions) {
		this.selectedSuppressions = selectedSuppressions;
	}

	public ArrayList<String> getExcludedCampaigns() {
		return excludedCampaigns;
	}

	public void setExcludedCampaigns(ArrayList<String> excludedCampaigns) {
		this.excludedCampaigns = excludedCampaigns;
	}

	public ArrayList<String> getExcludedSegments() {
		return excludedSegments;
	}

	public void setExcludedSegments(ArrayList<String> excludedSegments) {
		this.excludedSegments = excludedSegments;
	}

	public ArrayList<String> getSelectedContacts() {
		return selectedContacts;
	}

	public void setSelectedContacts(ArrayList<String> selectedContacts) {
		this.selectedContacts = selectedContacts;
	}

	public String getTimeTravel() {
		return timeTravel;
	}

	public void setTimeTravel(String timeTravel) {
		this.timeTravel = timeTravel;
	}

	public String getPerfectTiming() {
		return perfectTiming;
	}

	public void setPerfectTiming(String perfectTiming) {
		this.perfectTiming = perfectTiming;
	}

}
