package jdev.mentoria.lojavirtual.model;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.ConstraintMode;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "usuario")
@SequenceGenerator(name = "seq_usuario", sequenceName = "seq_usuario", allocationSize = 1, initialValue = 1)
public class Usuario implements UserDetails {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_usuario")
	private Long id;
	
	@Column(nullable = false, unique = true)
	private String login;
	
	@Column(nullable = false)
	private String senha;
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date dataAtualSenha;
	
	
	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "pessoa_id", nullable = false, 
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
	private Pessoa pessoa;
	
	
	
	public Pessoa getEmpresa() {
		return empresa;
	}

	public void setEmpresa(Pessoa empresa) {
		this.empresa = empresa;
	}

	@ManyToOne(targetEntity = Pessoa.class)
	@JoinColumn(name = "empresa_id", nullable = false, 
	foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "empresa_id_fk"))
	private Pessoa empresa;
	
	
	@OneToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "usuarios_acesso", 
		uniqueConstraints = @UniqueConstraint (columnNames = {"usuario_id", "acesso_id"} ,
		name = "unique_acesso_user"),
	
	   joinColumns = @JoinColumn(name = "usuario_id", referencedColumnName = "id", table = "usuario", 
	   unique = false, foreignKey = @ForeignKey(name = "usuario_fk", value = ConstraintMode.CONSTRAINT)), 
	   
	inverseJoinColumns = @JoinColumn(name = "acesso_id", 
						unique = false, referencedColumnName = "id", table = "acesso",
						foreignKey = @ForeignKey(name = "aesso_fk", value = ConstraintMode.CONSTRAINT)))
	private List<Acesso> acessos;
	
	
	public void setPessoa(Pessoa pessoa) {
		this.pessoa = pessoa;
	}
	
	public Pessoa getPessoa() {
		return pessoa;
	}
	
	
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public Date getDataAtualSenha() {
		return dataAtualSenha;
	}

	public void setDataAtualSenha(Date dataAtualSenha) {
		this.dataAtualSenha = dataAtualSenha;
	}

	public List<Acesso> getAcessos() {
		return acessos;
	}

	public void setAcessos(List<Acesso> acessos) {
		this.acessos = acessos;
	}

	/*Autoridades = São os acesso, ou seja ROLE_ADMIN, ROLE_SECRETARIO, ROLE_FINACEIRO*/
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		return this.acessos;
	}

	@Override
	public String getPassword() {
		return this.senha;
	}

	@Override
	public String getUsername() {
		return this.login;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

}
