package jdev.mentoria.lojavirtual.controller;

import java.util.List;

import javax.validation.Valid;

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
import jdev.mentoria.lojavirtual.model.CategoriaProduto;
import jdev.mentoria.lojavirtual.model.MarcaProduto;
import jdev.mentoria.lojavirtual.repository.MarcaRepository;

@Controller
@RestController
public class MarcaProdutoController {
	
	
	@Autowired
	private MarcaRepository marcaRepository;
	
	
	@ResponseBody
	@GetMapping(value = "**/listaPorPageMarcaProduto/{idEmpresa}/{pagina}")
	public ResponseEntity<List<MarcaProduto>> page(@PathVariable("idEmpresa") Long idEmpresa,
			@PathVariable("pagina") Integer pagina){
		
		Pageable pageable = PageRequest.of(pagina, 5, Sort.by("nomeDesc"));
		
		List<MarcaProduto> lista = marcaRepository.findPorPage(idEmpresa, pageable); 
		
		return new ResponseEntity<List<MarcaProduto>>(lista, HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarPorDescMarca/{desc}/{empresa}")
	public ResponseEntity<List<MarcaProduto>> buscarPorMarca(@PathVariable("desc") String desc,
			@PathVariable("empresa") Long empresa) { 
		
		List<MarcaProduto> lista = marcaRepository.buscarMarcaDes(desc.toUpperCase(), empresa);
		
		return new ResponseEntity<List<MarcaProduto>>(lista,HttpStatus.OK);
	}
	
	
	@ResponseBody
	@GetMapping(value = "**/qtdPaginaMarcaProduto/{idEmpresa}")
	public ResponseEntity<Integer> qtdPagina(@PathVariable("idEmpresa") Long idEmpresa){
		
		Integer qtdPagina = marcaRepository.qtdPagina(idEmpresa);
		
		return new ResponseEntity<Integer>(qtdPagina, HttpStatus.OK);
	}
	
	@ResponseBody 
	@PostMapping(value = "**/salvarMarca")
	public ResponseEntity<MarcaProduto> salvarMarca(@RequestBody @Valid MarcaProduto marcaProduto ) throws ExceptionMentoriaJava { /*Recebe o JSON e converte pra Objeto*/
		
		if (marcaProduto.getId() == null) {
		  List<MarcaProduto> marcaProdutos  = marcaRepository.buscarMarcaDesc(marcaProduto.getNomeDesc().toUpperCase());
		  
		  if (!marcaProdutos.isEmpty()) {
			  throw new ExceptionMentoriaJava("Já existe Marca com a descrição: " + marcaProduto.getNomeDesc());
		  }
		}
		
		
		MarcaProduto marcaProdutoSalvo = marcaRepository.save(marcaProduto);
		
		return new ResponseEntity<MarcaProduto>(marcaProdutoSalvo, HttpStatus.OK);
	}
	
	
	
	@ResponseBody /*Poder dar um retorno da API*/
	@PostMapping(value = "**/deleteMarca") /*Mapeando a url para receber JSON*/
	public ResponseEntity<String> deleteMarca(@RequestBody MarcaProduto marcaProduto) { /*Recebe o JSON e converte pra Objeto*/
		
		marcaRepository.deleteById(marcaProduto.getId());
		
		return new ResponseEntity<String>(new Gson().toJson("Marca produto Removido"),HttpStatus.OK);
	}
	

	//@Secured({ "ROLE_GERENTE", "ROLE_ADMIN" })
	@ResponseBody
	@DeleteMapping(value = "**/deleteMarcaPorId/{id}")
	public ResponseEntity<?> deleteMarcaPorId(@PathVariable("id") Long id) { 
		
		marcaRepository.deleteById(id);
		
		return new ResponseEntity("Marca Produto Removido",HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/obterMarcaProduto/{id}")
	public ResponseEntity<MarcaProduto> obterMarcaProduto(@PathVariable("id") Long id) throws ExceptionMentoriaJava { 
		
		MarcaProduto marcaProduto = marcaRepository.findById(id).orElse(null);
		
		if (marcaProduto == null) {
			throw new ExceptionMentoriaJava("Não encontrou Marca Produto com código: " + id);
		}
		
		return new ResponseEntity<MarcaProduto>(marcaProduto,HttpStatus.OK);
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "**/buscarMarcaProdutoPorDesc/{desc}")
	public ResponseEntity<List<MarcaProduto>> buscarMarcaProdutoPorDesc(@PathVariable("desc") String desc) { 
		
		List<MarcaProduto>  marcaProdutos = marcaRepository.buscarMarcaDesc(desc.toUpperCase().trim());
		
		return new ResponseEntity<List<MarcaProduto>>(marcaProdutos,HttpStatus.OK);
	}
	
	
	

}
