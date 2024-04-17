package jdev.mentoria.lojavirtual.model.dto;

public class Payment {

	private String object;
	private String id;
	private String dateCreated;
	private String customer;
	private String installment = null;
	private String paymentLink = null;
	private float value;
	private float netValue;
	private String originalValue = null;
	private float interestValue;
	private String description = null;
	private String billingType;
	private String confirmedDate;
	private String pixTransaction;
	private String status;
	private String dueDate;
	private String originalDueDate;
	private String paymentDate;
	private String clientPaymentDate;
	private String installmentNumber = null;
	private String invoiceUrl;
	private String invoiceNumber;
	private String externalReference = null;
	private boolean deleted;
	private boolean anticipated;
	private boolean anticipable;
	private String creditDate;
	private String estimatedCreditDate = null;
	private String transactionReceiptUrl;
	private String bankSlipUrl = null;
	private String lastInvoiceViewedDate;
	private String lastBankSlipViewedDate = null;
	private Boolean postalService = false;

	public String getObject() {
		return object;
	}

	public void setObject(String object) {
		this.object = object;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getInstallment() {
		return installment;
	}

	public void setInstallment(String installment) {
		this.installment = installment;
	}

	public String getPaymentLink() {
		return paymentLink;
	}

	public void setPaymentLink(String paymentLink) {
		this.paymentLink = paymentLink;
	}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public float getNetValue() {
		return netValue;
	}

	public void setNetValue(float netValue) {
		this.netValue = netValue;
	}

	public String getOriginalValue() {
		return originalValue;
	}

	public void setOriginalValue(String originalValue) {
		this.originalValue = originalValue;
	}

	public float getInterestValue() {
		return interestValue;
	}

	public void setInterestValue(float interestValue) {
		this.interestValue = interestValue;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBillingType() {
		return billingType;
	}

	public void setBillingType(String billingType) {
		this.billingType = billingType;
	}

	public String getConfirmedDate() {
		return confirmedDate;
	}

	public void setConfirmedDate(String confirmedDate) {
		this.confirmedDate = confirmedDate;
	}

	public String getPixTransaction() {
		return pixTransaction;
	}

	public void setPixTransaction(String pixTransaction) {
		this.pixTransaction = pixTransaction;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public String getOriginalDueDate() {
		return originalDueDate;
	}

	public void setOriginalDueDate(String originalDueDate) {
		this.originalDueDate = originalDueDate;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getClientPaymentDate() {
		return clientPaymentDate;
	}

	public void setClientPaymentDate(String clientPaymentDate) {
		this.clientPaymentDate = clientPaymentDate;
	}

	public String getInstallmentNumber() {
		return installmentNumber;
	}

	public void setInstallmentNumber(String installmentNumber) {
		this.installmentNumber = installmentNumber;
	}

	public String getInvoiceUrl() {
		return invoiceUrl;
	}

	public void setInvoiceUrl(String invoiceUrl) {
		this.invoiceUrl = invoiceUrl;
	}

	public String getInvoiceNumber() {
		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	public String getExternalReference() {
		return externalReference;
	}

	public void setExternalReference(String externalReference) {
		this.externalReference = externalReference;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	public boolean isAnticipated() {
		return anticipated;
	}

	public void setAnticipated(boolean anticipated) {
		this.anticipated = anticipated;
	}

	public boolean isAnticipable() {
		return anticipable;
	}

	public void setAnticipable(boolean anticipable) {
		this.anticipable = anticipable;
	}

	public String getCreditDate() {
		return creditDate;
	}

	public void setCreditDate(String creditDate) {
		this.creditDate = creditDate;
	}

	public String getEstimatedCreditDate() {
		return estimatedCreditDate;
	}

	public void setEstimatedCreditDate(String estimatedCreditDate) {
		this.estimatedCreditDate = estimatedCreditDate;
	}

	public String getTransactionReceiptUrl() {
		return transactionReceiptUrl;
	}

	public void setTransactionReceiptUrl(String transactionReceiptUrl) {
		this.transactionReceiptUrl = transactionReceiptUrl;
	}

	public String getBankSlipUrl() {
		return bankSlipUrl;
	}

	public void setBankSlipUrl(String bankSlipUrl) {
		this.bankSlipUrl = bankSlipUrl;
	}

	public String getLastInvoiceViewedDate() {
		return lastInvoiceViewedDate;
	}

	public void setLastInvoiceViewedDate(String lastInvoiceViewedDate) {
		this.lastInvoiceViewedDate = lastInvoiceViewedDate;
	}

	public String getLastBankSlipViewedDate() {
		return lastBankSlipViewedDate;
	}

	public void setLastBankSlipViewedDate(String lastBankSlipViewedDate) {
		this.lastBankSlipViewedDate = lastBankSlipViewedDate;
	}

	public Boolean getPostalService() {
		return postalService;
	}

	public void setPostalService(Boolean postalService) {
		this.postalService = postalService;
	}

}
