--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

-- Started on 2019-04-29 14:57:14

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
-- TOC entry 197 (class 1259 OID 24784)
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
-- TOC entry 196 (class 1259 OID 24782)
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
-- TOC entry 2818 (class 0 OID 0)
-- Dependencies: 196
-- Name: medidor001_serialno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tempumidade
--

ALTER SEQUENCE public.medidor001_serialno_seq OWNED BY public.medidor001.serialno;


--
-- TOC entry 2686 (class 2604 OID 24787)
-- Name: medidor001 serialno; Type: DEFAULT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001 ALTER COLUMN serialno SET DEFAULT nextval('public.medidor001_serialno_seq'::regclass);


--
-- TOC entry 2688 (class 2606 OID 24794)
-- Name: medidor001 datahora_unik; Type: CONSTRAINT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001
    ADD CONSTRAINT datahora_unik UNIQUE (datahora);


--
-- TOC entry 2690 (class 2606 OID 24789)
-- Name: medidor001 medidor001_pkey; Type: CONSTRAINT; Schema: public; Owner: tempumidade
--

ALTER TABLE ONLY public.medidor001
    ADD CONSTRAINT medidor001_pkey PRIMARY KEY (serialno);


-- Completed on 2019-04-29 14:57:26

--
-- PostgreSQL database dump complete
--

