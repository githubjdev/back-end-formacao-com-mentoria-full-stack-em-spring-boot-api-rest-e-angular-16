package jdev.mentoria.lojavirtual.service;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.xml.bind.DatatypeConverter;

import org.apache.tomcat.util.json.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import jdev.mentoria.lojavirtual.enums.ApiTokenIntegracao;
import jdev.mentoria.lojavirtual.model.AccessTokenJunoAPI;
import jdev.mentoria.lojavirtual.model.BoletoJuno;
import jdev.mentoria.lojavirtual.model.VendaCompraLojaVirtual;
import jdev.mentoria.lojavirtual.model.dto.AsaasApiPagamentoStatus;
import jdev.mentoria.lojavirtual.model.dto.BoletoGeradoApiJuno;
import jdev.mentoria.lojavirtual.model.dto.ClienteAsaasApiPagamento;
import jdev.mentoria.lojavirtual.model.dto.CobrancaApiAsaas;
import jdev.mentoria.lojavirtual.model.dto.CobrancaGeradaAsassApi;
import jdev.mentoria.lojavirtual.model.dto.CobrancaGeradaAssasData;
import jdev.mentoria.lojavirtual.model.dto.CobrancaJunoAPI;
import jdev.mentoria.lojavirtual.model.dto.ConteudoBoletoJuno;
import jdev.mentoria.lojavirtual.model.dto.CriarWebHook;
import jdev.mentoria.lojavirtual.model.dto.ObjetoPostCarneJuno;
import jdev.mentoria.lojavirtual.model.dto.ObjetoQrCodePixAsaas;
import jdev.mentoria.lojavirtual.repository.AccesTokenJunoRepository;
import jdev.mentoria.lojavirtual.repository.BoletoJunoRepository;
import jdev.mentoria.lojavirtual.repository.Vd_Cp_Loja_virt_repository;
import jdev.mentoria.lojavirtual.util.ValidaCPF;

@Service
public class ServiceJunoBoleto implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private AccessTokenJunoService accessTokenJunoService;
	
	@Autowired
	private AccesTokenJunoRepository accesTokenJunoRepository;
	
	@Autowired
	private Vd_Cp_Loja_virt_repository vd_Cp_Loja_virt_repository;
	
	@Autowired
	private BoletoJunoRepository boletoJunoRepository;
	
	/**
	 * suporte@jdetreinamento.com.br
	   59dwed9898sd8
	 * Retorna o id do Customer (Pessoa/cliente)
	 */
	public String buscaClientePessoaApiAsaas(ObjetoPostCarneJuno dados) throws Exception {
		
		/*id do clinete para ligar com a conbrança*/
		String customer_id = "";
		
		/*--------------INICIO - criando ou consultando o cliente*/
		
		Client client = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
		WebResource webResource = client.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "customers?email="+dados.getEmail());
		
		ClientResponse clientResponse = webResource.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("access_token", AsaasApiPagamentoStatus.API_KEY)
				.get(ClientResponse.class);
		
		LinkedHashMap<String, Object> parser = new JSONParser(clientResponse.getEntity(String.class)).parseObject();
		clientResponse.close();
		Integer total = Integer.parseInt(parser.get("totalCount").toString());
		
		if (total <= 0) { /*Cria o cliente*/
			
			ClienteAsaasApiPagamento clienteAsaasApiPagamento = new ClienteAsaasApiPagamento();
			
			if (!ValidaCPF.isCPF(dados.getPayerCpfCnpj())) {
				clienteAsaasApiPagamento.setCpfCnpj("60051803046");
			}else {
				clienteAsaasApiPagamento.setCpfCnpj(dados.getPayerCpfCnpj());
			}
			
			clienteAsaasApiPagamento.setEmail(dados.getEmail());
			clienteAsaasApiPagamento.setName(dados.getPayerName());
			clienteAsaasApiPagamento.setPhone(dados.getPayerPhone());
			
			Client client2 = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
			WebResource webResource2 = client2.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "customers");
			
			ClientResponse clientResponse2 = webResource2.accept("application/json;charset=UTF-8")
					.header("Content-Type", "application/json")
					.header("access_token", AsaasApiPagamentoStatus.API_KEY)
					.post(ClientResponse.class, new ObjectMapper().writeValueAsBytes(clienteAsaasApiPagamento));
			
			LinkedHashMap<String, Object> parser2 = new JSONParser(clientResponse2.getEntity(String.class)).parseObject();
			clientResponse2.close();
			
			customer_id = parser2.get("id").toString();
			
		}else {/*Já tem cliente cadastrado*/
			List<Object> data = (List<Object>) parser.get("data");
			customer_id = new Gson().toJsonTree(data.get(0)).getAsJsonObject().get("id").toString().replaceAll("\"", "");
		}
		
		return customer_id;
		
		
	}
	
	
	
	/**
	 * Cria a chave da API Asass para o PIX;
	 * @return Chave
	 */
	public String criarChavePixAsaas() throws Exception {

		Client client = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
		WebResource webResource = client.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "pix/addressKeys");

		ClientResponse clientResponse = webResource.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("access_token", AsaasApiPagamentoStatus.API_KEY)
				.post(ClientResponse.class, "{\"type\":\"EVP\"}");

		String strinRetorno = clientResponse.getEntity(String.class);
		clientResponse.close();
		return strinRetorno;

	}
	
	
	public String cancelarBoleto(String code) throws Exception {
		
		AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		
		Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://api.juno.com.br/charges/"+code+"/cancelation");
		
		ClientResponse clientResponse = webResource.accept(MediaType.APPLICATION_JSON)
				.header("X-Api-Version", 2)
				.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
				.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
				.put(ClientResponse.class);
		
		if (clientResponse.getStatus() == 204) {
			
			boletoJunoRepository.deleteByCode(code);
			
			return "Cancelado com sucesso";
		}
		
		return clientResponse.getEntity(String.class);
		
	}
	
	public String gerarCarneApiAsaas(ObjetoPostCarneJuno objetoPostCarneJuno) throws Exception {
		
		VendaCompraLojaVirtual vendaCompraLojaVirtual = vd_Cp_Loja_virt_repository.findById(objetoPostCarneJuno.getIdVenda()).get();
		
		CobrancaApiAsaas cobrancaApiAsaas = new CobrancaApiAsaas();
		cobrancaApiAsaas.setCustomer(this.buscaClientePessoaApiAsaas(objetoPostCarneJuno));
		
		/*PIX, BOLETO OU UNDEFINED*/
		cobrancaApiAsaas.setBillingType("UNDEFINED"); /*Gerando tanto PIX quanto Boleto*/
		cobrancaApiAsaas.setDescription("Pix ou Boleto gerado para ao cobrança, cód: " + vendaCompraLojaVirtual.getId());
		cobrancaApiAsaas.setInstallmentValue(vendaCompraLojaVirtual.getValorTotal().floatValue());
		cobrancaApiAsaas.setInstallmentCount(1);
		
		Calendar daVencimento = Calendar.getInstance();
		daVencimento.add(Calendar.DAY_OF_MONTH, 7);
		cobrancaApiAsaas.setDueDate(new SimpleDateFormat("yyyy-MM-dd").format(daVencimento.getTime()));
		
		cobrancaApiAsaas.getInterest().setValue(1F);
		cobrancaApiAsaas.getFine().setValue(1F);
		
		String json  = new ObjectMapper().writeValueAsString(cobrancaApiAsaas);
		Client client = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
		WebResource webResource = client.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "payments");
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("access_token", AsaasApiPagamentoStatus.API_KEY)
				.post(ClientResponse.class, json);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		clientResponse.close();
		
		/*Buscando parcelas geradas*/
		
		LinkedHashMap<String, Object> parser = new JSONParser(stringRetorno).parseObject();
		String installment = parser.get("installment").toString();
		Client client2 = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
		WebResource webResource2 = client2.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "payments?installment=" + installment);
		ClientResponse clientResponse2 = webResource2
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("access_token", AsaasApiPagamentoStatus.API_KEY)
				.get(ClientResponse.class);
		
		String retornoCobrancas = clientResponse2.getEntity(String.class);
		/*Buscando parcelas geradas*/
		
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		
		CobrancaGeradaAsassApi listaCobranca = objectMapper
				.readValue(retornoCobrancas, new TypeReference<CobrancaGeradaAsassApi>() {});
		
		List<BoletoJuno> boletoJunos = new ArrayList<BoletoJuno>();
		int recorrencia = 1;
		for (CobrancaGeradaAssasData data : listaCobranca.getData()) {
			
			BoletoJuno boletoJuno = new BoletoJuno();
			
			boletoJuno.setEmpresa(vendaCompraLojaVirtual.getEmpresa());
			boletoJuno.setVendaCompraLojaVirtual(vendaCompraLojaVirtual);
			boletoJuno.setCode(data.getId());
			boletoJuno.setLink(data.getInvoiceUrl());
			boletoJuno.setDataVencimento(new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getDueDate())));
			boletoJuno.setCheckoutUrl(data.getInvoiceUrl());
			boletoJuno.setValor(new BigDecimal(data.getValue()));
			boletoJuno.setIdChrBoleto(data.getId());
			boletoJuno.setInstallmentLink(data.getInvoiceUrl());
			boletoJuno.setRecorrencia(recorrencia);

			//boletoJuno.setIdPix(c.getPix().getId());
			
			ObjetoQrCodePixAsaas codePixAsaas = this.buscarQrCodeCodigoPix(data.getId());
			
			boletoJuno.setPayloadInBase64(codePixAsaas.getPayload());
			boletoJuno.setImageInBase64(codePixAsaas.getEncodedImage());
			
			boletoJunos.add(boletoJuno);
			recorrencia ++;
		}
		
		boletoJunoRepository.saveAllAndFlush(boletoJunos);
		
		return boletoJunos.get(0).getCheckoutUrl();
		
	}
	
	
	public ObjetoQrCodePixAsaas buscarQrCodeCodigoPix(String idCobranca) throws Exception {
		
		Client client = new HostIgnoringCliente(AsaasApiPagamentoStatus.URL_API_ASAAS).hostIgnoringCliente();
		WebResource webResource = client.resource(AsaasApiPagamentoStatus.URL_API_ASAAS + "payments/"+idCobranca +"/pixQrCode");
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("access_token", AsaasApiPagamentoStatus.API_KEY)
				.get(ClientResponse.class);
		
		String stringRetorno = clientResponse.getEntity(String.class);
		clientResponse.close();
		
		ObjetoQrCodePixAsaas codePixAsaas = new ObjetoQrCodePixAsaas();
		
		LinkedHashMap<String, Object> parser = new JSONParser(stringRetorno).parseObject();
		codePixAsaas.setEncodedImage(parser.get("encodedImage").toString());
		codePixAsaas.setPayload(parser.get("payload").toString());
		
		return codePixAsaas;
	}
	
	/*
	 * Método que gera o PIX  e Boleto com a API da Juno/Ebanx
	 * */
	public String gerarCarneApi(ObjetoPostCarneJuno objetoPostCarneJuno) throws Exception {
		
		VendaCompraLojaVirtual vendaCompraLojaVirtual = vd_Cp_Loja_virt_repository.findById(objetoPostCarneJuno.getIdVenda()).get();
		
		CobrancaJunoAPI cobrancaJunoAPI = new CobrancaJunoAPI();
		
		cobrancaJunoAPI.getCharge().setPixKey(ApiTokenIntegracao.CHAVE_BOLETO_PIX);
		cobrancaJunoAPI.getCharge().setDescription(objetoPostCarneJuno.getDescription());
		cobrancaJunoAPI.getCharge().setAmount(Float.valueOf(objetoPostCarneJuno.getTotalAmount()));
		cobrancaJunoAPI.getCharge().setInstallments(Integer.parseInt(objetoPostCarneJuno.getInstallments()));
		
		Calendar dataVencimento = Calendar.getInstance();
		dataVencimento.add(Calendar.DAY_OF_MONTH, 7);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyy-MM-dd");
		cobrancaJunoAPI.getCharge().setDueDate(dateFormat.format(dataVencimento.getTime()));
		
		cobrancaJunoAPI.getCharge().setFine(BigDecimal.valueOf(1.00));
		cobrancaJunoAPI.getCharge().setInterest(BigDecimal.valueOf(1.00));
		cobrancaJunoAPI.getCharge().setMaxOverdueDays(10);
		cobrancaJunoAPI.getCharge().getPaymentTypes().add("BOLETO_PIX");
		
		cobrancaJunoAPI.getBilling().setName(objetoPostCarneJuno.getPayerName());
		cobrancaJunoAPI.getBilling().setDocument(objetoPostCarneJuno.getPayerCpfCnpj());
		cobrancaJunoAPI.getBilling().setEmail(objetoPostCarneJuno.getEmail());
		cobrancaJunoAPI.getBilling().setPhone(objetoPostCarneJuno.getPayerPhone());
		
		AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		if (accessTokenJunoAPI != null) {
			
			Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
			WebResource webResource = client.resource("https://api.juno.com.br/charges");
			
			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(cobrancaJunoAPI);
			
			ClientResponse clientResponse = webResource
					.accept("application/json;charset=UTF-8")
					.header("Content-Type", "application/json;charset=UTF-8")
					.header("X-API-Version", 2)
					.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
					.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
					.post(ClientResponse.class, json);
			
			String stringRetorno = clientResponse.getEntity(String.class);
			
			if (clientResponse.getStatus() == 200) { /*Retornou com sucesso*/
				
				clientResponse.close();
				objectMapper.enable(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY); /*Converte relacionamento um para muitos dentro de json*/
				
				BoletoGeradoApiJuno jsonRetornoObj = objectMapper.readValue(stringRetorno,
						   new TypeReference<BoletoGeradoApiJuno>() {});
				
				int recorrencia = 1;
				
				List<BoletoJuno> boletoJunos = new ArrayList<BoletoJuno>();
				
				for (ConteudoBoletoJuno c : jsonRetornoObj.get_embedded().getCharges()) {
					
					BoletoJuno boletoJuno = new BoletoJuno();
					
					boletoJuno.setEmpresa(vendaCompraLojaVirtual.getEmpresa());
					boletoJuno.setVendaCompraLojaVirtual(vendaCompraLojaVirtual);
					boletoJuno.setCode(c.getCode());
					boletoJuno.setLink(c.getLink());
					boletoJuno.setDataVencimento(new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(c.getDueDate())));
					boletoJuno.setCheckoutUrl(c.getCheckoutUrl());
					boletoJuno.setValor(new BigDecimal(c.getAmount()));
					boletoJuno.setIdChrBoleto(c.getId());
					boletoJuno.setInstallmentLink(c.getInstallmentLink());
					boletoJuno.setIdPix(c.getPix().getId());
					boletoJuno.setPayloadInBase64(c.getPix().getPayloadInBase64());
					boletoJuno.setImageInBase64(c.getPix().getImageInBase64());
					boletoJuno.setRecorrencia(recorrencia);
					
					boletoJunos.add(boletoJuno);
					recorrencia ++;
					
				}
				
				boletoJunoRepository.saveAllAndFlush(boletoJunos);
				
				return boletoJunos.get(0).getLink();
				
			}else {
				return stringRetorno;
			}
			
		}else {
			return "Não exite chave de acesso para a API";
		}
		
	}
	
	
	public String geraChaveBoletoPix() throws Exception {
		
		AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		
		Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://api.juno.com.br/pix/keys");
		//WebResource webResource = client.resource("https://api.juno.com.br/api-integration/pix/keys");
		
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("X-API-Version", 2)
				.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
				.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
				.post(ClientResponse.class, "{ \"type\": \"RANDOM_KEY\" }");
		
		         //.header("X-Idempotency-Key", "chave-boleto-pix")
		return clientResponse.getEntity(String.class);
		
		
	}
	
	public AccessTokenJunoAPI obterTokenApiJuno() throws Exception {
		
		AccessTokenJunoAPI accessTokenJunoAPI = accessTokenJunoService.buscaTokenAtivo();
		
		if (accessTokenJunoAPI == null || (accessTokenJunoAPI != null && accessTokenJunoAPI.expirado()) ) {
			
			String clienteID = "vi7QZerW09C8JG1o";
			String secretID = "$A_+&ksH}&+2<3VM]1MZqc,F_xif_-Dc";
			
			Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
			
			WebResource webResource = client.resource("https://api.juno.com.br/authorization-server/oauth/token?grant_type=client_credentials");
			
			String basicChave = clienteID + ":" + secretID;
			String token_autenticao = DatatypeConverter.printBase64Binary(basicChave.getBytes());
			
			ClientResponse clientResponse = webResource.
					accept(MediaType.APPLICATION_FORM_URLENCODED)
					.type(MediaType.APPLICATION_FORM_URLENCODED)
					.header("Content-Type", "application/x-www-form-urlencoded")
					.header("Authorization", "Basic " + token_autenticao)
					.post(ClientResponse.class);
			
			if (clientResponse.getStatus() == 200) { /*Sucesso*/
				accesTokenJunoRepository.deleteAll();
				accesTokenJunoRepository.flush();
				
				AccessTokenJunoAPI accessTokenJunoAPI2 = clientResponse.getEntity(AccessTokenJunoAPI.class);
				accessTokenJunoAPI2.setToken_acesso(token_autenticao);
				
				accessTokenJunoAPI2 = accesTokenJunoRepository.saveAndFlush(accessTokenJunoAPI2);
				
				return accessTokenJunoAPI2;
			}else {
				return null;
			}
			
			
		}else {
			return accessTokenJunoAPI;
		}
	}
	
	/*
	 * {"id":"wbh_AE815607C1F5A94934934A2EA3CA0180","url":"https://lojavirtualmentoria-env.eba-bijtuvkg.sa-east-1.elasticbeanstalk.com/loja_virtual_mentoria/requisicaojunoboleto/notificacaoapiv2","secret":"23b85f4998289533ed3ee310ae9d5bd3f803fadac7fb1ecff0296fbf1bb060f8","status":"ACTIVE","eventTypes":[{"id":"evt_DC2E7E8848B08C62","name":"DOCUMENT_STATUS_CHANGED","label":"O status de um documento foi alterado","status":"ENABLED"}],"_links":{"self":{"href":"https://api.juno.com.br/api-integration/notifications/webhooks/wbh_AE815607C1F5A94934934A2EA3CA0180"}}}
	 * 
	 * */
	public String criarWebHook(CriarWebHook criarWebHook) throws Exception {
		
	    AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		
		Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://api.juno.com.br/notifications/webhooks");
		
		String json = new ObjectMapper().writeValueAsString(criarWebHook);
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("X-API-Version", 2)
				.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
				.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
				.post(ClientResponse.class, json);
		
		 String resposta = clientResponse.getEntity(String.class);
		 clientResponse.close();
		
		return resposta;
		
	}
	
	public String listaWebHook() throws Exception {
		
	    AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		
		Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://api.juno.com.br/notifications/webhooks");
		
		ClientResponse clientResponse = webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("X-API-Version", 2)
				.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
				.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
				.get(ClientResponse.class);
		
		 String resposta = clientResponse.getEntity(String.class);
		 
		return resposta;
		
	}
	
	
	
	public void deleteWebHook(String idWebHook) throws Exception {
		
	    AccessTokenJunoAPI accessTokenJunoAPI = this.obterTokenApiJuno();
		
		Client client = new HostIgnoringCliente("https://api.juno.com.br/").hostIgnoringCliente();
		WebResource webResource = client.resource("https://api.juno.com.br/notifications/webhooks/" + idWebHook);
		
		webResource
				.accept("application/json;charset=UTF-8")
				.header("Content-Type", "application/json")
				.header("X-API-Version", 2)
				.header("X-Resource-Token", ApiTokenIntegracao.TOKEN_PRIVATE_JUNO)
				.header("Authorization", "Bearer " + accessTokenJunoAPI.getAccess_token())
				.delete();
		
		
	}

	

}
