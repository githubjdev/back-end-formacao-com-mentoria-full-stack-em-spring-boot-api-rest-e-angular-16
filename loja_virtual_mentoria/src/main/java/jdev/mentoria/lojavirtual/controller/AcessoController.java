package jdev.mentoria.lojavirtual.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.model.Acesso;
import jdev.mentoria.lojavirtual.repository.AcessoRepository;
import jdev.mentoria.lojavirtual.service.AcessoService;

//@CrossOrigin(origins = "https://www.jdevtreinamento.com.br")
@Controller
@RestController
public class AcessoController {
	
	@Autowired
	private AcessoService acessoService;
	
	@Autowired
	private AcessoRepository acessoRepository;
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/salvarAcesso") /*Mapeando a url para receber JSON*/
	public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) throws ExceptionMentoriaJava { /*Recebe o JSON e converte pra Objeto*/
		
		if (acesso.getId() == null) {
		  List<Acesso> acessos = acessoRepository.buscarAcessoDesc(acesso.getDescricao().toUpperCase());
		  
		  if (!acessos.isEmpty()) {
			  throw new ExceptionMentoriaJava("Já existe Acesso com a descrição: " + acesso.getDescricao());
		  }
		}
		
		
		Acesso acessoSalvo = acessoService.save(acesso);
		
		return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
	}
	
	
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/deleteAcesso") /*Mapeando a url para receber JSON*/
	public ResponseEntity<String> deleteAcesso(@RequestBody Acesso acesso) { /*Recebe o JSON e converte pra Objeto*/
		
		acessoRepository.deleteById(acesso.getId());
		
		return new ResponseEntity<String>(new Gson().toJson("Acesso Removido"),HttpStatus.OK);
	}
	

	//@Secured({ "ROLE_GERENTE", "ROLE_ADMIN" })
	@ResponseBody
	@DeleteMapping(value = "**/deleteAcessoPorId/{id}")
	public ResponseEntity<String> deleteAcessoPorId(@PathVariable("id") Long id) { 
		
		acessoRepository.deleteById(id);
		
		return new ResponseEntity<String>(new Gson().toJson("Acesso Removido"),HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/obterAcesso/{id}")
	public ResponseEntity<Acesso> obterAcesso(@PathVariable("id") Long id) throws ExceptionMentoriaJava { 
		
		Acesso acesso = acessoRepository.findById(id).orElse(null);
		
		if (acesso == null) {
			throw new ExceptionMentoriaJava("Não encontrou Acesso com código: " + id);
		}
		
		return new ResponseEntity<Acesso>(acesso,HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPorDesc/{desc}")
	public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable("desc") String desc) { 
		
		List<Acesso> acesso = acessoRepository.buscarAcessoDesc(desc.toUpperCase());
		
		return new ResponseEntity<List<Acesso>>(acesso,HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/listaPorPageAcesso/{idEmpresa}/{pagina}")
	public ResponseEntity<List<Acesso>> page(@PathVariable("idEmpresa") Long idEmpresa,
			@PathVariable("pagina") Integer pagina){
		
		Pageable pageable = PageRequest.of(pagina, 5, Sort.by("descricao"));
		
		List<Acesso> lista = acessoRepository.findPorPage(idEmpresa, pageable); 
		
		return new ResponseEntity<List<Acesso>>(lista, HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/qtdPaginaAcesso/{idEmpresa}")
	public ResponseEntity<Integer> qtdPagina(@PathVariable("idEmpresa") Long idEmpresa){
		
		Integer qtdPagina = acessoRepository.qtdPagina(idEmpresa);
		
		return new ResponseEntity<Integer>(qtdPagina, HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPorAcesso/{desc}/{empresa}")
	public ResponseEntity<List<Acesso>> buscarPorDesc2(@PathVariable("desc") String desc,
			@PathVariable("empresa") Long empresa) { 
		
		List<Acesso> acesso = acessoRepository.buscarAcessoDes(desc.toUpperCase(), empresa);
		
		return new ResponseEntity<List<Acesso>>(acesso,HttpStatus.OK);
	}
	
	
	

}
