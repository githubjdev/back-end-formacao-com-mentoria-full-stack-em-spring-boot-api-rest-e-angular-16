package jdev.mentoria.lojavirtual;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import jdev.mentoria.lojavirtual.model.VendaCompraLojaVirtual;
import jdev.mentoria.lojavirtual.model.dto.ObjetoDevolucaoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.ObjetoEmissaoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.ObjetoEstornoNotaFiscalWebMania;
import jdev.mentoria.lojavirtual.model.dto.WebManiaClienteNF;
import jdev.mentoria.lojavirtual.model.dto.WebManiaNotaFicalEletronica;
import jdev.mentoria.lojavirtual.model.dto.WebManiaPedidoNF;
import jdev.mentoria.lojavirtual.model.dto.WebManiaProdutoNF;
import jdev.mentoria.lojavirtual.repository.Vd_Cp_Loja_virt_repository;
import jdev.mentoria.lojavirtual.service.WebManiaNotaFiscalService;
import junit.framework.TestCase;


@Profile("test")
@SpringBootTest(classes = LojaVirtualMentoriaApplication.class)
public class TesteNotaFiscal extends TestCase {
	
	@Autowired
	private WebManiaNotaFiscalService webManiaNotaFiscalService;
	
	@Autowired
	private Vd_Cp_Loja_virt_repository vd_Cp_Loja_virt_repository;
	
	@Test
	public void testeGravaNotaNoBanco() throws Exception {
		String json = emiteNotaFiscal();
		
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
		
		ObjetoEmissaoNotaFiscalWebMania notaFiscalWebMania = objectMapper
				.readValue(json, new TypeReference<ObjetoEmissaoNotaFiscalWebMania>() {});
		
		VendaCompraLojaVirtual vendaCompraLojaVirtual = vd_Cp_Loja_virt_repository.findById(18L).get();
		
		webManiaNotaFiscalService.gravaNotaParaVenda(notaFiscalWebMania, vendaCompraLojaVirtual);
		
	}
	
	@Test
	public void testeEmissaoNota() throws Exception {
		
		emiteNotaFiscal();
		
	}

	private String emiteNotaFiscal() throws Exception {
		WebManiaNotaFicalEletronica webManiaNotaFicalEletronica = new WebManiaNotaFicalEletronica();
		
		/*Dados da nota*/
		webManiaNotaFicalEletronica.setID("1");
		webManiaNotaFicalEletronica.setUrl_notificacao("");/*WebHook*/
		webManiaNotaFicalEletronica.setOperacao(1); /*Saída*/
		webManiaNotaFicalEletronica.setNatureza_operacao("Venda de celular Iphone 13");
		webManiaNotaFicalEletronica.setModelo("1"); /* NF-e*/
		webManiaNotaFicalEletronica.setFinalidade(1); /* NF-e normal*/
		webManiaNotaFicalEletronica.setAmbiente(2); /*Homologação*/
		
		/*Dados do cliente que está comprando*/
		WebManiaClienteNF cliente = new WebManiaClienteNF();
		cliente.setBairro("JD Dias 1");
		cliente.setCep("87025758");
		cliente.setCidade("Maringá");
		cliente.setComplemento("NA");
		cliente.setCpf("05916564937");
		cliente.setEmail("alex.fernando.egidio@gmail.com");
		cliente.setEndereco("Pioneiro antonio de ganello");
		cliente.setNumero("356");
		cliente.setTelefone("45999795800");
		cliente.setUf("PR");
		cliente.setNome_completo("Alex Fernando Egidio");
		
		webManiaNotaFicalEletronica.setCliente(cliente);
		
		/*Dados do Produto*/
		WebManiaProdutoNF produto = new WebManiaProdutoNF();
		
		produto.setNome("Iphone 13");
		produto.setCodigo("1111");
		produto.setNcm("6109.10.00");
		produto.setCest("28.038.00");
		produto.setQuantidade(1);
		produto.setUnidade("UN");
		produto.setPeso("0.800");
		produto.setOrigem(0);
		produto.setSubtotal("1500");
		produto.setTotal("1500");
		produto.setClasse_imposto("REF57569972");
		
        WebManiaProdutoNF produto2 = new WebManiaProdutoNF();
		
		produto2.setNome("Sansung galaxy 13");
		produto2.setCodigo("11112");
		produto2.setNcm("6109.10.00");
		produto2.setCest("28.038.00");
		produto2.setQuantidade(1);
		produto2.setUnidade("UN");
		produto2.setPeso("0.800");
		produto2.setOrigem(0);
		produto2.setSubtotal("1500");
		produto2.setTotal("1500");
		produto2.setClasse_imposto("REF57569972");
		
		webManiaNotaFicalEletronica.getProdutos().add(produto);
		webManiaNotaFicalEletronica.getProdutos().add(produto2);
		
		WebManiaPedidoNF pedidoNF = new WebManiaPedidoNF();
		
		pedidoNF.setPagamento(0); /* á vista*/
		pedidoNF.setPresenca(2); /* pela internet*/
		pedidoNF.setModalidade_frete(0);
		pedidoNF.setFrete("60");
		pedidoNF.setDesconto("120");
		pedidoNF.setTotal("2940");
		
		webManiaNotaFicalEletronica.setPedido(pedidoNF);
		
		String retorno = webManiaNotaFiscalService.emitirNotaFiscal(webManiaNotaFicalEletronica);
		
		System.out.println("-------->> Retorno Emissão nota fiscal: " + retorno);
		
		return retorno;
	}
	
	@Test
	public void cancelNota() throws Exception {
		
		String retorno = webManiaNotaFiscalService.
				cancelarNotaFiscal("93d9fd23-2389-4f50-b57f-b873471eda2c", "cancelamento teste");
		
		System.out.println("---------->> Retorno cancelamento nota fiscal: " +  retorno);
		
	}
	
	
	@Test
	public void consultarNota() throws Exception {
		
		String retorno = webManiaNotaFiscalService.
				consultarNotaFiscal("93d9fd23-2389-4f50-b57f-b873471eda2c");
		
		System.out.println("---------->> Retorno consulta nota fiscal: " +  retorno);
		
	}
	
	@Test
	public void estornoNota() throws Exception {
		
		ObjetoEstornoNotaFiscalWebMania objetoEstornoNotaFiscalWebMania = new  ObjetoEstornoNotaFiscalWebMania();
		
		objetoEstornoNotaFiscalWebMania.setChave("41230426934453000189550010000000071924977109");
		objetoEstornoNotaFiscalWebMania.setNatureza_operacao("999");
		objetoEstornoNotaFiscalWebMania.setCodigo_cfop("1.102");
		objetoEstornoNotaFiscalWebMania.setAmbiente("2");
		String retorno = webManiaNotaFiscalService.estornoNotaFiscal(objetoEstornoNotaFiscalWebMania);
		
		System.out.println("----------->> Retorno do estorno da nota: " + retorno);
	}
	
	
	@Test
	public void devolucaNota() throws Exception {
		
		ObjetoDevolucaoNotaFiscalWebMania objetoEstornoNotaFiscalWebMania = new  ObjetoDevolucaoNotaFiscalWebMania();
		
		objetoEstornoNotaFiscalWebMania.setChave("41230426934453000189550010000000071924977109");
		objetoEstornoNotaFiscalWebMania.setNatureza_operacao("Devolução de venda de produção do estabelecimento");
		objetoEstornoNotaFiscalWebMania.setCodigo_cfop("1.102");
		objetoEstornoNotaFiscalWebMania.setAmbiente("2");
		objetoEstornoNotaFiscalWebMania.setVolume(1);
		objetoEstornoNotaFiscalWebMania.setProdutos(new int[] {1});
		objetoEstornoNotaFiscalWebMania.setQuantidade(new int[] {1});
		
		String retorno = webManiaNotaFiscalService.devolucaoNotaFiscal(objetoEstornoNotaFiscalWebMania);
		
		System.out.println("----------->> Retorno do estorno da nota: " + retorno);
	}
		
		
		

}
