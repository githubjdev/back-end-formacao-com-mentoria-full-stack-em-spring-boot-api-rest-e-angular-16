package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class EnvioEtiquetaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String service;
	private String agency;

	private FromEnvioEtiquetaDTO from = new FromEnvioEtiquetaDTO();

	private ToEnvioEtiquetaDTO to = new ToEnvioEtiquetaDTO();

	private List<ProductsEnvioEtiquetaDTO> products = new ArrayList<ProductsEnvioEtiquetaDTO>();

	private List<VolumesEnvioEtiquetaDTO> volumes = new ArrayList<VolumesEnvioEtiquetaDTO>();
	
	private OptionsEnvioEtiquetaDTO options = new OptionsEnvioEtiquetaDTO();
	
	public void setOptions(OptionsEnvioEtiquetaDTO options) {
		this.options = options;
	}
	public OptionsEnvioEtiquetaDTO getOptions() {
		return options;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public FromEnvioEtiquetaDTO getFrom() {
		return from;
	}

	public void setFrom(FromEnvioEtiquetaDTO from) {
		this.from = from;
	}

	public ToEnvioEtiquetaDTO getTo() {
		return to;
	}

	public void setTo(ToEnvioEtiquetaDTO to) {
		this.to = to;
	}

	public List<ProductsEnvioEtiquetaDTO> getProducts() {
		return products;
	}

	public void setProducts(List<ProductsEnvioEtiquetaDTO> products) {
		this.products = products;
	}

	public List<VolumesEnvioEtiquetaDTO> getVolumes() {
		return volumes;
	}

	public void setVolumes(List<VolumesEnvioEtiquetaDTO> volumes) {
		this.volumes = volumes;
	}

	public String getAgency() {
		return agency;
	}

	public void setAgency(String agency) {
		this.agency = agency;
	}

}
