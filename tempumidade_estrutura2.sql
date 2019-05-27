--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.2

-- Started on 2019-05-17 23:10:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS tempumidade;
--
-- TOC entry 2817 (class 1262 OID 24781)
-- Name: tempumidade; Type: DATABASE; Schema: -; Owner: tempumidade
--

CREATE DATABASE tempumidade WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE tempumidade OWNER TO tempumidade;

\connect tempumidade

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 24797)
-- Name: medidor001; Type: TABLE; Schema: public; Owner: tempumidade
--

CREATE TABLE public.medidor001 (
    serialno integer NOT NULL,
    medidor text NOT NULL,
    temperatura text NOT NULL,
    umidade text NOT NULL,
    datahora timestamp with time zone NOT NULL,
    serial text NOT NULL
);


ALTER TABLE public.medidor001 OWNER TO tempumidade;

--
-- TOC entry 197 (class 1259 OID 24803)
-- Name: medidor001_serialno_seq; Type: SEQUENCE; Schema: public; Owner: tempumidade
--

CREATE SEQUENCE public.medidor001_serialno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medidor001_serialno_seq OWNER TO tempumidade;

--
-- TOC entry 2827 (class 0 OID 0)
-- Dependencies: 197
-- Name: medidor001_serialno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tempumidade
--

ALTER SEQUENCE public.medidor001_serialno_seq OWNED BY public.medidor001.serialno;


--
-- TOC entry 199 (class 1259 OID 32974)
-- Name: medidores; Type: TABLE; Schema: public; Owner: tempumidade
--

CREATE TABLE public.medidores (
    serialno_medidores integer NOT NULL,
    nome text,
    tabela text
);


ALTER TABLE public.medidores OWNER TO tempumidade;

--
-- TOC entry 198 (class 1259 OID 32972)
-- Name: medidores_serialno_medidores_seq; Type: SEQUENCE; Schema: public; Owner: tempumidade
--

CREATE SEQUENCE public.medidores_serialno_medidores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medidores_serialno_medidores_seq OWNER TO tempumidade;

--
-- TOC entry 2828 (class 0 OID 0)
-- Dependencies: 198
-- Name: medidores_serialno_medidores_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tempumidade
--

ALTER SEQUENCE public.medidores_serialno_medidores_seq OWNED BY public.medidores.serialno_medidores;


--
-- TOC entry 2693 (class 2604 OID 24805)
-- Name: medidor001 serialno; Type: DEFAULT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001 ALTER COLUMN serialno SET DEFAULT nextval('public.medidor001_serialno_seq'::regclass);


--
-- TOC entry 2694 (class 2604 OID 32977)
-- Name: medidores serialno_medidores; Type: DEFAULT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidores ALTER COLUMN serialno_medidores SET DEFAULT nextval('public.medidores_serialno_medidores_seq'::regclass);


--
-- TOC entry 2696 (class 2606 OID 24807)
-- Name: medidor001 datahora_unik; Type: CONSTRAINT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001
    ADD CONSTRAINT datahora_unik UNIQUE (datahora);


--
-- TOC entry 2698 (class 2606 OID 24809)
-- Name: medidor001 medidor001_pkey; Type: CONSTRAINT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001
    ADD CONSTRAINT medidor001_pkey PRIMARY KEY (serialno);


--
-- TOC entry 2700 (class 2606 OID 32982)
-- Name: medidores medidores_pkey; Type: CONSTRAINT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidores
    ADD CONSTRAINT medidores_pkey PRIMARY KEY (serialno_medidores);


-- Completed on 2019-05-17 23:10:47

--
-- PostgreSQL database dump complete
--

