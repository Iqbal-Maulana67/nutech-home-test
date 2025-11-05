--
-- PostgreSQL database dump
--

\restrict pBW9mwogddTOh0ulvS9JDxlcc9p4qHnxKDeAfRQtFwTbfqzgJVki81EyVUVyG4y

-- Dumped from database version 16.1
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-05 13:15:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 41032)
-- Name: Banner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Banner" (
    id integer NOT NULL,
    banner_name text NOT NULL,
    banner_image text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public."Banner" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 41031)
-- Name: Banner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Banner_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Banner_id_seq" OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 218
-- Name: Banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Banner_id_seq" OWNED BY public."Banner".id;


--
-- TOC entry 221 (class 1259 OID 41047)
-- Name: History; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."History" (
    invoice_number text NOT NULL,
    "userId" integer NOT NULL,
    transaction_type text NOT NULL,
    description text NOT NULL,
    total_amount integer NOT NULL,
    created_on timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."History" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 41040)
-- Name: Services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Services" (
    service_code text NOT NULL,
    service_name text NOT NULL,
    service_icon text NOT NULL,
    service_tariff integer NOT NULL
);


ALTER TABLE public."Services" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 41022)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    profile_image text,
    balance integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 41021)
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 216
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- TOC entry 215 (class 1259 OID 41012)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 4757 (class 2604 OID 41035)
-- Name: Banner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Banner" ALTER COLUMN id SET DEFAULT nextval('public."Banner_id_seq"'::regclass);


--
-- TOC entry 4754 (class 2604 OID 41025)
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- TOC entry 4918 (class 0 OID 41032)
-- Dependencies: 219
-- Data for Name: Banner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Banner" (id, banner_name, banner_image, description) FROM stdin;
1	Banner 1	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
2	Banner 2	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
3	Banner 3	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
4	Banner 4	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
5	Banner 5	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
6	Banner 6	https://nutech-integrasi.app/dummy.jpg	Lerem Ipsum Dolor sit amet
\.


--
-- TOC entry 4920 (class 0 OID 41047)
-- Dependencies: 221
-- Data for Name: History; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."History" (invoice_number, "userId", transaction_type, description, total_amount, created_on) FROM stdin;
INV05112025-001	7	PULSA	Pulsa	40000	2025-11-04 18:54:43.581
INV05112025-002	7	PULSA	Pulsa	40000	2025-11-04 18:55:05.049
INV05112025-003	7	PULSA	Pulsa	40000	2025-11-04 18:55:08.731
INV05112025-004	7	PULSA	Pulsa	40000	2025-11-04 18:55:11.378
INV05112025-005	7	PULSA	Pulsa	40000	2025-11-04 18:55:15.927
INV05112025-006	7	PULSA	Pulsa	40000	2025-11-04 18:55:17.347
INV05112025-007	9	PULSA	Pulsa	40000	2025-11-04 21:06:53.23
INV05112025-008	9	PULSA	Pulsa	40000	2025-11-04 21:07:36.455
\.


--
-- TOC entry 4919 (class 0 OID 41040)
-- Dependencies: 220
-- Data for Name: Services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Services" (service_code, service_name, service_icon, service_tariff) FROM stdin;
PAJAK	Pajak PBB	https://nutech-integrasi.app/dummy.jpg	40000
PLN	Listrik	https://nutech-integrasi.app/dummy.jpg	10000
PDAM	PDAM Berlangganan	https://nutech-integrasi.app/dummy.jpg	40000
PULSA	Pulsa	https://nutech-integrasi.app/dummy.jpg	40000
PGN	PGN Berlangganan	https://nutech-integrasi.app/dummy.jpg	50000
MUSIK	Musik Berlangganan	https://nutech-integrasi.app/dummy.jpg	50000
TV	TV Berlangganan	https://nutech-integrasi.app/dummy.jpg	50000
PAKET_DATA	Paket data	https://nutech-integrasi.app/dummy.jpg	50000
VOUCHER_GAME	Voucher Game	https://nutech-integrasi.app/dummy.jpg	100000
VOUCHER_MAKANAN	Voucher Makanan	https://nutech-integrasi.app/dummy.jpg	100000
QURBAN	Qurban	https://nutech-integrasi.app/dummy.jpg	200000
ZAKAT	Zakat	https://nutech-integrasi.app/dummy.jpg	300000
\.


--
-- TOC entry 4916 (class 0 OID 41022)
-- Dependencies: 217
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, first_name, last_name, email, password, profile_image, balance, "createdAt") FROM stdin;
6	Iqbal	Maulana	im.fiekri	$2b$10$WtHN7qKEb4.splX1NPPfiOvk9uYYatoUdt2ZHOIp4QckNtZ.hOBJ2	\N	0	2025-11-04 04:05:50.058
8	Iqbal	Maulana	im.fiekri1@gmail.com	$2b$10$AoMQWeV5QgaaaijasPcZSOf47ssYLBw0.YufBrykvOM9nvlT93aL2	\N	0	2025-11-04 15:19:49.684
7	Iqbal	Maulana Fiekri	im.fiekri@gmail.com	$2b$10$dhPKHGfDKLhXrB/rGJ10jeeGeTBGzQ6WMi0sA0g8rhbjsR/IQ.WPi	\N	1350300	2025-11-04 04:15:20.54
9	User Edited	Nutech Edited	user@nutech-integrasi.com	$2b$10$TwB9IcpByvXZZoKwvK4zE.mrysl2wo2HU51zBWEkWKLHUK4uMxY2S	http://localhost:3000/public/images/profiles/profile-9.png	450000	2025-11-04 20:23:15.309
\.


--
-- TOC entry 4914 (class 0 OID 41012)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
4e894d00-f1bb-4bd5-8b04-caa2cf455771	a2e49ca30c7070a788ee9e9a7a89be2cf516fa869e2b1cde8b7c9fe2111ce2f7	2025-11-04 07:13:21.233157+07	20251104001321_init_db	\N	\N	2025-11-04 07:13:21.171758+07	1
f7f3f5b7-ed82-429e-871c-2662b111fa35	4a9e3d0ba0e611ae815f33a63152adaa45d3f0731679b082b00a306514b3b163	2025-11-04 22:18:27.816535+07	20251104151827_balance_update	\N	\N	2025-11-04 22:18:27.810347+07	1
\.


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 218
-- Name: Banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Banner_id_seq"', 6, true);


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 216
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 9, true);


--
-- TOC entry 4765 (class 2606 OID 41039)
-- Name: Banner Banner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_pkey" PRIMARY KEY (id);


--
-- TOC entry 4769 (class 2606 OID 41054)
-- Name: History History_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_pkey" PRIMARY KEY (invoice_number);


--
-- TOC entry 4767 (class 2606 OID 41046)
-- Name: Services Services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Services"
    ADD CONSTRAINT "Services_pkey" PRIMARY KEY (service_code);


--
-- TOC entry 4763 (class 2606 OID 41030)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- TOC entry 4760 (class 2606 OID 41020)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4761 (class 1259 OID 41055)
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- TOC entry 4770 (class 2606 OID 41056)
-- Name: History History_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-11-05 13:15:16

--
-- PostgreSQL database dump complete
--

\unrestrict pBW9mwogddTOh0ulvS9JDxlcc9p4qHnxKDeAfRQtFwTbfqzgJVki81EyVUVyG4y

