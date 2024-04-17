package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class ConsultaCnpjDto implements Serializable {

	private static final long serialVersionUID = 1L;

	private List<AtividadeDto> atividade_principal = new ArrayList<AtividadeDto>();

	private String data_situacao;
	private String tipo;
	private String nome;
	private String uf;
	private String telefone;
	private String email;

	private List<AtividadeDto> atividades_secundarias = new ArrayList<AtividadeDto>();

	private List<QsaDTO> qsa = new ArrayList<QsaDTO>();

	private String situacao;
	private String bairro;
	private String logradouro;
	private String numero;
	private String cep;
	private String municipio;
	private String porte;
	private String abertura;
	private String natureza_juridica;
	private String fantasia;
	private String cnpj;
	private String ultima_atualizacao;
	private String status;
	private String complemento;
	private String efr;
	private String motivo_situacao;
	private String situacao_especial;
	private String data_situacao_especial;
	private String capital_social;

	@JsonIgnore
	private ExtraDTO extra;

	private BillingDTO billing;

	public List<AtividadeDto> getAtividade_principal() {
		return atividade_principal;
	}

	public void setAtividade_principal(List<AtividadeDto> atividade_principal) {
		this.atividade_principal = atividade_principal;
	}

	public String getData_situacao() {
		return data_situacao;
	}

	public void setData_situacao(String data_situacao) {
		this.data_situacao = data_situacao;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getUf() {
		return uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<AtividadeDto> getAtividades_secundarias() {
		return atividades_secundarias;
	}

	public void setAtividades_secundarias(List<AtividadeDto> atividades_secundarias) {
		this.atividades_secundarias = atividades_secundarias;
	}

	public List<QsaDTO> getQsa() {
		return qsa;
	}

	public void setQsa(List<QsaDTO> qsa) {
		this.qsa = qsa;
	}

	public String getSituacao() {
		return situacao;
	}

	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getLogradouro() {
		return logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getMunicipio() {
		return municipio;
	}

	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}

	public String getPorte() {
		return porte;
	}

	public void setPorte(String porte) {
		this.porte = porte;
	}

	public String getAbertura() {
		return abertura;
	}

	public void setAbertura(String abertura) {
		this.abertura = abertura;
	}

	public String getNatureza_juridica() {
		return natureza_juridica;
	}

	public void setNatureza_juridica(String natureza_juridica) {
		this.natureza_juridica = natureza_juridica;
	}

	public String getFantasia() {
		return fantasia;
	}

	public void setFantasia(String fantasia) {
		this.fantasia = fantasia;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getUltima_atualizacao() {
		return ultima_atualizacao;
	}

	public void setUltima_atualizacao(String ultima_atualizacao) {
		this.ultima_atualizacao = ultima_atualizacao;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getComplemento() {
		return complemento;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public String getEfr() {
		return efr;
	}

	public void setEfr(String efr) {
		this.efr = efr;
	}

	public String getMotivo_situacao() {
		return motivo_situacao;
	}

	public void setMotivo_situacao(String motivo_situacao) {
		this.motivo_situacao = motivo_situacao;
	}

	public String getSituacao_especial() {
		return situacao_especial;
	}

	public void setSituacao_especial(String situacao_especial) {
		this.situacao_especial = situacao_especial;
	}

	public String getData_situacao_especial() {
		return data_situacao_especial;
	}

	public void setData_situacao_especial(String data_situacao_especial) {
		this.data_situacao_especial = data_situacao_especial;
	}

	public String getCapital_social() {
		return capital_social;
	}

	public void setCapital_social(String capital_social) {
		this.capital_social = capital_social;
	}

	public ExtraDTO getExtra() {
		return extra;
	}

	public void setExtra(ExtraDTO extra) {
		this.extra = extra;
	}

	public BillingDTO getBilling() {
		return billing;
	}

	public void setBilling(BillingDTO billing) {
		this.billing = billing;
	}

}
