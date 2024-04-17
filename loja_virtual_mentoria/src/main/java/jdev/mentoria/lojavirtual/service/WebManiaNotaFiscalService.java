package jdev.mentoria.lojavirtual.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import jdev.mentoria.lojavirtual.model.NotaFiscalVenda;
import jdev.mentoria.lojavirtual.model.VendaCompraLojaVirtual;
import jdev.mentoria.lojavirtual.model.dto.ObjetoDevolucaoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.ObjetoEmissaoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.ObjetoEstornoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.WebManiaNotaFicalEletronica;
import jdev.mentoria.lojavirtual.repository.NotaFiscalVendaRepository;

@Service
public class WebManiaNotaFiscalService {
	
	@Autowired
	private NotaFiscalVendaRepository notaFiscalVendaRepository;
	
	public String emitirNotaFiscal(WebManiaNotaFicalEletronica webManiaNotaFicalEletronica) throws Exception {
		
		Client client = new HostIgnoringCliente("https://webmaniabr.com/api/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://webmaniabr.com/api/1/nfe/emissao/");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(webManiaNotaFicalEletronica);
		
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json;charset=UTF-8")
				.header("X-Consumer-Key", "N6scITMtiEunElnEUAVMQpRAhJrHgU0e")
				.header("X-Consumer-Secret", "6fBypsFYfQCTt6LBAkRjuGm6nHimRWoNCOiQ9aqLkcNEtHLR")
				.header("X-Access-Token", "3554-LLWm2CoGsTzxXW0QiLPmG2ha2f4lSO6hA3USo2IprD6J9Wwy")
				.header("X-Access-Token-Secret", "6RGm39tdeCYEgIvOKLuSdrGbiuK769Lx0Ngy3iueCVXCDP0E")
				.post(ClientResponse.class, json);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		
		return stringRetorno;
		
	}
	
	
	public String cancelarNotaFiscal(String uuid, String motivo) throws Exception {
		
		Client client = new HostIgnoringCliente("https://webmaniabr.com/api/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://webmaniabr.com/api/1/nfe/cancelar/");
		
		String json = "{\"uuid\":\""+uuid+"\",\"motivo\":\""+motivo+"\"}";
		
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json;charset=UTF-8")
				.header("X-Consumer-Key", "N6scITMtiEunElnEUAVMQpRAhJrHgU0e")
				.header("X-Consumer-Secret", "6fBypsFYfQCTt6LBAkRjuGm6nHimRWoNCOiQ9aqLkcNEtHLR")
				.header("X-Access-Token", "3554-LLWm2CoGsTzxXW0QiLPmG2ha2f4lSO6hA3USo2IprD6J9Wwy")
				.header("X-Access-Token-Secret", "6RGm39tdeCYEgIvOKLuSdrGbiuK769Lx0Ngy3iueCVXCDP0E")
				.put(ClientResponse.class, json);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		
		return stringRetorno;
		
	}
	
	
	public String consultarNotaFiscal(String uuid) throws Exception {
		
		Client client = new HostIgnoringCliente("https://webmaniabr.com/api/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://webmaniabr.com/api/1/nfe/consulta/");
		
		
		
		ClientResponse clientResponse = webResource.
				 queryParam("uuid", uuid)
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json;charset=UTF-8")
				.header("X-Consumer-Key", "N6scITMtiEunElnEUAVMQpRAhJrHgU0e")
				.header("X-Consumer-Secret", "6fBypsFYfQCTt6LBAkRjuGm6nHimRWoNCOiQ9aqLkcNEtHLR")
				.header("X-Access-Token", "3554-LLWm2CoGsTzxXW0QiLPmG2ha2f4lSO6hA3USo2IprD6J9Wwy")
				.header("X-Access-Token-Secret", "6RGm39tdeCYEgIvOKLuSdrGbiuK769Lx0Ngy3iueCVXCDP0E")
				.get(ClientResponse.class);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		
		return stringRetorno;
		
	}
	
	
	public String estornoNotaFiscal(ObjetoEstornoNotaFiscalWebMania estorno) throws Exception {
		
		Client client = new HostIgnoringCliente("https://webmaniabr.com/api/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://webmaniabr.com/api/1/nfe/devolucao/");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(estorno);
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json;charset=UTF-8")
				.header("X-Consumer-Key", "N6scITMtiEunElnEUAVMQpRAhJrHgU0e")
				.header("X-Consumer-Secret", "6fBypsFYfQCTt6LBAkRjuGm6nHimRWoNCOiQ9aqLkcNEtHLR")
				.header("X-Access-Token", "3554-LLWm2CoGsTzxXW0QiLPmG2ha2f4lSO6hA3USo2IprD6J9Wwy")
				.header("X-Access-Token-Secret", "6RGm39tdeCYEgIvOKLuSdrGbiuK769Lx0Ngy3iueCVXCDP0E")
				.post(ClientResponse.class, json);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		
		return stringRetorno;
		
	}
	
	
	public String devolucaoNotaFiscal(ObjetoDevolucaoNotaFiscalWebMania devolucao) throws Exception {
		
		Client client = new HostIgnoringCliente("https://webmaniabr.com/api/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://webmaniabr.com/api/1/nfe/devolucao/");
		
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(devolucao);
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json;charset=UTF-8")
				.header("X-Consumer-Key", "N6scITMtiEunElnEUAVMQpRAhJrHgU0e")
				.header("X-Consumer-Secret", "6fBypsFYfQCTt6LBAkRjuGm6nHimRWoNCOiQ9aqLkcNEtHLR")
				.header("X-Access-Token", "3554-LLWm2CoGsTzxXW0QiLPmG2ha2f4lSO6hA3USo2IprD6J9Wwy")
				.header("X-Access-Token-Secret", "6RGm39tdeCYEgIvOKLuSdrGbiuK769Lx0Ngy3iueCVXCDP0E")
				.post(ClientResponse.class, json);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		
		return stringRetorno;
		
	}
	
	
	
	public NotaFiscalVenda gravaNotaParaVenda(ObjetoEmissaoNotaFiscalWebMania emissaoNotaFiscalWebMania, VendaCompraLojaVirtual vendaCompraLojaVirtual) {
		
		NotaFiscalVenda notaFiscalVendaBusca = notaFiscalVendaRepository.buscaNotaPorVendaUnica(vendaCompraLojaVirtual.getId());
		
		NotaFiscalVenda notaFiscalVenda = new NotaFiscalVenda();
		
		if (notaFiscalVendaBusca != null && notaFiscalVendaBusca.getId() > 0) {
			notaFiscalVenda.setId(notaFiscalVendaBusca.getId());
		}
		
		notaFiscalVenda.setEmpresa(vendaCompraLojaVirtual.getEmpresa());
		notaFiscalVenda.setNumero(emissaoNotaFiscalWebMania.getUuid());
		notaFiscalVenda.setPdf(emissaoNotaFiscalWebMania.getDanfe());
		notaFiscalVenda.setSerie(emissaoNotaFiscalWebMania.getSerie());
		notaFiscalVenda.setTipo(emissaoNotaFiscalWebMania.getModelo());
		notaFiscalVenda.setVendaCompraLojaVirtual(vendaCompraLojaVirtual);
		notaFiscalVenda.setXml(emissaoNotaFiscalWebMania.getXml());
		notaFiscalVenda.setChave(emissaoNotaFiscalWebMania.getChave());
		
		return notaFiscalVendaRepository.saveAndFlush(notaFiscalVenda);
		
	}
	
	


}
