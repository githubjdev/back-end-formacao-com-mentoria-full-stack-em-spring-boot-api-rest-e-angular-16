package jdev.mentoria.lojavirtual.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jdev.mentoria.lojavirtual.model.Endereco;

@Repository
public interface EnderecoRepository extends JpaRepository<Endereco, Long> {
	
	
	@Query(value = "select e from Endereco e where e.empresa.id = ?1")
	public List<Endereco> enderecoPj(Long idEmpresa);

}
