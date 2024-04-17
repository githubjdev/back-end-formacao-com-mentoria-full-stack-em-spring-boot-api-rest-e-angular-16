package jdev.mentoria.lojavirtual.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import jdev.mentoria.lojavirtual.model.MarcaProduto;

@Repository
@Transactional
public interface MarcaRepository extends JpaRepository<MarcaProduto, Long> {
	
	@Query("select a from MarcaProduto a where upper(trim(a.nomeDesc)) like %?1%")
	List<MarcaProduto> buscarMarcaDesc(String desc);
	
	
	
	@Query(nativeQuery = true, value = "select cast((count(1) / 5) as integer) + 1 as qtdpagina  from  marca_produto where empresa_id = ?1")
	public Integer qtdPagina(Long idEmpresa);
	
	
	@Query("select a from MarcaProduto a where upper(trim(a.nomeDesc)) like %?1% and a.empresa.id = ?2")
	public List<MarcaProduto> buscarMarcaDes(String nomeDesc, Long empresa);
	
	
	@Query(value = "select a from MarcaProduto a where a.empresa.id = ?1 ")
	public List<MarcaProduto> findPorPage(Long idEmpresa, Pageable pageable);

}
