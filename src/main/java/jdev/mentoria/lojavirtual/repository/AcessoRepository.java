package jdev.mentoria.lojavirtual.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import jdev.mentoria.lojavirtual.model.Acesso;

@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, Long> {
	
	@Query("select a from Acesso a where upper(trim(a.descricao)) like %?1%")
	List<Acesso> buscarAcessoDesc(String desc);
	
	
	@Query("select a from Acesso a where upper(trim(a.descricao)) like %?1% and a.empresa.id = ?2")
	public List<Acesso> buscarAcessoDes(String descricao, Long empresa);
	
	@Query(nativeQuery = true, value = "select cast((count(1) / 5) as integer) + 1 as qtdpagina  from  acesso where empresa_id = ?1")
	public Integer qtdPagina(Long idEmpresa);
	
	@Query(value = "select a from Acesso a where a.empresa.id = ?1 ")
	public List<Acesso> findPorPage(Long idEmpresa, Pageable pageable);

}
