--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

-- Started on 2024-07-09 20:07:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 236 (class 1255 OID 140268)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

  declare existe integer;

  begin 
    existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_id);
    if(existe <=0 ) then 
     existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
    if (existe <= 0) then
      raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
     end if;
    end if;
    RETURN NEW;
  end;
  $$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 140269)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

  declare existe integer;

  begin 
    existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id);
    if(existe <=0 ) then 
     existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
    if (existe <= 0) then
      raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
     end if;
    end if;
    RETURN NEW;
  end;
  $$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 232 (class 1259 OID 198895)
-- Name: access_token_junoapi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE access_token_junoapi (
    id bigint NOT NULL,
    access_token text,
    data_cadastro timestamp without time zone,
    expires_in character varying(255),
    jti character varying(255),
    scope character varying(255),
    token_acesso character varying(255),
    token_type character varying(255),
    user_name character varying(255)
);


ALTER TABLE access_token_junoapi OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 140270)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    empresa_id bigint
);


ALTER TABLE acesso OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 140273)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE avaliacao_produto OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 198982)
-- Name: boleto_juno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE boleto_juno (
    id bigint NOT NULL,
    id_pix character varying(255),
    chargeicartao character varying(255),
    checkout_url character varying(255),
    code character varying(255),
    data_vencimento character varying(255),
    id_chr_boleto character varying(255),
    image_in_base64 text,
    installment_link character varying(255),
    link character varying(255),
    payload_in_base64 text,
    quitado boolean NOT NULL,
    recorrencia integer,
    valor numeric(19,2),
    empresa_id bigint NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE boleto_juno OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 140276)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE categoria_produto OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 140279)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conta_pagar (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint,
    empresa_id bigint NOT NULL,
    data_pagamento_conta_pagar date
);


ALTER TABLE conta_pagar OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 140285)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conta_receber (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_total numeric(19,2) NOT NULL,
    pessoa_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    status_conta_receber character varying(255) NOT NULL,
    empresaid bigint NOT NULL,
    pessoaid bigint NOT NULL,
    pessoa_fornecedorid bigint NOT NULL,
    descricao_conta_receber character varying(255) NOT NULL,
    data_cadastro_conta_receber date NOT NULL,
    data_pagamento_conta_receber date,
    data_vencimento_conta_receber date NOT NULL,
    valor_desconto_conta_receber numeric(19,2) NOT NULL,
    valor_total_conta_receber numeric(19,2) NOT NULL
);


ALTER TABLE conta_receber OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 140291)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cup_desc (
    id bigint NOT NULL,
    cod_desc character varying(255) NOT NULL,
    data_validade_cupom date NOT NULL,
    valor_porcent_desc numeric(19,2),
    valor_real_desc numeric(19,2),
    empresa_id bigint NOT NULL,
    codigo_desconto character varying(255) NOT NULL,
    valor_percentual_desconto numeric(19,2),
    valor_real_desconto numeric(19,2)
);


ALTER TABLE cup_desc OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 186006)
-- Name: cupom_desconto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cupom_desconto (
    id bigint NOT NULL,
    codigo_descricao character varying(255) NOT NULL,
    data_validade_cupom date NOT NULL,
    valor_porcent_desconto numeric(19,2),
    valor_real_desconto numeric(19,2),
    empresaid bigint NOT NULL
);


ALTER TABLE cupom_desconto OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 140294)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    estado character varying(255)
);


ALTER TABLE endereco OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 158770)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE flyway_schema_history OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 140300)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE forma_pagamento OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 195269)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 140303)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE imagem_produto OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 140309)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE item_venda_loja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtu_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE item_venda_loja OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 140312)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE marca_produto OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 140315)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    numero_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(19,2),
    valor_icms numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    valor_desconto_nota_compra numeric(19,2)
);


ALTER TABLE nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 140321)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    empresa_id bigint NOT NULL,
    venda_compra_loja_virt_id bigint,
    venda_compra_loja_virtualid bigint,
    chave character varying(255),
    vd_cp_loja_virt_id bigint
);


ALTER TABLE nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 140327)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE nota_item_produto OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 140330)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date,
    tipo_pessoa character varying(255),
    empresa_id bigint NOT NULL,
    empresaid bigint
);


ALTER TABLE pessoa_fisica OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 140336)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255),
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255),
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL,
    tipo_pessoa character varying(255),
    empresa_id bigint,
    empresaid bigint
);


ALTER TABLE pessoa_juridica OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 140342)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE produto (
    id bigint NOT NULL,
    qtd_estoque integer NOT NULL,
    qtde_alerta_estoque integer,
    alerta_qtde_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtde_clique integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(19,2) NOT NULL,
    empresa_id bigint NOT NULL,
    categoria_produto_id bigint NOT NULL,
    marca_produto_id bigint NOT NULL,
    alerta_quantidade_estoque boolean,
    quantidade_alerta_estoque integer,
    quantidade_clique integer,
    link_youtube_produto character varying(255),
    quantidade_clique_produto integer
);


ALTER TABLE produto OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 198905)
-- Name: seq_access_token_junoapi; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_access_token_junoapi
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_access_token_junoapi OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 140348)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_acesso OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 140350)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_avaliacao_produto OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 198992)
-- Name: seq_boleto_juno; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_boleto_juno
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_boleto_juno OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 140352)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 140354)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 140356)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_conta_receber OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 140358)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_cup_desc OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 186030)
-- Name: seq_cupom_desconto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_cupom_desconto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_cupom_desconto OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 140360)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_endereco OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 186032)
-- Name: seq_endereco_cobranca; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_endereco_cobranca
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_endereco_cobranca OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 140362)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_forma_pagamento OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 140364)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 140366)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 140368)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_marca_produto OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 140370)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 140372)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 140374)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 140376)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_pessoa OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 140378)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_produto OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 186036)
-- Name: seq_status_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_status_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_status_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 140380)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_status_rastreio OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 140382)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_usuario OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 140384)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 186034)
-- Name: seqitem_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seqitem_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seqitem_venda_loja OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 186038)
-- Name: seqvd_cp_loja_virtual; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seqvd_cp_loja_virtual
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seqvd_cp_loja_virtual OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 140386)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE status_rastreio (
    id bigint NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    url_rastreio character varying(255),
    status_rastreio character varying(255)
);


ALTER TABLE status_rastreio OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 160968)
-- Name: tabela_acesso_end_potin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tabela_acesso_end_potin (
    nome_end_point character varying,
    qtd_acesso_end_point integer
);


ALTER TABLE tabela_acesso_end_potin OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 195262)
-- Name: trail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE trail (
    id bigint NOT NULL,
    descricao character varying(255)
);


ALTER TABLE trail OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 140392)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    empresa_id bigint NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 140398)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE usuarios_acesso OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 140401)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(19,2),
    valor_fret numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cupom_desc_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    empresa_id bigint NOT NULL,
    excluido boolean,
    status_venda_loja_virtual character varying(255),
    codigo_etiqueta character varying(255),
    servico_transportadora character varying(255),
    url_imprime_etiqueta character varying(255),
    url_impressao_etiqueta character varying(255),
    url_rastreio character varying(255),
    cupom_desconto_id bigint
);


ALTER TABLE vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 186018)
-- Name: vd_cp_loja_virtual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE vd_cp_loja_virtual (
    id bigint NOT NULL,
    dias_entrega integer NOT NULL,
    dt_entrega date NOT NULL,
    dt_venda date NOT NULL,
    excluido boolean NOT NULL,
    valor_desconto numeric(19,2),
    valor_frete numeric(19,2) NOT NULL,
    valor_total numeric(19,2) NOT NULL,
    cupom_desc_id bigint,
    empresaid bigint NOT NULL,
    endereco_cobrancaid bigint NOT NULL,
    endereco_entregaid bigint NOT NULL,
    forma_pagamentoid bigint NOT NULL,
    nota_fiscal_vendaid bigint NOT NULL,
    pessoaid bigint NOT NULL,
    CONSTRAINT vd_cp_loja_virtual_dias_entrega_check CHECK (((dias_entrega >= 1) AND (dias_entrega <= '9223372036854775807'::bigint))),
    CONSTRAINT vd_cp_loja_virtual_valor_frete_check CHECK (((valor_frete >= (10)::numeric) AND (valor_frete <= ('9223372036854775807'::bigint)::numeric))),
    CONSTRAINT vd_cp_loja_virtual_valor_total_check CHECK (((valor_total >= (1)::numeric) AND (valor_total <= ('9223372036854775807'::bigint)::numeric)))
);


ALTER TABLE vd_cp_loja_virtual OWNER TO postgres;

--
-- TOC entry 2459 (class 0 OID 198895)
-- Dependencies: 232
-- Data for Name: access_token_junoapi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO access_token_junoapi (id, access_token, data_cadastro, expires_in, jti, scope, token_acesso, token_type, user_name) VALUES (12, 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiJhbGV4LmZlcm5hbmRvLmVnaWRpb0BnbWFpbC5jb20iLCJzY29wZSI6WyJhbGwiXSwiZXhwIjoxNjc3NjAzMjMxLCJqdGkiOiJubWsteGpwUU5ZcFQ3SFZjdWdiUm9wT2FBem8iLCJjbGllbnRfaWQiOiJ2aTdRWmVyVzA5QzhKRzFvIn0.JV50Ei4nkT8FriFKTx5iknXvWDwCllXa3b7YJWsTTnH-B7Rp2afT4Lp3_BBJAYg6hqZlEbTy197mPB4fmgarr10cf8DfLDOT7VSXb8gVikV4kbazpl78PUEt-ycI8KqhnUPC0NuhP_sxcoZcOVZafMEhyKYEubTtiiYtBLIdp_1IJZGM_RyyJ5wuIhSQfnADQwyqR5MyUHqt55dOBFo88ryb7k7QZHwznW50EMDQLndR0VE8XSU-pLHTZumBHbpQrR1AbvgbLtnN32tMwH_U-IPCX1w0G9Jt8UJUYspgmC892vyKfFFqk37c2M76GG5XmDqM-Lvp25RCheJfDAeITA', '2023-02-28 12:53:52.273', '3599', 'nmk-xjpQNYpT7HVcugbRopOaAzo', 'all', 'dmk3UVplclcwOUM4SkcxbzokQV8rJmtzSH0mKzI8M1ZNXTFNWnFjLEZfeGlmXy1EYw==', 'bearer', 'alex.fernando.egidio@gmail.com');


--
-- TOC entry 2408 (class 0 OID 140270)
-- Dependencies: 181
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO acesso (id, descricao, empresa_id) VALUES (22, 'GERENTE7 d', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (1, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (2, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (3, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (4, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (5, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (6, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (7, 'ROLE_ADMIN', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (20, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (21, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (23, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (24, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (25, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (26, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (27, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (28, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (29, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (30, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (31, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (32, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (33, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (34, 'GERENTE7', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (35, 'GERENTE7 444', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (36, 'GERENTE7 444', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (37, 'GEREs5d5s65ds7 444', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (38, 'GEREs5ddddd5s65ds7 444', 86);
INSERT INTO acesso (id, descricao, empresa_id) VALUES (500, 'ROLE_USER', 86);


--
-- TOC entry 2409 (class 0 OID 140273)
-- Dependencies: 182
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO avaliacao_produto (id, descricao, nota, pessoa_id, produto_id, empresa_id) VALUES (4, 'produtro muito bom de otima qualidde', 5, 100, 1, 8);
INSERT INTO avaliacao_produto (id, descricao, nota, pessoa_id, produto_id, empresa_id) VALUES (5, 'produtro muito bom de otima qualidde', 5, 100, 1, 8);
INSERT INTO avaliacao_produto (id, descricao, nota, pessoa_id, produto_id, empresa_id) VALUES (6, 'produtro muito bom de otima qualidde', 5, 100, 1, 8);
INSERT INTO avaliacao_produto (id, descricao, nota, pessoa_id, produto_id, empresa_id) VALUES (8, 'produtro muito bom de otima qualidde', 8, 100, 1, 8);
INSERT INTO avaliacao_produto (id, descricao, nota, pessoa_id, produto_id, empresa_id) VALUES (9, 'produtro muito bom de otima qualidde', 8, 100, 1, 8);


--
-- TOC entry 2461 (class 0 OID 198982)
-- Dependencies: 234
-- Data for Name: boleto_juno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (1, 'qrc_9C1C1D73BB10F3F951BA967B2CECAA91', '', 'https://pay.juno.com.br/checkout/BA640365DD68BCA96742097E10AF67A074BC2CBC8FF074AB', '508086555', '2022-12-22', 'chr_894285C4D0364D48B23E32A4E2B85A03', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1ElEQVR4Xu2XMa7jIBCGJ6Kgsy+AxDXouJJzgTi+gH0lOq6B5AvYHQXK7D95ku192i0C0mqLhywr4UMm/mf4Z0L8t0HfJ47xQ36IjH9JAt04jZlnxzvzEol0A4m8h/Qgc4+pz2rTFjMNhO45dV69fLkH+9Lm1kiieXgao3p6LGkmbJfAT6JbLD03krcGWk1sGdP8XZ3PCOITIedx/Ra5jwlGTrew7qz2wJv/mqolgQbNS7Ab2Z1TH9ZZYC2J1Of08GqJCUte3rYReTwRhFQzmVsuZ3wqSC5jpsFZDqYPCnN9Cwlqj3g8ddq+nPzwvYXg7HrktZ2pkMN30/kGwoZoXbJduODkbQ6W0ELW2WEOdztFxfnUoIZkiU/nCWbwdDjNFw0qSERklCjhkNSSRJfc+ZyEdXNmDPA8tQQiKme0K0i2s04929mlER7jrhp8TgLeHocDdwQHfsCbbiBcHoh2lH2wZL5oUEVgTuWheSMFg7+HSx5UkJzGCK9CzBUcdNYXRStIRNmRkniLyJ3UaZGhgZgx8ssxPB6VFvscZ66GiAbqSWUg0zkaA8paA8moYOWOHby8/UznCa4idod3SunGl0TvY9dAYE4W1j4FO2WxmSN3agjiA1EzoaBB3UGfuVNFcOBgBlIxdllyalBFIIDpo8XHp6fuokENYfWi8nDrEsoAQ3V8nrkqMsUVTj+iSQxm8ObQoIbk0iEHCfUHcqKH4kWW15IgtRqdHTnEOZFPhwY1JMKMcaG5M6iNCyOPGkjmKUrrOuYyRkPaHp1dFYFFITjvXiDwJGW8gaALcwr3J3zUwaFpaCECC3kFH91gVFevqiDoYXGh8UQvhmKrxQjrCco+F/zS6d2FiY/qFoKqKPsQoY7RQNLSNpGITES5wFb8ZQ9NBKWbzQNvD1Gd1I0Ggv8lsFLYPCwQrbo9vaqCSHyQNYR2GN1TJyFqIH8eP+SHyPifyS8GpSvZv/NZ0AAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508086555:d4bc2d34e38d55621f9765cb244de3f568a769c65cc04bcac890843049e5af29', 'https://pay.juno.com.br/charge/boleto.pdf?token=403032056:m:2600246d76b69495e7f621c93becca85d77e2f02bcf2543b07245dfdabfab296', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvOUMxQzFENzNCQjEwRjNGOTUxQkE5NjdCMkNFQ0FBOTE1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NTQ1RA==', false, 1, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (3, 'qrc_10A5AB76A519E412A9B43C65D043F415', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093192', '2023-01-22', 'chr_D062D569925082F580F46E465BBA72D4', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1klEQVR4Xu2XQaqsPBCFSzLITDcQyDYyy5bsDWi7Ad1SZtlGwA3oLAOx3okP9N6f/w1uBR5v0KFp7HzQxlNVp0riPy3678a9PuRDyvqbJFCT7dvhgnfmJRLpChJ5j/b0aompy2rTFjsVhF6Zl7ye/ngFe2rTVJJAg6MxqrdPra8m2S7RvomaeHRcSaBBGshObBnb/F2dnxLEJ5rX8/kWuR8TrGwgwM5qD7z531tSEqjXx+DtRnbn1IV1LlBMjlarKa/InV7z6W0dMU1YJ1Yc1UymyccdHwnJptU479E60wWFva6GsN0cT5leqBVXDr5XEUL2QdGZDkIds2l9BcnphdplpPbReoV7LvfzCEgwA62nU7OzU1ScHw1EpNTcVcdwLCjxaCAhkQZScL7TIanT4NWdOxLCV2S0wmcJRHQ80RaQXNKny7hPGgPj4FUkHL2mwRPScHPwA950BWE1a9NFO7v0Cjx/1UBAQiKdBg0/gAwGDv2cWkJoDAlVu5ci5lk/iooI2g5qF26K3EmtLjLISUxjLM4Hj0enxX3umpMR5AvsaiPToqfhIZ77SMjg7OZhxuXpZ3oqWELy0TvYZ7oOm+gqOzmBOWmMAHYKtjh9fjxeQnIRYGHCN0eDHH/qR0AYacibg8GoPZoxPxpICHKnRJtG5ren9osGEpIVCqXB36OUHboQPxpICPW+NEZcLsH03jzqCAivZ8lB9B/IyW/kTtmUkwlNw2O4Q5wT+fTkjoBktfC6BIsjozcujHm2hvB0Fe6YjzEa0vae7EQE/XDlUBKnCRgHvkXuxyTAVEAww6rTHQMhXBWkQEO+zIkbjOqLV0kIHBQ27zCCYRBA8zG3V0kI3B1DCmJ+TWHFR3UNQZHhtQluij5GPTSoJKF4PMaKqfzEJFVJ0ojhDk8PUV3pGxWEd4zYeP1i2Ayc3t5eJSGlK8JBr5kCb2AlRBXk/9eHfEhZ/zL5BYilN+L1L6rSAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093192:69bb7c14ae2832946db57c97a5c8db9bcb08b9626756e2e22189788d8edb47c4', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMkE5QjQzQzY1RDA0M0Y0MTU1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NDNCQw==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (4, 'qrc_10A5AB76A519E412C28518D797544295', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093193', '2023-02-22', 'chr_D062D569925082F50C26E9E50E838DDE', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACzUlEQVR4Xu2XPc6cMBCGB1G4gwtY8jXc+UpwAVgusFzJna9hiQtA58Ji8g6fxJIoKWJLUYrPWqFdPysYz887A/GfFv26ca9v8k1k/UviqWFNFl/4YF4DkaoggY9gmNs1xD61uzLYqSA0MnXUni6P3pxKN5Uk6Mnh9u3Lxc5VE5jstxdRE3LPlYQPz2/SDRvm61pDEJ+gx8/np8j9NcFK2xLMwS0euLuvrVLiacCNg9kJMPZ+ewssJrn3RHZD7uAvpzNVhPVgdeNbRFv8mvIdnxLi+VR8pNxZ3YMz9TUkbTuyLxnUymnF8KOGeF4Tjg6Ts9Qx685VEGaEemWzhty5dreQhAoCY8m8bfu2Zgktp48Pigi/nJ5Red68LKr544MiojvCHp8WSR0nOMNVEN52osm2p4IqEFG+rS4hoUWQe8Zz4uwZhlcRzgNB+QhpuFvoAe+qgoQ8ORQcQhRHiNbTOwUk4dzbW0EP4AY9+keVFJBAc5CYQ6twfauHRwuIz6M4FWqKmMdOiRvKSUJY0GzNwlA+ec5dcyVERF2UbyfdWcK/5BDFJMVJbbuCGMvp3/Sp4CLCO8UmxcvYSFfZlRNG598g7Ys3S9rW9ND4ApKQNWjX1PgN1TyoR1YVEI6zRFuK7wh6Tg9NLCINIyY0M0SLuqcPCgiamBKtWn0eLLoQf6qxgCQ9uDyjRDAkenzXH+8UkKB7xu0N2ixa2Qu5wxXEZ3KiVROgi+TioxoLCPa21RuYjN6Itna6CpLEUqjUnPIcNClzT3ZFpD0JWbMhcRrPS3rEp4B4c0hGmxd01OaJaKghLCGCukBHdwjVQ6tKiMyw8RrBMAig+ehbq0oI1D3FkbflmsJER1UNQZGJVhGhj9FA10hbRdAepewW+Sk9vIp4WJ0nnB5OtdI3KgjeSzAbasAxQOnNrVUlxH8p6DVT4A1MQlRBfr++yTeR9T+TH3pHMnhSAfefAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093193:8b3894ab4aaa89165e9ce836875b7bac9f5325a8735cadf35a87a80a87941f6e', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMkMyODUxOEQ3OTc1NDQyOTU1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QkE3Rg==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (5, 'qrc_10A5AB76A519E412B4DCB990B36D9787', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093194', '2023-03-22', 'chr_D062D569925082F5126C688420FD858C', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0UlEQVR4Xu2XMc7cIBCFx6Kg814AiWvQcSX7Avb6AvaV6LgGki9gdxTIk4ej2P6jpPhBilIs2mJ3voLhMfOYJf7bot8D1/qQD8nrXxJHTdRvgy+8My+eSFYQz7sPA4nFh1cUm9SIVBDqWcxWHDb1Th9SNZUEAUujF28bWltNWCyO30SNTy+uJNCAoMHEmhHmr+p8l+B+vOrvz5eb+zbBijwhxmJ3vNmfoVLiqJNqsHojvXN4uXXOsJR4PqyY4ora6SS+6yrCqTP8toK9mEk1MV33U0KQJqnOqNaolxOIvWoI64lDE6n3+jA58b2GOM0xQdGZEqGPWbW2gkS9SZSzXnxqrdgMLKGCMB8SATEbPXnB8aFBCRETfOXs47eBEg91CkjE6cNg+DAo6jBYcdVOEUFzpJEFcl8cEaUr6xLiVSvFjIo2YYTHmFuDEhL15GiwhDLcDPyAN1lBXD734vVsQu94fmhQQnyinDX8ADKo3j3OU0Ly0bObMpqYZ/lQtIDE0GcIN0XthFZmGcoJp9Gtb4s+hvPlfa6eKyIKBdPEdSMYDGHD8dqngOQWSZ2EGefTz3R3cAmJqD6eYjiTDXS2XTnhFU0Ma5+czk4fHx5fQKLqJLSkxq3omE4+uqSA+F+17MXu1Rgf6hQQFm9CDdLIeIWofWpQQJAsTAVm7PCspdbw3Y0FJMLw0iDxjgGqzqpbnQLCqD6ejc4vpMQMxcsZLCRIFvtYGgBtIBtuDQpIpOxVTiPlrATrw9YQXEtOeYxp9Iqk5ludAiLOBy0XTuPQLo/7KSBO7349jEYFHSYNRF0NwcIOGBIZg39qn15VQLKDrpPDCIZBAI+PuryqhGR3R6brdE5h2UdlDUGTYRYLROhj6qBBLVGDzX/CpvwzvLiOuNBHNeD0ENXkd6OCYFxCl2D2T72H0+uHi32fnPdzmHOmwD+wfEUV5M/rQz4kr/+Z/AA7hiuvtjLXugAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093194:447e224eec33f16abcd53f9af9e7887d26ec8598314aef481ebbd2e869961897', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMkI0RENCOTkwQjM2RDk3ODc1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0OTQxQg==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (6, 'qrc_10A5AB76A519E4125B3CA3596995623B', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093195', '2023-04-22', 'chr_D062D569925082F57C068875B764FFDD', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1ElEQVR4Xu2XMY6kMBBFCzkggwtY8jWc+Upwgaa5AFzJma9hiQtA5sCi9lePBD2r3WBsabVBWxN0+43apqr+r4L4b4t+37jWh3yIrH9JPDVJPS0+8MG8BqK2ggQ+QnyQWkPsk9pbg50KQiPnnrfT5dGbs9VNJfH6YfHz6uli56pJyj22iZqAAysJH54GMjMbxjZ/i86PCfIT9Hj/fcvcjwlWij32WB2ed/e1VUrkynEKZidzcOz9tggsJYkerSa7oXaGlk9nqoiP2J5ZIdsL6SblKz8lJPDSopxzZ3XvFfb6KoLfVnOiMZjTysWPGsK80OvRKRN0zLpzFSTgobeDzRpy59RuYQkVhGlK1Fm1WDMHhXRdMSghCbVDk+jYPC0icceghLBa0wbnOy2KOj6cumqnhAR+ykd1tmr1RJTf6qCAqNdRkurJMy5eRbyo7XSEMtwt/ID3toIEKZw1mMXG0fPyLQY/J15Ta5YWpyEMevRvty4iSDW+HSJi6O+OaBmBfQI2AbUTu1bCUE4YaYFXMTwenRbn3GosIEkTqdlvO+nO0uRR4zVkY1iygxnL08Mb1hoSMhHPKb4uC08V2VUQdAmF8pm9mdOGAr+rqoSgaqhP1HhcXw/tm34KCPoPxcEaiO9A2tNbdAoII89R0sIwBljgHYMSIuk1T8jO58GiC/GtuQLCmHT0BIlgSPR6cPqKQQnxeeJtseg/CCc/UTvy76UEVyb9cIThbnGRXLxrp4Qg1fBjxECUtzJcsIIkOLGMrlPKUxDf4qsOSgj64Xag2WIc8JDLnZ8S4s2RRCVP+KjND6KhhmBhEMBR/Jp63l2sgGCGhXY9JgsMAmg++vKqEgJ3T3lwGO5Eu+KjbQ2ByGKTItx0cTJfDLUkPxBRsXkW6+I64uPEGnMxlLdb6RsVBO8lmBAz3sPGAKc3t8cXEMmPdB6ZKfAGJimqIH9eH/Ihsv5n8gsO5x0S7ziZ4wAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093195:a3018bc770d26f81845c0d09ea1052b423bff50786ac88d0ed363b72e453ac2b', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMjVCM0NBMzU5Njk5NTYyM0I1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0OEZCQQ==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (7, 'qrc_10A5AB76A519E4121F65A186FC6F6A1B', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093197', '2023-05-22', 'chr_D062D569925082F58967EF6532CD998E', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0ElEQVR4Xu2XPY6kMBBGCzkggwtY8jWc+UpwAaAvAFdy5msgcQHIHFjUfsVIA7PaDdqWVhu01cG036hx188rN/HfFv2+8b0+5ENk/UviqYppjPiDD+YlENUFJPDh16FWS1jbqPbaYKeAUB/VErfTpd6bs9ZVIfF8Wny8mtzauGISqcU2URVSy4UEMVAnmRcbxjb/jM67BPkJur9fPzL3NsGKqQrmYHV43t3XVi7x1NE6OLMT4Nr6bRaYS+I6snnFDbXT1Xw6U0RCQu1MpJDtmXQl36CAeLN4nDc1VrdeYa8tIlRJkqkP5rRy8KOEBD1yGizPlMjivW5cAYkruW1hs4TUOLVbKKGItCF1Vs3WvIJi6ZgC4rfD4x362EwWkXhEJ4MENJzE4LQoapSkumsng3jdsx7cdkJ+nojSfeoMEvVASI6kevSMgxcRTsjP6QhluFv4gPe6gEQ9eqTIzHaFUOdHDLJIolrNNXygIPheclVAGM+RDMNVMOhc3xHNIjIxYHrIb7JrU0sY8klYxyDdBsdj0uI5dzfmEJE6zLeTbiyNnsbv52SQK4S7g4zl2890d3AOCTyJPtfrsCtdbZdPUNe1gtpf/jJ9fNg/g6CcUdRMld9gwa5+2CWDMEyA/jAQwwGnxjsGWeRyJ9LCPDlqHjHIIZFPQgdjCsGmmEJ8RyeDYMzK0MAcw9N05/QdgwyCy47DxxuMWYyyCbUj/55LgoY7B0cDoMMsWu+qyiHo2m2R6a3ReRhrpysgEb2LoCLPacQza/N9s8sicjdZwobCqTxa+ZG5DOLNbiXbuPKcNg1EXQkRmKq4waM7RPVwVQ6ROyx6F1cwXAQwfPTDVe8T2D2mnrfXdQsTj9YlBI7Hz6aVCHMM91nqSokeEFHRvJRSy2Uk0Cj+k86DZo4igsGInCAMqQ8wvXk4/n0i+cGsuO4U+AUmKSogf14f8iGy/mfyCzLnP1l5k3H2AAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093197:204d8592d2881433285bd8bedf5c2a49d54efa05386c98da8af03f45cd2ff3ab', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMjFGNjVBMTg2RkM2RjZBMUI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MENGOQ==', false, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (8, 'qrc_484445AE26AF80CF3DC796CE3768D8D6', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160389', '2022-12-22', 'chr_E6810901DA819F181D640E56A08D70AC', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACzUlEQVR4Xu2Xwc3jIBCFx+Lgm90AEm1woyW7gThuwG6JG20guQH7xgFl9o1/KU5Wu4eAtNpDkBXJfFGANzNvCPHfBv0+8Rxf8iUy/iXx1CRzt7x6PpjXQNRWkMBH2DiYg2Of1N4azFQQGhMvVt9cHr15tLqpJCHeHE1B3V3sXDVh3Xu+EzUh91xJoIFaWjOzYUzzuzqfEsQn6PF63iL3MZGRm6AOVofn3f3MlBJPA23n5xlwvy0CSwkjwpkcjh6Hlh/O1JE4kJqT7qEr6SblZ3xKSDCrRzIqJGPvFeb6GsI0tCg75KN5WNn4UUNQImRw9NVnsnjXnash2+x5ZbO0uXNqhzE81ykg3ixEg90Wa+agOF0aFJHtTtvDmsPDsaDEpUERkZg0rB4WSQ1jUFeOFpAUmxAnKWKFsBPl565LCMeJpTIWGyd4jH3JnQKC33YwURo9ggM/4L2tIdgvSsRgndHz8qZOAcG51U5mJwWDH/3brj8mCXJu4qas8Il8rCIcxwBFkYbIndi1IkM5kXXOWmE4n6xz1VwBYU2tulMeSHeWJk/yxWIS8q1FQ8PG5fQLXRVcQjwaBXw0ksNLpLPsygmjOMTaV2/mtK3pxeMLCAyPdM84PWKu4alXVpUQlFq8WeneR9BTetGggCRNFCUszHdH3YsGJQQ1ZzEnHj/Y3Fl+rcaPCSsxY9ZYZ/V6cPqqkhISxQwID+TEHQrdo4KIBhleRRZxRgbFN3U+JUFuJZI4XqM3oq09XAVJPMM7z9vEFFB/182uiCh5IGrQjec5XfEpIR5d8afzoKHlG7puDRGIjgGjwsU/d69eVUDkDgs5N2QQUnJv9dOrSoi4e4RXzectTHy0rSHoirGBVxH6GG6yuJrVkSAa4E/YLK+x50qCN43OM0FUK32jgvDh883mifNPW3t6VQmR+Mi/Q9gMbk+dhKiC/Hl8yZfI+J/JLy5gKWPw0gIyAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160389:cdbdf916f4b0794ede3d7f67f0456490ef80779eb5982411fdd74e95179a309e', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNDg0NDQ1QUUyNkFGODBDRjNEQzc5NkNFMzc2OEQ4RDY1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NDE1Qg==', false, 1, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (9, 'qrc_484445AE26AF80CF7B7E667B8424779E', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160390', '2023-01-22', 'chr_00C0EE01336F34FB667B0FDCC31F7F9F', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0klEQVR4Xu2XQcrjMAyFVbzwLrmAwdfwzldqLtAkF0iupJ2vYcgFml0WppqnDDSdYWbx2zDM4jelNPmgtvWkJ5vkb4N+f/Ee3+Sb6PiXhOkmfgqysuwiayKyDSTJzu4R/S65P8zTerxpIDTItlB5xDKwf1l3ayRpewUak5li7mIzEeqTn4huqfTSSGRP24LFihc5v1sI9EluuD6/KPdlgnEgANDH7CzP+PNVLWG6W6/fdArO26KwlogstE0RW893K6/om8jhbodM1vXJLITf5a1PDWFd6TNuS3A9G1HlG0iiGxeIvCf/CrrwvYn4Vd9tKxcKeHZdbCCM/y6j+MWWLponjOHaz9eJlAf5Z0AM/JwM8ugdgxqSzC70CH5nOBaq+SMGFYT9gtoV8wpI6vyI5srRGuKgiWgRm5WJqFx5UEESdRGm4peQRxYsvImITGRekQaGOPADedoGkqg/MpwP8wwsy0cMasgBc0K1+Sdms27ga9U1hGlkN0JkMXBQ5GMTUe/UWplh8yF39nysJpLHtE1hm1HEovO8a66KIF8gUbmT69DTsIn3PBWEt5dFocCMdfcLfdR2DdGt345MEQ+ZzrKrJwkie1j7yn4+tvW4PL6GiCPYHhoab9Dqbj+qpIKg8zMgTMXsyY3HFYMawmfDgSwovkjdZ3QqSCqwvUljUO6hdEGu6NSQPKT8sA7zrPCt6K4YVBBsmksPWUgtcELuSAMRg6b9iEQBOiOD8lVzFQRLpk0T51RpFeRRAzlkhuFZPU2MyZH175NdFTEouzlpGt5Y5uPSp4aw3wFxPISPBnRdurcQhWdeCw7+pfv0qgqiZ1j4ARZuFjRbqw5dT+DuR8ZlYj5PYeqjtoWgK55eRehjOMmStvEWgrKLegmb9TH30kjycLhOyw6tW/tGA4FLwQZwuCu4PC0who+IfpmoPiBecKbADUwlaiB/Ht/km+j4n8kPGHos4d/fIUYAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160390:a7d6b8719c6219ca919fe457a6ae36ad678339ee5482cfce8d49424fb1eca394', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNDg0NDQ1QUUyNkFGODBDRjdCN0U2NjdCODQyNDc3OUU1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QjNCOA==', false, 2, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (10, 'qrc_484445AE26AF80CF874A5DBD4A33AF04', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160391', '2023-02-22', 'chr_00C0EE01336F34FB3F7233D9D203EBF4', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACz0lEQVR4Xu2XS66jMBBFC3ngGWzAkrfBjC2FDfDZAGzJM2/DEhuAmQcW1bfyJOC1ugfPllo9iBVFik8Um/rcWyH+26LfN671IR8i618SRxVbjrw6PphXT6QLiOfDh6G1B4cmql1b7BQQ6qNaoxm61Dt7alMVEm+Glkavpi7UXTHhbfV2Iqp8ariQ8OFo0O+4Ypu/RefHBPnxpr9f3zL3YyIrNR75UYfjvfvaySWOXnqTd3on3G2LwGxias1Th0cPL81nZwvJSyPPpvFqIVPFdOUnh/g0dPaIamlN4xT2miLCs1Mzox7t2crFjxKCH0ZztOjgRC0+mrorIdtONLJddKo7teMr1zkZxIcR1dduS2tnrzg+YpBBYnrRW12cnVpE4o5BFpHqm1khDHsXhk5dtZNDpD8gUWrRanVElO7nySAuNIxY2qUNo2NcvIxsqJ2zo94hOdAD3nUJsUgvlA/n9I6XRwyyiCHkh+xOCgLfu8etM4hPo5euhVahY1CPRSTCdqBPKEPUTqi1hCGfeDgPnBblg7TLOVfP5RAOpNElqG5Tw9McvlhAoFLQKsbF5ekXujs4h7AYzhwDde8z322XTxzcFa1mV2fnuK3xofE5xEBacMLoNvbQ+29V9WPi1eoxStjDq8ObMT6UL4NE/DaUGFIKT6P6EYMswifZ92SXXm2qW75VLIdgKkEMDM5Z4ZNikiUkjLAgpIVwfZ5QO1xA/DaL2aK0kWdUULh7LoOIum9SOJJ2HGLProBEnjR/TROjN6TtNdllEfghpjApw8qhXR75ySAO4wm24Ty4fhqIXiVEoDw9dHSHUD21KoPIDJsqKB9mMZitNpdW5RCoe8RNoaPSu6KjuoSgyUIFrSJIICZZjLSFxECrppZn+QgbLyMujBFzMdoO1i2+UUDwvwTnYDv1XmztVrEMIvnZztYyZgr8A5MUFZA/rw/5EFn/M/kFwMczCEzlL8YAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160391:f6cb841c4ba541b558704cd5b719ece0d52ae7d043374120a955763c07be2bdc', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNDg0NDQ1QUUyNkFGODBDRjg3NEE1REJENEEzM0FGMDQ1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MzVBMA==', false, 3, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (11, 'qrc_484445AE26AF80CFB6F5AA3E277633DD', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160392', '2023-03-22', 'chr_00C0EE01336F34FB19BC5D1066A45F75', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC00lEQVR4Xu2XQY7jIBBFy2LBzr4AEtdgx5XsC4T4AvaV2HENJF/A3rGwUvMrI8WZ0cwiII1mEdRqdXhRG6p+/SoT/23R7xuv9SVfIutfkkhd2e6O18gH85qIdANJfKR8I3twHoratcVOA6Gp2MWfN39O0T606RpJwjb+vbr73PtmgqvH7U7UpXPgRsJH3BZNHVvGNv8SnY8J8pPMdP38krmPiSycFPlRR+Td/9ypJZFGUs/fz4TjBgJrSaEQT5L85FHzw9smwufot5nNkNRCpivnKz81JNFQtqOoxZkhKuwNbWR0uSvQo304OfjRRHhxG66+IhIOn03vW4idoWu2iz57r3YYw+s5FSTi0pnctjg7J4V0vWJQQwoCYG7OHtHeHSJxxaCGRAopd6weDqLON6/eNPo5gXZcDhCOVmskovN16hqScHsIB1nKITIO3kbyxHA+miKSAz/gXTeQmEOxa7J4zhR5eY9OFSGohuxOCgY/SfKbSIhyWHiVaFxfEa0hqLZ4hggZQju51/KtepJk++7VzHA+ec5VczUEpn7CokYyvYMLQpgNpIgMdw8zltsvdFVwDWHp/HPJJIdFKUvZ1RNp2tK3VwS1bKtMBE2EyOLPEDdOZtRvVVJDNkapeZiKOpIJ5c0TK0iUhvPwFBic+rcY1BCm3uP2GFJgM2cPY/ANBEOizoFNkKnHjN5cVVJBIso3986izaKV3aGd58MrCXqjN/AqAvRQUL60U0EK5KxEONGgN6KtPXwL4Rn5eU4TIRnS9jXZVRH0QzUnkWEXGYm68lNBot01OgY6DxraeSOEpIEIRKplTtxhVG9eVUNkhoVXbRgB0NN2bV5eVUPE3TGwY7iT2hUf1S0EHo/XpowYLB6TLI2tRLwKL2GzfMwDNxIMngadJyCoTvpGA4FL4Tln4HPCfAFDfYvoxwQBiPAAy5gp8AYmKWogf15f8iWy/mfyA6zAM/5EWmutAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160392:a574a9a9f2ba48b43555a9937be983311fc7470d45af7fe948d7dfd236c3945a', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNDg0NDQ1QUUyNkFGODBDRkI2RjVBQTNFMjc3NjMzREQ1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0M0YxQw==', false, 4, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (12, 'qrc_3C70EF5A2706BC42714BAB0D8AE90B73', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160394', '2023-04-22', 'chr_00C0EE01336F34FB39338E7389F73E94', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC50lEQVR4Xu2XQY6jMBBFC3nhXXIBS74GO18pXCDABeBK3vkalnwB2HlhUfOrW4Hu0cyibWk0i1gRUngRdqp+/SqI/7bo9xvnepM3kfUviacuWGa19Lwzr4FIN5DAey5D5smZIZiHtrjTQGjwccxponToctOmayRBHQ6PV5OLN9dO0qTpQQa7rdxIEMh4Z1zpIUH9Fp0fE8mPxPL1+Z65nxIshBOBZLtyHD/vVBOvdo+IIj/07NXRlzMGNSTg8eXZJw7xoRmJWlwDyabLvDKUyJtTi7NbCwllzGrSdmdc402XgVsI/r2Ec9P26OXg+xmDGoLaVRDO6OmpI+RzqaqCoHZ1fFLac5pz7JCu16lrCPSSkRPsZuegONP9tU8Nyag2uEuaeviBPciQayCeFylftWlsqNbA21k/NcRQ/yFArVZPROU8dQ0J+NOly+XukXMYQzpep64h8APoOkCAZhR1q7NKakiw8IM12KWPA+LRSDiStuwLkZ3gB3CFFuJpDPimZjZizHL8BsJxCBEQHXLqUcGw0gaSzejNnc3AyHbsYA8tBNoRXeOKg6eFqJPNqwkf2jxcWpxocCFkvoHktGlzc2oPavYw1ARDrSdBFH0PCd9ujmAzZ83VkGwePYyZOo+mgQnli7tUECkyKZGb4zWrzZlLoxUko3yhndL5eM8JAr/Lz2uJV4vMJrz6guPfer5qu4IEEQ4aBbwKDQ2Wf/lOBcn2Q9oJbRaqHLI6u1kVwSxWng6jE/pGJBevmqsgMp4U0hgrInoj9V/8uoKgN/aoYNRu2giTXZq5hahDywC1B9N5nvOVnxriMZtIb9zgozrtMjY2EBab38RakCWL5GNIqSd4MOYmSrOMKmiz5nK+CiLvJRAgfBTC+fBR2bqaEPx4I2kXHUYeD49pIwEegHbBkucg7wFtxMI7Map3Hq27XO9zNUTGzD3gdkKbHUM6J7saImJJR29RLhvewCRFDeTP603eRNb/TH4BoLJmVidgGEwAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160394:c40d26204e4190575a6a6152023a7fb407806254e96aa6da6cfd4d98a432afeb', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvM0M3MEVGNUEyNzA2QkM0MjcxNEJBQjBEOEFFOTBCNzM1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QUE2MA==', false, 5, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (13, 'qrc_3C70EF5A2706BC422B166A5E42850D3E', '', 'https://pay.juno.com.br/checkout/029CC69B08D24D14AD0D75AEF1AA2311C21ACBB76906B7CA', '508160396', '2023-05-22', 'chr_00C0EE01336F34FB370A41C60E70F676', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC20lEQVR4Xu2XvY3kMAyFaShQ5mlAgNtwppbsBvzTgN2SMrUhQA3YmQLBvMfFro1b3AUrAYcLRphgrG+x0vCRjzTx3xZ937jXm7yJrH9JHDXekFVbzyfz7ol0BfHYCGPixZrRm0F32KkgNHp16bhQvHRutWkqiTNTT7NXiw2trSe8UB7IzCnuXEkQA7VzPJkGCerv0fkp+dBnfD7flPshkWUmTQ13O4f5c6eUOHV6tVnoQ1Ovrj7fMSgiHadu6SP7MGi+bLfZCpLUonEOMpEPZLftjhri1Y4q0aLSokOr88gVhBEDXiG17q5eLn5+xaCEePzoMLKZHU06IH2erCoh6hBx4pnimkIDueTwUpJoTnkSd+lWr/D4+jqniJgxySEQ/EIYCL5VQVhdpA58dJgTtOLjrpICgtyxeeZu02p3RJSfWxcQl6c+UG9ezjQcXhwvW0FSIDIvn0VwRnZLjleQKPdFBvUBFrjVkowSWV0mQh0jujTVEPiTgw2olY0Ys1y/guCrhxPDTXEOKhhWWkFSnj0c1Ixwehcaj8cKIqYeD6Qz4eJxI9hzBUkQOQ82blZycCMMAhVEfr2IDKdfHaOtwVDLSZKn3Uc8tZYmik/NFRBG7sh249A0MKE87lJCXIfeOCbTWt4TXNDcmVhCEpJaoY4bF14p4stLDi8lLsDa4S67y0Of257vmishLOPhidrVcHe4Mt/uUkLgBPpDFou7IxjS3MoJeiOjY2B0krZG6GxVhC+C4OKmCAb1jyuXEJmF88yoXVQe4hFX+etigp+u2MfTm8bxmh59SojrsDcgovBRHU8ZGyuIQKgtPjojx33GkFJO8I8ZLShiBMCryaHN7XwlBPN1wtwEH0XifPioHF1MCNkHH0W7aDDyOHhMHfHwALQLFp19uCu4lHRHD//DICYO/bzPlRAp3xOdx0W02RlJdJ9TQKAP/Ml3yMcDb2AiUQX583qTN5H1P5Nf3jhvsBQVd8AAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508160396:296d0a93f842178aa131ea2d1a4242a4e5bb3041a60d9f8b7149cf950d91795a', 'https://pay.juno.com.br/charge/boleto.pdf?token=403098788:m:7a2802acec3862eb0e9519cefe69de12329bf059bf1ecdd8dd6c06cba4f780cf', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvM0M3MEVGNUEyNzA2QkM0MjJCMTY2QTVFNDI4NTBEM0U1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NDBEMg==', false, 6, 300.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (14, 'qrc_37DE466E6CFF7CD7C8FDF372349A22D3', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161085', '2022-12-22', 'chr_0EFD6B642B47B8B5736C76EE6F522222', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC10lEQVR4Xu2XT86jMAzFjbLIDi4QKddglyvBBUq5AFwpu1wjEheAXRYRnufOqPCNZhZNpNEsvqiq2vwQf/zsZ0P8t0W/b7zXN/kmsv4l8dQkfjp19nwwr4FIV5DAR4iTp1bHLqldW+xUEBqZ2l6dLo/ento0lSSYR4/Tq6eLrasmya7YJmpC7riS8OG3RVPDlrHNX6LzMYE+wYzX54tyHxNZNHlIrQ7Pu/u1U0g8DQSCb3tw7PAEAktJig8HZfDocdB8OltJRk9EpgtqIdOk/NanhDDOve1SJabzCntdFTGN32ZG+tizlxs/akhQa0Jeb0ufqZcDW1dBfGwQBknt3Dq197CECpKixNKppbdzUJyuGJSQsM0B0B7ePntU8y0GBQTXSRkxgPPtTvLoljufE96emiYYjFarJFG+1C4gHibKKyMG8gM3XkU4IpFPR6OHOPAD3nUF8RZXQETxPXoWoVwFSTCn+CC7k4LBo/6uPCghefK5e3kVHHTRV0RLiJd8wb3PAbkTWy1hKCfBTB5epVDE6LS4zlWNBSRl0mr2cSDT9mKo0/U8nxPeOJnBQRl5+oWuCi4hQe3OzimSw59Ir7KrIGJOsPYVQU3bmi6PLyHQB4UiDW3DUYO+1U8BSbElGjA6BXVAq3R3vs9J2CA1B4ufT4fB5xaDApIQAARyW30e+tz2fNVcCUGdSbVNGBI9ZDdXDEpIxFi3JmmzaGVP5A5XEA8fzQ+HoEJnZFC8qrGE0MuPkTsGvXFle7oKknj2fOo8wWaCIW3fk10RwTSx/UycxvOcbvoUEG93hxEAnQeH5Aeysobwy67EqDD45/bmVSVEZtjt2aN7o6Gh+Zi3V5UQtH0kI2OAktoVH9U1BEWG16aIGCxO5tmhknjzcGgXPMvf2HEdCdRhuJOyQ+uWvlFB8F6C6+SG8xgwqtvLqwqI6IOssYyZAm9gIlEF+fP6Jt9E1v9MfgDpzSUZ7HBf6wAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161085:fba0f49c04f3ad57347db9bbc4a4bb673cccb3a7dcc071e836fb7e8edc9fbb20', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NEN0M4RkRGMzcyMzQ5QTIyRDM1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0Q0VEMA==', false, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (15, 'qrc_37DE466E6CFF7CD79EAF8793691C17EB', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161086', '2023-01-22', 'chr_0EFD6B642B47B8B5D6CA6EE01406BCB2', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC3UlEQVR4Xu2XMY7jMAxFaahQ51xAgK6hzleKLxDbF7CvpE7XEKAL2J0KwdzPGcSZWewWIwGLLSJMkdELIpmf/KSJ/7bo941rvcmbyPqXxFPn0zyo0/HBvAUi3UACNuzhFbMZg7lri50GQmNQp+aZ0qlLr03XSvh0NAU1D7EfmonHIeVOZspp40bCRy4dx5HpLkH9Fp0fE+gTJJbPv2/K/Zhg5TRr6thuHKfPnWri1eF5dYWIHg4ZVK4Y1JBseo1MxKPHu+ZzsOvQQuKYS0/Y431Q62D3JoJzEFQ7azXr2OsycgMRkRFOugV7Orn48YxBDQm8MX7bTJ4eOiJ9vmTVz4nHD1NP6chpybGDXB+HV5IQHzqtiKWzS1Cccf0G4u3iDVEhBz+wJxkaGgik1uXmoU+cstoC788qqSGosw/be2i1eSR3eT1PBYEspBYfJ2/gCjdO5/PWVYQXWFQoNwjOPEtqN5CMa+LR7eoiLFCEaiEhEsUxwA/sDD+AK7SQXCZvd6cWNmLM4Us1VhB8DGUKSEOcgwqGlTYQeGdAo6CRoXbs5FsNJBvSandIbVw8rQRvaCBcHgMOgTKSgythEGghatdwYnUE5COcBg7dQLJlycR0MPUDcjy9qrGCMOYdlrj6xDKhvNylhgTUblq4wFS2rPbBvHK0guA/ir1LKOJbTuxRfA2EyyRRROKUuyu946vmakgWBz0yrxruDleWJllPfFoduLRZ9mbM6upmVQT+hCiiQyKDIg3xqrkakmF4hXR5ODSiSO7lylWEZ40JEbWbdsJkB+VbCKIIqfHophOH/qJPBRHbw61xCBpaOmRsbCAC4QG4LMYKCyPEkFJPvJgTBn+MAJB9RzyuG1QQeS9JmP0x8owSV6R5C6ExIwDSLjoJLTymjXhYKdoFi84hXhVcS2Qbo3rnP7OyhTCmdZaZIqHNTmKoDUTeNU3vLF4CdryBiUQN5M/rTd5E1v9MfgGa5HRsesiqQwAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161086:a91d7d7bed93e7c17f4898e462c91b388244e4acdefdf382ad06dc24e7efe6f1', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NENzlFQUY4NzkzNjkxQzE3RUI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NjhCMA==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (16, 'qrc_37DE466E6CFF7CD7FE8116E7B240B287', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161087', '2023-02-22', 'chr_0EFD6B642B47B8B50B63EC490CAAC975', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1ElEQVR4Xu2XMQ7jIBBFJ6Kgsy+AxDXouJJzATu+gHMlOq6B5AvYHQXy7J9oFXtXu0VAWm0RlCLmFeA/M3/GxH9b9PvGe33Jl8j6lyTQjYm8OhzvzM9IpBtI5D2kUVOnU5/Vpi12GgjdMy9+PXy5B3toc2skgUZPU1QPnzrfTFg9Az+IbrH03EigAS4LXS1jm39V51OC+ERzP3+/RO5jIgsyINRqD7z5nzuVJNCgkTg0kN059WFdBNaTKaTXq6dB8+FtIyH/ikxUC5lbLu/41BDGht0zLm76oLDXt5Cg5lhw62e0h5OL7y1EqjaNbl1cIYcn0/kGEtbN8TPjnNJ5Jf/fN6gh6vDyW5ydo+J81eBzkpGDCLVFrTwc3eOpQQ0Jpc94+xXOt/k04kDfQLIhVyYuo4YrEFE5b11B2PSR4KCLSxM8xl2yqoKg5nyB890DggM/4E03kIj7pj5anANXWC4a1JBQSKeR7EYKBg+HPm9dQRjuDi5eBQdd9EXRChIS7LOTNETupE6LDPWEEZYVrjAznE/OOauxgiB3dCJKA+E0uODrJaoJNMhoaIiMvP1CZwXXkADbs3NO5PGQ6FV2DcQgqWHtzwC+wmbO3KkgGfFZYSqiazSDvrhLBYEZe2mJe1R7NFM+NaghGWOOKIG/D0/dRYMaEvhAtD2spQyudI5PdSoImk/EIWZC6whm8ObUoIIwuiKaj7RZtLIHckc2awk0iOJVg0Occf10VedjEtZnhADIHdgzDpFw1ZPMc+SDEOcyRdTfOdlVEYWj9iCJcws8y3TcQFBzaLAYD+GjrowEy28gAuXt4aMbjOrqYhVEZtgVtYsRYEGz1ebtVTUEbZ/T4Nf5NYWJj+oWgiJLN3gVoY9hksVI20jM6NEueJbH1HMbCXBl9FuUHVq39I0Ggu8SnIMvEpQLRnV7ulgFkfggdyxGPExPnYSogfx5fcmXyPqfyQ9fnUHDqhZT7gAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161087:13304b3b30f52737899fddf5b8dbc4cccc9cbea3b4e4d10ec0be5de778d8ad79', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NEN0ZFODExNkU3QjI0MEIyODc1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QzI5OQ==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (17, 'qrc_37DE466E6CFF7CD76285C3E4FF5F047C', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161088', '2023-03-22', 'chr_0EFD6B642B47B8B5E398E3D192500EE0', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACz0lEQVR4Xu2XMa7jIBCGx6Kgsy+AxDXouJJ9gcS5gH0lOq6B5As4HQXy7D95kuO32i0C0mqLh6Io5osC/DP8MyH+26DfJ87xQ36IjH9JAnV5Y1aH4yfzGol0A4n8DPbQ1Os0ZLVri5kGQhObAev4MslXTNdIIh+e7lHNPvW+meQ0BJ6JulgGbiTQAAKoB1vGNH9X51OC+EQzvV/fIvcxkaGeYXvKO+/+a6aWBBop3Rze7ZMhxrYIrCVRLWRFgJhGjUDZJpK32RfyZpCvmC6XMz41JPCCHMzb4cwQFOaGFsKGtAR5jfZwsvFnG0FGH25bXCEnj71vIIHIqTVjndJ7tTtYQgOJdiHC3OLsIyrObw1qSLaPjN+28JjZyW0+NaghAS9oifggqdMNC/oGks2ENMzmptUKPai8d11BZBEoivikOzzGXbKqgsQyMTZLU0Bw4Ae86waS1UGShlhnkhy/aFBBQiKNgNudFAx+CpfzVJCMvMYESpmCgy76qvXnJGKz0ABpiNxJvRYZWsg9IBk32BUqLdY571wNyQb50oU0kukd3QPKWgOJG0IEa4dj4fQLXW5wDYF3oq1IJJtN9Lp29QReFdAC2PWlBGzmzJ0q8qqxGaffsOaoL65cQYJa2R4epqKe0dzFaRoIl5EQE4tPs6f+qkEFQXzCNrttDWV0pXd8alBDstw5nP6OJjGYUYpkA8E6DKOSMotSNiN3uIGwmrWBV40OcUYGpbc6FQSF0cOPkTsGtfErVvUky04XjTgX2MxLjxaikD5QAonTBUZluzjs5yTY3W/oiAk+6sqNaGwhAkuXxUd3GNXFq2qI9LBKnA+9GIotxDjvTwVB2WcUNPio3F3xUd1CcMmSeBWhjqGTpbGRBGQiygU/5DEN3EbkqdxweojqpG40EPwvMeiIOygR0arb06tqCOITUCss8hHdUy8haiB/Hj/kh8j4n8kvNHEyjfG2p/oAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161088:dc04dfb795abdca9f1ee14dd737053e76d3047e1209e74324a88ea4f06ef4851', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NENzYyODVDM0U0RkY1RjA0N0M1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0RTAzNw==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (18, 'qrc_37DE466E6CFF7CD7A511A18EA10185CB', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161089', '2023-04-22', 'chr_0EFD6B642B47B8B531D34296798396B7', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC2UlEQVR4Xu2XP66jMBDGJ3LhDi5gyddw5yvBBUK4AFzJna9hiQtA5wIx+02eXuCtdovY0mqLWFEU/EMae/58MyH+26LfN17rQz5E1r8kgW68k1eH4415jkS6gkTeguVMjU5tVqu22Kkg1LNpYMfvfbCHNrdKEvnwNET18Knx1SQvc+AH0S3uLVcS3uJyaDWyZWzzD++8TRCfaPrz8yNybxOsrHDqjdUWePVfW6UkUEfL4fBtN05tWCaBpYRpyPvz6qnTCJStIjnd8jKyaaOayNzw1rdHS0hUM+99RpWYNijstVXEblJ2do72cHLwrYrwzHR3y+R2cnhGxVQQtltWnGFnR+WtDpJQQ7Bh7l5Nzo4Rr5w+KCFxeXgJMjTm4aSaTx8UkIDPjoBD+VafxKCvINk+/HLg4Bq1QkT769QlBAmol0nDB2mAxrhrVr1P2PQZh6U+IDjQA151BYnLMyYWdvrA08UHJQTNRy8H2ZUUBL4P1zx4nwRcndqnViHHJ316tIRw6pGAAWmI3EmNFjeUk2xgB50WGo9OCzuvmishbCDqY04dmcYR3hrOaL9PgoGOdh6RkdtPdFZwCYlqjGKHPB4SPcuuhkBX7t7OcCpabj41voQwbq829I2wcDSdvmRVCVFSvs5uUW0R/rgoXwF5zjtDtPj58NRcfVBAgmk0ZABDyt65vXF8qlgBicgdGmAKQ2IwnTcvH5QQlFqGUEmbRSt7IHdks5hI04ZWdQ5xRgalsxoLSP7SY+SOQW+c2R6+hvAIwSOplUH8YV+TXRGBRCE4kji3gHI541NCgl1FidF5MKTsd6KuhrAEHOkMHV0hVFetKiAYduSwC0aACc1Wm1OrCgjaPkOrEHOpXdFRXUNQZBgVE3wAT3TwQSUJyES0Cx7lMbVcR2JCzd1xezjVSd+oIBiXMCHiH8neR4zq9tSqAiLxQa+wjJkC/8AkRBXkz+tDPkTW/0x+AZ5vN0k6tNw4AAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161089:92fcfe101612e5e2fa38dc4400192074305885943d1bbe0ecfdb93cb68a5050f', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NEN0E1MTFBMThFQTEwMTg1Q0I1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QTQxMA==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (19, 'qrc_37DE466E6CFF7CD7CEAA229121E8CF44', '', 'https://pay.juno.com.br/checkout/805883E262B68839BF05852644BC0A25BB4CA11F6839A523', '508161090', '2023-05-22', 'chr_5AC95B8A6FDAEEF3B130BC563F95165B', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACzElEQVR4Xu2XQa7jKhBFy2Lgmb0BJLbBjC3ZG4iTDdhbqhnbQPIG4hkD5OpbaSnO/+oeNEitHgQ9RZgjGVy3uFWP5HeD/r/wHl/yJTr+JmHqJFEwp5dDZItEfQOJckR762no05jNs3dYaSA0ZzuE/QxlZnf2tmsk2Cfg9eYe0hCaSZaN9ztRF8sojQQxKDccVpzI67eFQJ9o5+vvP8r9MdHhcOpDzMHyDD9XagnTRGbTX3dIGnlfFdYSBIDcqfqkqRdMmkg2d5KH2DGalWyXy1ufGhJpifsTmejtyAZrYwvhQpS6jAV3ej340UKibELI69UX8njGjWkgnIhky26LZQjm6WEJDSTvJ+na6t0jGtHjNxAxD4bU7mB397jNVwxqCGv6kIc+SOp0w4ahgSABdQrz0+wmKlceVJCs3z0QYpAWFhy8ifD+YByWZoY48AN59i0EtULTEPvMLOtndCpIxnerGTzJwOBn/vieCiJl4R0qwauQ42t/RbSK4N24u0hD5E4aeg1DC4EfnME8BM6n+7zvXA1hq0GgNJEdPC0Ms2kgUQWBta9Bv36l6wbXEClToC6jrcA80eva1RN4vFeP3xDUvMNmrjtXQYSmnhYh1TxazC+1awjaHHXQIxo0Pkv+iEENkQfcjh0m90DDZ3QqCKO6qkVtXCZfBi/XbawgOWEBHcqCJpHtFOw7BlUEU7xeyyxKGaruJg0EvUm28KrJQ2dkULpiUEFgohoA5I6FSpsgj1qI3HuHIy+5LNFS796dXRUxZ9gP1sTpGMp/6FNB2KE9QUdG8FEIBU9tIRg4bIBRofEvw6eLVZBXD9vlHS3AimKLJHorV0FQ9gXFdn+8ujD10b6F4JIl9SoUW2QQYtBIuNwCygV6TzymUdqIPtnXtUPp1rrRQOTAPh7/kZQ5olV3b6+qIdCH0To5tAPongaVqIH8enzJl+j4l8kPYTMXnLsLpqsAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508161090:45f6141057d5698f7cc815962606faac705d383110369374f623fafd4d6b3712', 'https://pay.juno.com.br/charge/boleto.pdf?token=403099435:m:8c94d8b6d8499533c9c503a57f1e5b6011b992d1a33d88ddc34b2361498bce5a', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMzdERTQ2NkU2Q0ZGN0NEN0NFQUEyMjkxMjFFOENGNDQ1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NkIyQQ==', false, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (20, 'qrc_FF41B38D491A29AA112FEF8D52854602', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162414', '2022-12-22', 'chr_86062F0E87E436F1A3F6A3068C85088F', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC2ElEQVR4Xu2XMY6kMBBFCzlwRl/Akq9B5is1F2jgAnAlZ76GJV8AMgcWtd+MBPRqN2hbWm3Q1mh6xg9h+lf9qoL4b4t+3zjXl3xJXv+SWGqip46XyBvz4ohkBXG8Wc1RPaV/RLFKjZ0KQj1uz7yb1Fu9S9VUEutfHQ1OjMa3pprE9HB6JGpcenAlgQbqJXlizdjmd3U+JYiPU/318xa5j0leqrdiY7FZXs3PTimx9JTHb9Ib+4cNc4alJIbFhdHgq3tcshtdRxBtRUYsTsykmpjO+JQQG5B9feTFqocV2HvUENYjso+hhN67/OBbDcnOoFd2cIKPEavW1JDUI9qsZ5laI1Zccp5TQGL+fHVi7vTkBAQ+NSghHCYX9k6jxowd9e6mTgFxfnB6YpyDpPYvI87cKSHWk8QGYi4WS0TpyoMCwshryKlxyWAZD15FHLyLc6glBAf1gFdZQ8KM58VRne8tz3d1CggSkHwr9Uoi28Xe8qCEKFT3xaK0CFRQ5GMVQVK7NDhUU+QODswylBOnBpvdhhqPTnt4pYIwiroYKaykWvQ0i7ZWQeAzhxNw+/ztZ7ocXEIsSrLHWPEy+AfDRbZdBcG9BUo7QjSh3serxpcQ5wlPyvj2Aeo+5c0lBQTtizBT6A12QaziXYMCAtcqeG5gHuG8Nw0+J5GQfU3uP+nZpbbjy3MFxIVVBnQh/ImG9jTqUqeEYDxE88ltFq1szOpWkKioS9AAos7Gk/GXBgUkf4acOJgF0MpY76aCRJ4ijIs4oyookvqc7IoIkjpsNidOY4+rznMKiD0qqEHnETvEIHrWkAxTk18jMPin9l6rCghmWJuDjBEgN1uIcWZ8AUHbjxhSwnRMYbmOyhoCkx2vTYQ+hkn2GGlrCGZ/g3aBMn+kOdcRh2KArFEDRO1y36ggGJfgErzfpB49HAX1pujHJL+XIGs0W4Hpqc0hqiB/Xl/yJXn9z+QXtwI7M1D5d3wAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162414:3bba1a354397689b6150d0c99ccb650a164adf208816a62de49ff3a403978fbb', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkY0MUIzOEQ0OTFBMjlBQTExMkZFRjhENTI4NTQ2MDI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NDZDOA==', false, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (21, 'qrc_FF41B38D491A29AA637CD391CEA53969', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162415', '2023-01-22', 'chr_86062F0E87E436F1EACDFFC81038C8C0', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACzklEQVR4Xu2XTcrbMBCGx2ihnXMBga6hna5kXyCOL2BfSTtdQ+AL2DsthKfvfAV/bmkXkaB0ERFCrAei0fy8Myb+26LfN671IR8i61+SQF1mzrxmPpjXSKQbSOQjWg5m0OmR1a4tdhoIjZl6Z09fxmBPbbpGgg1PU1Qvn3rfTFitgV9EXSwPbiTwgel16tgytvlX77xLEJ9oxu/PL5F7m8ja1mAPVkfg3f/cqSWBBkJ88A2YHmFbBNaSqJjLJFdPg+bT2yaS7Zypg+FRLWS6XK74VBHTexqcXYN5BJxJjxYSFUptZov6OJ0YfjQRM0V6um3NhRyecWwLKWNM8OiiS+/V7iAJDSTbNdrFqcXZGbHKN+9UkGgGlyZkYrAvR6MUTQNhxdjzOAdJnZ744VsIHwE+UKeGKhBRuayuISgLSr2GlMJ2huFNJMrVn556QnCgB7zrFgIFhaUIURoDLzcf1BAkoFaLtjvBDWYMtzyoIIxzICqiVVBQ5GMTybi3he2dOAOuFTfUk4CaS6g2FDFK+atWGggbIjuHbScDNZ0CLtFAMhJQ7R5/L7df6FbBNURUas6oDzzAfCm7esKinU8PHQWHYn1rfBUp5C1EZQqbaIO+5U4FyQZJ/fIQFYUGPuWbDyoI5iYqEOaJ+eWlSd5y533CKBHJnTWUwZXe8c0775OwHbnAo/iJhjZ4c/mgipQempelzaKVvZA73ECi6YKBVj0d4pzIp8sHNSQjcWTemYMRTzBmxhbCc0BqI86IkiFtr8muiqhTztkOMZ/n/B2fGgLNi4DoPOp05Uk0tBCBpZPXCAz+iNVNqyqIzLAk9savZgtnXLlTQdD2Mzr2Nn9NYaKjuoXgTQKvTQk+WLzMs0MjichEtAvIPB7Tg9sI+mFG1hhMFruTvtFAMKFggML7DUY8jOr20qoaAgeE7XSWpW+kXkLUQP68PuRDZP3P5AfM8xklpA3gzwAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162415:b0eb2237a072c18ca67b84c4c8365f0bda65453052a82a40520cbacb85c8a02b', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkY0MUIzOEQ0OTFBMjlBQTYzN0NEMzkxQ0VBNTM5Njk1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QzU5MA==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (22, 'qrc_FF41B38D491A29AADA22D18A8ACD1AB6', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162416', '2023-02-22', 'chr_86062F0E87E436F10179AC0F7FF79BBD', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC00lEQVR4Xu2XQa6jMAyGjbLIDi4QKddglyvRC5RyAbhSdrlGJC5QdllEeH73SYWOZhYk0mgWjZ6qV76KhN/2b0P8t0W/X3ivL/kSWf+SeGo4jomXxBvzEoh0BQm8BXN3ZtCxS+qpLa5UELql2GreXb55u2vTVJJgd4fbq4eLrasmbBe/PoiakDuuJLz5ddc8sWVc5g91LhPEJ5jb8fcRucsEC6H2dmO1eX66n0ulxNNA1MknYOz8OgssJmpJ8S7xiYPE3NYR+3BIbbUENZNpUn7Hp4isM+Whhwym8wrXuipiiOzENGi793LwrYYE3HjdsU/K1OO7aV0N4YfGYe2sc+vUEz85cvQ6QXwgaq/m3k5BcTppUECCod7i8iYc1XzSoID4OOKTsQ+SGkmkjtwpIEEyendq1zg+EeXj1AWETcfrrF8besbBq0iwT1p3Ry0hOPADfuoK4vH0sQsQNd48z2d1CoiYU241doMM5uZPpy4g3ox+5ZdXISuRj1WE0XbUy02RO2hEIkM5CXHEwR2KGFvJPkfNFRD4gc5NWp9k2p5GT+PxPNcJ05jy4HB7efqZjgouItCAJzFm/B/pVXblJPHeS99evJ3SuqTD40uI+AHmHZKYB8wpn+5ylXi1E7XObkFh8BnT2fmuk4AgZ/TGkRmNqD1pUEKgJepDNEAXym3PhzoFhNcpZOm0LA1tcOaokgISxOOXJG0WreyB3JGfl5LEsKi7ozuc3kVy8ZQ714m061USB+WCVsbIowqSkNQMl0KtjMgjbd+TXRFRLxkkcRopl1PkCgg8D3I6dB619/lONNQQrJBHeY3A4A97PryqhPw4KDFGAGm2EOMdnwKCtp9w0nV6TWHio7qGoMhikyI0gBKYZ4daIlXy6DH+42vsuJJgSEHWmBGi9tI3KgjeS1C4eL/Jt4BR3R5eVUAQH/TGYGGBmJ5aCVEF+fP6ki+R9T+TX4voJUAakwo3AAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162416:cf81e2c048dd1fcfdc477f70e05541b472888c975a622879e0bf5b9f51c264a4', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkY0MUIzOEQ0OTFBMjlBQURBMjJEMThBOEFDRDFBQjY1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MEIzMg==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (23, 'qrc_1D9412092F70883A424A26765FCD8EF0', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162417', '2023-03-22', 'chr_86062F0E87E436F191F90CC43CEA1763', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0ElEQVR4Xu2XMc7bMAyFaXjQllxAgK7hzVeyLxDbF/hzJW26hgBfwN40CGYf3TZyi3YIBRQdIgRB4m8QQz4+MsR/O/T7g9f5kA+R8y+JpyZk6uIU2g3fA5GpIIH3sM59JLI3087G4UkFoTG4p89j4KePD2ObSuLXg+LQ06N3X301SXEAIUtdnriS8O7jGOLI7UF25F+y8zaR+tixvH6t3LsEJ8Ux8c509zTI4wric8PrZtxM0E4czDq/IlCQsH71bsFV3uK2hVGlCpJsw0Qdbz0NtC7B3moI21uHErm5c7vPk49UQxJvnYUGZ1o5xHuIL+1oiKd7WJGDh0HZee7b4+c9GpJ4Jjt5PEMa8oBC1RDOU4pk2sXbKeQpXLKjILjHuI3cgtgD3cw1O++TkCWLTLe+RfM1bIuqFMS3yCInAhwlE/YVtYpY1OeJkD1eaN+SAw0J7R7ahZED2DOMORaPVxCopms3g1azQw9XKDlQEUuU0SgbIeR1R+A1JMQJqmHxqkaqnasIfAXTzDjJBLw5FI/XELknTkk8HpN2D7moSkPsWWE7kNs6aeihhiSaAhLZntWGui+9rSAiQBScjw7TDOGLiPQk8NGLMZ95Xbfu4v4KkmjoZNLivQkgF3dRkBDxuw/CbWKoHEoOVATSw4Cle2rRweM1BxriDpObBAdFGjK2lZIdBfHrRvbRwd3zKJ9Ll2hIckcfb4aX5L4M2te9tgANgQwD1grsdCv2xIm55EBBUoa7w1qmc8ZiFyj7gYYwdH1DDgg3rLMsFzUEgzrf5d2xbHml2hri3Yaoz/EIHTUXH9UQFjE2CVPR7Qk7e/EqDUGkULSYKJoPApe5oSeyX4sYG27Fq6BxuVpN0Bz0kPmDfyeyFJepqSMsXjX07Ux8irqS8POU9sLoPD6u97xNvucgI9gntgCSFU9PUB+Mi+R+/N2RLa+C/Pl8yIfI+Z/JN3RWHoZUeaPhAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162417:bcf9faef29a6ef96ca1ed3c1c6efd9915dd99f20e3c50539e3cde52b839e3558', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMUQ5NDEyMDkyRjcwODgzQTQyNEEyNjc2NUZDRDhFRjA1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MDgyOQ==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (24, 'qrc_1D9412092F70883A113959FAA49255F1', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162418', '2023-04-22', 'chr_86062F0E87E436F1964851187125A516', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC10lEQVR4Xu2XQQ7bIBBFx/KCnX0BJK7Bjis5F7DjC9hXYsc1kHwBe8cCefonqmK3ahcBqeoiKIoSXhTgD/NnTPy3Qb9PvMeXfImMf0k8NSmS5dXzwbwGIlVBAh8hTmx2FfvU7spgpoLQg3Xn9Ojyw5tT6aaS+Dw6mkL7dBE/qSVJBHgSNSH3XEn48O2itpkNY5p/UedjgvgE/bhev0TuYyJDBDi4PTzv7udMIfE0qPZ0NJA5OPZ+WwSWEizC25x4DnFQfDpTRRBkaucEIduFdJPyFZ8C4iMEwNFXr3vfYq6vIUEP8vdQwpxWNn7UEIxEI45OGXnMkjEVBPFBtrFZQ+5cu8MYrpv4OWEEZFssXmYOLdZ8a1BCgjkCjRZ5bJ54F7OpIbmzEal2WlzqOLr2ujslJA5uO4k61a6eiPK16wKSEBBx0MXGCR5jLw1KCCPIMFFogODAD3hXFcTzKf9tsM7D83LToIRwJPiBMjvhXT/8bdcFJOXJS6jhVXDQRd0ULSCMcxt4VRNwd2KnRIZy4vUUWLyKsZSsc+VcAUHRpgiLgit0lnCC6X2eAsIbM8o1zFhOv9AtgwuIrCNtxWuzaC4k7coJw9fFq2Zv5rSt6eb+JQR126yoG34TT1W3W1VAgu6UGNWB8hj0lC4Nigi6CQTc4OPTUXfToIS84vO02+rzYOFbfGlQQsyRUMT0xFLQBqcvdUpIe5KRsBDkxAl4lclSgvpDGV41WsQ5kotXzhUQuLv4scGWpS/GV1dBkqTvohDnPAVNyrw7uyICi8I6cnEa//rVe50CAs9DcqA9hI/aPBLKeAURqEeLxwi4Qu5uXlVCpIeFH2xoARYUWyVGWE5Q9mF7KjevLkx8VNUQlIsoj02EOoZ7hKaskmh41dPC5vE19lxJCI8jqDwTRLVSNyoInks0nKDn/AhwenPzqs8J4oNGOBDaYXRPnYSogvx5fMmXyPifyQ9aNRgXNc0ltwAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162418:7232ef3787743ac155563c7252f44cb4794a38acfa74c33a81c845b00a26c94e', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMUQ5NDEyMDkyRjcwODgzQTExMzk1OUZBQTQ5MjU1RjE1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NTA2RQ==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (25, 'qrc_1D9412092F70883AFDED7CEFD20FCF73', '', 'https://pay.juno.com.br/checkout/DB68922922F0436E214D38F0C7B0476104E23B3F0D217F45', '508162419', '2023-05-22', 'chr_86062F0E87E436F19A110906E7D3374F', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0klEQVR4Xu2XMa7jIBCGx6Kgiy+AxDXccSXnArZzAftKdFwDyRewOwqU2X/8JNtvtVs8kFZbBEVRwhcF+Jn5Z0z8t0G/T5zjQz5Exr8knhqO1PHieWdeApGuIIH3kIfObjq2SW3aYqaC0DNhzgwuP719a9NUEm+GjsagJhcfrpqk3AY7ETUht1xJoIEZNL/YMqb5uzo/JbifYJ7X69vN/ZhgJLUHu7PaPW/ua6qUeOopDw7vgLH16yywmJg2xCbxK8Re89vZKhLWPRkiCKlmMk3K1/0UEFaLXyU/sKBXmGtriFeTpiZRr+27k43vNYTNQ8cBR6eMPJavroL4TPLRLiE/nNpgDOcOCgibkbHfde7sKyhON3VKSO67+OiQx3bCuyRNBQnidsdSCGqIoa7YKSCMiDZjoofGtRNRvnZdQAK1aV1YzV0cPWPjVYTVy6u3gwa4HPgBb7qCYBEPGSzWeXqebxqUEJxbQwC7kYLBP/0tS0pIHr3UCngV7mrWl6IlJGCaEDsNbB5BpEWGcpLyeMQOPB6ugHXOnCshDKOKjc+IIKw2epS1ChJgUevmYMZy+pmuDC4hqPzOvlI8NovmQtKunIR1QW0E9ODrku4e/3OSDq9KOP2KE/T6ip0S4u3CAveAColUvnliAUHxcQzbw8fJSRBd6hQQD1NRRxWCBeZHx1fOFZAEf0K8wJuloPXOXOqUkHWWDhH1B3LyhNjhCsL474yeAo3n7CK5eGpQQrBOB7uy2LL0xTB7V0PgxLLlUVLZkLZnZ1dE1LtTX4HTeH6l2/0UEHgeCqxUHvwkD0R9DRGIuBYf3WBUd68qINLDrlO3ogWYUWy1Ob2qhKDsc35ybo4uTHxU1xBURfRiERrM0smiKaskiESUC7T/+BpbriNBnplQeUaI2kndqCDyPEedaaFEgNPb06tKyHE/bzQm6CnwBCZXVEH+PD7kQ2T8z+QXdmsWo2n1dqwAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=508162419:9aed2a5393df3f6aa69823641f67edc7a016c666a8444dc68bacf88bde15a3c8', 'https://pay.juno.com.br/charge/boleto.pdf?token=403100664:m:f3bff7bc8d65697df06ebd5fc532f49dc1c251af71892d472b89fe653a33d35d', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMUQ5NDEyMDkyRjcwODgzQUZERUQ3Q0VGRDIwRkNGNzM1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MDVGRA==', false, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (26, 'qrc_CF1A35843BB76915A63E121C8FB579E5', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501014', '2023-01-10', 'chr_1E0AD6AC700BECCCCDF4E66535CB42F1', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0ElEQVR4Xu2XQY6kMAxFjbLIDi4QKdfILleiLlAUF4ArZZdrROICsMsiKs93t1TQo5lFJdJoFhW1SpAnNeHb/jbEf1v0+8ZrfciHyPqXJFCH38xr5oN5jUS6gUQ+Qrp7M+o0ZLVri50GQjfeFr09fbkF+9SmayR4jsO/Vw+fet9MIAC2ibpYBm4k0EAtOnVsGdv8U513CeITze38+xG5t4ksdQR7yC/v/nunlgQaNQ2RRgJMQ9gWgbWEU0/8dBA1jZqf3jaRzDuVLtIU1UKmy+UVnxoSLOcyuo2DGYLC3tBCEJOAUFOv7dPJwY8WgqTWosHiCjncm963EERmY7ZrLL1Xu0jbQOAowe5OLc7OUXE+NaghAYctd486tg9Ht3jRoIZsELLL0ABJDdNSZ47WEFiUmbK5a7UGIiqXU79P8iZaOruGNAXGwZtISCOqxCNKCA78gHfdQLgMGSe1i0u3wMtFgxqSC9G2kN1JweBv4fI+VWSKMBXxKjjooi+K1hDki0UdzxG5k3otMjSQNMVCXs2MR8lzXjVXQ7Ct0XzKSKZ3NAWYVgPJsCix9sXL2y90VnANCdtDqgT1gZtEX2XXQOBVdPd2hqjI8Xx6fA2Bj7IZGG+/4fqrFzWRKeCw9ojqwLVMBA0k4znIQYvLh6f+okEd6Qnmt60BXQjGwGfNVZCgHk6a2CT2bEZvXhrUEOYniVehzaKVPZA7sldLwraTgcdD1MUn8umSVe+TjMSBAMgdg964sn36FgInhlEhzrAZQ/qc7KoI5FRr3JA4XeA5XyJXQeB5cZORHz6KJkk0thAWg7k7fEZg8C/9xatqiMyw0mkxAkiz1eblVTUEbZ/lY2L+msLER3ULQZGJV0GDRTokRtpGgkxEu+BZbtPAbQT9kJE1ZoKoTvpGA8F3CXoFvm/KLWJUt6eLVRDEJyBrCOMwpqdeQtRA/rw+5ENk/c/kF/Q8NWYth+NhAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501014:d586abe20390e2f957f011517f332d2d179052437feabe6a7014970b30932b00', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNUE2M0UxMjFDOEZCNTc5RTU1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0M0JDNQ==', false, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (27, 'qrc_CF1A35843BB7691523A3CB220D5228EF', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501016', '2023-02-10', 'chr_1E0AD6AC700BECCCD6259C57E57621D0', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0klEQVR4Xu2XTaqlMBCF6+IgM91AINvILFvybsCfDeiWMss2Am5AZxkEq0+9BrWb7sFLoOnBDfK45oOnOVV1qiT+26LfN671IR8i618ST6+Ux8Rr4oN5DUSqggQ+vB6s7lXsUrMrg50KQu+0LXY7XX57cyr9qiSeBkdjaCYXW1dNUrN6noheIXdcSaBBbNU2s2Fs86/qfJcgPkG/7+uXyH2bYCXD3hzcHJ5393OrlHjqSY8BfwFj57dFYCnhLzktcjD2ik9nqkhqjmAmFRHthTRy/IpPCfG5wyvbhr3ufIO9roYEnjm/klmUOa28+FFDfBy5OV2z2EwW97p1NcTskJPNGnLrGvl9PaeApDxYPASXmUPD6daghCCXE4KDOjaTpXd4qFNAOA8UcfrFIqnjADFcBUk8e0A9KKQkEeX7PAUk6NETYrIiUJLgTw2+T3yD3IHz9YTgwA94VxUkINT432ax8e15eWhQRCLOPZDZqYHBw6Hv8xSQBHffji+vwjMX9dC6hGTY5xiQhsgd2LPIUEFke7Li8ei0eM5VcyXEZ1IaMsBNW0uI/HhFu4BIZDZY++Lk9AvdFVxG5oQL9YEblIuUXTmRpNaDM7MH39Z0e3wJSWZyYsaj31AxvXrkTgkhMTwHU0Hr0DJGVRHUHIYdg5+To/ahQRGhzqOJbavPvc0tTMtVkKDJ4fQ0Ykj0unf60qCEsEb/WaxBm0Urm5A7sllK/CZTpyMCdJFcvHOngMAGRADkjqavtna6CpLwpmZXiHMeoYcyfMWnhEjTlncP+uV5To/IFRDp25iv0Xma08JQqa8hWCGPYlQY/HP78KoSghlW5GSMANJsIcYVuQKCts+xd/BRqV3xUVVDUGT4bEIXQh9Dh6S+lohXYYyd5TZ2XEkInyNwepTLbqVvVBB8l8AGdMdoaxjVze3xBUTiI0MxxmFMT62EqIL8eX3Ih8j6n8kPa1oe4IWxL6cAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501016:5b0c359f0a88f625c337ee92d970ee9bfb141e22cb9d6e427806ad89488b35e3', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNTIzQTNDQjIyMEQ1MjI4RUY1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QTc5Rg==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (28, 'qrc_CF1A35843BB769157F35DE03FC61566A', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501017', '2023-03-10', 'chr_1E0AD6AC700BECCC0299B0F33A06F6D8', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0klEQVR4Xu2XQQ7bIBBFx2LBzrkAEtdgx5XsC9jxBewrseMaSL5AvGOBMv2TSrFbtYuAVHURFEUxLwrwZ+YzIf7boN8n3uNLvkTGvySBOjZz5i3zwbxFIt1AIh+Rn9oMOt2yemiLmQZCY7Ybq6cvY7D4StdIYpoczVHdfep9M2G6RXsn6mK5cSOBBmbSpWPLmOZf1fmUID7RjOfrl8h9TDDyvgR1sDoCP/zPqVoSaCAzebzbg9Mt7KvAapJ6nTpkYkyD5qe3TSQjIKkLEu2VTJfLOz5VZF+pDF5xMLegWCLfQKJaInWZem2fTjZ+tBD8ML+O7go5PJreN5BQyPPGdoul9+rhIG0DYbVFMzi1OrtExfnUoIbE/a6tVF6wd4dqvqhTQUKaNOH0q0NSp8mrS1Z9TtguwUwORay2QETlPE8Fyal3pXd2C2kOjI03EYYG9Ko5BAd+wA/dQEKZCBFG7qQx8HpVp4YYwjpkH6Rg8GM4d11DcJVJtcFaFBx01RetK0jEZtMckYbIHTiNyNBC5rDf3b4wlpJ13jVXRQyRWnKBm/a408S0GkhAiZQRK3g5/SqxaiBxf3h4FeoDD4leZVdPJHcwjVqxS963fHH/CsIweLVlnH6HHoO+5E4FyWWSmoOpKFzg0ka1EOYDG3cWH+6e+osGNSSUOaChgLWU4bXgRZ3PCfzAF/jBjCYxmMGbU50KkpHLr7AQ5OQ7cke+XksYh5Z1yCHOiXw61akgERpAAPFmOD2utadvIBlOLFuec5lRf9q+O7sqAsND1uxInC7wks/41BB4HiA0gI86VAwNLYTFYDr5G4HGv/QXr6oh6GGDdHZoAeSy1eb0qgqCaz/Dq+CjUrvio7qFyD8JeBU0WOWGpKGRoAvwuC54kceE1qyNoLlD1pgZojq5NxoIXEqc4MZljGjV7enxFUTiAw8gtMPonnoJUQP58/iSL5HxP5MfBBAecb3s3S8AAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501017:02c7cb535150d8945d523c7e4f8d3a717371afbc148daf847ad1a8e944b86dea', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNTdGMzVERTAzRkM2MTU2NkE1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NjBERQ==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (29, 'qrc_CF1A35843BB769152C8B97057D83E6C7', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501018', '2023-04-10', 'chr_1E0AD6AC700BECCC1D6E3F123E96478C', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC5UlEQVR4Xu2XQY7jIBBFy2LBLrkAkq/BjivZF7CdC8RXYsc1kLiAvWOBXPMr6jjp0cyiQRrNIiiKunkoRlW/fpWJ/7bo941zfciHyPqXxFMXaM68Zt6Z10CkG0jARtqIb2zGYAbdY6eB0Oj50P1C6dDlok3XStThaA5qcfHi2gkv2gxk5pxWbiSIQZlZ7UyDxd/fo/NTIvmRWD4/3zP3UyIrbTp23K8c56+dWuLVHvq7K0Q0WXXYcsaghuR0t4UsNBgHzYfDqQbiiWx/twobm8N3v7UQLteMK0PXatHxossom7VEKsN0mS66P6xcfD91UEF8mSiOucyeJh0hn5d2KkguA0HXac/plmOHdD1vXUMY4eQDEbX9LSjOdH0+p4aEQo4GSouFH/QHGXINJEPLBpYAac9ZrYG3Z5VUEXG7w5pJqxU6onLeuoYgBi52uUzWdByvnI7nrWuIx7a5hgLPm5kXkXYDyWJOK4rYRljgvZEwSiTtyBL1C/wArtBEzOwh54T+I8Yc3qqxhpTRx2uADPEcVDCstIVI54HBj4xsxy6UuYVkA1PfLFSjbpzuRN3jeC3hVZoPMiMavBNy1UJQcBAj6kPdPE6lxbWQMosHJPx3cTRRetVcBUEzJPQxmn16eOqbu1QQjpMlFApMZc1qc+alxAqSiVy5QIlQUE4w6ascrybx6jHpQDhlsDjCr2qsIeLum013jZzDlfl0lyrCeALmJrRZ9mbM6uxmNURKFlF8dG8XycWz5mpIVtIlNAIQ0RvJvvl1DYF3wkFRuzIXYzq+cQvBAJt2D/MznedbfstPBfEYcMRKN/goureMjQ3kAVcPa4Ghwu8LhpR6gh/OasH0FDAIoM2a0/lqiMzXPWoFOR/zw0fl0dVE/HgjaRcdRh4Pj2kjHkpEu2DJc4hnBVcSTCW23yEfDxGV1/tcDeHdY9JE005os3NI52RXQ5AfvIFZgsdseAOTFDWQP68P+RBZ/zP5BTNjWVo1oBEqAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501018:72c9f9e141524ab06a683b4a149f7945c2c595e3829d8922e97542c03bf8054d', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNTJDOEI5NzA1N0Q4M0U2Qzc1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NDI5RA==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (30, 'qrc_CF1A35843BB769159AF72917BD5DF5B0', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501019', '2023-05-10', 'chr_1E0AD6AC700BECCC0EAD64F6FE209472', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1ElEQVR4Xu2XQY7jIBBFK2LBzrkAEtdgx5WcC8T2BciV2HENJF/A3rFArvnVPeOkRzOLBmk0i6AosnlSjH9V/aoQ/23R7xvnepM3kfUvSaRLoanwo/DO/EhEuoMk3lO+azPqfC1q0xY7HYRuZQ1+PXy9RXtoc+kkydw9fl7NPg++mxRzjetMdEn1yp0EGtRBrwtbxjZ/Vee7BPFJ5vb8fInctwlWMVO0O6s98uY/t1pJpJHy3eMbMEOMILCVcL07XpCJKY+aD2+7SMmjr5eUp6QCmUupZ3xaCJKaEHDFETFX2Lv2kGLIq4Vp0PZwcvC9h7C5Mh+Og6vk5HbwHSSue1kfbB/IR682B2k7CM7rzOBUcHZJistTgyaiNlphUTCD2aGaXzRoIAVBlvQJDkmNlFTP3Gkgcd1cntjctXpEIqrnqZuISIiHPGKeIuPgXYQzcvmj5hAc+AFvuoNEmiTUNrh8ixxeNWgiRBzIbqRg8Lf48j4tBEa18odXwUGDflG0gTCyRuHUS0Lu5EGLDO0kVfjK4cTj0WnxnLPmWgj8QEuIRkKt0ASBfz2nhaAxUoWpBC9vH+hZwS2E19nVS0F94DrTR9m1k2IDYQSwS7QLbKa8eHwDQXzE/LLEPGFOefWdBlIH4s3ZPak9GRmjegimCQmLxeXs4YJPDVoI4qPt7GEtdXR1gGn5HgKvWg+NOobBmNGbU4MWAiELchBRgpw8I3e4gzCcwMCrCNBn8vmZVQ0EPYchAHLHoDeirR2+gxSGEwSNOKOUUX/2nOyaiDoIz5HEuUQZfJ4Z30Ci3X52HnhMxbQy9hAWu7p78dENRvXiVS0EM2yscl7MYmi2EOPMnQaCts/mxvBRqV3xUd1D4PH425ShQZAOSWMvEQ1mTLJymzGa9ZE8idObCaI66RsdhHc4AQye6y1hVLenV7UQiQ96LGEcxvQ0SIg6yJ/Xm7yJrP+Z/ABSwijf+D0M9QAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501019:018ea1adbd4b25f12bc1f82f6856a09e7a7683450b4cbecc0b98249ce2923278', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNTlBRjcyOTE3QkQ1REY1QjA1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MUI5Mw==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (31, 'qrc_CF1A35843BB76915AC975C33094802E4', '', 'https://pay.juno.com.br/checkout/301834A9ED3246B7246AFE528574934AA4B306FD8E9AB731', '527501020', '2023-06-10', 'chr_ACE82F8A6E782544FE9A9C8834E3D388', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC4klEQVR4Xu2XPQ7jIBCFx6Kgsy+AxDXouFJ8Af9cwL4SHddA4gJ2R4Ey+8gqTna1WwSk1RZBKRI+y5CZ4b2B+G+Dfp+4xpd8SRn/kjjqHJHhPfHJvHsi2UA8n0mNSa+sRq9uUmOmgRAmZs8LxbvMvVRdI3F8tzR7sdjQ22biFUl1IzWnuHMjQQyoY30y3QyC+mt0PiXIjy+xfH5+ydzHBCPxInllvXOYf85UEydOJzabiWgy4m7yFYM6srtQKtGHm0Si9GYbSMqY3ihi4rBYUB8txIfB6dUjBmKRoZd55AaCA0dxTdRLfTdl4+cr258TppnFmfLsaJIB5XPVThXBlsMk45mwWuiQrsfjtQTHF0kWm8EjghMN1zoVxKOu40FxMdADfSdFtoEkNTCjGA8Z5iR2z8fzlNSQcoIFezVJlCRylV+7riH4mrukJqM6DgPH+3PXNYSLVgFC82bmpZR2A0k4ZPjrejMBgro1EogTlb0T6QV6AFVoI7MLvYnwnyLM/u00VhDOoxNcDjHWwQmGlDaQBOdRQwojF9HqfJ5biA8k42EQCbFy3Aju0UAY2qluFpkpNbgRBLWBODU61ZeEi9XxznGxDQTvNpiO+NVbmii+nbnPyUOMZ+ifi1w6lDfdqSHYKew6Q1T2JA6rrkqsIcVm9e7i6sKQIrs8lKdriWcYRVcKJ99M7uFsz3VqiIMlYi5uEuoOVeZLXWoIOib/SIsVJfNJXG5WQ5xYCFFEGwuZCWTDdeZqSEI40dlh4/A0NBcvVa4ivBbTCA8XQtohMy0ExhhPF0+vOoenXvmpIU4f8ENEFDoK9y5tYwPB8AgDpEXNTkOe0aTUE7w45bJfj0YANlvuAfWkOC36JhpxL0kPHS1LVxNC9SEMsIsOLY+DxrQRnycLu+CSZ7SNb+tUEV4MbhJoxGDd+XWfqyFoMzU7mHaEzc4+Xp1dDSl3TfQ7NKCBwg2spKiB/Hl8yZeU8T+TH3u2WC4oVcLtAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501020:a91c3c84451c9bcbff32147183376fe5af15e2728fdd9029c7fdf1c99c35c5c4', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203316:m:837d571a612568482dd536e564d8c2042625e01a34c135dbce672cea43692bad', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvQ0YxQTM1ODQzQkI3NjkxNUFDOTc1QzMzMDk0ODAyRTQ1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0OTgwQg==', false, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (32, 'qrc_FCD5062B43A92AC40A3AC680A8865B73', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501540', '2023-01-10', 'chr_7F684D409F723A73147AF0B458EF10EE', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1UlEQVR4Xu2XMY6kMBBFCzkggwtY8jWc+UpwgQYuAFdy5mtY8gUgc2BR+90jAbPaDcaWVhu01cG036htflX9Koj/tuj3jWt9yIfk9S+JpSaq2YhT88G8OaK2gjg+bGBOvfN9FHursFNBaOSwGnWaNFp1trKpJJZPQ5MTs/GdqSZRbJZnosalnisJH46GlhpWjG3+ps6PCeLj5Hh/vkXuxwQrCrbiYHFY3s3XVimxuLJ8aRpIHex7i1jVELF+CeD80CJQqoq4MBsiEzYnVpJNTHd8CgjLKfKuZW/xEdjra4gNR8StoYQ6db74UUOc7Ah7vMVEOh/bmQrCWYCD1dqmzogd/3I9TwGxvBr/0mHVanGC40ODAhLV4cK7jtWsacxFU0EYuRNmzZBhx4FGXLlTQizOIWycLVyBiNL9PAUkylerVlKb9RM8Rj80KCAsBw0TRc0hOPAD3tsako/qnVq1H3OsHuoUECsJWUNqJ8ggR/vIgyIyuTQ6WIuAgyIfqwhn+5wc0hC547s2y1BObJrgxDosjKPyOVfNFRFJhObjB5KdpsmirVUQlIhNI04w+elXuiu4hEADDkv078t6epddOcl76WWQ12qJYYu3x5cQp/Y2bIynhytItNwr2iUEuazx26hjcbjs95cGRUQtnJ1gYkYj6h4alBDcN6KCoUEadOo039VYQFyADSCv8edm5WDkrU4JSX2EDLnNopXNyB2uIJwIMwW8KuvqyfhbgxKCjYDEwZXRGzeGHhUk8oKps0WcUcrwLXVNdkVEnBQOmxOnsbzEOz4lJPefAI8n+KhOL6KhhmSYmojXCAz+qXt4VQnBDGvhBxjBxIpmCzGujC8gaPtoaIaX9xSWfbStIZgm8NrkocGaOySGsjrisldhrFjyV99zHbH4JtF5Joiqc9+oIBiXMCGmhtEh86vY5VUlJMcHWaMwtmN66nKIKsif14d8SF7/M/kFLusk1F9fzNgAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501540:b3f0c3bdd3005c5e5e32b5a06566a57b7fbbcf96b451783a9bb1ba4be9150670', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNDBBM0FDNjgwQTg4NjVCNzM1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0Nzg5MQ==', false, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (33, 'qrc_FCD5062B43A92AC4707D688048678EB9', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501541', '2023-02-10', 'chr_7F684D409F723A736AE284BAA9651562', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0klEQVR4Xu2XQQ6bMBBFJ/KCHVzAkq/hna8EFwByAbiSd76GJS4AOy8spn9SKdCqXcSWqi5ioSj4RbH5M/M9EP9t0O8T7/ElXyLjXxJPDzazU6flg3kNRE0FCXwEPTrdhdgltTcGMxWEhmRW5tPlwZuz0Y9KErbT4e/V7GLrqklSq99mokfIHVcSPjweXT3ZMKb5F3U+JohP0MN1/RK5jwlG0pPXA6vD8+5+TpUSTz2p16c5OHZ+WwSWkoSYbLPEJ/YNYm6qCCOvNbltDWoh/Uj5HZ8S4rHT2FvdeVwKc10VgZbxwdQ35rSy8aOGhG2hDeW7pkwW97p1FUQ0iB2bpcmtUzt+clfnU5L0aLfdbos1z6A4XRoUEbVTnFB53swW1XxpUEJ87sI2W4YMu4ujU1eOFpAQh0SjVWcDVyCi/N51CYHnUW4bXn2cPGPjVcSrZ8qjk8rbLfyA96aCJJoCImwWGwfPy02DEhI0NUhGsxNk0IO/dl1CUsajPwOsRcFBkY9VxCNrMIc0RO7EthEZygkjLJrsBo/HSfuqlQqSYOqyQk+6tTR5EbiCYB0xlcXJ0y90q+ACIraXH+LNuIn0KrtyghJxenRm9eaZtjXd3L+AsOTOgXz0G/Kob271U0AC1hEfPYJC4zOlS4MSIh4vLdjEPDtq7+qUEMjw8nifIW1r+XKxAiI1h2oz+Lp63UuLV0FSHJEvSY5ZZNCM71xBULvSdVJvEedILr41KCI4/zckziqVh0XM6SpIgrWgcBHnPIke5t3ZFRH1WkoS5wHTSld8Sog3uzQ7OHnQ/ueRqK8hLAEf5TUCnSwOopuLFRDpYWEDaMHUgsMWYrzzuoDg2H856PPVhYmPNjUERUbwKmiwyAmJpqyOeGQijBlL4RadVCWJU9I4eSaIauUJKoi8z4kxc8bL0wJDvSn6MZH4wF0Mmgt0T62EqIL8eXzJl8j4n8kPipEzj8mo0rQAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501541:1415cfe4d5b39791e8e0febc33a39d68fb8a8764ea9afa39055d957b2371c6b9', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNDcwN0Q2ODgwNDg2NzhFQjk1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0OUI5Ng==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (34, 'qrc_FCD5062B43A92AC4C28F5742B0DDC7D2', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501542', '2023-03-10', 'chr_7F684D409F723A733BFCDFB20D1E637C', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1UlEQVR4Xu2XT86kLBDGy7Bgpxcg4RruuJJ9gVYvoFdixzVIvIDuWBBrnupJWt8v3ywaksksmpjuyM8I1J+nSuI/DfrvxHt8yZfI+JvEU8OGnDp7PpjXQKQrSODD5yeZLsQuqV1bzFQQenBue3u6/PD21KapJGE7HV6vJhdbV03Yrn6biJqQO64kfIT81HZmy5jmH9b5mMA/wTyu64fnPiYyNvb2YHV43t3vmVLiaSBqe/wCxs5vi8BSgrtAoxw9DprhqCqSeCc1kVqDWsg0Kb/9U0Lwn7a9N53HpTDX1RC2E8WGadD27GXjRw1JCEPz7HlNmXrcm9ZVEI44d8d20bl1ascj7x0UkSfFZ78tvZ2D4nSzQQFJkKgMh0MMph7ZfLNBAfHYpsgert3Fp1NXjBaQYCcHi6pTq9UTUb7ioIRsa4KC8urj6BkbryJJEvd0yDk4B3rAu64gWMcj7ezSx4fn5W6DEgJxMi1ZZB4E/uFv5ykgbEafxyBahfxDPFaRhHfDMwhDxE5stZihnECoUMScgsaj0r5ypYqQVrOPAxmo6ehpvFvnU5KQbUpWcHL6ha4MLiGciXhO8bXZSK+0KydBAgfSLkZNiPFL40uI6CgqBk6/cTCD/qnKn5JksRQU9AjqCGZMN+uUkG3ScZSCxpOTInlFVQkxLxmAHuShRxvFbxuUEEY3Z0ZpTwDN4MxlnQLioZ12TVJmUcomxI48XkpwdMpPaFUPP0dy8YqqEoIYlAzGluGllRFHFSTxLKICP0NjDGn77uyKiDppm8OGwGk80uXmuQLy6umk5YeO9mjbaaghGEF6ikPcntubVpUQ6WGRdmjB1IJiC2O8Y6eAoOyn/GCeX12Y6KiuIegmqEkRNlikQqIpqyOwgUO5wFIs0sWVhDp8NknmoXRL3aggUCmsgy+SjI+nBfl3s+jHBAbwiBrLXqF7asVFFeT/x5d8iYx/mfwC4JctkizDsQcAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501542:c9a7a81620b8e4bdca9a1ad8d127665dfefe85bdbc8712f50532640f0e43dd4d', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNEMyOEY1NzQyQjBEREM3RDI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MEU1Nw==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (35, 'qrc_FCD5062B43A92AC43ABF0187256EE609', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501543', '2023-04-10', 'chr_7F684D409F723A7343AA0F986A50FDD9', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC00lEQVR4Xu2Xwc3jIBCFx+LAzW4AiTa40ZLdQGI3YLfEjTaQ3IB944A8+/AvOc5q9xCQVnsIiqKEL5LhzcybCfHfFv2+ca0v+ZK8/iVx1PA6WnEY3pkXTyQriOfdpwepzocuik1q7FQQGiLPVh82DU4fUjWVxKmHoacXow2trSZxXbweiRqfOq4k0GCdJXTVjG1+V+dTgvh4Nbxeb5H7mOSlF6d3Frvjzf7slBJHPYnzHTB0bp0zLCapJWQirh56yYfVVYQTGT15sXgxk2piuuJTQiI9LOojdU51TmCvqyKItp6YeqkPkw++1xAOT5fLd4k4Pr6q1taQdZO8sJ5laq3Y8JPrOSUEVw+9WedTV0hyaVBEeIoIDupYj4aGXDQVBDHxKzTAa7PhYcUrq0rIj7uIQ4rFEVG6Tl1E4Cg8S5QdAsU4eBWBS+HINlfeZuAHjHCVE4fbh87r2YTBwZ5vGpQQmBOqTW8EGdTgbvcpIbh6dmV4FRwU+VhHcG/kDtIQYoRWZhnKCaPz0MOsE+NR+TmvmisgTpHUUww9qRY9zeGHFYTTA6G2iEy+/Uy3Ci4hepQou3AeNtBZduUkBhwT1r44nH1d4svjiwj1yETo6lb2qpd3v/6cwKt8ajE6ebF79YxvzvcxQaOmFdn9ZB4ttTcNSkiEAIGyBqk3+YEvDQqIDwPD8DQ+Lk71Vl0aFBGcVMwmt1m0shG5wxUE7YLOZDSIM44fXtVYQLzqGH4MDRR6I9raYStIZOT1LBHn9PS5/q7JroigH667y4nTOJTLLXIFxOlN5lmM4KMGY3uu5nKSYULuwEc3GNXdxQoIZtizJTaYxdBsIcYVuQKCto8BCrPAOYVlH5U1BEUWmhigwZw7JIayOoIpwOZ+O+WvcJpKEp4Y6HB7iGpy36ggvDtUSWo4DfiDAmO4Kfoxyf9LMD1pjFGYntocogry5/UlX5LX/0x+AWJlKl+2F8xFAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501543:7c24363d83ce3535f05b06ea6771ae49da41e17c1c13b1d964955d9c0230296b', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNDNBQkYwMTg3MjU2RUU2MDk1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MzRCNA==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (36, 'qrc_FCD5062B43A92AC44733DBCF4C667177', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501544', '2023-05-10', 'chr_7F684D409F723A730150D28930CCE073', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC0ElEQVR4Xu2XQa6kIBCGy7Bgpxcg4RrsuJJeoNUL6JXYcQ0SL6A7FsSaH1/S+iYziwfJZBZNOnY330KoKv6/IP7boN8n3uNDPiSPf0kcNaxGFqfhg3n1RLKCeD68Po3qfOii2KXGTAWhIfLKfNo0OH1K1VQSTy9LoxeTDa2tJniP44mo8anjSsLH12JZM1/PGoL8eDXcn2+Z+zHJQ8xOHCwOx7v9mikljnr6euqDQ+e2JcNSkjetJ4tn6CVyruuIOLBvEqsXC6kmpnd+ikhqTRpi6pzqnMBcV0Ni6I2YI/USZyUv/KgjrVQvq9eYyOC/am0FcTyzWFkvMrVW7AaSUEHwHVVvtsXo2QuOdwyKiLqSTBCDyeA03zEoIcxYbxMZyrfb8LLirp0CEhXRxk6cUqwORZTubBcQhhhoBGB1YYTGmEdVFZEjJihfT0gO9IB3WUEc4dSuHq8Kg+PlEYMiEoj0QnonhEEN7l51EaERQuUhLQJ1hFxVEca+N4jKDI0x+cQMVSSNbpvjNiO0Vx29z1wRQQxQPqEn1RrsALZWQ1A7G6R9sXn3C90nuIREMVFooDH2eud17MoJbydpRHR1GpFY40PjC0i8BD5i99ulDQ9VLiAuvCS6CX14VJAa40MTC0jcJqg7OhTmyVL7jE4JgaggomhSUm/gRXzHoIAwBCDXNX6sTvVW3aekgCAGltAhwmYhzxPlLq+cMHoxlbXKIM+BbLhrp4Cgm/MbCgdLhjfC1k5bQSK8kU9CntPoFcm7sysi4rRI0YbCaeC68Zm5nxOnD4f85Oo+TXoR9TWEcxhQO9DRHUL11KoCgh4WyufQgokFZivVW6tKCGyf80rnqwvLOiprSL5JQKsQgyU7JJqyOuLgtLCLnHZ0sh3XkfxPwXlwq9tN9o0KgnsJKjo1nGBrCwT1EdEfk3wvgcdqtDzontqcogry5/EhH5LH/0x+AQucLri4cUSVAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501544:874ee04b929abf0be4b78eb07aaaeff686b8258b061356b7d4842173d3d0123e', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNDQ3MzNEQkNGNEM2NjcxNzc1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NjY3RQ==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (38, 'qrc_5DED744BA82A2B33E1D4EF51121C7F47', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985640', '2023-01-31', 'chr_A9A3E78486F7D6E8EF614C59BB9DA431', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1klEQVR4Xu2XTc6kIBCGy7BgZ1+AhGuw40p6gba9gF6Jndcg4QK6Y0Gseasn3X4zmVl8kExm0cQF8hgL6+elJP7boN8X3uNDPkTGvySBuo3IKw58MK+Y6way8ZFp8JiZcTODtlhpIDQGxZt6UDp16bXpWkm5eyvQx963k0iaBjJTTis3EjgSC3FkGhzmv3jn20TiI758Xb9G7rsEI6eTTMcW1qafK9UkqCOY3hciujt1uvL2QRWxyBpycEYcNJ/eLr6FiC97iTPvXi3e7k0kLYSdppnVQ8del5EbSLa74xmmtD2dbPx4+aCKqEVj40hDuus4iDMaCKudYCTtLs05dgiXLNaSDe5Mi8Nl501xptvLTg1hkZYHFXLQA4uUJN9AMp9k12ARnCmrdeP9VSU1BLmTy8Sm12oNSO7y3nUNYdiBKpspoOzijdPpWwgED14sNwSc+SGp3UCCuTtz2+zi4hh4aSQoX22PAD2wD+gBVKGFBHw90lDNbESYty/VWENo3NJTTWEHFQwpbSBwZLBrxusR7dhtZWoh+HpNY8bZiI1DaaiTx2vJhp2iaguEGTm4EBqBFkJdTggyyncOvHJ6+AaSLZJxhVNFm+lO6arGCoI602nNhJizdCiXutQQhh1z4wJRWbPavblytIJs0ANYKF2IN0wCiq+BwAgckHkNZXCld/yl5r5PkM7womQ0Yq5ECJsItoyeIu3SeBqk5Ps0qyFyBy8SOZz/kXy8qrGGIKMhMOXuIs5Gcl/0uoJknlG1jNpNO0mXN3MLgRfRQOHTTRd4zld8akiwh0hLGaCjOh0iWg1EoJyH81O0kJJoUuoJXgyhkvZQLQ6PmEv5Koj01+ibDFqeMT91VExXExHRneS4gGjNARrTRp7/JQ/p73Abr9quJBbaiVa9w8kGmXl5tIrwATGGxgRUHk1bujq7CoL4iIJa/ATs6LIlRA3kz+NDPkTG/0x+AGTcVy9TZMBzAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985640:9e6594b1902c2e0b2a7135254ed101778315c70b3d56ac76f8dd0c0ef05b6061', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzM0UxRDRFRjUxMTIxQzdGNDc1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MkY0Mw==', false, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (39, 'qrc_5DED744BA82A2B3343FDEA94EE1A1AAA', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985642', '2023-02-28', 'chr_A9A3E78486F7D6E8546A8844979B5652', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC2klEQVR4Xu2XTQ6kIBCFy7BgR1+AhGuw40p6Ae2+gF6JHdcg8QK6Y0GseThJ60xmFg3JZBZd6UXLZwTr51VJ/Dej3xfe9iVfUuxfEk9dyhML9rwzL4FINpDAu9dT0krGRxKbNFhpIDTwuiRzuDx4c0jdNZKgR4fHi6eLyjUTFotfn0RdyA9uJPCBmKV4sWEs86/e+ZQgPkEP1++XyH1MioklZJx997y5nyu1xFMv4+ioJ7NzfPh1LrCWwJJ5JTgj9pIPZ5qIj3h1sgLRnkkjx9/xqSOPpIfyRz+8wNqjhQTUnHglUtIcthx8byNKZuT1TJksrrVyDSTxK0APzCyzcmKzkIQG4sXCYrbrbM0rCE4371SQlIe0LsHs3jwtqvnyQQ1BTEIc7XpYJDVSUly5U0FS7JgmOFJCFYgoX6euIGGdiWfJs42TZxy8jWAfFAcNHsGBHvAmGwjnURaPYp/B83zzQQ1JmSiO0mwkIPCDv0f7c+Lx6qg2tDIECs64PFpDGPmSJ1ReQO5EJYsb6kmgCZ3HMjQenfaslQaSNBKmS7yRVpYmjxsbCJMi3Ts8vrw98mhpIRBRB62KvcNFpLPs6glqLpW+/fJQ+jIO3KvxY5LEjppLePsVe/byllUVJBBamXJmD2IPGHxuPqggpZVBiSEJ/MQtNx/UEI/sM9DmxefeZmX58k4FYd2TLnMihkSPsOurSiqI1yPyBWFBBkl+4n+5vZYgPiXaRBZxjuTi5Z0KguYDrfIGR0ZvXNgcroEknLSMrlOCKmiCd98nqCHicNhnReJ0njH43PL6c+JNmTqteUJHbR6JzuKrJbAyBaBWMPhnddOqGoIZ1kMGMIJhNzQf/daqGoK2j0GAoaOldouOyhaCrhi7FInQxzDJYqRtI+d3ySnzuIwPbiPQdaS2LJW32dI3Ggi+S06B5zxgvnDmUrEKcn6XKGsgz5ieVAlRA/mzfcmXFPufyQ+78yHXKdNNTwAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985642:9ee802be91053731a7efc5aed9bb59c6dcc3440e54852a5ca23cd4ea27585e9a', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzMzQzRkRFQTk0RUUxQTFBQUE1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0OUU2Qg==', false, 2, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (40, 'qrc_5DED744BA82A2B33AB705A0F6446C502', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985643', '2023-03-31', 'chr_A9A3E78486F7D6E8726EE8AFF655F9F4', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC00lEQVR4Xu2XQY6kMAxFXcoiO7hApFwjO64EFyjgAnCl7HINJC4AuywiPN90q6BHM4tKpNEsKmq1VLxSJfG3vw3x3xb9/uC1PuRDZP1L4ukReWgUe96Z50CkC0jg3dNTp0ovdVSbtnhSQKiLVEd7NKnz9tDmUUj88nTUBzU0S9UUE7m6HYgeIdVcSBCDddJqZMt4zD+j8y6BPsF0198P5d4mshCAdWe1e96a7yeZxFNLIPhvd15q3EBgLmGqGjU4BGNpNR+NLSN2hM5acVATmUdML32yiKm0CM7e1F7hWV1CAn4YIlOl7eHk4HsJYdQH8ponSuTObZsCEtcx2pnthCJu1OaQ4wXEm2djnm6dnISW4xWDHBLtiApu7O7t4KgLVwxyCK8o4kdcD4ekxlfUlTsZJCaSU0NzNXsiStepM0ig3iO17eSW3jMOXkS8Og8L/4M48APedAGBOUUF58M+nefpHp0MEhLMadJ2IwWD7/y9St4nUa6+SytDEeMrt1hnkIC2g9qFmyJ3lkpLGPJJhD5IbQuPR6c9a6WEGCQMWvdGpnKifP/aJ4NInUFw/LzcfqKrgnOIt5tbHnFp5bALnWWXT+ArJNY+ejvGdY53j3+fBB4hOBqaRymbVt+yKougaQ/O7kHtwfTxFp0cspx+QD1jIqPqFoMcIh4vA8XsU+tSBbNvCoiUSOpRIph6vGkb84pBDokWgosshHDygNyRzXMJcgcxaIgcdEY8lntWvU1iqmidsZU36I2zhKSEwIkhOHROfTCkLb/2ySHqwD6YxTALeGTlpU8OQQwIGY0ZVh0uPYnO4sslAjFNyJy4yRvA5VU55NtBMfWoCc0WwXgpl0HQ9mPCScdzChMf1SVE3iTgVUToYzLPtoUkJHg8NB/l41JzIaE+miduj6A66RsFBOMS3AXvN6kLGNXtzcXeJ6KP5M7XcFGJRAXkz+tDPkTW/0x+AbFsIlW5QrWeAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985643:bf085fe32d2e56a8e5472b6bb37dee42189f837ac21c4902fc7d88bc423d60bf', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzM0FCNzA1QTBGNjQ0NkM1MDI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NTlCNA==', false, 3, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (41, 'qrc_5DED744BA82A2B339BB343B5B60D6D8B', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985644', '2023-04-30', 'chr_A9A3E78486F7D6E8C3959C998D80AB94', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1UlEQVR4Xu2XQc7bIBCFx2LBzr4AEtdgx5XsC8TJBZwrseMaSL6AvWOBPH2TSrFbtYuAVHUR9OtXzCfZ8IZ5MxD/bdDvE+/xJV8i41+SQF1e715x4J35GYl0A4m8x/Ug0+s0ZLVpi5kGQhPbxfHhyxTsoU3XSAKmaY7q7lPvmwmvz8B3oi6WgRsJNIAA6sGWMc2/qvMpQXyimc6/XyL3McHINMV1Z7UH3vzPqVoSaNQrFB3J7pyGsC4Ca0ksc7SPjB9p1AiUbSJh3XPqeOWoFjJdLu/41BBkBpspWw5mCApzQwvJdo9IO+q1PZwsfG8i1FO5YetUyOHZ9L6BBDPqNCPtdOm92hwsoYHwupA63Lo4+4gKnz3VqSCZOjZDtHuwd4cjedXgcxLWQ8t3DodDnW5eXc5OBeFHBpQkfgYiKu9VV5HSO2jJi0szPMadGtQQ5s2Zm4f/ITjwA950A4mpl3fDmBMMdbloUEWwb7VouyHm2kzhXHUNyXB3mqWUKTgozmMbQdkRr+oizk7qtchQTzjNksEMj0elfeVKAxENTAc/RrF1WD420ULgVWn0eL3sfqEzg2tITig4jwyIh0SvtKsnocxBwdofAU6/PvPF4ysIy4ux8DnA5uFblyypIZIio4M3KxTwOV+cr4agYyoDwsJ899RfNKghKDtRNHiGMsIYHJ/q1BDkhz3QJ6Kswe+9eWtQRaRJHBAWgpzooaBuA+EyahGVHOKcyKdTnQoSUAzR2UEDg9r4lB00EOQulqwRZ7QqhrR9d3ZVBIYHl1pxcDqpHmd8akiAqaz4f5d6W25Er+SrJRixkFf760j2VxerINLDIn3RgincADaI8Y5PBUHZzziA8FHJXfFR3UJQFeHKSaqQdLJoaRtJuXmUC3wKj2ngRpImeAx2D1Gd1I0GgnYJ38H9puAGsMAYLop+TCBAQK2wjJ4CNzAJUQP58/iSL5HxP5Mf5rszUBZp+wsAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985644:53825266aafe295ef32493bbe47334692f3232ae8a50eb96c4ce75f7dd76a780', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzMzlCQjM0M0I1QjYwRDZEOEI1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0NTc5Qg==', false, 4, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (42, 'qrc_5DED744BA82A2B33DC7DFD9ED7E4BA70', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985645', '2023-05-31', 'chr_A9A3E78486F7D6E8EBE1772350F429F1', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACz0lEQVR4Xu2WMa7jIBCGx6Kgsy+AxDXouJJ9gdi5gH0lOq6B5AvYHQXK7D9+UpK32i0eSKstgtyYzwrkn5l/hvhvi37feK4P+RBZ/5IE6riQVxz4ZN4ikW4gkc9obs70Og1ZHdpip4HQlHlj+/BlCvahTddIYro5/LxafOp9M+EyYJuoi2XgRsJnoF5DV8vY5m/q/JggPtFMr+db5H5MrnXHaazOwIf/2qglgUZdek8j2ZPTEPZVYC3J1NPOGWKkUfPD2zaSupi6rBDtlUyXyzM+NYTLTe6L65shKOwNLSTzXR67avtwcvGzhcSCpH54XLmQw7vpfQPJafRpYJyDKKnDwRIaSFBb3FeHx96jQrieGtSQCAF2BPkMdnGo5jcNaki6wVEAHZI63SCGbyGlC1ACzqe2QETldesKAie+Qr26NAfGxZtI2E82N09TQHDgB3zoBpLLEPDbcs4UeH3ToIbEQsS49UEKBj/JVy0Ef32/WhmKGJ+8aV1BQkLHGMRNkTup1yJDPYlmjmJRdxZXuGqlgbAhnVC7B5ne0RxofuZBDVEPMmhovZd/v9KrgmtIRh9DlcAV8IIDpezqieS1VPA9WJSy5Lh8UksCGrXFaRLzaEb9ViUVRA6BE9gzKgw+c37ToILgspwkMsyLp/5NgxoCE9WW2W6hjK70jl81V0UWjWpDH+MtmNGbV/1UEE7zV1gIcvKC3JHNarIfrsCryCHOiXx65U4NQSuDH0MDg1q5xs8GknnRMrrOucwR9Wefk10VgZz7Bm+OBq0DE8HLYStIQFdUqJIFPgoxiK7iqyUCC3ojfPSAUb17VQWBgwbMJhjB1ArH0mKE9QRtP5cJY+w1hYmP6haCIiN4FRH6GCZZjLRtJCAT0S5wFF6RSo2Ehmwwp8wQ1V0TaD3BuCSKDlwmeIO3T6+qIdIVkTUWIx6mp15C1ED+vD7kQ2T9z+QXLtRObran0EgAAAAASUVORK5CYII=', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985645:525834ccb0dcb9c8b1552f8c35f532d5aa3ed8a838a9affc5f624987468938d2', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzM0RDN0RGRDlFRDdFNEJBNzA1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0Q0RGRA==', false, 5, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (43, 'qrc_5DED744BA82A2B3308DD9D0954E9F06A', '', 'https://pay.juno.com.br/checkout/1770AEA5443A588D8DAE37F132D73FD652AE20CABBC52FC6', '550985646', '2023-06-30', 'chr_A9A3E78486F7D6E888A9E7D312117AAD', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACy0lEQVR4Xu2Xu63jMBBFR2DATGqAANtgxpakBiy7AaklZmyDgBqQMgaEZu/4AZbfYjd4JLDYwIQh2HMMfuZzOSL+26DfDa/xIR8i41+SQF025BUHPpjXSKQbSOQjljmbXqchq11bWBoITZlXtqcvU7CnNl0jCXw6TK/uPvW+mbBdYSbqYhm4kcAH1GOzbJmfzxaC+EQzXZ9vkfsxkSFzH6yOwLv/stSSQCOZIeJpD05D2BaBtYRhNjcHZ6RR8+ltG0lTKB0rRHsh0+Xyik8dmSPv+BbMEBRsQwsJhgjr2EXb08nGjxbC6nTI622hQvAEm943kGzvngZZp/Re7Q6S0EAiypd6rOPsIyrOlw9qSIYB3B7B3h1NUjQNBIemRG6DJ3afbl69ZdXPSS6jhhnKp9ZAiNW16wrCfJLk8uLSHBgbbyOpY3Pz0D8EB3rAu24gocy8rdFiHQjq8uaDKmJIww12JwWBn8K3Kvkxiai5bZWrDEXMyMcmkkU7oVVdRO4kyPPURGiOBVr1YCifrHPVXA0ppLc70pBM72gO+GMDCQiOOhjTy+kXuiq4iiBrtkdOo2wW5SJlV0+ypDOk/RHsI29rvjS+ivAjm4Fx+o2jGfWbulSQuKHmdm8PeCKaOb8pXw1BfLBrmpkhqP2bD6qIaFWH6UMZXekdv3xQQ4LdHYoY9xigGb15+aCGRLppu0CuCO7kO3KHG8hTD6BV5BDnRD5dWVVDyhyhxxZbxt34bD8bSOY74qPRFOMvWNPylVUVRJ0eOSiJ0wVk5RWfGiLx2fC8Q0dduRE9i6+WCJQ3CejoDqF606oagh42QAbQgqkFiqXNpVUVBNd+LhNDR6V2RUd1C4FW4bUpEeEeQydLYyNBD+txXWAp/EwDtxHch9nccHo41cm90UD4+CpcLlNEq24vraogEh+IimX0FHgDkxA1kD+PD/kQGf8z+QVfvzE9Lfq+tQAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=550985646:66ec94bd0dce50a3bff5df0e8fa10c04c4d77bd7ddecd0ba2e74fee06909d133', 'https://pay.juno.com.br/charge/boleto.pdf?token=443552073:m:59fa38c27f83aaf92956a8c3ff95ea561ba9653ab999141268300155b0b93abb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvNURFRDc0NEJBODJBMkIzMzA4REQ5RDA5NTRFOUYwNkE1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0QkRDNg==', false, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (2, 'qrc_10A5AB76A519E412DAAF608C7CAFBCC9', '', 'https://pay.juno.com.br/checkout/00BE6895109499DBB421D59EC108549CB8D49D0FDFC35CB1', '508093191', '2022-12-22', 'chr_D062D569925082F55F7A0B65B1B914BB', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAAC1klEQVR4Xu2XMa7jIBCGx6Kgsy+AxDXouFJyATu+gH0lOq6B5AvYHQXy7D95Upy32i0eSKstgiIl4SvA/8z8Myb+26LfN17rQz5E1r8kgbpsOeMHH8xrJNINJPIRaIpqjWnIatcWOw2E7tkMrE5f7sGe2nSNJNLo5aiHT71vJrkMgR9EXSwDNxJoYEZSM1vGNn9X56cE8Ynmfn2+Re7HRJadoz1YHYF3/7VTSwLddBmi3QkwDWFbBFYTe7oyug25c9N8ettEcrnp1EXFUS1kulxe8akhsrbdl96ZISjsDS0kIHfUnJGPuL5c/GghnKZQRjw6FXL4a3rfQOKG4pjYrrH0Xu0OltBAsl30tji1OGSQ4nxpUEUggFo8wQweDkpcGtQQ+IorU+bTIanT6NUrd2pI3nadRqdOrdZAROW6dQ2xCHiPjHYIFOPibUQdeTs9IQ13Bz/gXTeQuLHksl1cugde3jSoIfLcqdfwA8hg7uG9Sn5OspnChgjDq+CgizhNAwm4LDweborcwYEiQz2JZYpIGQuPR6fFOVfNVZAMUydy206mdzRJ120gUrvm5mHG8vQLXRVcQ6KaA8ouPS+b6Fl29SQjr5GJdg52ztua3zy+hsDUNyjRhY1xff2WOxVEvtXu0a7VEQ2M4dKggrC5o0oQFuaHp/5NgxoSyvTUYA3l5tCF+Kq5CoLOw2nU6GO8BoTdXOpUkICWaCUsBDkxQ/HKDSQneCcmu9Ehzol8unKngjw1WHFUMOiNK9vTN5DMDy2j65RRyoa0fU12VQT9RwoFidMFnvNbfCpIsLuTWz9I2tpIdGshLHaFlggf3WFUb15VQ8RBJUQYxxY0W4jxik8FgbtnOOg2P6cw8VHdQjBN4LUJR8lkcYMGrcSMHu2CZ/mbBm4jEbOYGfH0ENVJ32ggGJeQ0fCYco9wevvyqhoi8UHWPGcKvIFJiBrIn9eHfIis/5n8Aic6M+AweLsUAAAAAElFTkSuQmCC', 'https://pay.juno.com.br/charge/boleto.pdf?token=508093191:6668c3c2d02dca803102ae924ec55151c469b260cc4c7f80e3866b67c81c53b4', 'https://pay.juno.com.br/charge/boleto.pdf?token=403038185:m:7e3a4ae80ba687ef8752c7dce503c66693506aa294258872c38461042cdb3eeb', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvMTBBNUFCNzZBNTE5RTQxMkRBQUY2MDhDN0NBRkJDQzk1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0MTAyRg==', true, 1, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (37, 'qrc_FCD5062B43A92AC445B9A21E1BA1183A', '', 'https://pay.juno.com.br/checkout/059CEC736EE151177BD73B55C53DE58E0E0ACAA0A5AFB79D', '527501545', '2023-06-10', 'chr_7F684D409F723A734FC3D3895D93258C', 'iVBORw0KGgoAAAANSUhEUgAAAMgAAADIAQAAAACFI5MzAAACzklEQVR4Xu2XTc7bIBCGJ2LBzr4AEtdgx5XsC3yOL2BfiR3XQPIF7B0L5Ok7qRq7VbsoSFUXQSiKeawA8/POhPhPg35deI8P+RAZ/5IEerBlVqfjg3mNRLqBRD5Cmbj0MfVZ7dpipYHQmKlz9vRlDPbU5tFIwnZ6mqJ6+tT5ZpJ5DfwkesTScyOBDTY5rNj19dlC4J9oxmv+5Lm/JjISbHmwOgLv/vtKLQk0EGyAT8DUh20RWEu4TCF9eVw9DZpPb5tI4JnVnNUa1ULmkcvbP3UEa0c2fcBUWOtbCJaxD9Og7enk4EcL4Y1hA8drLuTwaDrfQPK2E01sF106r3a88mOfGhILnLO4bXF2jorzzQYVJCNL6Msjj+3T0RgvG9QQNpCoOTOUb/cIInVFVQXJ2+uHkcQK0U1UrlNXkGAm5sXbNaQJGuNuUVVBotoJh0XOwTnQA951C7E48hrhIqgCNrxsUENCIkQ02Z0U9G8Mt/tUkAg9QPqKVkFBEY9NJJcRARgRhoid1GkxQz1hVB5k2zYztpJ9rmysIFjWhSgNZDpHU8CLLWQ7nYK0L15uv9Atg2uImiPPOb0Om+iVdi2EM1oAxLWd87bmS+OriIWIThm33ziaQd9ip4JkI1rl7QF5jmbKN02sIAytSlOElPLTo/G5bFBF5JhPiHEogyud40vFKkjgI4vG4+sazODN2wY1BOcVMZAyi1L2ROxwA2EzshGtcrBrIp8uG1QQtJyix4gdg9q4MuKohcAtECr4uUzRQLfenV0VUTKDBM4D3Uq+/FNDgt01khiVB+1/+SIaWojA8hChQuNfuruKVRD0sJjSgqkFxVabt1bVEJR9Loia+RXgoqO6haCbwD4JNlikQqIpayOvlgdpN8tj6rmNQNfR0OH2MKqTutFAoC6GPFyEsrZJc3Gz6F8T+V+CWmERjOieOnFRA/n9+JAPkfE/k2+hBUhZJMRUvgAAAABJRU5ErkJggg==', 'https://pay.juno.com.br/charge/boleto.pdf?token=527501545:330b9fa5db8f0b0c88fa2feaa1da40e671c6a1bb94744fff4000a9f6a7dad9fe', 'https://pay.juno.com.br/charge/boleto.pdf?token=421203814:m:e86ab6822a7d509c1c3de5e624bc580fb732b6780fbccbd7502e671ac16dde96', 'MDAwMjAxMDEwMjEyMjY3OTAwMTRici5nb3YuYmNiLnBpeDI1NTdwaXguZWJhbnguY29tL3FyL3YyL2NvYnYvRkNENTA2MkI0M0E5MkFDNDQ1QjlBMjFFMUJBMTE4M0E1MjA0MDAwMDUzMDM5ODY1ODAyQlI1OTI1QWxleCBGZXJuYW5kbyBFZ2lkaW8gMDU5MTYwMDdNQVJJTkdBNjIwNzA1MDMqKio2MzA0Mjk1OA==', true, 6, 50.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (44, NULL, 'chr_768702548F4144B8B3B143D07C7C26C2', 'https://pay.juno.com.br/checkout/AED1A16F7E80493B5D391D64263145BB85FEB4047EF56D0E', '589497771', '2023-03-07', 'chr_768702548F4144B8B3B143D07C7C26C2', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (45, NULL, 'chr_98C14771E1438CD7535CBFFC49857B0F', 'https://pay.juno.com.br/checkout/8BC110051A41DC962374EDF5F7BE891D139B94C50CA8D197', '589499515', '2023-03-07', 'chr_98C14771E1438CD7535CBFFC49857B0F', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (46, NULL, 'chr_A3C31FDBAA27FBD77F27F99CFD12E221', 'https://pay.juno.com.br/checkout/73756DCA8CB6BC9EF3BBAE9A583D600639D4FC4ADDD4B3ED', '589501737', '2023-03-07', 'chr_A3C31FDBAA27FBD77F27F99CFD12E221', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (47, NULL, 'chr_74ABF0D42DD941FC24BC7A37C17B585D', 'https://pay.juno.com.br/checkout/295F3A4C72EB7EFC9177A7CC73617257F6A05768D3E564AD', '589504942', '2023-03-07', 'chr_74ABF0D42DD941FC24BC7A37C17B585D', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (48, NULL, 'chr_E3499E02E0D0F5D7D69AE88CD4863125', 'https://pay.juno.com.br/checkout/AD7E8DC0A4739B37B8F202AEB43160CF2E9B9BC116F98F22', '589505125', '2023-03-07', 'chr_E3499E02E0D0F5D7D69AE88CD4863125', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (49, NULL, 'chr_17C1B17BE2399D530136754AE6DD7296', 'https://pay.juno.com.br/checkout/E4837BE2F840980312207B04EFF911A425F4CCFE11BE2545', '589505607', '2023-03-07', 'chr_17C1B17BE2399D530136754AE6DD7296', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (50, NULL, 'chr_A507F6B449E8CF7CF5C4F63B2F04BF71', 'https://pay.juno.com.br/checkout/0E24C0D31133BA6741BC13CB414CEB7D7643682700F63A3C', '589509352', '2023-03-07', 'chr_A507F6B449E8CF7CF5C4F63B2F04BF71', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (51, NULL, 'chr_2B672F3E810E2A83A2E3F905E3040F46', 'https://pay.juno.com.br/checkout/A3B9029A62121DFA7E891C3BF21E0BE1EF01BBBE3E5B4D8D', '589517317', '2023-03-07', 'chr_2B672F3E810E2A83A2E3F905E3040F46', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (52, NULL, 'chr_DCFA4331832A2ABFC3EDD14C1687AA8E', 'https://pay.juno.com.br/checkout/DE9C8FF7388A717FACFC00E373937F8AB6CDD2CBC5913282', '589519437', '2023-03-07', 'chr_DCFA4331832A2ABFC3EDD14C1687AA8E', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (53, NULL, 'chr_51E472B9A37B09A1A099AABBBA17F4A2', 'https://pay.juno.com.br/checkout/6A30C8A8FE98C8F6F5043BEEF3FF07B2EB34E2ED1BD3EAD5', '589521001', '2023-03-07', 'chr_51E472B9A37B09A1A099AABBBA17F4A2', NULL, NULL, NULL, NULL, false, 1, 1.00, 13, 18);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (56, 'pay_4216354126858526', 'pay_4216354126858526', 'https://www.asaas.com/i/4216354126858526', 'pay_4216354126858526', '2023-06-06', 'pay_4216354126858526', '', 'https://www.asaas.com/i/4216354126858526', NULL, '', true, 1, 5.00, 13, 15);
INSERT INTO boleto_juno (id, id_pix, chargeicartao, checkout_url, code, data_vencimento, id_chr_boleto, image_in_base64, installment_link, link, payload_in_base64, quitado, recorrencia, valor, empresa_id, venda_compra_loja_virt_id) VALUES (58, '', '', 'https://www.asaas.com/i/0307489281813731', 'pay_0307489281813731', '2023-06-19', 'pay_0307489281813731', 'iVBORw0KGgoAAAANSUhEUgAAAYsAAAGLCAIAAAC5gincAAAOM0lEQVR42u3ZQZIjNxADwPn/p+0f7EUsoMhOXHtWUpOspMP4+09EZGv+LIGIEEpEhFAiQigREUKJCKFERAglIkIoESGUiAihRIRQIiKEEhEhlIgQSkSEUCJCKBERQomIEEpECCUiQigRIZSICKFERAglIoQSEVku1F8q//7euV91cHHuOBw/LOzBkxP7kQdfYe4wHJyU2IQSilCEIhShCEUoQhGKUIQiFKEIRShCEYpQHxZqyagcPJQHNyk2hHMvGFvYJRdSbIBbc7T0kwlFKEIRilCEIhShCEUoQhGKUIQiFKEIRainhIq1dQ/UZHOvv1PVmJut/Z2j8MabnlCEIhShCEUoQhGKUIQiFKEIRShCEYpQhCJU/P1jxVBrrZYszkEZYwbFCrgYo63TTihCEYpQhCIUoQhFKEIRilCEIhShCEUoQhHqqvffeQp38n3QzVh12zoqsaIz9pRQhCIUoQhFKEIRilCEIhShCEUoQhGKUIQi1IBQLftaHxWbnLnaqPVRV7STS+C4YkIJRShCEYpQhCIUoQhFKEIRilCEIhShCEWoDwv1QPXjqacPP41NKKE89dRTQhHKU08JRShCeeopoQjlqaeE+pJQrcx1TL9sQ6wYer5FmrvMDv7bVqU4R8OW6SYUoQhFKEIRilCEIhShCEUoQhGKUIQiFKGeEirW1h385IOOtIQ6OGZ3VD+pOyYGVmwHYwtLKEIRilCEIhShCEUoQhGKUIQiFKEIRShCfUmouXeYq2DmRrQ1V0teYUk9d2PTd8X1TChCEYpQhCIUoQhFKEIRilCEIhShCEUoQhFqoGRpGTR37JYsXcuCuTJrbn/fIym27IQiFKEIRShCEYpQhCIUoQhFKEIRilCEIhSh8v+3f0clcUWp9J65DxykJY3qknEmFKEIRShCEYpQhCIUoQhFKEIRilCEIhShLheqtRytGqV1OJYgGxv+VpkV+81zH3XF4hCKUIQiFKEIRShCEYpQhCIUoQhFKEIRilBvCTUHR6tjarl5cNpbvVjrbMRG9Io/njvPuYKVUIQiFKEIRShCEYpQhCIUoQhFKEIRilCEukyouZLll0+OdR+t1di5gztxP3ghtd4otgux/ywgFKEIRShCEYpQhCIUoQhFKEIRilCEIhShPixUq6+Z26Q5kpac0bndnyuV5k7dzgtpSUdMKEIRilCEIhShCEUoQhGKUIQiFKEIRShCEWq+U9t5+ufOWcv62O21pGFsDeGcI7Gq+souj1CEIhShCEUoQhGKUIQiFKEIRShCEYpQhCoIdfDYzU3sQRpin9ySIlZ1zV1IsQGeu9uW3F4vdHmEIhShCEUoQhGKUIQiFKEIRShCEYpQhCJU4fTPsXJFjTK3GrFbZO6ozDHaukSXbIouj1CEIhShCEUoQhGKUIQiFKEIRShCEYpQhJoXqqXbFQ3FznJnLrGZjBWsrf09eDZilyihCEUoQhGKUIQiFKEIRShCEYpQhCIUoQj1YaHmWJnbhrm5WtKLLXmFWD03x3esrWsxuhMsQhGKUIQiFKEIRShCEYpQhCIUoQhFKEIR6nKhYtu/c1fmXn/nIB18hStKtFiD3KJw7mwQilCEIhShCEUoQhGKUIQiFKEIRShCEYpQXxIqxtmNNUrM3IPLHqsjd958sSunNWWxsSIUoQhFKEIRilCEIhShCEUoQhGKUIQiFKE+LNTcOYtNXWu/5+CINYy5A10y94qD1OKMUIQiFKEIRShCEYpQhCIUoQhFKEIRilCE+pJQsZMUKztaf3yQhtjixMxt3QSt+jW2zq22jlCEIhShCEUoQhGKUIQiFKEIRShCEYpQhHpaqCWVxMERbZU7MbCW/NtYdbtku28cnFjTRyhCEYpQhCIUoQhFKEIRilCEIhShCEUoQl0u1JJyJ1YbxTq1WAH3tVe4oheL3V6xOpJQhPIKhCIUoQhFKEIRilCEIhShCGW8CUWot4RaUlfFdJsrO3YWYUuqzF++d0lbF/MrFkIRilCEIhShCEUoQhGKUIQiFKEIRShCEYpQAy3Dwadzvzl2gudKpZ187yxn53qxJRf/wcEhFKEIRShCEYpQhCIUoQhFKEIRilCEIhShCBWvuq6ob2ID3KKw1V7deMzmerGD9MdKUkIRilCEIhShCEUoQhGKUIQiFKEIRShCEerDQs0djtbRmat+5kq0G72ONbmtw7/zPo6Vd4QiFKEIRShCEYpQhCIUoQhFKEIRilCEItRbQs3t2Xvz3NK8taGtUmnJqYs1bkvsIxShCEUoQhGKUIQiFKEIRShCEYpQhCIUoT4s1NyxW7L9V9RVc27u3IXWss8N8MEXjF1mhCIUoQhFKEIRilCEIhShCEUoQhGKUIQi1IeFag3hXPfRmqu5X9UqwpYQ3CqkWn3c3K+KLSyhCEUoQhGKUIQiFKEIRShCEYpQhCIUoQh1m1CxCqbVA+6sYJasRkvVuQKuhXtsF2J9HKEIRShCEYpQhCIUoQhFKEIRilCEIhShCEWoeAexZINbrLRO/5wFrT9ecnnPzeAVfhGKUIQiFKEIRShCEYpQhCIUoQhFKEIRilCXC9XKwe0/eHSWzHOr29pZoc7duDvPxtyyE4pQhCIUoQhFKEIRilCEIhShCEUoQhGKUISKj3esdFjyUa2WcG67n+/U5jri1iXa0o1QhCIUoQhFKEIRilCEIhShCEUoQhGKUIS6Tai5hX5gJneelVYtOLewc6y0lv29i59QhCIUoQhFKEIRilCEIhShCEUoQhGKUIQi1Dwcc1XIwRe84hS2LpUWdjvLu1hi9BOKUIQiFKEIRShCEYpQhCIUoQhFKEIRilBPC/XAqLTKjtg8x5a91U7GWrNWhTonxU6/CEUoQhGKUIQiFKEIRShCEYpQhCIUoQhFqNuEatVzz89V7HDsLLOW3IsHN2Vnr71kuglFKEIRilCEIhShCEUoQhGKUIQiFKEIRainhTo4hHNN38GT1AI6NrGtEY3dT62Pio1V7JgRilCEIhShCEUoQhGKUIQiFKEIRShCEYpQHxYqVtAs6XrmxnvJAM8JNVdlxtZq7l6cO4Sts0EoQhGKUIQiFKEIRShCEYpQhCIUoQhFKEI9LVSrFow5EkMn1ri1dmGujmxt95Ij2gKaUIQiFKEIRShCEYpQhCIUoQhFKEIRilCEItT8SdrZ5S0Z7xtf4eB2t5qvJejELrP3uzxCEYpQhCIUoQhFKEIRilCEIhShCEUoQhGqQFKrVWmVSrGKbW7ZY+u8pJ08uKGtpm+JqoQiFKEIRShCEYpQhCIUoQhFKEIRilCEItSXhNpp0Fxd9UDHtBOOndVtq627sZwlFKEIRShCEYpQhCIUoQhFKEIRilCEIhShCDXQfcRGNFZ2tIq/nXXVXFnZImluj5bcmrlbhFCEIhShCEUoQhGKUIQiFKEIRShCEYpQhLpbqFi3FZMi9lE766ol+xub9p13auyeaDFKKEIRilCEIhShCEUoQhGKUIQiFKEIRShCXS7UweWIrfuS7jK2krGZbH1Rq7ptzVHr1OWmjFCEIhShCEUoQhGKUIQiFKEIRShCEYpQhLpMqJgjB2fjYD81d4KvKBxv/JGxLZtTZucXEYpQhCIUoQhFKEIRilCEIhShCEUoQhGKUIQaqEJiUrSKkrlftROdg2MWu4FqI5r6GbFzRShCEYpQhCIUoQhFKEIRilCEIhShCEUoQj0tVGtiWzO580c+sBpLWuBY/9gqlFt9OqEIRShCEYpQhCIUoQhFKEIRilCEIhShCPW0UK39XlLBLDnBsTeKFX9zC/s80EvuVEIRilCEIhShCEUoQhGKUIQiFKEIRShCEYpQN2MXG4bWqCzpiWK6LfFrrtqL1aBzs08oQhGKUIQiFKEIRShCEYpQhCIUoQhFKEJdLtSSYWj1YrFPjv2qVv94cJBaFiy5vGNgEYpQhCIUoQhFKEIRilCEIhShCEUoQhGKUISKz9XOPZvz+gpzY8seQyfWxsZ63rmTQyhCEYpQhCIUoQhFKEIRilCEIhShCEUoQhEq3se1lnJn4diq52IbOreSsVowNmWxti73voQiFKEIRShCEYpQhCIUoQhFKEIRilCEItRTQi3pxXbWka21ai3dzrJyrgfc+Qpzv4pQhCIUoQhFKEIRilCEIhShCEUoQhGKUIQiVPxwLHkaa5FiXU9MmdjExkjaeXnP7RGhCEUoQhGKUIQiFKEIRShCEYpQhCIUoQhFqHbm+oudlWKrb21Ve0tOTouGWOPWuo8JRShCEYpQhCIUoQhFKEIRilCEIhShCEWot4T6S+UK+345hTEoY3VVa3Fa57l1x+zspglFKEIRilCEIhShCEUoQhGKUIQiFKEIRagPC7Xkk1sly86lmzvfS26vFtCxHjDW5RGKUIQiFKEIRShCEYpQhCIUoQhFKEIRilCEajdfscmZ68Xmzujc9y75VbFTt/OPn98yQhGKUIQiFKEIRShCEYpQhCIUoQhFKEIRilBxoZbMc8zN3NEp7eCNXe1cLRgrlHV5hCIUoQhFKEIRilCEIhShCEUoQhGKUIQi1ENCzVlwRUHTOnZzvdgco7FebMnizB1vQhGKUIQiFKEIRShCEYpQhCIUoQhFKEIRilDtT44drFZdtbPZXFIatmrQOQpj9yKhCEUoQhGKUIQiFKEIRShCEYpQhCIUoQhFqIGTNCdFi9Gdo7Kzjox5fWMr+kDDSChCEYpQhCIUoQhFKEIRilCEIhShCEUoQhFKRIRQIkIoERFCiYgQSkQIJSJCKBEhlIgIoURECCUihBIRIZSIEEpEhFAiIoQSEUKJiBBKRAglIkIoERFCiQihREQIJSKEEhEhlIgIoUTknvwPED16aeux4KcAAAAASUVORK5CYII=', 'https://www.asaas.com/i/0307489281813731', 'https://www.asaas.com/i/0307489281813731', '00020101021226640014br.gov.bcb.pix2542pix.asaas.com/qr/cobv/pay_03074892818137315204000053039865802BR5920Alex Fernando Egidio6007Maringa61088702575862070503***6304CB81', false, 1, 10.00, 13, 15);


--
-- TOC entry 2410 (class 0 OID 140276)
-- Dependencies: 183
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (106, ' fdfd fd fdf', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (8, 'eltronico', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (9, 'eltronico', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (10, 'eltronico', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (11, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (12, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (13, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (14, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (15, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (16, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (17, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (18, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (21, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (23, 'eltronic455454', 2);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (24, 'eltronic455454', 2);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (25, 'eltronic455454', 2);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (26, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (27, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (28, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (29, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (30, 'eltronic455454', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (31, 'sdsdsdsdsdsdsds', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (32, 'sdsdsdsdsdsddddsds', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (33, 'sdsdsdsdsdsddddddsds', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (34, 'sdsdsdsdsddddsddddddsds', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (35, 'sdsdsdsdsddddsddddddsds sdsf ', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (36, 'sdsdsdsds778777dddsds sdsf ', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (20, 'VESTUARIO', 1);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (37, ' teste update categoria 5454545 sdd sdsd', 2);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (107, 'd fdfd fd fd fdf', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (108, 'ds sd sd sds', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (105, ' dfdfdfdfdf f', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (86, ' sd4d6 s6464sdsds d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (87, ' sd4d6 s6464sdsds d f', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (88, 's fd8f4d4f df', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (89, 'sdsdsd', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (91, 's s dff df d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (92, 'dwrwewreree ere er ', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (38, 'dfdfdf  sfdfd d d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (39, 'veio do angualr d d d d d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (44, 'fgfgf  fsfsf ', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (40, 'dsdsdssd dfdf ', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (46, 'dfdf dfd  edutado', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (95, 'hh', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (80, ' sdsd sds ds sd sd sfs ss s', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (48, 'dddddddddddddd sds s sss', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (99, 'sdsd sd d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (100, 't  f gf gfg', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (101, 'dsddddd', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (102, 'fddfd f d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (90, 'sds dsdsd s d d', 86);
INSERT INTO categoria_produto (id, nome_desc, empresa_id) VALUES (104, 'sddf', 86);


--
-- TOC entry 2411 (class 0 OID 140279)
-- Dependencies: 184
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (12, 'compra de 15 iphone pro max', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, NULL, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (14, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (15, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (16, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (17, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (18, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (19, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (20, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (21, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (22, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (23, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (24, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (25, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (26, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (27, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (28, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (29, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (30, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (31, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (32, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (33, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (34, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (35, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (36, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (37, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (38, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (39, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (40, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (41, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (42, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (43, 'compra de 15 iphone pro max ddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (44, 'compra de 15 iphone pro max dddd ', NULL, '2022-10-09', 'ABERTA', 5.00, 150.00, 99, 8, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (46, 'conta pagar compra estoque iphone', NULL, '2022-10-09', 'ABERTA', NULL, 150.00, 99, 13, 8, NULL);
INSERT INTO conta_pagar (id, descricao, dt_pagamento, dt_vencimento, status, valor_desconto, valor_total, pessoa_id, pessoa_forn_id, empresa_id, data_pagamento_conta_pagar) VALUES (47, 'conta pagar compra estoque iphone 2 ', NULL, '2022-10-09', 'ABERTA', NULL, 150.00, 99, 13, 8, NULL);


--
-- TOC entry 2412 (class 0 OID 140285)
-- Dependencies: 185
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2413 (class 0 OID 140291)
-- Dependencies: 186
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2450 (class 0 OID 186006)
-- Dependencies: 223
-- Data for Name: cupom_desconto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2414 (class 0 OID 140294)
-- Dependencies: 187
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (25, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 81, 81, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (26, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 82, 82, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (27, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 83, 83, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (28, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 84, 84, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (102, '56555', '01002001', 'Maringá', NULL, '65656', ' rua são joão', 'ENTREGA', 'BR', 135, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (44, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 93, 93, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (45, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 94, 94, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (46, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 94, 94, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (47, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 95, 95, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (85, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 126, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (87, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 127, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (88, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 128, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (61, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 102, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (62, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 102, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (63, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 103, 103, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (64, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 104, 104, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (65, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 105, 105, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (66, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 106, 106, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (68, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 108, 108, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (69, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 109, 109, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (70, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 110, 110, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (71, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 111, 111, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (72, 'Jardim Dias I', '87025758', 'Maringá', '', '356', 'Rua Pioneiro Antônio de Ganello', 'COBRANCA', 'BR', 112, 112, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (73, 'Presidente Kennedy', '60357240', 'Fortaleza', '(Cj Pres Castelo Branco)', '356', 'Quadra E', 'COBRANCA', 'BR', 113, 113, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (76, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 122, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (77, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 122, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (78, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 123, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (79, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 123, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (80, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 124, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (81, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 124, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (82, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 125, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (83, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 125, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (89, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 128, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (90, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 129, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (92, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 130, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (93, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 130, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (94, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 131, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (95, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 131, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (96, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 132, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (97, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 132, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (98, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 133, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (99, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 133, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (101, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 134, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (104, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 136, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (105, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 136, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (106, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 137, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (107, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'asasasdsdsdsdasassa', 'ENTREGA', 'BR', 137, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (100, '56555', '87025950', 'Maringá', NULL, '65656', ' pioneiro antonio', 'COBRANCA', 'BR', 134, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (91, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', ' rua são joão', 'ENTREGA', 'BR', 129, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (103, 'dsd', '87025950', 'Maringá', NULL, '65sddsds656', 'rua são joão', 'ENTREGA', 'BR', 135, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (84, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 126, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (13, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 71, 71, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (14, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 72, 72, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (15, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 74, 74, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (16, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 75, 75, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (18, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 77, 77, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (19, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 77, 77, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (20, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 78, 78, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (21, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 78, 78, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (22, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 79, 79, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (23, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 79, 79, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (24, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 80, 80, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (118, '5656', '87025758', '6565', '56565', '5665656', '54545454545455454', 'COBRANCA', '6565', 157, 86, '656656');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (86, '56555', '87025950', 'Maringá', NULL, '65656', 'asasasasassa', 'COBRANCA', 'BR', 127, 13, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (36, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 89, 89, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (37, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 90, 90, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (38, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 90, 90, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (39, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 91, 91, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (40, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 91, 91, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (41, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 92, 92, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (42, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 92, 92, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (43, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 93, 93, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (121, '45454', '55430970', '5454545', '54554', '545454', '54544554ddd', 'COBRANCA', '5545454', 157, 86, '54545');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (122, '54545', '87025778', '5454', '545454', '54545', '46545454 editado', 'COBRANCA', '4554', 157, 86, '545');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (123, '5454', '55415970', '545', '4545', '544545', '7446545545445', 'COBRANCA', '4545', 157, 86, '454');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (29, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 85, 85, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (30, 'jd dias', '7878787', 'maringá', NULL, '356', 'av brasil', 'COBRANCA', 'BR', 86, 86, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (31, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 87, 87, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (32, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 87, 87, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (33, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 88, 88, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (34, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 88, 88, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (35, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 89, 89, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (48, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 95, 95, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (49, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 96, 96, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (50, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 96, 96, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (51, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 97, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (52, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 97, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (55, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 99, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (56, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 99, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (57, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 100, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (58, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 100, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (59, 'Jd Maracana', '7878778', 'Curitiba', 'Andar 4', '555', 'Av. maringá', 'ENTREGA', 'BR', 101, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (60, 'Jd Dias', '556556565', 'Curitiba', 'Casa cinza', '389', 'Av. são joao sexto', 'COBRANCA', 'BR', 101, 97, 'SP');
INSERT INTO endereco (id, bairro, cep, cidade, complemento, numero, rua_logra, tipo_endereco, uf, pessoa_id, empresa_id, estado) VALUES (124, '545454', '55770971', '545454', '54545', '545445', '4454554 ed', 'COBRANCA', '5454', 156, 86, '54545');


--
-- TOC entry 2448 (class 0 OID 158770)
-- Dependencies: 221
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES (1, '1', 'Linha de Base Flyway', 'BASELINE', 'Linha de Base Flyway', NULL, 'null', '2022-03-15 14:50:34.510324', 0, true);


--
-- TOC entry 2415 (class 0 OID 140300)
-- Dependencies: 188
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO forma_pagamento (id, descricao, empresa_id) VALUES (1, 'pagamento cartão', 13);


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 231
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 12, true);


--
-- TOC entry 2416 (class 0 OID 140303)
-- Dependencies: 189
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2417 (class 0 OID 140309)
-- Dependencies: 190
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO item_venda_loja (id, quantidade, produto_id, venda_compra_loja_virtu_id, empresa_id) VALUES (1, 5, 1, 17, 13);
INSERT INTO item_venda_loja (id, quantidade, produto_id, venda_compra_loja_virtu_id, empresa_id) VALUES (2, 5, 1, 18, 13);
INSERT INTO item_venda_loja (id, quantidade, produto_id, venda_compra_loja_virtu_id, empresa_id) VALUES (3, 4, 15, 18, 13);


--
-- TOC entry 2418 (class 0 OID 140312)
-- Dependencies: 191
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (1, 'Apple', 8);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (2, 'ddd', 8);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (3, 'ddd77', 8);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (4, 'ddd75557', 8);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (7, 'marca teste update', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (12, 'dsdsd sd sd sd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (13, 'dsds ds ds dsd sd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (14, 'ds ds ds ds ds s dsd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (15, 'dsdsdssd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (18, 'dfdfdfdfdfdfdff', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (20, 'df df df df ', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (22, 'dfd fd f', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (26, 'dsdsd sd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (27, 'sdsdsd', 86);
INSERT INTO marca_produto (id, nome_desc, empresa_id) VALUES (28, 'sdsds ', 86);


--
-- TOC entry 2419 (class 0 OID 140315)
-- Dependencies: 192
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (7, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (8, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (9, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (10, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (11, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (12, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (13, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (14, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (15, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (16, '2023-03-04', NULL, '4545454', 'abc', NULL, 4545.00, 150.00, 12, 8, 8, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (18, '2022-02-01', NULL, '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (19, '2022-02-01', NULL, '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (20, '2022-02-01', NULL, '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (21, '2022-02-01', NULL, '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (22, '2022-02-01', NULL, '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (23, '2022-02-01', 'pacote iphone', '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (24, '2022-02-01', 'pacote iphone', '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (25, '2022-02-01', 'pacote iphone 2', '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (26, '2022-02-01', 'pacote iphone 3', '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (27, '2022-02-01', 'pacote iphone 4', '45455454', 'AB', NULL, 787.00, 45.00, 12, 8, 13, NULL);
INSERT INTO nota_fiscal_compra (id, data_compra, descricao_obs, numero_nota, serie_nota, valor_desconto, valor_icms, valor_total, conta_pagar_id, pessoa_id, empresa_id, valor_desconto_nota_compra) VALUES (28, '2022-02-01', 'pacote iphone 8', '45455454', 'AA', NULL, 787.00, 45.00, 12, 8, 13, NULL);


--
-- TOC entry 2420 (class 0 OID 140321)
-- Dependencies: 193
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (6, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 10, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (7, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 11, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (8, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 12, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (9, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 13, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (10, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 14, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (11, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 15, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (12, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 16, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (13, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 17, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (15, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, NULL, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (16, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, NULL, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (14, '31190307586261000184550010000092481404848162', 'sdsdsdsdsd', '4544', 'sdsdsdsd', '55454445', 13, 10, NULL, NULL, NULL);
INSERT INTO nota_fiscal_venda (id, numero, pdf, serie, tipo, xml, empresa_id, venda_compra_loja_virt_id, venda_compra_loja_virtualid, chave, vd_cp_loja_virt_id) VALUES (19, 'e644b1f2-3327-49ef-b5e3-df426bfa9fef', 'https://nfe.webmaniabr.com/danfe/41230426934453000189550010000000071924977109/', '1', 'nfe', 'https://nfe.webmaniabr.com/xmlnfe/41230426934453000189550010000000071924977109/', 13, 18, NULL, '41230426934453000189550010000000071924977109', NULL);


--
-- TOC entry 2421 (class 0 OID 140327)
-- Dependencies: 194
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO nota_item_produto (id, quantidade, nota_fiscal_compra_id, produto_id, empresa_id) VALUES (4, 50, 21, 1, 8);
INSERT INTO nota_item_produto (id, quantidade, nota_fiscal_compra_id, produto_id, empresa_id) VALUES (10, 50, 21, 15, 8);


--
-- TOC entry 2422 (class 0 OID 140330)
-- Dependencies: 195
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (100, 'alex.fe89989r99nando.egidio@gmail.com', 'Alex fernando', '45999795800', '173.512.910-04', NULL, NULL, 97, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (101, 'alex.fe89989r9559nando.egidio@gmail.com', 'Alex fernando', '45999795800', '966.970.320-49', NULL, NULL, 97, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (102, 'alex.fe85549989r9559nando.egidio@gmail.com', 'Alex fernando', '45999795800', '713.482.980-49', NULL, NULL, 97, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (99, 'alex.fe89989rnando.egidio@gmail.com', 'Alex fernando egidio', '45999795800', '309.513.620-03', NULL, NULL, 97, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (119, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '05916564937', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (120, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '42805935071', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (121, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '91550286080', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (122, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '59660793073', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (123, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '17874036026', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (124, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '81870630092', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (125, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '99523846027', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (126, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '07318695088', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (127, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '09863129089', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (128, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '01441612068', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (129, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '23884453025', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (130, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '88258860046', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (131, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '56973885004', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (132, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '28187264098', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (133, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '26753604065', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (134, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '83676274075', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (136, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '81820105008', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (137, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '87878787887787', '08385511067', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (135, 'alex.fernando.egidio@gmail.com', 'alex fernando egidio', '45999795800', '05916564937', NULL, 'FISICA', 13, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (146, 'alex.testeintegrator@gmail.com', 'alex egidio', '8486684645646', '629.394.490-90', NULL, 'FISICA', 1, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (148, 'dsdsdssd@gmail.com', 'alex', '55656565666', '77211190060', '1987-10-13', 'FORNECEDOR', 86, NULL);
INSERT INTO pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento, tipo_pessoa, empresa_id, empresaid) VALUES (157, 'ASASASA@GMAIL.COM', '5+5+5+65+6', '54544545454', '65807171063', '1987-10-11', 'CLIENTE', 86, NULL);


--
-- TOC entry 2423 (class 0 OID 140336)
-- Dependencies: 196
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (8, 'adlehx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646771815684', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (10, 'adlehx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646771855295', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (11, 'adlehx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646771891348', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (12, 'adledhx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646772043839', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (13, 'adledhx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646772884988', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (14, 'adledfhx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646772919555', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (46, 'adledfhx.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1646773246550', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (47, 'alxex@gmail.com', 'teste salva pj', '487878877877', NULL, '46565454545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (48, 'alxex@gmail.com', 'teste salva pj', '487878877877', NULL, '46565454d545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (49, 'alxex@gmail.com', 'teste salva pj', '487878877877', NULL, '4656d5454d545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (50, 'alxdex@gmail.com', 'teste salva pj', '487878877877', NULL, '4656d545dd545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (51, 'alxdex@gmail.com', 'teste salva pj', '487878877877', NULL, '4656d545ddD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (52, 'alxdex@gmail.com', 'teste salva pj', '487878877877', 'ALGUMA COISA', '4656d545ddDDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (56, 'testesalvarpj@gmail.com', 'Alex fernando', '45999795800', NULL, '1646779422811', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (57, 'alxdex@gmail.com', 'teste salva pj', '487878877877', 'ALGUMA COISA', '4656d545ddddDDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (58, 'alxdex@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656d54dddddddDDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (59, 'alxdex@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656d54dddddd55dDDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (60, 'alxdexssdd@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656d54ddddddddd55dDDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (71, 'alxdexssdd@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656d54ddddddDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (72, 'alxdeddxssdd@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656d54dddddddddDD545', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (73, 'testesalvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647381858347', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (77, 'testesalvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647382690972', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (78, 'testesalvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647382925741', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (79, 'testesalddddvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647384814486', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (75, 'alex.fernaddddddndo.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4879887777889987987', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (1, 'ddsd', 'Alex fernando', '45999795800', NULL, '865545598956556', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (2, 'alex.fernandosdsds.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '8655455989554546', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (4, 'dsdsdsds', 'Alex fernando', '45999795800', NULL, '1646771155937', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (3, 'dsdsds', 'Alex fernando', '45999795800', NULL, '1646770918759', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (5, 'sdsdsd', 'Alex fernando', '45999795800', NULL, '1646771544044', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (7, 'sdsds', 'Alex fernando', '45999795800', NULL, '1646771635458', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (9, 'adlehx.fernando.egidio@gdsdsmail.com', 'Alex fernando', '45999795800', NULL, '1646771839634', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (6, 'sdsd', 'Alex fernando', '45999795800', NULL, '1646771598144', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (55, 'sdsdsdsd', 'Alex fernando', '45999795800', NULL, '1646779315873', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (74, 'dsdsdsd', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4656dsdsdsdsdsdsdsdd65', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (80, 'alex.fernandsdsdsdssdsdsdsdsdsdsdo.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', 's5d65565665565566655665', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (81, 'alex.fernanddddddo.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', 'dsdsdsdsdsd65sds6d65s', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (82, 'alex.fernaddddddndo.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', 'dsdsdsdsddddsd65sds6d65s', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (83, 'alex.fernando.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', 'dsdsdsdsddddsd65dddddsds6d65s', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (84, 'alex.fernando.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4dsds65dsd5s5d65sd', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (85, 'alex.fernando.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4dsds65dsddddddd5s5d65sd', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (86, 'alex.fernando.egidio@gmail.com', 'teste salva pj teste 2 ', '487878877877', 'ALGUMA COISA', '4dsds65dsddddddddddd5s5d65sd', '4544544455445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (87, 'testesalddddvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647972413226', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (88, 'testesalddddvarpj2@gmail.com', 'Alex fernando', '45999795800', NULL, '1647972461573', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (89, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647972578220', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (90, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647972697109', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (91, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647972733966', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (92, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647986999043', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (93, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647987470414', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (94, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647987565426', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (95, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647987615208', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (96, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647987884552', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (97, 'alex.fernando.egidio@gmail.com', 'Alex fernando', '45999795800', NULL, '1647987989047', '65556565656665', '55554565656565', '54556565665', '4656656566', NULL, NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (103, 'alex.fernando.egidio@gmail.com', '', '487878877877', 'ALGUMA COISA', '69728983000183', '454488885498588dd64455445544', '787d8888878445587778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (104, 'alex.fernando.egidio@gmail.com', '', '487878877877', 'ALGUMA COISA', '27781312000136', '45448888585445544', '787d888878877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (105, 'alex.fernando.egidio@gmail.com', '', '487878877877', 'ALGUMA COISA', '17017459000109', '4544888885885445544', '787d88888878877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (106, 'alex.fernando.egidio@gmail.com', '', '487878877877', 'ALGUMA COISA', '89853097000199', '4588885885445544', '7888878877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (108, 'alex.fernando.egidio@gmail.com', 'alex fernando', '487878877877', 'ALGUMA COISA', '88501910000107', '4588888885885445544', '788887888877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (109, 'alex.fernando.egidio@gmail.com', ' egidio ', '487878877877', 'ALGUMA COISA', '98855263000187', '458888787885445544', '78454588877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (110, 'alex.fernando.egidio@gmail.com', 'ana jesus', '487878877877', 'ALGUMA COISA', '42103128000120', '787878788', '787878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (111, 'alex.ddddddd.egddddidio@gmail.com', 'teste salva pj teste 2 ', '4878dd78877877', 'ALGUMA COISA', '12770283000130', '4544544455dd445544', '7878787778877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (112, 'alex.ddddddd.egdd7887dio@gmail.com', 'teste salva pj teste 2 ', '4878dd78877877', 'ALGUMA COISA', '68155318000185', '454454454555dd445544', '78745458877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (113, 'alex.ddddddd.egdd7887dio@gmail.com', 'teste salva pj teste 2 ', '4878dd78877877', 'ALGUMA COISA', '03232942000193', '4454555dd445544', '787458877878', 'nome fantasia aqui', 'razao social aqui', 'JURIDICA', NULL, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (138, 'sdsdssds@gmail.com', '654654564654', '54545544', '654654654', '26934453000189', '6546544654564', '654654654', '5456446545456465', '65465454654', '545545455', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (141, 'alex@gmail.com', '455454544544', '44556444654645656', 'MEI', '46.663.738/0001-30', '844454654654545454', '54454545455', '4645sd5s4d4sd45', '54654564554', 'FORNECEDOR', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (140, 'asasa@gmail.com', '4654564564564', '45454544555', 'LTDA', '16.763.460/0001-01', '4654645645646544545454', '55454454545', '454564646465654 update dd 787 77777 dsds', '545454545445545', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (151, '4sdssd@gmail.com', '4545554545', '44444444444', 'MEI', '16248398000110', '212132132', '312131321321', 'sdsdssd', '2121212121', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (142, '541321321sdsds@gmail.com', '465644', '46545466546', 'ME', '29.665.403/0001-31', '4554545455', '65464454', 'assds4d4sd4 ed', '65464654', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (143, '465444@gmail.com', '545454455', '454546565456456', 'MEI', '47007900000124', '47465464654654', '56465465454564564', 'alex egidio MEI', '6546546544564', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (149, 's56ssd5sd@gmail.com', 'd5s65d65s6d5s56d', '45455454554', 'ME', '09110137000173', '454446545', 's45d45s4d54s4d5sd5s4d5', '47fd456sd 4s4d56s464s', 's4d5s5d45sd4sd', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (150, '5sdsdsd@gmail.com', '4845s4d545s4d', '44444444444', 'MEI', '20831502000171', '556556546', '5645456464564', 'sds54d5s45d4s54d', '5456456456564654', 'JURIDICA', 86, NULL);
INSERT INTO pessoa_juridica (id, email, nome, telefone, categoria, cnpj, insc_estadual, insc_municipal, nome_fantasia, razao_social, tipo_pessoa, empresa_id, empresaid) VALUES (156, '656@gmail.com', '656565656', '45455477777', 'MEI', '01683378000108', '656565656', '656565', '54656455565565', '656565', 'JURIDICA', 86, NULL);


--
-- TOC entry 2424 (class 0 OID 140342)
-- Dependencies: 197
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO produto (id, qtd_estoque, qtde_alerta_estoque, alerta_qtde_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, qtde_clique, tipo_unidade, valor_venda, empresa_id, categoria_produto_id, marca_produto_id, alerta_quantidade_estoque, quantidade_alerta_estoque, quantidade_clique, link_youtube_produto, quantidade_clique_produto) VALUES (16, 5, 0, false, 10, true, 'iphone pro max 12 na cor azul marinho tela 6.1', 15, NULL, 'iphon sdsd dd dsweweee66  ddddddds4444', 0.40000000000000002, 5, 0, 'UN', 0.00, 1, 8, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO produto (id, qtd_estoque, qtde_alerta_estoque, alerta_qtde_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, qtde_clique, tipo_unidade, valor_venda, empresa_id, categoria_produto_id, marca_produto_id, alerta_quantidade_estoque, quantidade_alerta_estoque, quantidade_clique, link_youtube_produto, quantidade_clique_produto) VALUES (15, 5, 6, false, 10, true, 'iphone pro max 12 na cor azul marinho tela 6.1', 15, NULL, 'iphon sdsd dd dsweweee66  ddddddds', 0.40000000000000002, 5, 0, 'UN', 0.00, 1, 8, 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO produto (id, qtd_estoque, qtde_alerta_estoque, alerta_qtde_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, qtde_clique, tipo_unidade, valor_venda, empresa_id, categoria_produto_id, marca_produto_id, alerta_quantidade_estoque, quantidade_alerta_estoque, quantidade_clique, link_youtube_produto, quantidade_clique_produto) VALUES (1, 9, 10, true, 50, true, 'iphone 13 pro max', 40, '', 'iphone 13 pro max', 50, 80, 1, 'UN', 13000.00, 8, 10, 1, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 233
-- Name: seq_access_token_junoapi; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_access_token_junoapi', 12, true);


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_acesso', 78, true);


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 199
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_avaliacao_produto', 9, true);


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_boleto_juno; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_boleto_juno', 58, true);


--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_categoria_produto', 109, true);


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_pagar', 49, true);


--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 202
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_receber', 1, false);


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 203
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_cup_desc', 1, false);


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 225
-- Name: seq_cupom_desconto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_cupom_desconto', 1, false);


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 204
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_endereco', 124, true);


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 226
-- Name: seq_endereco_cobranca; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_endereco_cobranca', 1, false);


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 205
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_forma_pagamento', 1, true);


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 206
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_imagem_produto', 31, true);


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_item_venda_loja', 7, true);


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 208
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_marca_produto', 28, true);


--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 209
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_compra', 28, true);


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_venda', 19, true);


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 211
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_item_produto', 4, true);


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 212
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_pessoa', 157, true);


--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_produto', 16, true);


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 228
-- Name: seq_status_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_status_nota_fiscal_venda', 1, false);


--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 214
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_status_rastreio', 2, true);


--
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 43, true);


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 216
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_vd_cp_loja_virt', 20, true);


--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 227
-- Name: seqitem_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seqitem_venda_loja', 1, false);


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 229
-- Name: seqvd_cp_loja_virtual; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seqvd_cp_loja_virtual', 1, false);


--
-- TOC entry 2444 (class 0 OID 140386)
-- Dependencies: 217
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (1, 14, 1, NULL, NULL);
INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (2, 14, 1, NULL, NULL);
INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (3, 14, 1, NULL, NULL);
INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (4, 14, 1, NULL, NULL);
INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (5, 14, 1, NULL, NULL);
INSERT INTO status_rastreio (id, venda_compra_loja_virt_id, empresa_id, url_rastreio, status_rastreio) VALUES (6, 14, 1, NULL, NULL);


--
-- TOC entry 2449 (class 0 OID 160968)
-- Dependencies: 222
-- Data for Name: tabela_acesso_end_potin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tabela_acesso_end_potin (nome_end_point, qtd_acesso_end_point) VALUES ('END-POINT-NOME-PESSOA-FISICA', 0);


--
-- TOC entry 2457 (class 0 OID 195262)
-- Dependencies: 230
-- Data for Name: trail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO trail (id, descricao) VALUES (1, NULL);
INSERT INTO trail (id, descricao) VALUES (2, 'Bla ba bla');
INSERT INTO trail (id, descricao) VALUES (3, 'Bla ba bla');
INSERT INTO trail (id, descricao) VALUES (4, 'Bla ba bla');
INSERT INTO trail (id, descricao) VALUES (5, 'Bla ba bla');
INSERT INTO trail (id, descricao) VALUES (6, 'Testando trail');
INSERT INTO trail (id, descricao) VALUES (7, ' bla bla bla teste');
INSERT INTO trail (id, descricao) VALUES (8, ' bla bla bla teste');
INSERT INTO trail (id, descricao) VALUES (9, ' bla bla bla teste');
INSERT INTO trail (id, descricao) VALUES (10, ' bla bla bla teste');
INSERT INTO trail (id, descricao) VALUES (11, ' bla bla bla teste');
INSERT INTO trail (id, descricao) VALUES (12, ' bla bla bla teste');


--
-- TOC entry 2445 (class 0 OID 140392)
-- Dependencies: 218
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (23, '2022-03-22', 'alex.fernandodd.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 97, 97);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (3, '2022-03-08', 'adlex.fernando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 5, 5);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (4, '2022-03-08', 'adlehx.fernando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 7, 7);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (5, '2022-03-08', 'adledhx.fernando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 12, 12);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (6, '2022-03-08', 'adledfhx.fernando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 14, 14);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (7, '2022-03-08', 'alxex@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 47, 47);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (8, '2022-03-08', 'alxdex@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 50, 50);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (9, '2022-03-08', 'testesalvarpj@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 56, 56);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (10, '2022-03-08', 'alxdexssdd@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 60, 60);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (11, '2022-03-08', 'alxdeddxssdd@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 72, 72);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (12, '2022-03-15', 'testesalvarpj2@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 73, 73);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (13, '2022-03-15', 'testesalddddvarpj2@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 79, 79);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (30, '2024-03-04', 'sdsdssds@gmail.com', '$2a$10$tljWbDJ/HIqqVQQP4NBpneWLXLL8vlfHbxjqYRejnGcx4ud1Xhv6a', 138, 138);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (33, '2024-03-07', 'alex@gmail.com', '$2a$10$S54KnkFZqqdAwYECkUF/puYhk9lePHpUM9wHjxSJ2uN1EkjASSKVm', 141, 141);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (35, '2024-03-07', '465444@gmail.com', '$2a$10$JjH8GToWk52kpe0hueB4AuGiqeV6gwf0Gr4wt5xdYpmz/p76VmaOq', 143, 143);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (36, '2024-03-18', 'alex.testeintegrator@gmail.com', '$2a$10$iuHgItLZdnK9xsEQ3FCu5uQQ7cxiQ/SvkFV4nDUfvwzqhhuzFX7Di', 146, 1);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (39, '2024-04-19', 's56ssd5sd@gmail.com', '$2a$10$QROzpBo.6xJbD32g2zbkX.pY5PC8SrziyoEZk2h9dGnng7HKKLhn2', 149, 149);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (41, '2024-04-19', '4sdssd@gmail.com', '$2a$10$guVgkPwng.WwYw1lQg64QOQEIRkGjkilCRIsBYiAL.O/bbSpC0m8K', 151, 151);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (1, '2022-03-08', 'alex.fernando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 2, 86);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (14, '2022-03-15', 'alex.fernandddddddo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 84, 84);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (15, '2022-03-15', 'alex.fernaddddndo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 85, 85);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (27, '2022-03-29', 'alex.fe85549989r9559nando.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 102, 97);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (17, '2022-03-22', 'alex.fernandfffffffffffo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 89, 89);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (18, '2022-03-22', 'alex.ferna5s5d56s5dsdndo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 91, 91);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (28, '2022-04-12', 'alex.ddddddd.egddddidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 111, 111);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (19, '2022-03-22', 'alex.fernanS5D5S4Ddo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 92, 92);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (29, '2022-04-12', 'alex.ddddddd.egdd7887dio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 112, 112);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (20, '2022-03-22', 'alex.fernan555do.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 93, 93);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (21, '2022-03-22', 'alex.ferna54sd4sdndo.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 95, 95);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (22, '2022-03-22', 'alex.fernandsdsdso.egidio@gmail.com', '$2a$10$sjo2RNTyDpW8Knk7eabEse6UNsW0pp.dzJJj72.fU5C8luoLcI3Jq', 96, 96);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (32, '2024-03-07', 'asasa@gmail.com', '$2a$10$SdnrAzCa2i3wn28WmJcgJufcvPE4vWylMUseg26eMWAbKW2hFwkFC', 140, 140);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (34, '2024-03-07', '5413213211@gmail.com', '$2a$10$Pwrga4bjCYRXc3AnNnwz2u4sNgtU.FjTPIfr9LfiLgMEQBujjsgei', 142, 142);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (40, '2024-04-19', '5sdsdsd@gmail.com', '$2a$10$l8nGE9S42UWyP5QDqQn5beCTuchTg0FBLNtH0BGYZxVtBmt4SRtai', 150, 150);
INSERT INTO usuario (id, data_atual_senha, login, senha, pessoa_id, empresa_id) VALUES (42, '2024-04-19', '656@gmail.com', '$2a$10$fq6aLRuQ7zLvaefANthe6e/gjucQ56snn9MpDmpHFdSw03cQLrkzm', 156, 156);


--
-- TOC entry 2446 (class 0 OID 140398)
-- Dependencies: 219
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (1, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (30, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (5, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (6, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (7, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (8, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (9, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (10, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (11, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (12, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (13, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (14, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (15, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (17, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (18, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (19, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (20, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (21, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (22, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (23, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (23, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (27, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (28, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (28, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (29, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (29, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (30, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (32, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (32, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (33, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (33, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (34, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (34, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (35, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (35, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (36, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (39, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (39, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (40, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (40, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (41, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (41, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (42, 500);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (42, 1);
INSERT INTO usuarios_acesso (usuario_id, acesso_id) VALUES (1, 1);


--
-- TOC entry 2447 (class 0 OID 140401)
-- Dependencies: 220
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (18, '2024-06-05', '2023-12-05', 5, NULL, 10.00, 10.00, NULL, 102, 103, 1, 14, 135, 13, false, 'FINALIZADA', '1b866885-b36b-42e4-8637-b4b51298ab7e', '3', '{"url":"http:\/\/sandbox.melhorenvio.com.br\/imprimir\/dVjZNdjstj9z"}', NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (16, '2024-06-05', '2023-12-05', 5, NULL, 10.00, 10.00, NULL, 98, 99, 1, 12, 133, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (10, '2024-06-05', '2021-01-01', 5, NULL, 10.00, 10.00, NULL, 86, 87, 1, 6, 127, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (11, '2024-06-05', '2021-12-05', 5, NULL, 10.00, 10.00, NULL, 88, 89, 1, 7, 128, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (12, '2024-06-05', '2021-12-05', 5, NULL, 10.00, 10.00, NULL, 90, 91, 1, 8, 129, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (13, '2024-06-05', '2021-12-05', 5, NULL, 10.00, 10.00, NULL, 92, 93, 1, 9, 130, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (14, '2024-06-05', '2021-12-05', 5, NULL, 10.00, 10.00, NULL, 94, 95, 1, 10, 131, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (15, '2024-06-05', '2023-12-05', 5, NULL, 10.00, 10.00, NULL, 96, 97, 1, 11, 132, 13, false, 'FINALIZADA', NULL, '3', NULL, NULL, NULL, NULL);
INSERT INTO vd_cp_loja_virt (id, data_entrega, data_venda, dia_entrega, valor_desconto, valor_fret, valor_total, cupom_desc_id, endereco_cobranca_id, endereco_entrega_id, forma_pagamento_id, nota_fiscal_venda_id, pessoa_id, empresa_id, excluido, status_venda_loja_virtual, codigo_etiqueta, servico_transportadora, url_imprime_etiqueta, url_impressao_etiqueta, url_rastreio, cupom_desconto_id) VALUES (17, '2024-06-05', '2023-12-05', 5, NULL, 10.00, 10.00, NULL, 100, 101, 1, 13, 134, 13, false, 'CANCELADA', NULL, '3', NULL, NULL, NULL, NULL);


--
-- TOC entry 2451 (class 0 OID 186018)
-- Dependencies: 224
-- Data for Name: vd_cp_loja_virtual; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2220 (class 2606 OID 198902)
-- Name: access_token_junoapi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY access_token_junoapi
    ADD CONSTRAINT access_token_junoapi_pkey PRIMARY KEY (id);


--
-- TOC entry 2165 (class 2606 OID 140405)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2167 (class 2606 OID 140407)
-- Name: avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2222 (class 2606 OID 198989)
-- Name: boleto_juno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boleto_juno
    ADD CONSTRAINT boleto_juno_pkey PRIMARY KEY (id);


--
-- TOC entry 2169 (class 2606 OID 140409)
-- Name: categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2171 (class 2606 OID 140411)
-- Name: conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2173 (class 2606 OID 140413)
-- Name: conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 2175 (class 2606 OID 140415)
-- Name: cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 186010)
-- Name: cupom_desconto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cupom_desconto
    ADD CONSTRAINT cupom_desconto_pkey PRIMARY KEY (id);


--
-- TOC entry 2177 (class 2606 OID 140417)
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 2209 (class 2606 OID 158778)
-- Name: flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 2179 (class 2606 OID 140419)
-- Name: forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2181 (class 2606 OID 140421)
-- Name: imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2183 (class 2606 OID 140423)
-- Name: item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 2201 (class 2606 OID 150663)
-- Name: login_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT login_unique UNIQUE (login);


--
-- TOC entry 2185 (class 2606 OID 140425)
-- Name: marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 160975)
-- Name: nome_end_point_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tabela_acesso_end_potin
    ADD CONSTRAINT nome_end_point_unique UNIQUE (nome_end_point);


--
-- TOC entry 2187 (class 2606 OID 140427)
-- Name: nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2189 (class 2606 OID 140429)
-- Name: nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 2191 (class 2606 OID 140431)
-- Name: nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2193 (class 2606 OID 140433)
-- Name: pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2195 (class 2606 OID 140435)
-- Name: pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2197 (class 2606 OID 140437)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2199 (class 2606 OID 140439)
-- Name: status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 2218 (class 2606 OID 195266)
-- Name: trail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY trail
    ADD CONSTRAINT trail_pkey PRIMARY KEY (id);


--
-- TOC entry 2205 (class 2606 OID 140443)
-- Name: unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 2203 (class 2606 OID 140445)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2207 (class 2606 OID 140447)
-- Name: vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 186025)
-- Name: vd_cp_loja_virtual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT vd_cp_loja_virtual_pkey PRIMARY KEY (id);


--
-- TOC entry 2210 (class 1259 OID 158779)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON flyway_schema_history USING btree (success);


--
-- TOC entry 2284 (class 2620 OID 140448)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2286 (class 2620 OID 140449)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON endereco FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2288 (class 2620 OID 140450)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2290 (class 2620 OID 140451)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON usuario FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2292 (class 2620 OID 140452)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2285 (class 2620 OID 140453)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2287 (class 2620 OID 140454)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON endereco FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2289 (class 2620 OID 140455)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2291 (class 2620 OID 140456)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON usuario FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2293 (class 2620 OID 140457)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2278 (class 2620 OID 140458)
-- Name: validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2279 (class 2620 OID 140459)
-- Name: validachavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto2 BEFORE INSERT ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2280 (class 2620 OID 140460)
-- Name: validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2281 (class 2620 OID 140461)
-- Name: validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa();


--
-- TOC entry 2283 (class 2620 OID 140462)
-- Name: validachavepessoacontapagarpessoa_forn_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_forn_id BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa2();


--
-- TOC entry 2282 (class 2620 OID 140463)
-- Name: validachavepessoacontapagarpessoa_forn_id2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarpessoa_forn_id2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validachavepessoa2();


--
-- TOC entry 2260 (class 2606 OID 140464)
-- Name: aesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT aesso_fk FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2254 (class 2606 OID 161573)
-- Name: categoria_produto_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT categoria_produto_id_fk FOREIGN KEY (categoria_produto_id) REFERENCES categoria_produto(id);


--
-- TOC entry 2243 (class 2606 OID 140469)
-- Name: conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES conta_pagar(id);


--
-- TOC entry 2268 (class 2606 OID 140474)
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES cup_desc(id);


--
-- TOC entry 2275 (class 2606 OID 186055)
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES cupom_desconto(id);


--
-- TOC entry 2261 (class 2606 OID 215910)
-- Name: cupom_desconto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT cupom_desconto_fk FOREIGN KEY (cupom_desconto_id) REFERENCES cup_desc(id);


--
-- TOC entry 2224 (class 2606 OID 150567)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2226 (class 2606 OID 150572)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2229 (class 2606 OID 150577)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2231 (class 2606 OID 150582)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_receber
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2232 (class 2606 OID 150587)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cup_desc
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2233 (class 2606 OID 150592)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY endereco
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2234 (class 2606 OID 150597)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_pagamento
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2235 (class 2606 OID 150602)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2237 (class 2606 OID 150607)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2240 (class 2606 OID 150612)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca_produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2242 (class 2606 OID 150617)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2247 (class 2606 OID 150622)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2248 (class 2606 OID 150627)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2251 (class 2606 OID 150632)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_fisica
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2255 (class 2606 OID 150642)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2256 (class 2606 OID 150647)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2258 (class 2606 OID 150652)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2263 (class 2606 OID 150657)
-- Name: empresa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT empresa_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2277 (class 2606 OID 198994)
-- Name: empresa_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boleto_juno
    ADD CONSTRAINT empresa_id_fk FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2274 (class 2606 OID 186060)
-- Name: empresaidfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT empresaidfk FOREIGN KEY (empresaid) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2267 (class 2606 OID 140479)
-- Name: endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES endereco(id);


--
-- TOC entry 2266 (class 2606 OID 140484)
-- Name: endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES endereco(id);


--
-- TOC entry 2273 (class 2606 OID 186065)
-- Name: enderecocobrancafk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT enderecocobrancafk FOREIGN KEY (endereco_cobrancaid) REFERENCES endereco(id);


--
-- TOC entry 2272 (class 2606 OID 186070)
-- Name: enderecoentregafk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT enderecoentregafk FOREIGN KEY (endereco_entregaid) REFERENCES endereco(id);


--
-- TOC entry 2252 (class 2606 OID 233073)
-- Name: fk_jcqalei9t301o4gglt27b8kdp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_juridica
    ADD CONSTRAINT fk_jcqalei9t301o4gglt27b8kdp FOREIGN KEY (empresa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2265 (class 2606 OID 140489)
-- Name: forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id);


--
-- TOC entry 2271 (class 2606 OID 186075)
-- Name: formapagamentofk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT formapagamentofk FOREIGN KEY (forma_pagamentoid) REFERENCES forma_pagamento(id);


--
-- TOC entry 2253 (class 2606 OID 161588)
-- Name: marca_produto_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT marca_produto_id_fk FOREIGN KEY (marca_produto_id) REFERENCES marca_produto(id);


--
-- TOC entry 2250 (class 2606 OID 140494)
-- Name: nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES nota_fiscal_compra(id);


--
-- TOC entry 2264 (class 2606 OID 140499)
-- Name: nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES nota_fiscal_venda(id);


--
-- TOC entry 2270 (class 2606 OID 186080)
-- Name: notafiscalvendafk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT notafiscalvendafk FOREIGN KEY (nota_fiscal_vendaid) REFERENCES nota_fiscal_venda(id);


--
-- TOC entry 2228 (class 2606 OID 168886)
-- Name: pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES pessoa_fisica(id);


--
-- TOC entry 2241 (class 2606 OID 168923)
-- Name: pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2223 (class 2606 OID 172035)
-- Name: pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES pessoa_fisica(id);


--
-- TOC entry 2262 (class 2606 OID 172044)
-- Name: pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES pessoa_fisica(id);


--
-- TOC entry 2230 (class 2606 OID 215895)
-- Name: pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_receber
    ADD CONSTRAINT pessoa_fk FOREIGN KEY (pessoa_id) REFERENCES pessoa_fisica(id);


--
-- TOC entry 2227 (class 2606 OID 168891)
-- Name: pessoa_forn_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT pessoa_forn_fk FOREIGN KEY (pessoa_forn_id) REFERENCES pessoa_juridica(id);


--
-- TOC entry 2269 (class 2606 OID 186085)
-- Name: pessoafk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virtual
    ADD CONSTRAINT pessoafk FOREIGN KEY (pessoaid) REFERENCES pessoa_fisica(id);


--
-- TOC entry 2225 (class 2606 OID 140504)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2236 (class 2606 OID 140509)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2239 (class 2606 OID 140514)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2249 (class 2606 OID 140519)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2259 (class 2606 OID 140524)
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- TOC entry 2244 (class 2606 OID 215905)
-- Name: vd_cp_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT vd_cp_loja_virt_fk FOREIGN KEY (vd_cp_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2257 (class 2606 OID 140534)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2246 (class 2606 OID 172080)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2276 (class 2606 OID 198999)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boleto_juno
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2238 (class 2606 OID 140539)
-- Name: venda_compraloja_virtu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT venda_compraloja_virtu_fk FOREIGN KEY (venda_compra_loja_virtu_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2245 (class 2606 OID 186040)
-- Name: vendacompralojavirtualvendacompralojavirtualfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT vendacompralojavirtualvendacompralojavirtualfk FOREIGN KEY (venda_compra_loja_virtualid) REFERENCES vd_cp_loja_virtual(id);


--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-07-09 20:07:14

--
-- PostgreSQL database dump complete
--
