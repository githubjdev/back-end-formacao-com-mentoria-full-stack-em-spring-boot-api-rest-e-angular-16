package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;

public class AttibutesNotificaoPagaApiJuno implements Serializable {

	private static final long serialVersionUID = 1L;

	private String entityId;
	private String entityType;

	private AttributesNotificaoPagaJuno attributes = new AttributesNotificaoPagaJuno();

	public String getEntityId() {
		return entityId;
	}

	public void setEntityId(String entityId) {
		this.entityId = entityId;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public AttributesNotificaoPagaJuno getAttributes() {
		return attributes;
	}

	public void setAttributes(AttributesNotificaoPagaJuno attributes) {
		this.attributes = attributes;
	}

}
