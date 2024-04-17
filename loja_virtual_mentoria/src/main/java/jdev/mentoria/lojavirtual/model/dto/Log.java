package jdev.mentoria.lojavirtual.model.dto;

import java.util.ArrayList;

public class Log {

	private boolean bStat;
	private String versao;
	private String tpAmb;
	private String cStat;
	private String verAplic;
	private String xMotivo;
	private String dhRecbto;
	private String cUF;
	private String nRec;
	private ArrayList<WebManiaProtNoaFiscal> aProt = new ArrayList<WebManiaProtNoaFiscal>();
	private String recibo;

	public boolean isbStat() {
		return bStat;
	}

	public void setbStat(boolean bStat) {
		this.bStat = bStat;
	}

	public String getcStat() {
		return cStat;
	}

	public void setcStat(String cStat) {
		this.cStat = cStat;
	}

	public String getxMotivo() {
		return xMotivo;
	}

	public void setxMotivo(String xMotivo) {
		this.xMotivo = xMotivo;
	}

	public String getcUF() {
		return cUF;
	}

	public void setcUF(String cUF) {
		this.cUF = cUF;
	}

	public String getnRec() {
		return nRec;
	}

	public void setnRec(String nRec) {
		this.nRec = nRec;
	}

	public ArrayList<WebManiaProtNoaFiscal> getaProt() {
		return aProt;
	}

	public void setaProt(ArrayList<WebManiaProtNoaFiscal> aProt) {
		this.aProt = aProt;
	}

	public void setRecibo(String recibo) {
		this.recibo = recibo;
	}

	public String getRecibo() {
		return recibo;
	}

	// Getter Methods

	public boolean getBStat() {
		return bStat;
	}

	public String getVersao() {
		return versao;
	}

	public String getTpAmb() {
		return tpAmb;
	}

	public String getCStat() {
		return cStat;
	}

	public String getVerAplic() {
		return verAplic;
	}

	public String getXMotivo() {
		return xMotivo;
	}

	public String getDhRecbto() {
		return dhRecbto;
	}

	public String getCUF() {
		return cUF;
	}

	public String getNRec() {
		return nRec;
	}

	// Setter Methods

	public void setBStat(boolean bStat) {
		this.bStat = bStat;
	}

	public void setVersao(String versao) {
		this.versao = versao;
	}

	public void setTpAmb(String tpAmb) {
		this.tpAmb = tpAmb;
	}

	public void setCStat(String cStat) {
		this.cStat = cStat;
	}

	public void setVerAplic(String verAplic) {
		this.verAplic = verAplic;
	}

	public void setXMotivo(String xMotivo) {
		this.xMotivo = xMotivo;
	}

	public void setDhRecbto(String dhRecbto) {
		this.dhRecbto = dhRecbto;
	}

	public void setCUF(String cUF) {
		this.cUF = cUF;
	}

	public void setNRec(String nRec) {
		this.nRec = nRec;
	}

}
