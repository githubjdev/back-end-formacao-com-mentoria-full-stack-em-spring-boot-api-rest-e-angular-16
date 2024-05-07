package jdev.mentoria.lojavirtual.model.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Embedded implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private List<ConteudoBoletoJuno> charges = new ArrayList<ConteudoBoletoJuno>();
	
	public void setCharges(List<ConteudoBoletoJuno> charges) {
		this.charges = charges;
	}
	
	public List<ConteudoBoletoJuno> getCharges() {
		return charges;
	}

}
