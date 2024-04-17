package jdev.mentoria.lojavirtual.controller;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import jdev.mentoria.lojavirtual.model.BoletoJuno;
import jdev.mentoria.lojavirtual.model.dto.AttibutesNotificaoPagaApiJuno;
import jdev.mentoria.lojavirtual.model.dto.DataNotificacaoApiJunotPagamento;
import jdev.mentoria.lojavirtual.model.dto.NotificacaoPagamentoApiAsaas;
import jdev.mentoria.lojavirtual.repository.BoletoJunoRepository;

@Controller
@RequestMapping(value = "/requisicaojunoboleto")
public class RecebePagamentoWebHookApiJuno implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Autowired
	private BoletoJunoRepository boletoJunoRepository; 
	
	
	@ResponseBody
	@RequestMapping(value = "/notificacaoapiasaas", consumes = {"application/json;charset=UTF-8"},
	headers = "Content-Type=application/json;charset=UTF-8", method = RequestMethod.POST)
	public ResponseEntity<String> recebeNotificacaoPagamentoApiAsaas(@RequestBody NotificacaoPagamentoApiAsaas notificacaoPagamentoApiAsaas) {
		
		
		BoletoJuno boletoJuno = boletoJunoRepository.findByCode(notificacaoPagamentoApiAsaas.idFatura());
		
		if (boletoJuno == null) {
			return new ResponseEntity<String>("Boleto/Fatura não encontrada no banco de dados", HttpStatus.OK);
		}
		
		
		if (boletoJuno != null 
				&& notificacaoPagamentoApiAsaas.boletoPixFaturaPaga()
				&& !boletoJuno.isQuitado()) {
			 
			 boletoJunoRepository.quitarBoletoById(boletoJuno.getId());
			 System.out.println("Boleto: " + boletoJuno.getCode() + " foi quitado ");
			 /**Fazendo qualquer regra de negocio que vc queira*/
			 
			 return new ResponseEntity<String>("Recebido do Asaas, boleto id: " + boletoJuno.getId(),HttpStatus.OK);
		}else {
			System.out.println("Fatura :"  
		          + notificacaoPagamentoApiAsaas.idFatura() 
		          + " não foi processada, quitada: " 
		          + notificacaoPagamentoApiAsaas.boletoPixFaturaPaga() 
		          + " valor quitado : "+ boletoJuno.isQuitado());
		}
		
		return new ResponseEntity<String>("Não foi processado a fatura : " + notificacaoPagamentoApiAsaas.idFatura(), HttpStatus.OK);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/notificacaoapiv2", consumes = {"application/json;charset=UTF-8"},
	headers = "Content-Type=application/json;charset=UTF-8", method = RequestMethod.POST)
	private HttpStatus recebeNotificaopagamentojunoapiv2(@RequestBody DataNotificacaoApiJunotPagamento dataNotificacaoApiJunotPagamento) {
		
		
		for (AttibutesNotificaoPagaApiJuno data : dataNotificacaoApiJunotPagamento.getData()) {
			
			 String codigoBoletoPix = data.getAttributes().getCharge().getCode();
			 
			 String status = data.getAttributes().getStatus();
			 
			 boolean boletoPago = status.equalsIgnoreCase("CONFIRMED") ? true : false;
			 
			 BoletoJuno boletoJuno = boletoJunoRepository.findByCode(codigoBoletoPix);
			 
			 if (boletoJuno != null && !boletoJuno.isQuitado() && boletoPago) {
				 
				 boletoJunoRepository.quitarBoletoById(boletoJuno.getId());
				 System.out.println("Boleto: " + boletoJuno.getCode() + " foi quitado ");
				 
			 }
		}
		
		return HttpStatus.OK;
	}
	
	

}
