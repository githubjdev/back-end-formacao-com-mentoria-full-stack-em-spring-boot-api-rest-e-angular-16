package jdev.mentoria.lojavirtual.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.model.ContaPagar;
import jdev.mentoria.lojavirtual.repository.ContaPagarRepository;

@Controller
@RestController
public class ContaPagarController {
	
	@Autowired
	private ContaPagarRepository contaPagarRepository; 
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/salvarContaPagar") /*Mapeando a url para receber JSON*/
	public ResponseEntity<ContaPagar> salvarAcesso(@RequestBody @Valid ContaPagar contaPagar) throws ExceptionMentoriaJava { /*Recebe o JSON e converte pra Objeto*/
		
		if (contaPagar.getEmpresa() == null || contaPagar.getEmpresa().getId() <= 0) {
			throw new ExceptionMentoriaJava("Empresa responsável deve ser informada");
		}
		

		if (contaPagar.getPessoa() == null || contaPagar.getPessoa().getId() <= 0) {
			throw new ExceptionMentoriaJava("Pessoa responsável deve ser informada");
		}
		
		if (contaPagar.getPessoa_fornecedor() == null || contaPagar.getPessoa_fornecedor().getId() <= 0) {
			throw new ExceptionMentoriaJava("Fornecedor responsável deve ser informada");
		}
		
		
		if (contaPagar.getId() == null) {
			List<ContaPagar> contaPagars = contaPagarRepository.buscaContaDesc(contaPagar.getDescricao().toUpperCase().trim());
			if(!contaPagars.isEmpty()) {
				throw new ExceptionMentoriaJava("Já existe conta a pagar com a mesma descrição.");
			}
		}
		
		
		ContaPagar conPagarSalva = contaPagarRepository.save(contaPagar);
		
		return new ResponseEntity<ContaPagar>(conPagarSalva, HttpStatus.OK);
	}
	
	
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/deleteContaPagar") /*Mapeando a url para receber JSON*/
	public ResponseEntity<String> deleteContaPagar(@RequestBody ContaPagar contaPagar) { /*Recebe o JSON e converte pra Objeto*/
		
		contaPagarRepository.deleteById(contaPagar.getId());
		
		return new ResponseEntity<String>("Conta Pagar Removida",HttpStatus.OK);
	}
	

	@ResponseBody
	@DeleteMapping(value = "**/deleteContaPagarPorId/{id}")
	public ResponseEntity<String> deleteContaPagarPorId(@PathVariable("id") Long id) { 
		
		contaPagarRepository.deleteById(id);
		
		return new ResponseEntity<String>("Conta Pagar Removida",HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/obterContaPagar/{id}")
	public ResponseEntity<ContaPagar> obterContaPagar(@PathVariable("id") Long id) throws ExceptionMentoriaJava { 
		
		ContaPagar contaPagar = contaPagarRepository.findById(id).orElse(null);
		
		if (contaPagar == null) {
			throw new ExceptionMentoriaJava("Não encontrou Conta a PAgar com código: " + id);
		}
		
		return new ResponseEntity<ContaPagar>(contaPagar,HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarContaPagarDesc/{desc}")
	public ResponseEntity<List<ContaPagar>> buscarContaPagarDesc(@PathVariable("desc") String desc) { 
		
		List<ContaPagar> contaPagar = contaPagarRepository.buscaContaDesc(desc.toUpperCase());
		
		return new ResponseEntity<List<ContaPagar>>(contaPagar,HttpStatus.OK);
	}
	
	
	

}
