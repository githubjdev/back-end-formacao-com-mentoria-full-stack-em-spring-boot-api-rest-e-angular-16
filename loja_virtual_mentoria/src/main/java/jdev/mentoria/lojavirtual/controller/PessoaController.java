package jdev.mentoria.lojavirtual.controller;

import java.util.List;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.enums.TipoPessoa;
import jdev.mentoria.lojavirtual.model.Endereco;
import jdev.mentoria.lojavirtual.model.PessoaFisica;
import jdev.mentoria.lojavirtual.model.PessoaJuridica;
import jdev.mentoria.lojavirtual.model.Usuario;
import jdev.mentoria.lojavirtual.model.dto.CepDTO;
import jdev.mentoria.lojavirtual.model.dto.ConsultaCnpjDto;
import jdev.mentoria.lojavirtual.model.dto.ObejtoMsgGeral;
import jdev.mentoria.lojavirtual.repository.EnderecoRepository;
import jdev.mentoria.lojavirtual.repository.PesssoaFisicaRepository;
import jdev.mentoria.lojavirtual.repository.PesssoaRepository;
import jdev.mentoria.lojavirtual.repository.UsuarioRepository;
import jdev.mentoria.lojavirtual.service.PessoaUserService;
import jdev.mentoria.lojavirtual.service.ServiceContagemAcessoApi;
import jdev.mentoria.lojavirtual.service.ServiceSendEmail;
import jdev.mentoria.lojavirtual.util.ValidaCNPJ;
import jdev.mentoria.lojavirtual.util.ValidaCPF;

@RestController
public class PessoaController {
	
	@Autowired
	private PesssoaRepository pesssoaRepository;
	
	@Autowired
	private PessoaUserService pessoaUserService;
	
	@Autowired
	private EnderecoRepository enderecoRepository;
	
	@Autowired
	private PesssoaFisicaRepository pesssoaFisicaRepository;
	
	@Autowired
	private ServiceContagemAcessoApi serviceContagemAcessoApi;
	
	@Autowired
	private UsuarioRepository usuarioRepository;
	
	@Autowired
	private ServiceSendEmail serviceSendEmail;
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaPfNome/{nome}")
	public ResponseEntity<List<PessoaFisica>> consultaPfNome(@PathVariable("nome") String nome) {
		
		List<PessoaFisica> fisicas = pesssoaFisicaRepository.pesquisaPorNomePF(nome.trim().toUpperCase());
		
		serviceContagemAcessoApi.atualizaAcessoEndPointPF();
		
		return new ResponseEntity<List<PessoaFisica>>(fisicas, HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaPfCpf/{cpf}")
	public ResponseEntity<List<PessoaFisica>> consultaPfCpf(@PathVariable("cpf") String cpf) {
		
		List<PessoaFisica> fisicas = pesssoaFisicaRepository.pesquisaPorCpfPF(cpf);
		
		return new ResponseEntity<List<PessoaFisica>>(fisicas, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaNomePJ/{nome}")
	public ResponseEntity<List<PessoaJuridica>> consultaNomePJ(@PathVariable("nome") String nome) {
		
		List<PessoaJuridica> fisicas = pesssoaRepository.pesquisaPorNomePJ(nome.trim().toUpperCase());
		
		return new ResponseEntity<List<PessoaJuridica>>(fisicas, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaCnpjPJ/{cnpj}")
	public ResponseEntity<List<PessoaJuridica>> consultaCnpjPJ(@PathVariable("cnpj") String cnpj) {
		
		List<PessoaJuridica> fisicas = pesssoaRepository.existeCnpjCadastradoList(cnpj.trim().toUpperCase());
		
		return new ResponseEntity<List<PessoaJuridica>>(fisicas, HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaCep/{cep}")
	public ResponseEntity<CepDTO> consultaCep(@PathVariable("cep") String cep){
		
	  return new ResponseEntity<CepDTO>(pessoaUserService.consultaCep(cep), HttpStatus.OK);
		
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/consultaCnpjReceitaWs/{cnpj}")
	public ResponseEntity<ConsultaCnpjDto> consultaCnpjReceitaWs(@PathVariable("cnpj") String cnpj){
		
	  return new ResponseEntity<ConsultaCnpjDto>(pessoaUserService.consultaCnpjReceitaWS(cnpj), HttpStatus.OK);
		
	}
	
	/*end-point é microsservicos é um API*/
	@ResponseBody
	@PostMapping(value = "**/salvarPj")
	public ResponseEntity<PessoaJuridica> salvarPj(@RequestBody @Valid PessoaJuridica pessoaJuridica) throws ExceptionMentoriaJava{
		
		/*if (pessoaJuridica.getNome() == null || pessoaJuridica.getNome().trim().isEmpty()) {
			throw new ExceptionMentoriaJava("Informe o campo de nome");
		}*/
		
		
		if (pessoaJuridica == null) {
			throw new ExceptionMentoriaJava("Pessoa juridica nao pode ser NULL");
		}
		
		
		if (pessoaJuridica.getTipoPessoa() == null) {
			throw new ExceptionMentoriaJava("Informe o tipo Jurídico ou Fornecedor da Loja");
		}
		
		if (pessoaJuridica.getId() == null && pesssoaRepository.existeCnpjCadastrado(pessoaJuridica.getCnpj()) != null) {
			throw new ExceptionMentoriaJava("Já existe CNPJ cadastrado com o número: " + pessoaJuridica.getCnpj());
		}
		
		
		if (pessoaJuridica.getId() == null && pesssoaRepository.existeInsEstadualCadastrado(pessoaJuridica.getInscEstadual()) != null) {
			throw new ExceptionMentoriaJava("Já existe Inscrição estadual cadastrado com o número: " + pessoaJuridica.getInscEstadual());
		}
		
		
		if (!ValidaCNPJ.isCNPJ(pessoaJuridica.getCnpj())) {
			throw new ExceptionMentoriaJava("Cnpj : " + pessoaJuridica.getCnpj() + " está inválido.");
		}
		

		if (pessoaJuridica.getId() == null || pessoaJuridica.getId() <= 0) {
			
			for (int p = 0; p < pessoaJuridica.getEnderecos().size(); p++) {
				
				CepDTO cepDTO = pessoaUserService.consultaCep(pessoaJuridica.getEnderecos().get(p).getCep());
				
				pessoaJuridica.getEnderecos().get(p).setBairro(cepDTO.getBairro());
				pessoaJuridica.getEnderecos().get(p).setCidade(cepDTO.getLocalidade());
				pessoaJuridica.getEnderecos().get(p).setComplemento(cepDTO.getComplemento());
				pessoaJuridica.getEnderecos().get(p).setRuaLogra(cepDTO.getLogradouro());
				pessoaJuridica.getEnderecos().get(p).setUf(cepDTO.getUf());
				
			}
		}else {
			
			for (int p = 0; p < pessoaJuridica.getEnderecos().size(); p++) {
				
				Endereco enderecoTemp =  enderecoRepository.findById(pessoaJuridica.getEnderecos().get(p).getId()).get();
				
				if (!enderecoTemp.getCep().equals(pessoaJuridica.getEnderecos().get(p).getCep())) {
					
					CepDTO cepDTO = pessoaUserService.consultaCep(pessoaJuridica.getEnderecos().get(p).getCep());
					
					pessoaJuridica.getEnderecos().get(p).setBairro(cepDTO.getBairro());
					pessoaJuridica.getEnderecos().get(p).setCidade(cepDTO.getLocalidade());
					pessoaJuridica.getEnderecos().get(p).setComplemento(cepDTO.getComplemento());
					pessoaJuridica.getEnderecos().get(p).setRuaLogra(cepDTO.getLogradouro());
					pessoaJuridica.getEnderecos().get(p).setUf(cepDTO.getUf());
				}
			}
		}
		
		pessoaJuridica = pessoaUserService.salvarPessoaJuridica(pessoaJuridica);
		
		return new ResponseEntity<PessoaJuridica>(pessoaJuridica, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/possuiAcesso/{username}/{role}")
	public ResponseEntity<Boolean> possuiAcesso(@PathVariable("username") String username,
			@PathVariable("role") String role){
		
		String sqlRole = "'" + role.replaceAll(",", "','") + "'";
		
		Boolean possuiAcesso = pessoaUserService.possuiAcesso(username, sqlRole);
		
		return new ResponseEntity<Boolean>(possuiAcesso, HttpStatus.OK);
		
	}
	
	
	@ResponseBody
	@PostMapping(value = "**/recuperarSenha")
	public ResponseEntity<ObejtoMsgGeral> recuperarAcesso(@RequestBody String login) throws Exception {
		
		Usuario usuario = usuarioRepository.findUserByLogin(login);
		
		if (usuario == null) {
			return new ResponseEntity<ObejtoMsgGeral>(new ObejtoMsgGeral("Usuário não encontrado"), HttpStatus.OK);
		}
		
		String senha = UUID.randomUUID().toString();
		
		senha = senha.substring(0, 6);
		
		String senhaCriptografada = new BCryptPasswordEncoder().encode(senha);
		
		usuarioRepository.updateSenhaUser(senhaCriptografada, login);
		
		StringBuilder msgEmail = new StringBuilder();
		msgEmail.append("<b>Senha nova senha é:</b>")
		.append(senha);
		
		serviceSendEmail.enviarEmailHtml("Sua nova senha", msgEmail.toString(), usuario.getPessoa().getEmail());
		
		
		return new ResponseEntity<ObejtoMsgGeral>(new ObejtoMsgGeral("Senha enviada para o seu e-mail"), HttpStatus.OK);
		
	}
	
	
	
	
	/*end-point é microsservicos é um API*/
	@ResponseBody
	@PostMapping(value = "**/salvarPf")
	public ResponseEntity<PessoaFisica> salvarPf(@RequestBody PessoaFisica pessoaFisica) throws ExceptionMentoriaJava{
		
		if (pessoaFisica == null) {
			throw new ExceptionMentoriaJava("Pessoa fisica não pode ser NULL");
		}
		
		if (pessoaFisica.getTipoPessoa() == null) {
			pessoaFisica.setTipoPessoa(TipoPessoa.FISICA.name());
		}
		
		if (pessoaFisica.getId() == null && pesssoaRepository.existeCpfCadastrado(pessoaFisica.getCpf()) != null) {
			throw new ExceptionMentoriaJava("Já existe CPF cadastrado com o número: " + pessoaFisica.getCpf());
		}
		
		
		if (!ValidaCPF.isCPF(pessoaFisica.getCpf())) {
			throw new ExceptionMentoriaJava("CPF : " + pessoaFisica.getCpf() + " está inválido.");
		}
		
		pessoaFisica = pessoaUserService.salvarPessoaFisica(pessoaFisica);
		
		return new ResponseEntity<PessoaFisica>(pessoaFisica, HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@PostMapping(value = "**/criaAcesso")
	public ResponseEntity<PessoaFisica> criaAcesso(@RequestBody PessoaFisica pessoaFisica) throws ExceptionMentoriaJava{
		
		if (pessoaFisica == null) {
			throw new ExceptionMentoriaJava("Pessoa fisica não pode ser NULL");
		}
		
		if (pessoaFisica.getTipoPessoa() == null) {
			pessoaFisica.setTipoPessoa(TipoPessoa.FISICA.name());
		}
		
		if (pessoaFisica.getId() == null && pesssoaRepository.existeCpfCadastrado2(pessoaFisica.getCpf())) {
			throw new ExceptionMentoriaJava("Já existe CPF cadastrado com o número: " + pessoaFisica.getCpf());
		}
		
		
		if (!ValidaCPF.isCPF(pessoaFisica.getCpf())) {
			throw new ExceptionMentoriaJava("CPF : " + pessoaFisica.getCpf() + " está inválido.");
		}
		
		pessoaFisica = pessoaUserService.salvarPessoaFisica(pessoaFisica);
		
		return new ResponseEntity<PessoaFisica>(pessoaFisica, HttpStatus.OK);
	}


	
	@ResponseBody
	@GetMapping(value = "**/listaPorPagePj/{idEmpresa}/{pagina}")
	public ResponseEntity<List<PessoaJuridica>> pagePj(@PathVariable("idEmpresa") Long idEmpresa,
			@PathVariable("pagina") Integer pagina){
		
		Pageable pageable = PageRequest.of(pagina, 5, Sort.by("nomeFantasia"));
		
		List<PessoaJuridica> lista = pesssoaRepository.findPorPage(idEmpresa, pageable); 
		
		return new ResponseEntity<List<PessoaJuridica>>(lista, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/listaPorPagePf/{idEmpresa}/{pagina}")
	public ResponseEntity<List<PessoaFisica>> listaPorPagePf(@PathVariable("idEmpresa") Long idEmpresa,
			@PathVariable("pagina") Integer pagina){
		
		Pageable pageable = PageRequest.of(pagina, 5, Sort.by("nome"));
		
		List<PessoaFisica> lista = pesssoaRepository.findPorPagePf(idEmpresa, pageable); 
		
		return new ResponseEntity<List<PessoaFisica>>(lista, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/qtdPaginaPj/{idEmpresa}")
	public ResponseEntity<Integer> qtdPaginaPj(@PathVariable("idEmpresa") Long idEmpresa){
		
		Integer qtdPagina = pesssoaRepository.qtdPagina(idEmpresa);
		
		return new ResponseEntity<Integer>(qtdPagina, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/qtdPaginaPf/{idEmpresa}")
	public ResponseEntity<Integer> qtdPaginaPf(@PathVariable("idEmpresa") Long idEmpresa){
		
		Integer qtdPagina = pesssoaRepository.qtdPaginaPf(idEmpresa);
		
		return new ResponseEntity<Integer>(qtdPagina, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPorNomePj/{desc}/{empresa}")
	public ResponseEntity<List<PessoaJuridica>> buscarPorNomePj(@PathVariable("desc") String desc,
			@PathVariable("empresa") Long empresa) { 
		
		List<PessoaJuridica> acesso = pesssoaRepository.buscarPessoaJuridicaDes(desc.toUpperCase(), empresa);
		
		return new ResponseEntity<List<PessoaJuridica>>(acesso,HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPorNomePf/{desc}/{empresa}")
	public ResponseEntity<List<PessoaFisica>> buscarPorNomePf(@PathVariable("desc") String desc,
			@PathVariable("empresa") Long empresa) { 
		
		List<PessoaFisica> acesso = pesssoaRepository.buscarPessoaFisicaDes(desc.toUpperCase(), empresa);
		
		return new ResponseEntity<List<PessoaFisica>>(acesso,HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPjId/{id}")
	public ResponseEntity<PessoaJuridica> buscarPjId(@PathVariable("id") Long idPj) { 
		
		PessoaJuridica pessoaJuridica = pesssoaRepository.findById(idPj).get();
		
		return new ResponseEntity<PessoaJuridica>(pessoaJuridica,HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPfId/{id}")
	public ResponseEntity<PessoaFisica> buscarPfId(@PathVariable("id") Long idPj) { 
		
		PessoaFisica pessoaJuridica = pesssoaRepository.findByIdPf(idPj);
		
		return new ResponseEntity<PessoaFisica>(pessoaJuridica,HttpStatus.OK);
	}
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/deletePessoaJuridicia") /*Mapeando a url para receber JSON*/
	public ResponseEntity<String> deletePessoaJuridicia(@RequestBody PessoaJuridica pessoaJuridica) { /*Recebe o JSON e converte pra Objeto*/
		
		usuarioRepository.deleteAcessoUserByPessoa(pessoaJuridica.getId());
		usuarioRepository.deleteByPessoa(pessoaJuridica.getId());
		pesssoaRepository.deleteById(pessoaJuridica.getId());
		
		return new ResponseEntity<String>(new Gson().toJson("PJ Removido"),HttpStatus.OK);
	}
	
	
	
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/deletePessoaFisica") /*Mapeando a url para receber JSON*/
	public ResponseEntity<String> deletePessoaFisica(@RequestBody PessoaFisica pessoaFisica) { /*Recebe o JSON e converte pra Objeto*/
		
		usuarioRepository.deleteAcessoUserByPessoa(pessoaFisica.getId());
		usuarioRepository.deleteByPessoa(pessoaFisica.getId());
		pesssoaRepository.deleteByIdPf(pessoaFisica.getId());
		
		return new ResponseEntity<String>(new Gson().toJson("PF Removido"),HttpStatus.OK);
	}
	
	

}
