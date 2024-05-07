package jdev.mentoria.lojavirtual.model.dto;

public class ObjetoFromFieldIdGetResponse {

	private String fromFieldId;
	private String email;
	private String name;
	private String isDefault;
	private String isActive;
	private String createdOn;
	private String href;

	public String getFromFieldId() {
		return fromFieldId;
	}

	public void setFromFieldId(String fromFieldId) {
		this.fromFieldId = fromFieldId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
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

}
