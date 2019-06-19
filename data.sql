--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.13
-- Dumped by pg_dump version 9.6.13

-- Started on 2019-06-19 17:07:33 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 193 (class 1259 OID 24966)
-- Name: authorities; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.authorities (
    authority character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.authorities OWNER TO username;

--
-- TOC entry 186 (class 1259 OID 24840)
-- Name: autorzy; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.autorzy (
    id integer NOT NULL,
    imie character varying(30),
    nazwisko character varying(40)
);


ALTER TABLE public.autorzy OWNER TO username;

--
-- TOC entry 185 (class 1259 OID 24838)
-- Name: autorzy_id_seq; Type: SEQUENCE; Schema: public; Owner: username
--

CREATE SEQUENCE public.autorzy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.autorzy_id_seq OWNER TO username;

--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 185
-- Name: autorzy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: username
--

ALTER SEQUENCE public.autorzy_id_seq OWNED BY public.autorzy.id;


--
-- TOC entry 191 (class 1259 OID 24867)
-- Name: autorzy_to_ksiazki; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.autorzy_to_ksiazki (
    ksiazka_id integer NOT NULL,
    autor_id integer NOT NULL
);


ALTER TABLE public.autorzy_to_ksiazki OWNER TO username;

--
-- TOC entry 188 (class 1259 OID 24848)
-- Name: kategorie; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.kategorie (
    id integer NOT NULL,
    nazwa character varying(40)
);


ALTER TABLE public.kategorie OWNER TO username;

--
-- TOC entry 187 (class 1259 OID 24846)
-- Name: kategorie_id_seq; Type: SEQUENCE; Schema: public; Owner: username
--

CREATE SEQUENCE public.kategorie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategorie_id_seq OWNER TO username;

--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 187
-- Name: kategorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: username
--

ALTER SEQUENCE public.kategorie_id_seq OWNED BY public.kategorie.id;


--
-- TOC entry 190 (class 1259 OID 24856)
-- Name: ksiazki; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.ksiazki (
    id integer NOT NULL,
    nazwa character varying(100),
    wydawnictwo character varying(50),
    cena double precision,
    kategoria_id integer
);


ALTER TABLE public.ksiazki OWNER TO username;

--
-- TOC entry 189 (class 1259 OID 24854)
-- Name: ksiazki_id_seq; Type: SEQUENCE; Schema: public; Owner: username
--

CREATE SEQUENCE public.ksiazki_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ksiazki_id_seq OWNER TO username;

--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 189
-- Name: ksiazki_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: username
--

ALTER SEQUENCE public.ksiazki_id_seq OWNED BY public.ksiazki.id;


--
-- TOC entry 192 (class 1259 OID 24958)
-- Name: users; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.users (
    username character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO username;

--
-- TOC entry 195 (class 1259 OID 24981)
-- Name: zamowienia; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.zamowienia (
    id integer NOT NULL,
    data_i_czas timestamp without time zone,
    cena real,
    status character varying(255),
    uzytkownik_id character varying(255)
);


ALTER TABLE public.zamowienia OWNER TO username;

--
-- TOC entry 194 (class 1259 OID 24979)
-- Name: zamowienia_id_seq; Type: SEQUENCE; Schema: public; Owner: username
--

CREATE SEQUENCE public.zamowienia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zamowienia_id_seq OWNER TO username;

--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 194
-- Name: zamowienia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: username
--

ALTER SEQUENCE public.zamowienia_id_seq OWNED BY public.zamowienia.id;


--
-- TOC entry 196 (class 1259 OID 24990)
-- Name: zamowienia_to_ksiazki; Type: TABLE; Schema: public; Owner: username
--

CREATE TABLE public.zamowienia_to_ksiazki (
    zamowienie_id integer NOT NULL,
    ksiazka_id integer NOT NULL
);


ALTER TABLE public.zamowienia_to_ksiazki OWNER TO username;

--
-- TOC entry 2042 (class 2604 OID 24843)
-- Name: autorzy id; Type: DEFAULT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.autorzy ALTER COLUMN id SET DEFAULT nextval('public.autorzy_id_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 24851)
-- Name: kategorie id; Type: DEFAULT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.kategorie ALTER COLUMN id SET DEFAULT nextval('public.kategorie_id_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 24859)
-- Name: ksiazki id; Type: DEFAULT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.ksiazki ALTER COLUMN id SET DEFAULT nextval('public.ksiazki_id_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 24984)
-- Name: zamowienia id; Type: DEFAULT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia ALTER COLUMN id SET DEFAULT nextval('public.zamowienia_id_seq'::regclass);


--
-- TOC entry 2194 (class 0 OID 24966)
-- Dependencies: 193
-- Data for Name: authorities; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.authorities (authority, username) FROM stdin;
ROLE_ADMIN	admin
ROLE_USER	user
ROLE_USER	a
ROLE_USER	c
\.


--
-- TOC entry 2187 (class 0 OID 24840)
-- Dependencies: 186
-- Data for Name: autorzy; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.autorzy (id, imie, nazwisko) FROM stdin;
31	Wiliam	Shakespeare
32	Henryk	Sienkiewicz
33	Adam	Mickiewicz
34	Eliza	Orzeszkowa
\.


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 185
-- Name: autorzy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: username
--

SELECT pg_catalog.setval('public.autorzy_id_seq', 35, true);


--
-- TOC entry 2192 (class 0 OID 24867)
-- Dependencies: 191
-- Data for Name: autorzy_to_ksiazki; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.autorzy_to_ksiazki (ksiazka_id, autor_id) FROM stdin;
46	31
47	31
48	32
49	32
50	33
51	34
\.


--
-- TOC entry 2189 (class 0 OID 24848)
-- Dependencies: 188
-- Data for Name: kategorie; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.kategorie (id, nazwa) FROM stdin;
23	brak
24	Literatura polska
25	Literatura zagraniczna
\.


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 187
-- Name: kategorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: username
--

SELECT pg_catalog.setval('public.kategorie_id_seq', 25, true);


--
-- TOC entry 2191 (class 0 OID 24856)
-- Dependencies: 190
-- Data for Name: ksiazki; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.ksiazki (id, nazwa, wydawnictwo, cena, kategoria_id) FROM stdin;
46	Hamlet	AAA	6.5	25
47	Makbet	AAA	6.80000019073486328	25
48	Potop	BBB	18.3999996185302734	24
49	Quo vadis	BBB	17.9899997711181641	24
50	Pan Tadeusz	CCC	13.7799997329711914	24
51	Nad Niemnem	CCC	15.4499998092651367	24
\.


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 189
-- Name: ksiazki_id_seq; Type: SEQUENCE SET; Schema: public; Owner: username
--

SELECT pg_catalog.setval('public.ksiazki_id_seq', 51, true);


--
-- TOC entry 2193 (class 0 OID 24958)
-- Dependencies: 192
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.users (username, enabled, password) FROM stdin;
admin	t	$2a$10$3iBoAGSxSsNy3cDi5KdKtOa61q0cKm3ypf3zxe3B09g3zVgBuhac6
user	t	$2a$10$ctC1HLKGU6Kp6eCzK5Ono.EF2GBjOr.WFjtB/6H16cBUAwf8s32QO
a	t	$2a$10$7fI8zgJ3taf1ZUvXxzO9bOSZ9YZw3j8OSCCRvDvSkXNo7h5kokeb2
c	t	$2a$10$kNgIkLFGCUkt2cP/I92ji.EZ2.k4NyOFTlw80ngeRalo6v6SfV06W
\.


--
-- TOC entry 2196 (class 0 OID 24981)
-- Dependencies: 195
-- Data for Name: zamowienia; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.zamowienia (id, data_i_czas, cena, status, uzytkownik_id) FROM stdin;
9	2019-06-19 14:16:02.205	6.5	zrealizowane	user
10	2019-06-19 16:51:16.521	31.7000008	zrealizowane	a
\.


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 194
-- Name: zamowienia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: username
--

SELECT pg_catalog.setval('public.zamowienia_id_seq', 10, true);


--
-- TOC entry 2197 (class 0 OID 24990)
-- Dependencies: 196
-- Data for Name: zamowienia_to_ksiazki; Type: TABLE DATA; Schema: public; Owner: username
--

COPY public.zamowienia_to_ksiazki (zamowienie_id, ksiazka_id) FROM stdin;
9	46
10	48
10	47
10	46
\.


--
-- TOC entry 2057 (class 2606 OID 24973)
-- Name: authorities authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT authorities_pkey PRIMARY KEY (authority, username);


--
-- TOC entry 2047 (class 2606 OID 24845)
-- Name: autorzy autorzy_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.autorzy
    ADD CONSTRAINT autorzy_pkey PRIMARY KEY (id);


--
-- TOC entry 2053 (class 2606 OID 24871)
-- Name: autorzy_to_ksiazki autorzy_to_ksiazki_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.autorzy_to_ksiazki
    ADD CONSTRAINT autorzy_to_ksiazki_pkey PRIMARY KEY (ksiazka_id, autor_id);


--
-- TOC entry 2049 (class 2606 OID 24853)
-- Name: kategorie kategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_pkey PRIMARY KEY (id);


--
-- TOC entry 2051 (class 2606 OID 24861)
-- Name: ksiazki ksiazki_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_pkey PRIMARY KEY (id);


--
-- TOC entry 2055 (class 2606 OID 24965)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- TOC entry 2059 (class 2606 OID 24989)
-- Name: zamowienia zamowienia_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT zamowienia_pkey PRIMARY KEY (id);


--
-- TOC entry 2061 (class 2606 OID 24994)
-- Name: zamowienia_to_ksiazki zamowienia_to_ksiazki_pkey; Type: CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia_to_ksiazki
    ADD CONSTRAINT zamowienia_to_ksiazki_pkey PRIMARY KEY (zamowienie_id, ksiazka_id);


--
-- TOC entry 2064 (class 2606 OID 24877)
-- Name: autorzy_to_ksiazki autorzy_to_ksiazki_autor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.autorzy_to_ksiazki
    ADD CONSTRAINT autorzy_to_ksiazki_autor_id_fkey FOREIGN KEY (autor_id) REFERENCES public.autorzy(id);


--
-- TOC entry 2063 (class 2606 OID 24872)
-- Name: autorzy_to_ksiazki autorzy_to_ksiazki_ksiazka_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.autorzy_to_ksiazki
    ADD CONSTRAINT autorzy_to_ksiazki_ksiazka_id_fkey FOREIGN KEY (ksiazka_id) REFERENCES public.ksiazki(id);


--
-- TOC entry 2066 (class 2606 OID 24995)
-- Name: zamowienia fkevm7e19oihj6b4fgwfh4815en; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia
    ADD CONSTRAINT fkevm7e19oihj6b4fgwfh4815en FOREIGN KEY (uzytkownik_id) REFERENCES public.users(username);


--
-- TOC entry 2067 (class 2606 OID 25000)
-- Name: zamowienia_to_ksiazki fkfendia70k5wkwdjv6s1kewck0; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia_to_ksiazki
    ADD CONSTRAINT fkfendia70k5wkwdjv6s1kewck0 FOREIGN KEY (ksiazka_id) REFERENCES public.ksiazki(id);


--
-- TOC entry 2065 (class 2606 OID 24974)
-- Name: authorities fkhjuy9y4fd8v5m3klig05ktofg; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT fkhjuy9y4fd8v5m3klig05ktofg FOREIGN KEY (username) REFERENCES public.users(username);


--
-- TOC entry 2068 (class 2606 OID 25005)
-- Name: zamowienia_to_ksiazki fkq78grl5s95fl3qdvph3tb2g5s; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.zamowienia_to_ksiazki
    ADD CONSTRAINT fkq78grl5s95fl3qdvph3tb2g5s FOREIGN KEY (zamowienie_id) REFERENCES public.zamowienia(id);


--
-- TOC entry 2062 (class 2606 OID 24862)
-- Name: ksiazki ksiazki_kategoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: username
--

ALTER TABLE ONLY public.ksiazki
    ADD CONSTRAINT ksiazki_kategoria_id_fkey FOREIGN KEY (kategoria_id) REFERENCES public.kategorie(id);


-- Completed on 2019-06-19 17:07:33 CEST

--
-- PostgreSQL database dump complete
--

