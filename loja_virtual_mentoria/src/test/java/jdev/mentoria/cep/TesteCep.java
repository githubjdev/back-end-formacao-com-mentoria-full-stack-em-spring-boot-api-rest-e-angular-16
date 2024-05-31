package jdev.mentoria.cep;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

import jdev.mentoria.lojavirtual.LojaVirtualMentoriaApplication;
import jdev.mentoria.lojavirtual.model.dto.CepDTO;
import jdev.mentoria.lojavirtual.service.PessoaUserService;
import junit.framework.TestCase;

@Profile("dev")
@SpringBootTest(classes = LojaVirtualMentoriaApplication.class)
public class TesteCep extends TestCase {

	@Autowired
	private PessoaUserService pessoaUserService;

	@Test
	public void testCep()  throws Exception{

		HttpURLConnection con = (HttpURLConnection) 
				new URL("https://viacep.com.br/ws/87025-758/json/")
				.openConnection();

		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");

		con.setDoOutput(true);
		con.setDoInput(true);

		String output = new BufferedReader(
				 new InputStreamReader(con.getInputStream()))
				 .lines().reduce((a, b) -> a + b).get();

		System.out.println(output);

	}

}
