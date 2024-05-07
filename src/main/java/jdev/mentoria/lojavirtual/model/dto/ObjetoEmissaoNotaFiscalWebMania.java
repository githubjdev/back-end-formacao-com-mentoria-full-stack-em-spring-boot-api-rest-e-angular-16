
package jdev.mentoria.lojavirtual.model.dto;

public class ObjetoEmissaoNotaFiscalWebMania {
	private String uuid;
	private String status;
	private String motivo;
	private String nfe;
	private String serie;
	private String chave;
	private String modelo;
	private String xml;
	private String danfe;
	private String danfe_simples;
	private String danfe_etiqueta;
	private Log LogObject;
	private float recibo;

	// Getter Methods

	public String getUuid() {
		return uuid;
	}

	public String getStatus() {
		return status;
	}

	public String getMotivo() {
		return motivo;
	}

	public String getNfe() {
		return nfe;
	}

	public String getSerie() {
		return serie;
	}

	public String getChave() {
		return chave;
	}

	public String getModelo() {
		return modelo;
	}

	public String getXml() {
		return xml;
	}

	public String getDanfe() {
		return danfe;
	}

	public String getDanfe_simples() {
		return danfe_simples;
	}

	public String getDanfe_etiqueta() {
		return danfe_etiqueta;
	}

	public Log getLog() {
		return LogObject;
	}

	public float getRecibo() {
		return recibo;
	}

	// Setter Methods

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public void setNfe(String nfe) {
		this.nfe = nfe;
	}

	public void setSerie(String serie) {
		this.serie = serie;
	}

	public void setChave(String chave) {
		this.chave = chave;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}

	public void setDanfe(String danfe) {
		this.danfe = danfe;
	}

	public void setDanfe_simples(String danfe_simples) {
		this.danfe_simples = danfe_simples;
	}

	public void setDanfe_etiqueta(String danfe_etiqueta) {
		this.danfe_etiqueta = danfe_etiqueta;
	}

	public void setLog(Log logObject) {
		this.LogObject = logObject;
	}

	public void setRecibo(float recibo) {
		this.recibo = recibo;
	}
}
