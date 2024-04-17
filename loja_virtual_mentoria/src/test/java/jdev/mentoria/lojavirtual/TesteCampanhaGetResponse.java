package jdev.mentoria.lojavirtual;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.ws.rs.core.MediaType;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import jdev.mentoria.lojavirtual.enums.ApiTokenIntegracao;
import jdev.mentoria.lojavirtual.model.dto.CampanhaGetResponse;
import jdev.mentoria.lojavirtual.model.dto.LeadCampanhaGetResponse;
import jdev.mentoria.lojavirtual.model.dto.LeadCampanhaGetResponseCastrado;
import jdev.mentoria.lojavirtual.model.dto.NewsLetterGetResponse;
import jdev.mentoria.lojavirtual.model.dto.ObjetoFromFieldIdGetResponse;
import jdev.mentoria.lojavirtual.service.HostIgnoringCliente;
import jdev.mentoria.lojavirtual.service.ServiceGetResponseEmailMarketing;
import junit.framework.TestCase;

@Profile("dev")
@SpringBootTest(classes = LojaVirtualMentoriaApplication.class)
public class TesteCampanhaGetResponse extends TestCase {
	
	@Autowired
	private ServiceGetResponseEmailMarketing serviceGetResponseEmailMarketing; 
	
	@Test
	public void testCarregaCampanhaGetResponse() throws Exception {
		
	   List<CampanhaGetResponse> list = serviceGetResponseEmailMarketing.carregaListaCampanhaGetResponse();
		
		for (CampanhaGetResponse campanhaGetResponse : list) {
			System.out.println(campanhaGetResponse);
			System.out.println("---------------------------");
		}
		
	}
	
	
	
	@Test
	public void testCriaLead() throws Exception {
		
		LeadCampanhaGetResponse lead = new LeadCampanhaGetResponse();
		lead.setName("Alex teste api");
		lead.setEmail("contato7@jdevtreinamento.com.br");
		
		LeadCampanhaGetResponseCastrado campanha = new LeadCampanhaGetResponseCastrado();
		campanha.setCampaignId("qKBgP");
		lead.setCampaign(campanha);
		
		String retorno = serviceGetResponseEmailMarketing.criaLeadApiGetResponse(lead);
		
		System.out.println(retorno);
		
	}
	
	@Test
	public void testEnviaEmailporAPI() throws Exception {
		
		String retorno = serviceGetResponseEmailMarketing.
				enviaEmailApiGetResponse("qKBgP",  "Teste de e-mail", "<html><body>text do email</body></html>");
		
		System.out.println(retorno);
	}
	

	@Test
	public void testBuscaFromFielId() throws Exception {
		
		List<ObjetoFromFieldIdGetResponse> fieldIdGetResponses =	serviceGetResponseEmailMarketing.listaFromFieldId();
		
		for (ObjetoFromFieldIdGetResponse objetoFromFieldIdGetResponse : fieldIdGetResponses) {
			System.out.println(objetoFromFieldIdGetResponse);
		}
	}

}
