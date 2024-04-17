package jdev.mentoria.lojavirtual.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.mail.MessagingException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.enums.ApiTokenIntegracao;
import jdev.mentoria.lojavirtual.enums.StatusContaReceber;
import jdev.mentoria.lojavirtual.model.ContaReceber;
import jdev.mentoria.lojavirtual.model.Endereco;
import jdev.mentoria.lojavirtual.model.ItemVendaLoja;
import jdev.mentoria.lojavirtual.model.PessoaFisica;
import jdev.mentoria.lojavirtual.model.StatusRastreio;
import jdev.mentoria.lojavirtual.model.VendaCompraLojaVirtual;
import jdev.mentoria.lojavirtual.model.dto.ConsultaFreteDTO;
import jdev.mentoria.lojavirtual.model.dto.EmpresaTransporteDTO;
import jdev.mentoria.lojavirtual.model.dto.EnvioEtiquetaDTO;
import jdev.mentoria.lojavirtual.model.dto.ItemVendaDTO;
import jdev.mentoria.lojavirtual.model.dto.ObjetoPostCarneJuno;
import jdev.mentoria.lojavirtual.model.dto.ProductsEnvioEtiquetaDTO;
import jdev.mentoria.lojavirtual.model.dto.TagsEnvioDto;
import jdev.mentoria.lojavirtual.model.dto.VendaCompraLojaVirtualDTO;
import jdev.mentoria.lojavirtual.model.dto.VolumesEnvioEtiquetaDTO;
import jdev.mentoria.lojavirtual.repository.ContaReceberRepository;
import jdev.mentoria.lojavirtual.repository.EnderecoRepository;
import jdev.mentoria.lojavirtual.repository.NotaFiscalVendaRepository;
import jdev.mentoria.lojavirtual.repository.StatusRastreioRepository;
import jdev.mentoria.lojavirtual.repository.Vd_Cp_Loja_virt_repository;
import jdev.mentoria.lojavirtual.service.ServiceJunoBoleto;
import jdev.mentoria.lojavirtual.service.ServiceSendEmail;
import jdev.mentoria.lojavirtual.service.VendaService;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@RestController
public class Vd_Cp_loja_Virt_Controller {

	@Autowired
	private Vd_Cp_Loja_virt_repository vd_Cp_Loja_virt_repository;

	@Autowired
	private EnderecoRepository enderecoRepository;

	@Autowired
	private PessoaController pessoaController;

	@Autowired
	private NotaFiscalVendaRepository notaFiscalVendaRepository;
	
	@Autowired
	private StatusRastreioRepository statusRastreioRepository;
	
	@Autowired
	private VendaService vendaService; 
	
	@Autowired
	private ContaReceberRepository contaReceberRepository;
	
	@Autowired
	private ServiceSendEmail serviceSendEmail;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ServiceJunoBoleto serviceJunoBoleto;

	@ResponseBody
	@PostMapping(value = "**/salvarVendaLoja")
	public ResponseEntity<VendaCompraLojaVirtualDTO> salvarVendaLoja(
			@RequestBody @Valid VendaCompraLojaVirtual vendaCompraLojaVirtual) throws ExceptionMentoriaJava, UnsupportedEncodingException, MessagingException {

		vendaCompraLojaVirtual.getPessoa().setEmpresa(vendaCompraLojaVirtual.getEmpresa());
		PessoaFisica pessoaFisica = pessoaController.salvarPf(vendaCompraLojaVirtual.getPessoa()).getBody();
		vendaCompraLojaVirtual.setPessoa(pessoaFisica);

		vendaCompraLojaVirtual.getEnderecoCobranca().setPessoa(pessoaFisica);
		vendaCompraLojaVirtual.getEnderecoCobranca().setEmpresa(vendaCompraLojaVirtual.getEmpresa());
		Endereco enderecoCobranca = enderecoRepository.save(vendaCompraLojaVirtual.getEnderecoCobranca());
		vendaCompraLojaVirtual.setEnderecoCobranca(enderecoCobranca);

		vendaCompraLojaVirtual.getEnderecoEntrega().setPessoa(pessoaFisica);
		vendaCompraLojaVirtual.getEnderecoEntrega().setEmpresa(vendaCompraLojaVirtual.getEmpresa());
		Endereco enderecoEntrega = enderecoRepository.save(vendaCompraLojaVirtual.getEnderecoEntrega());
		vendaCompraLojaVirtual.setEnderecoEntrega(enderecoEntrega);

		vendaCompraLojaVirtual.getNotaFiscalVenda().setEmpresa(vendaCompraLojaVirtual.getEmpresa());

		for (int i = 0; i < vendaCompraLojaVirtual.getItemVendaLojas().size(); i++) {
			vendaCompraLojaVirtual.getItemVendaLojas().get(i).setEmpresa(vendaCompraLojaVirtual.getEmpresa());
			vendaCompraLojaVirtual.getItemVendaLojas().get(i).setVendaCompraLojaVirtual(vendaCompraLojaVirtual);
		}

		/* Salva primeiro a venda e todo os dados */
		vendaCompraLojaVirtual = vd_Cp_Loja_virt_repository.saveAndFlush(vendaCompraLojaVirtual);
		
		/* Associa a venda gravada no banco com a nota fiscal */
		vendaCompraLojaVirtual.getNotaFiscalVenda().setVendaCompraLojaVirtual(vendaCompraLojaVirtual);

		/* Persiste novamente as nota fiscal novamente pra ficar amarrada na venda */
		notaFiscalVendaRepository.saveAndFlush(vendaCompraLojaVirtual.getNotaFiscalVenda());

		VendaCompraLojaVirtualDTO compraLojaVirtualDTO = new VendaCompraLojaVirtualDTO();
		compraLojaVirtualDTO.setValorTotal(vendaCompraLojaVirtual.getValorTotal());
		compraLojaVirtualDTO.setPessoa(vendaCompraLojaVirtual.getPessoa());

		compraLojaVirtualDTO.setEntrega(vendaCompraLojaVirtual.getEnderecoEntrega());
		compraLojaVirtualDTO.setCobranca(vendaCompraLojaVirtual.getEnderecoCobranca());

		compraLojaVirtualDTO.setValorDesc(vendaCompraLojaVirtual.getValorDesconto());
		compraLojaVirtualDTO.setValorFrete(vendaCompraLojaVirtual.getValorFret());
		compraLojaVirtualDTO.setId(vendaCompraLojaVirtual.getId());

		for (ItemVendaLoja item : vendaCompraLojaVirtual.getItemVendaLojas()) {

			ItemVendaDTO itemVendaDTO = new ItemVendaDTO();
			itemVendaDTO.setQuantidade(item.getQuantidade());
			itemVendaDTO.setProduto(item.getProduto());

			compraLojaVirtualDTO.getItemVendaLoja().add(itemVendaDTO);
		}
		
		
		ContaReceber contaReceber = new ContaReceber();
		contaReceber.setDescricao("Venda da loja virtual nº: " + vendaCompraLojaVirtual.getId());
		contaReceber.setDtPagamento(Calendar.getInstance().getTime());
		contaReceber.setDtVencimento(Calendar.getInstance().getTime());
		contaReceber.setEmpresa(vendaCompraLojaVirtual.getEmpresa());
		contaReceber.setPessoa(vendaCompraLojaVirtual.getPessoa());
		contaReceber.setStatus(StatusContaReceber.QUITADA);
		contaReceber.setValorDesconto(vendaCompraLojaVirtual.getValorDesconto());
		contaReceber.setValorTotal(vendaCompraLojaVirtual.getValorTotal());
		
		contaReceberRepository.saveAndFlush(contaReceber);
		
		/*Emil para o comprador*/
		StringBuilder msgemail = new StringBuilder();
		msgemail.append("Olá, ").append(pessoaFisica.getNome()).append("</br>");
		msgemail.append("Você realizou a compra de nº: ").append(vendaCompraLojaVirtual.getId()).append("</br>");
		msgemail.append("Na loja ").append(vendaCompraLojaVirtual.getEmpresa().getNomeFantasia());
		/*assunto, msg, destino*/
		serviceSendEmail.enviarEmailHtml("Compra Realizada", msgemail.toString(), pessoaFisica.getEmail());
		
		/*Email para o vendedor*/
		msgemail = new StringBuilder();
		msgemail.append("Você realizou uma venda, nº " ).append(vendaCompraLojaVirtual.getId());
		serviceSendEmail.enviarEmailHtml("Venda Realizada", msgemail.toString(), vendaCompraLojaVirtual.getEmpresa().getEmail());

		return new ResponseEntity<VendaCompraLojaVirtualDTO>(compraLojaVirtualDTO, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "**/consultaVendaId/{id}")
	public ResponseEntity<VendaCompraLojaVirtualDTO> consultaVendaId(@PathVariable("id") Long idVenda) {

		VendaCompraLojaVirtual compraLojaVirtual = vd_Cp_Loja_virt_repository.findByIdExclusao(idVenda);
		
		if (compraLojaVirtual == null) {
			compraLojaVirtual = new VendaCompraLojaVirtual();
		}

		VendaCompraLojaVirtualDTO compraLojaVirtualDTO = vendaService.consultaVenda(compraLojaVirtual);

		return new ResponseEntity<VendaCompraLojaVirtualDTO>(compraLojaVirtualDTO, HttpStatus.OK);
	}
	
	@ResponseBody
	@DeleteMapping(value = "**/deleteVendaTotalBanco/{idVenda}")
	public ResponseEntity<String> deleteVendaTotalBanco(@PathVariable(value = "idVenda") Long idVenda) {
		
		vendaService.exclusaoTotalVendaBanco(idVenda);
		
		return new ResponseEntity<String>("Venda excluida com sucesso.",HttpStatus.OK);
		
	}
	
	
	@ResponseBody
	@DeleteMapping(value = "**/deleteVendaTotalBanco2/{idVenda}")
	public ResponseEntity<String> deleteVendaTotalBanco2(@PathVariable(value = "idVenda") Long idVenda) {
		
		vendaService.exclusaoTotalVendaBanco2(idVenda);
		
		return new ResponseEntity<String>("Venda excluida logicamente com sucesso!.",HttpStatus.OK);
		
	}
	
	
	
	@ResponseBody
	@PutMapping(value = "**/ativaRegistroVendaBanco/{idVenda}")
	public ResponseEntity<String> ativaRegistroVendaBanco(@PathVariable(value = "idVenda") Long idVenda) {
		
		vendaService.ativaRegistroVendaBanco(idVenda);
		
		return new ResponseEntity<String>("Venda ativada com sucesso!.",HttpStatus.OK);
		
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaVendaDinamicaFaixaData/{data1}/{data2}")
	public ResponseEntity<List<VendaCompraLojaVirtualDTO>> 
	                            consultaVendaDinamicaFaixaData(
	                            		@PathVariable("data1") String data1,
	                            		@PathVariable("data2") String data2) throws ParseException{
		
		List<VendaCompraLojaVirtual> compraLojaVirtual = null;
		
		
		compraLojaVirtual = vendaService.consultaVendaFaixaData(data1, data2);
		
		
		if (compraLojaVirtual == null) {
			compraLojaVirtual = new ArrayList<VendaCompraLojaVirtual>();
		}
		
		
		
         List<VendaCompraLojaVirtualDTO> compraLojaVirtualDTOList = new ArrayList<VendaCompraLojaVirtualDTO>();
		
		for (VendaCompraLojaVirtual vcl : compraLojaVirtual) {
			
			VendaCompraLojaVirtualDTO compraLojaVirtualDTO = new VendaCompraLojaVirtualDTO();
	
			compraLojaVirtualDTO.setValorTotal(vcl.getValorTotal());
			compraLojaVirtualDTO.setPessoa(vcl.getPessoa());
	
			compraLojaVirtualDTO.setEntrega(vcl.getEnderecoEntrega());
			compraLojaVirtualDTO.setCobranca(vcl.getEnderecoCobranca());
	
			compraLojaVirtualDTO.setValorDesc(vcl.getValorDesconto());
			compraLojaVirtualDTO.setValorFrete(vcl.getValorFret());
			compraLojaVirtualDTO.setId(vcl.getId());

			for (ItemVendaLoja item : vcl.getItemVendaLojas()) {
	
				ItemVendaDTO itemVendaDTO = new ItemVendaDTO();
				itemVendaDTO.setQuantidade(item.getQuantidade());
				itemVendaDTO.setProduto(item.getProduto());
	
				compraLojaVirtualDTO.getItemVendaLoja().add(itemVendaDTO);
			}
			
			compraLojaVirtualDTOList.add(compraLojaVirtualDTO);
		
		}

		return new ResponseEntity<List<VendaCompraLojaVirtualDTO>>(compraLojaVirtualDTOList, HttpStatus.OK);
		
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaVendaDinamica/{valor}/{tipoconsulta}")
	public ResponseEntity<List<VendaCompraLojaVirtualDTO>> 
						consultaVendaDinamica(@PathVariable("valor") String valor,
								              @PathVariable("tipoconsulta") String tipoconsulta) {

		List<VendaCompraLojaVirtual> compraLojaVirtual = null;
		
		if (tipoconsulta.equalsIgnoreCase("POR_ID_PROD")) {
			
			compraLojaVirtual =   vd_Cp_Loja_virt_repository.vendaPorProduto(Long.parseLong(valor));
			
		}else if (tipoconsulta.equalsIgnoreCase("POR_NOME_PROD")) {
			compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorNomeProduto(valor.toUpperCase().trim());
		}
		else if (tipoconsulta.equalsIgnoreCase("POR_NOME_CLIENTE")) {
			compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorNomeCliente(valor.toUpperCase().trim());
		}
		else if (tipoconsulta.equalsIgnoreCase("POR_ENDERECO_COBRANCA")) {
			compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorEndereCobranca(valor.toUpperCase().trim());
		}
		else if (tipoconsulta.equalsIgnoreCase("POR_ENDERECO_ENTREGA")) {
			compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorEnderecoEntrega(valor.toUpperCase().trim());
		}
		
		if (compraLojaVirtual == null) {
			compraLojaVirtual = new ArrayList<VendaCompraLojaVirtual>();
		}
		
		List<VendaCompraLojaVirtualDTO> compraLojaVirtualDTOList = new ArrayList<VendaCompraLojaVirtualDTO>();
		
		for (VendaCompraLojaVirtual vcl : compraLojaVirtual) {
			
			VendaCompraLojaVirtualDTO compraLojaVirtualDTO = new VendaCompraLojaVirtualDTO();
	
			compraLojaVirtualDTO.setValorTotal(vcl.getValorTotal());
			compraLojaVirtualDTO.setPessoa(vcl.getPessoa());
	
			compraLojaVirtualDTO.setEntrega(vcl.getEnderecoEntrega());
			compraLojaVirtualDTO.setCobranca(vcl.getEnderecoCobranca());
	
			compraLojaVirtualDTO.setValorDesc(vcl.getValorDesconto());
			compraLojaVirtualDTO.setValorFrete(vcl.getValorFret());
			compraLojaVirtualDTO.setId(vcl.getId());

			for (ItemVendaLoja item : vcl.getItemVendaLojas()) {
	
				ItemVendaDTO itemVendaDTO = new ItemVendaDTO();
				itemVendaDTO.setQuantidade(item.getQuantidade());
				itemVendaDTO.setProduto(item.getProduto());
	
				compraLojaVirtualDTO.getItemVendaLoja().add(itemVendaDTO);
			}
			
			compraLojaVirtualDTOList.add(compraLojaVirtualDTO);
		
		}

		return new ResponseEntity<List<VendaCompraLojaVirtualDTO>>(compraLojaVirtualDTOList, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/vendaPorCliente/{idCliente}")
	public ResponseEntity<List<VendaCompraLojaVirtualDTO>> vendaPorCliente(@PathVariable("idCliente") Long idCliente) {

		List<VendaCompraLojaVirtual> compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorCliente(idCliente);
		
		if (compraLojaVirtual == null) {
			compraLojaVirtual = new ArrayList<VendaCompraLojaVirtual>();
		}
		
		List<VendaCompraLojaVirtualDTO> compraLojaVirtualDTOList = new ArrayList<VendaCompraLojaVirtualDTO>();
		
		for (VendaCompraLojaVirtual vcl : compraLojaVirtual) {
			
			VendaCompraLojaVirtualDTO compraLojaVirtualDTO = new VendaCompraLojaVirtualDTO();
	
			compraLojaVirtualDTO.setValorTotal(vcl.getValorTotal());
			compraLojaVirtualDTO.setPessoa(vcl.getPessoa());
	
			compraLojaVirtualDTO.setEntrega(vcl.getEnderecoEntrega());
			compraLojaVirtualDTO.setCobranca(vcl.getEnderecoCobranca());
	
			compraLojaVirtualDTO.setValorDesc(vcl.getValorDesconto());
			compraLojaVirtualDTO.setValorFrete(vcl.getValorFret());
			compraLojaVirtualDTO.setId(vcl.getId());

			for (ItemVendaLoja item : vcl.getItemVendaLojas()) {
	
				ItemVendaDTO itemVendaDTO = new ItemVendaDTO();
				itemVendaDTO.setQuantidade(item.getQuantidade());
				itemVendaDTO.setProduto(item.getProduto());
	
				compraLojaVirtualDTO.getItemVendaLoja().add(itemVendaDTO);
			}
			
			compraLojaVirtualDTOList.add(compraLojaVirtualDTO);
		
		}

		return new ResponseEntity<List<VendaCompraLojaVirtualDTO>>(compraLojaVirtualDTOList, HttpStatus.OK);
	}
	
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaVendaPorProdutoId/{id}")
	public ResponseEntity<List<VendaCompraLojaVirtualDTO>> consultaVendaPorProduto(@PathVariable("id") Long idProd) {

		List<VendaCompraLojaVirtual> compraLojaVirtual = vd_Cp_Loja_virt_repository.vendaPorProduto(idProd);
		
		if (compraLojaVirtual == null) {
			compraLojaVirtual = new ArrayList<VendaCompraLojaVirtual>();
		}
		
		List<VendaCompraLojaVirtualDTO> compraLojaVirtualDTOList = new ArrayList<VendaCompraLojaVirtualDTO>();
		
		for (VendaCompraLojaVirtual vcl : compraLojaVirtual) {
			
			VendaCompraLojaVirtualDTO compraLojaVirtualDTO = new VendaCompraLojaVirtualDTO();
	
			compraLojaVirtualDTO.setValorTotal(vcl.getValorTotal());
			compraLojaVirtualDTO.setPessoa(vcl.getPessoa());
	
			compraLojaVirtualDTO.setEntrega(vcl.getEnderecoEntrega());
			compraLojaVirtualDTO.setCobranca(vcl.getEnderecoCobranca());
	
			compraLojaVirtualDTO.setValorDesc(vcl.getValorDesconto());
			compraLojaVirtualDTO.setValorFrete(vcl.getValorFret());
			compraLojaVirtualDTO.setId(vcl.getId());

			for (ItemVendaLoja item : vcl.getItemVendaLojas()) {
	
				ItemVendaDTO itemVendaDTO = new ItemVendaDTO();
				itemVendaDTO.setQuantidade(item.getQuantidade());
				itemVendaDTO.setProduto(item.getProduto());
	
				compraLojaVirtualDTO.getItemVendaLoja().add(itemVendaDTO);
			}
			
			compraLojaVirtualDTOList.add(compraLojaVirtualDTO);
		
		}

		return new ResponseEntity<List<VendaCompraLojaVirtualDTO>>(compraLojaVirtualDTOList, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/cancelaEtiqueta/{idEtiqueta}/{descricao}")
	public ResponseEntity<String> cancelaEtiqueta(@PathVariable String idEtiqueta, @PathVariable String reason_id, @PathVariable String descricao) throws IOException{
	
		OkHttpClient client = new OkHttpClient().newBuilder() .build();
		okhttp3.MediaType mediaType = okhttp3.MediaType.parse("application/json");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, "{\n    \"order\": {\n        \"id\": \""+idEtiqueta+"\",\n        \"reason_id\": \""+reason_id+"\",\n        \"description\": \""+descricao+"\"\n    }\n}");
		okhttp3.Request request = new Request.Builder()
				  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX+"api/v2/me/shipment/cancel")
				  .method("POST", body)
				  .addHeader("Accept", "application/json")
				  .addHeader("Content-Type", "application/json")
				  .addHeader("Authorization", "Bearer "+ ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
				  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
				  .build();
		
		okhttp3.Response response = client.newCall(request).execute();
		
		return new ResponseEntity<String>(response.body().string(), HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/imprimeCompraEtiquetaFrete/{idVenda}")
	public ResponseEntity<String> imprimeCompraEtiquetaFrete(@PathVariable Long idVenda) throws ExceptionMentoriaJava, IOException {
		
		VendaCompraLojaVirtual compraLojaVirtual = vd_Cp_Loja_virt_repository.findById(idVenda).orElseGet(null);
		
		if (compraLojaVirtual == null) {
			return new ResponseEntity<String>("Venda não encontrada", HttpStatus.OK);
		}
		
		List<Endereco> enderecos = enderecoRepository.enderecoPj(compraLojaVirtual.getEmpresa().getId());
		compraLojaVirtual.getEmpresa().setEnderecos(enderecos);
		
		EnvioEtiquetaDTO envioEtiquetaDTO = new EnvioEtiquetaDTO();
		
		envioEtiquetaDTO.setService(compraLojaVirtual.getServicoTransportadora());
		envioEtiquetaDTO.setAgency("49");
		envioEtiquetaDTO.getFrom().setName(compraLojaVirtual.getEmpresa().getNome());
		envioEtiquetaDTO.getFrom().setPhone(compraLojaVirtual.getEmpresa().getTelefone());
		envioEtiquetaDTO.getFrom().setEmail(compraLojaVirtual.getEmpresa().getEmail());
		envioEtiquetaDTO.getFrom().setCompany_document(compraLojaVirtual.getEmpresa().getCnpj());
		envioEtiquetaDTO.getFrom().setState_register(compraLojaVirtual.getEmpresa().getInscEstadual());
		envioEtiquetaDTO.getFrom().setAddress(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getRuaLogra());
		envioEtiquetaDTO.getFrom().setComplement(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getComplemento());
		envioEtiquetaDTO.getFrom().setNumber(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getNumero());
		envioEtiquetaDTO.getFrom().setDistrict(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getEstado());
		envioEtiquetaDTO.getFrom().setCity(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getCidade());
		envioEtiquetaDTO.getFrom().setCountry_id(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getUf());
		envioEtiquetaDTO.getFrom().setPostal_code(compraLojaVirtual.getEmpresa().getEnderecos().get(0).getCep());
		envioEtiquetaDTO.getFrom().setNote("Não há");


		envioEtiquetaDTO.getTo().setName(compraLojaVirtual.getPessoa().getNome());
		envioEtiquetaDTO.getTo().setPhone(compraLojaVirtual.getPessoa().getTelefone());
		envioEtiquetaDTO.getTo().setEmail(compraLojaVirtual.getPessoa().getEmail());
		envioEtiquetaDTO.getTo().setDocument(compraLojaVirtual.getPessoa().getCpf());
		envioEtiquetaDTO.getTo().setAddress(compraLojaVirtual.getPessoa().enderecoEntrega().getRuaLogra());
		envioEtiquetaDTO.getTo().setComplement(compraLojaVirtual.getPessoa().enderecoEntrega().getComplemento());
		envioEtiquetaDTO.getTo().setNumber(compraLojaVirtual.getPessoa().enderecoEntrega().getNumero());
		envioEtiquetaDTO.getTo().setDistrict(compraLojaVirtual.getPessoa().enderecoEntrega().getEstado());
		envioEtiquetaDTO.getTo().setCity(compraLojaVirtual.getPessoa().enderecoEntrega().getCidade());
		envioEtiquetaDTO.getTo().setState_abbr(compraLojaVirtual.getPessoa().enderecoEntrega().getEstado());
		envioEtiquetaDTO.getTo().setCountry_id(compraLojaVirtual.getPessoa().enderecoEntrega().getUf());
		envioEtiquetaDTO.getTo().setPostal_code(compraLojaVirtual.getPessoa().enderecoEntrega().getCep());
		envioEtiquetaDTO.getTo().setNote("Não há");
		
		
		List<ProductsEnvioEtiquetaDTO> products = new ArrayList<ProductsEnvioEtiquetaDTO>();
		
		for (ItemVendaLoja itemVendaLoja : compraLojaVirtual.getItemVendaLojas()) {
			
			ProductsEnvioEtiquetaDTO dto = new ProductsEnvioEtiquetaDTO();
			
			dto.setName(itemVendaLoja.getProduto().getNome());
			dto.setQuantity(itemVendaLoja.getQuantidade().toString());
			dto.setUnitary_value("" + itemVendaLoja.getProduto().getValorVenda().doubleValue());
			
			products.add(dto);
		}
		
		
		envioEtiquetaDTO.setProducts(products);
		
		
		List<VolumesEnvioEtiquetaDTO> volumes = new ArrayList<VolumesEnvioEtiquetaDTO>();
		
		for (ItemVendaLoja itemVendaLoja : compraLojaVirtual.getItemVendaLojas()) {
			
			VolumesEnvioEtiquetaDTO dto = new VolumesEnvioEtiquetaDTO();
			
			dto.setHeight(itemVendaLoja.getProduto().getAltura().toString());
			dto.setLength(itemVendaLoja.getProduto().getProfundidade().toString());
			dto.setWeight(itemVendaLoja.getProduto().getPeso().toString());
			dto.setWidth(itemVendaLoja.getProduto().getLargura().toString());
			
			volumes.add(dto);
		}
		
		
		envioEtiquetaDTO.setVolumes(volumes);
		
		envioEtiquetaDTO.getOptions().setInsurance_value("" + compraLojaVirtual.getValorTotal().doubleValue());
		envioEtiquetaDTO.getOptions().setReceipt(false);
		envioEtiquetaDTO.getOptions().setOwn_hand(false);
		envioEtiquetaDTO.getOptions().setReverse(false);
		envioEtiquetaDTO.getOptions().setNon_commercial(false);
		envioEtiquetaDTO.getOptions().getInvoice().setKey(compraLojaVirtual.getNotaFiscalVenda().getNumero());
		envioEtiquetaDTO.getOptions().setPlatform(compraLojaVirtual.getEmpresa().getNomeFantasia());
		
		TagsEnvioDto dtoTagEnvio = new TagsEnvioDto();
		dtoTagEnvio.setTag("Identificação do pedido na plataforma, exemplo:" + compraLojaVirtual.getId());
		dtoTagEnvio.setUrl(null);
		envioEtiquetaDTO.getOptions().getTags().add(dtoTagEnvio);
		
		
		String jsonEnvio = new ObjectMapper().writeValueAsString(envioEtiquetaDTO);
		
		
		
	    OkHttpClient client = new OkHttpClient().newBuilder().build();
	    okhttp3.MediaType mediaType = okhttp3.MediaType.parse("application/json");
	     okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, jsonEnvio);
			okhttp3.Request request = new okhttp3.Request.Builder()
			  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX + "api/v2/me/cart")
			  .method("POST", body)
			  .addHeader("Accept", "application/json")
			  .addHeader("Content-Type", "application/json")
			  .addHeader("Authorization", "Bearer " + ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
			  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
			  .build();
			
			okhttp3.Response response = client.newCall(request).execute();
			
			System.out.println(response.message());
			
			String respostaJson = response.body().string();
			
			if (respostaJson.contains("error")) {
				throw new ExceptionMentoriaJava(respostaJson);
			}
			
			JsonNode jsonNode = new ObjectMapper().readTree(respostaJson);
			
			
			Iterator<JsonNode> iterator = jsonNode.iterator();
			
			String idEtiqueta = "";
			
			while(iterator.hasNext()) {
				JsonNode node = iterator.next();
				 if (node.get("id") != null) {
				   idEtiqueta = node.get("id").asText();
				 }else {
					 idEtiqueta= node.asText(); 
				 }
				break;
			}
			
	    /*Salvando o código da etiqueta*/
		
			
		jdbcTemplate.execute("begin; update vd_cp_loja_virt set codigo_etiqueta = '"+idEtiqueta+"' where id = "+compraLojaVirtual.getId()+"  ;commit;");
	       //vd_Cp_Loja_virt_repository.updateEtiqueta(idEtiqueta, compraLojaVirtual.getId());
	    
	    
	    
		OkHttpClient clientCompra = new OkHttpClient().newBuilder().build();
		 okhttp3.MediaType mediaTypeC =  okhttp3.MediaType.parse("application/json");
		 okhttp3.RequestBody bodyC =  okhttp3.RequestBody.create(mediaTypeC, "{\n    \"orders\": [\n        \""+idEtiqueta+"\"\n    ]\n}");
		 okhttp3.Request requestC = new  okhttp3.Request.Builder()
		  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX  + "api/v2/me/shipment/checkout")
		  .method("POST", bodyC)
		  .addHeader("Accept", "application/json")
		  .addHeader("Content-Type", "application/json")
		  .addHeader("Authorization", "Bearer " + ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
		  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
		  .build();
		
		 okhttp3.Response responseC = clientCompra.newCall(requestC).execute();
		 
		 if (!responseC.isSuccessful()) {
			 return new ResponseEntity<String>("Não foi possível realizar a compra da etiqueta", HttpStatus.OK); 
		 }
		 
		OkHttpClient clientGe = new OkHttpClient().newBuilder().build();
		 okhttp3.MediaType mediaTypeGe =  okhttp3.MediaType.parse("application/json");
		 okhttp3.RequestBody bodyGe =  okhttp3.RequestBody.create(mediaTypeGe, "{\n    \"orders\":[\n        \""+idEtiqueta+"\"\n    ]\n}");
		 okhttp3.Request requestGe = new  okhttp3.Request.Builder()
		  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX  + "api/v2/me/shipment/generate")
		  .method("POST", bodyGe)
		  .addHeader("Accept", "application/json")
		  .addHeader("Content-Type", "application/json")
		  .addHeader("Authorization", "Bearer " +  ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
		  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
		  .build();
		
		 okhttp3.Response responseGe = clientGe.newCall(requestGe).execute();
		 
		 if (!responseGe.isSuccessful()) {
			 return new ResponseEntity<String>("Não foi possível gerar a etiqueta", HttpStatus.OK); 
		 }
		 
		 
			/*Faz impresão das etiquetas*/
			
			OkHttpClient clientIm = new OkHttpClient().newBuilder().build();
			okhttp3.MediaType mediaTypeIm = MediaType.parse("application/json");
			okhttp3.RequestBody bodyIm = okhttp3.RequestBody.create(mediaTypeIm, "{\n    \"mode\": \"private\",\n    \"orders\": [\n        \""+idEtiqueta+"\"\n    ]\n}");
					okhttp3.Request requestIm = new Request.Builder()
					  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX  + "api/v2/me/shipment/print")
					  .method("POST", bodyIm)
					  .addHeader("Accept", "application/json")
					  .addHeader("Content-Type", "application/json")
					  .addHeader("Authorization", "Bearer " + ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
					  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
					  .build();
					
					okhttp3.Response responseIm = clientIm.newCall(requestIm).execute();
					
					
			if (!responseIm.isSuccessful()) {
				 return new ResponseEntity<String>("Não foi imprimir a etiqueta.", HttpStatus.OK); 
			}		
					
		 String urlEtiqueta = responseIm.body().string();
			
		jdbcTemplate.execute("begin; update vd_cp_loja_virt set url_imprime_etiqueta =  '"+urlEtiqueta+"'  where id = " + compraLojaVirtual.getId() + ";commit;");
		// vd_Cp_Loja_virt_repository.updateURLEtiqueta(urlEtiqueta, compraLojaVirtual.getId());
		 
		
		        OkHttpClient clientRastreio = new OkHttpClient().newBuilder().build();
		        okhttp3.MediaType mediaTypeR = okhttp3.MediaType.parse("application/json");
		        okhttp3.RequestBody bodyR = okhttp3.RequestBody.create(mediaTypeR, "{\n    \"orders\": [\n        \"a54d16ed-1a73-4625-b73f-fb24833b9fb6\"\n    ]\n}");
		        okhttp3.Request requestR = new Request.Builder()
				  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX+ "api/v2/me/shipment/tracking")
				  .method("POST", bodyR)
				  .addHeader("Accept", "application/json")
				  .addHeader("Content-Type", "application/json")
				  .addHeader("Authorization", "Bearer " +  ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
				  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br").build();
				
				Response responseR = clientRastreio.newCall(requestR).execute();
				
				
				JsonNode jsonNodeR = new ObjectMapper().readTree(responseR.body().string());
				
				
				Iterator<JsonNode> iteratorR = jsonNodeR.iterator();
				
				String idEtiquetaR = "";
				
				while(iteratorR.hasNext()) {
					JsonNode node = iteratorR.next();
					 if (node.get("tracking") != null) {
					     idEtiquetaR = node.get("tracking").asText();
					 }else {
						 idEtiquetaR = node.asText(); 
					 }
					break;
				}
				
				 List<StatusRastreio> rastreios =	statusRastreioRepository.listaRastreioVenda(idVenda);
				 
				 if (rastreios.isEmpty()) {
					 
					 StatusRastreio rastreio = new StatusRastreio();
					 rastreio.setEmpresa(compraLojaVirtual.getEmpresa());
					 rastreio.setVendaCompraLojaVirtual(compraLojaVirtual);
					 rastreio.setUrlRastreio("https://www.melhorrastreio.com.br/rastreio/" + idEtiquetaR);
					 
					 statusRastreioRepository.saveAndFlush(rastreio);
				 }else {
					 statusRastreioRepository.salvaUrlRastreio("https://www.melhorrastreio.com.br/rastreio/" + idEtiquetaR, idVenda);
				 }
				
				
				
		
		return new ResponseEntity<String>("Sucesso", HttpStatus.OK);
		
	}
	
	@ResponseBody
	@PostMapping(value = "**/gerarBoletoPix")
	public ResponseEntity<String> gerarBoletoPix(@RequestBody @Valid ObjetoPostCarneJuno objetoPostCarneJuno) throws Exception{
		return  new ResponseEntity<String>(serviceJunoBoleto.gerarCarneApi(objetoPostCarneJuno), HttpStatus.OK);
	}
	
	
	@ResponseBody
	@PostMapping(value = "**/cancelarBoletoPix")
	public ResponseEntity<String> cancelarBoletoPix(@RequestBody @Valid String code) throws Exception{
		
		return new ResponseEntity<String>(serviceJunoBoleto.cancelarBoleto(code), HttpStatus.OK);
	}
	
	
	@ResponseBody
	@PostMapping(value = "**/consultarFreteLojaVirtual")
	public ResponseEntity<List<EmpresaTransporteDTO>> 
	     consultaFrete(@RequestBody @Valid ConsultaFreteDTO consultaFreteDTO ) throws Exception{
		
		
		ObjectMapper objectMapper = new ObjectMapper();
		String json = objectMapper.writeValueAsString(consultaFreteDTO);
		
		OkHttpClient client = new OkHttpClient().newBuilder() .build();
		okhttp3.MediaType mediaType = okhttp3.MediaType.parse("application/json");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, json);
		okhttp3.Request request = new okhttp3.Request.Builder()
		  .url(ApiTokenIntegracao.URL_MELHOR_ENVIO_SAND_BOX +"api/v2/me/shipment/calculate")
		  .method("POST", body)
		  .addHeader("Accept", "application/json")
		  .addHeader("Content-Type", "application/json")
		  .addHeader("Authorization", "Bearer " + ApiTokenIntegracao.TOKEN_MELHOR_ENVIO_SAND_BOX)
		  .addHeader("User-Agent", "suporte@jdevtreinamento.com.br")
		  .build();
		
		okhttp3.Response response = client.newCall(request).execute();
		
		JsonNode jsonNode = new ObjectMapper().readTree(response.body().string());
		
		Iterator<JsonNode> iterator = jsonNode.iterator();
		
		List<EmpresaTransporteDTO> empresaTransporteDTOs = new ArrayList<EmpresaTransporteDTO>();
		
		while(iterator.hasNext()) {
			JsonNode node = iterator.next();
			
			EmpresaTransporteDTO empresaTransporteDTO = new EmpresaTransporteDTO();
			
			if (node.get("id") != null) {
				empresaTransporteDTO.setId(node.get("id").asText());
			}
			
			if (node.get("name") != null) {
				empresaTransporteDTO.setNome(node.get("name").asText());
			}
			
			if (node.get("price") != null) {
				empresaTransporteDTO.setValor(node.get("price").asText());
			}
			
			if (node.get("company") != null) {
				empresaTransporteDTO.setEmpresa(node.get("company").get("name").asText());
				empresaTransporteDTO.setPicture(node.get("company").get("picture").asText());
			}
			
			if (empresaTransporteDTO.dadosOK()) {
				empresaTransporteDTOs.add(empresaTransporteDTO);
			}
		}
		
		return new ResponseEntity<List<EmpresaTransporteDTO>>(empresaTransporteDTOs, HttpStatus.OK);
		
	}

}
