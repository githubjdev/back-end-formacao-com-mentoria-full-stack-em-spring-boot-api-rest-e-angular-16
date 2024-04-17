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

import jdev.mentoria.lojavirtual.ExceptionMentoriaJava;
import jdev.mentoria.lojavirtual.model.FormaPagamento;
import jdev.mentoria.lojavirtual.repository.FormaPagamentoRepository;

@RestController
public class FormaPagamentoController {
	
	
	@Autowired
	private FormaPagamentoRepository formaPagamentoRepository;
	
	
	@ResponseBody 
	@PostMapping(value = "**/salvarFormaPagamento") 
	public ResponseEntity<FormaPagamento> salvarFormaPagamento(@RequestBody @Valid FormaPagamento formaPagamento) 
			throws ExceptionMentoriaJava { 

		formaPagamento = formaPagamentoRepository.save(formaPagamento);
		
		return new ResponseEntity<FormaPagamento>(formaPagamento, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = "**/listaFormaPagamento/{idEmpresa}")
	public ResponseEntity<List<FormaPagamento>> listaFormaPagamentoidEmpresa(@PathVariable(value = "idEmpresa") Long idEmpresa){
		
		return new ResponseEntity<List<FormaPagamento>>(formaPagamentoRepository.findAll(idEmpresa), HttpStatus.OK);
		
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/listaFormaPagamento")
	public ResponseEntity<List<FormaPagamento>> listaFormaPagamento(){
		
		return new ResponseEntity<List<FormaPagamento>>(formaPagamentoRepository.findAll(), HttpStatus.OK);
		
	}

}
