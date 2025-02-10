package jdev.mentoria.lojavirtual.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.model.CupDesc;
import jdev.mentoria.lojavirtual.repository.CupDescontoRepository;

@RestController
public class CupDescontoController {
	
	@Autowired
	private CupDescontoRepository cupDescontoRepository;
	
	
	
	@ResponseBody 
	@PostMapping(value = "**/salvarCupDesc") 
	public ResponseEntity<CupDesc> salvarCupDesc(@RequestBody @Valid CupDesc cupDesc) 
			throws ExceptionMentoriaJava { 

		cupDesc = cupDescontoRepository.saveAndFlush(cupDesc);
		
		return new ResponseEntity<CupDesc>(cupDesc, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/listaCupomDesc/{idEmpresa}")
	public ResponseEntity<List<CupDesc>> listaCupomDesc(@PathVariable("idEmpresa") Long idEmpresa){
		
		return new ResponseEntity<List<CupDesc>>(cupDescontoRepository.cupDescontoPorEmpresa(idEmpresa), HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/listaCupomDesc")
	public ResponseEntity<List<CupDesc>> listaCupomDesc(){
		
		return new ResponseEntity<List<CupDesc>>(cupDescontoRepository.findAll() , HttpStatus.OK);
	}
	
	
	@ResponseBody
	@PostMapping(value = "**/deletarCupDesc")
	public ResponseEntity<String> deletarCupDesc(@RequestBody CupDesc cupDesc) throws ExceptionMentoriaJava{
		
		if (cupDescontoRepository.findById(cupDesc.getId()).isPresent() == false) {
			throw new ExceptionMentoriaJava("Cupom já foi deletado.");
		}
		
		cupDescontoRepository.deleteById(cupDesc.getId());
		
		return new ResponseEntity<String>(new Gson().toJson("Cupom de desconto removido."),HttpStatus.OK);
		
	}

}
