package jdev.mentoria.lojavirtual.model.dto;

import java.util.ArrayList;
import java.util.List;

public class ErroResponseApiAsaas {
	
	private List<ObjetoErroResponseApiAsaas> errors = new ArrayList<ObjetoErroResponseApiAsaas>();
	
	
	public void setErrors(List<ObjetoErroResponseApiAsaas> errors) {
		this.errors = errors;
	}
	
	public List<ObjetoErroResponseApiAsaas> getErrors() {
		return errors;
	}
	
	public String listaErros() {
		
		StringBuilder builder = new StringBuilder();
		
		for (ObjetoErroResponseApiAsaas error : errors) {
			builder.append(error.getDescription()).append(" - Code: ").append(error.getCode()).append("\n");
		}
		
		return builder.toString();
	}

}
