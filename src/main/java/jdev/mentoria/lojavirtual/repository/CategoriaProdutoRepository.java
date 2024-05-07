package jdev.mentoria.lojavirtual.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jdev.mentoria.lojavirtual.model.CategoriaProduto;

@Repository
public interface CategoriaProdutoRepository extends JpaRepository<CategoriaProduto, Long> {
	
	@Query(nativeQuery = true, value = "select count(1) > 0 from categoria_produto where upper(trim(nome_desc)) = upper(trim(?1))")
	public boolean existeCatehoria(String nomeCategoria);

	
	@Query("select a from CategoriaProduto a where upper(trim(a.nomeDesc)) like %?1%")
	public List<CategoriaProduto> buscarCategoriaDes(String nomeDesc);


	@Query("select a from CategoriaProduto a where a.empresa.id = ?1")
	public List<CategoriaProduto> findAll(Long codEmpresa);


	@Query("select a from CategoriaProduto a where upper(trim(a.nomeDesc)) like %?1% and a.empresa.id = ?2")
	public List<CategoriaProduto> buscarCategoriaDes(String nomeDesc, Long empresa);
	
	@Query(nativeQuery = true, value = "select cast((count(1) / 5) as integer) + 1 as qtdpagina  from  categoria_produto where empresa_id = ?1")
	public Integer qtdPagina(Long idEmpresa);
	
	@Query(value = "select a from CategoriaProduto a where a.empresa.id = ?1 ")
	public List<CategoriaProduto> findPorPage(Long idEmpresa, Pageable pageable);

}
