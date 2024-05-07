package jdev.mentoria.lojavirtual.model.dto;

public class CobrancaApiAsaas {

	private String customer;
	private String billingType;
	private String dueDate;
	private float value;
	private String description;
	private String externalReference;
	private float installmentValue;
	private Integer installmentCount;

	private DiscontCobancaAsaas discount = new DiscontCobancaAsaas();
	private FineConbrancaAsaas fine = new FineConbrancaAsaas();
	private InterestCobrancaAsass interest = new InterestCobrancaAsass();

	private boolean postalService = false;

	public float getInstallmentValue() {
		return installmentValue;
	}

	public void setInstallmentValue(float installmentValue) {
		this.installmentValue = installmentValue;
	}

	public Integer getInstallmentCount() {
		return installmentCount;
	}

	public void setInstallmentCount(Integer installmentCount) {
		this.installmentCount = installmentCount;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getBillingType() {
		return billingType;
	}

	public void setBillingType(String billingType) {
		this.billingType = billingType;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getExternalReference() {
		return externalReference;
	}

	public void setExternalReference(String externalReference) {
		this.externalReference = externalReference;
	}

	public DiscontCobancaAsaas getDiscount() {
		return discount;
	}

	public void setDiscount(DiscontCobancaAsaas discount) {
		this.discount = discount;
	}

	public FineConbrancaAsaas getFine() {
		return fine;
	}

	public void setFine(FineConbrancaAsaas fine) {
		this.fine = fine;
	}

	public InterestCobrancaAsass getInterest() {
		return interest;
	}

	public void setInterest(InterestCobrancaAsass interest) {
		this.interest = interest;
	}

	public boolean isPostalService() {
		return postalService;
	}

	public void setPostalService(boolean postalService) {
		this.postalService = postalService;
	}

}
