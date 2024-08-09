--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    sender_id integer,
    user_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    help_request_id integer,
    visible boolean DEFAULT true
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: help_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.help_requests (
    user_id bigint NOT NULL,
    title character varying,
    request_type character varying,
    description text,
    accepted_by_user character varying,
    completion_status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    latitude double precision,
    longitude double precision,
    request_count bigint NOT NULL,
    conversation_id integer,
    assigned_users_count integer DEFAULT 0,
    visible boolean DEFAULT true
);


ALTER TABLE public.help_requests OWNER TO postgres;

--
-- Name: help_requests_request_count_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.help_requests_request_count_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.help_requests_request_count_seq OWNER TO postgres;

--
-- Name: help_requests_request_count_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.help_requests_request_count_seq OWNED BY public.help_requests.request_count;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    body text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    conversation_id integer,
    sender_id integer,
    user_id integer
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requests_id_seq OWNER TO postgres;

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.help_requests.user_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    photo character varying,
    first_name character varying,
    last_name character varying,
    completed_requests_count integer DEFAULT 0 NOT NULL,
    user_id bigint NOT NULL,
    jti character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: help_requests user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.help_requests ALTER COLUMN user_id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- Name: help_requests request_count; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.help_requests ALTER COLUMN request_count SET DEFAULT nextval('public.help_requests_request_count_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-05-13 19:46:19.018127	2024-05-13 19:46:19.018134
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, sender_id, user_id, created_at, updated_at, help_request_id, visible) FROM stdin;
230	2	\N	2024-08-06 19:54:31.636495	2024-08-06 20:31:57.988734	18338	f
232	13	2	2024-08-06 19:54:47.138094	2024-08-06 20:32:04.075283	18338	f
233	14	2	2024-08-06 19:54:54.472204	2024-08-06 20:32:08.114786	18338	f
234	15	2	2024-08-06 19:55:03.579146	2024-08-06 20:32:10.420249	18338	f
235	16	2	2024-08-06 19:55:12.360136	2024-08-06 20:32:36.925989	18338	f
236	17	2	2024-08-06 19:55:26.826084	2024-08-06 20:40:11.512111	18338	f
237	13	2	2024-08-06 20:40:34.385035	2024-08-06 20:40:34.385035	601749	t
238	14	2	2024-08-06 20:40:42.037858	2024-08-06 20:40:42.037858	601749	t
239	15	2	2024-08-06 20:40:48.844814	2024-08-06 20:40:48.844814	601749	t
240	16	2	2024-08-06 20:40:55.827154	2024-08-06 20:40:55.827154	601749	t
241	17	2	2024-08-06 20:41:16.375134	2024-08-06 20:41:16.375134	601749	t
231	2	\N	2024-08-06 19:54:38.85242	2024-08-06 20:41:47.097745	601749	f
243	2	\N	2024-08-06 20:52:04.694452	2024-08-06 20:52:04.694452	662566	t
242	2	\N	2024-08-06 20:51:58.276212	2024-08-06 20:51:58.276212	644637	f
244	13	2	2024-08-06 20:52:14.541623	2024-08-06 20:52:14.541623	644637	f
245	14	2	2024-08-06 20:52:22.650937	2024-08-06 20:52:22.650937	644637	f
246	15	2	2024-08-06 20:52:29.971504	2024-08-06 20:52:29.971504	644637	f
247	16	2	2024-08-06 20:52:40.130968	2024-08-06 20:52:40.130968	644637	f
248	17	2	2024-08-06 20:56:11.820017	2024-08-06 20:59:22.122789	644637	f
249	2	\N	2024-08-07 19:26:08.009006	2024-08-07 19:26:08.009006	51897	t
250	13	2	2024-08-07 19:26:18.812382	2024-08-07 19:26:18.812382	51897	t
\.


--
-- Data for Name: help_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.help_requests (user_id, title, request_type, description, accepted_by_user, completion_status, created_at, updated_at, latitude, longitude, request_count, conversation_id, assigned_users_count, visible) FROM stdin;
2	1	one-time-task	1	17	\N	2024-08-06 19:54:31.613247	2024-08-06 20:40:11.50044	40.4426	-80.0002	18338	230	0	f
2	2	material-need	2	17	t	2024-08-06 19:54:38.84157	2024-08-06 20:47:46.24893	40.4417	-80.0081	601749	231	5	f
2	4	one-time-task	4	\N	\N	2024-08-06 20:52:04.684088	2024-08-06 20:52:04.702972	40.5434	-79.995888	662566	243	0	t
2	3	material-need	3	17	t	2024-08-06 20:51:58.254115	2024-08-06 21:00:03.38277	40.440624	-79.9428	644637	242	4	f
2	5	one-time-task	5	13	f	2024-08-07 19:26:07.993607	2024-08-07 19:26:18.802236	40.440624	-80.0081	51897	249	1	t
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, body, created_at, updated_at, conversation_id, sender_id, user_id) FROM stdin;
266	Let's start the conversation!	2024-08-06 19:54:47.168855	2024-08-06 19:54:47.168855	232	13	2
267	Let's start the conversation!	2024-08-06 19:54:54.508751	2024-08-06 19:54:54.508751	233	14	2
268	Let's start the conversation!	2024-08-06 19:55:03.59872	2024-08-06 19:55:03.59872	234	15	2
269	Let's start the conversation!	2024-08-06 19:55:12.379986	2024-08-06 19:55:12.379986	235	16	2
270	Let's start the conversation!	2024-08-06 19:55:26.849203	2024-08-06 19:55:26.849203	236	17	2
271	Let's start the conversation!	2024-08-06 20:40:34.410126	2024-08-06 20:40:34.410126	237	13	2
272	Let's start the conversation!	2024-08-06 20:40:42.058022	2024-08-06 20:40:42.058022	238	14	2
273	Let's start the conversation!	2024-08-06 20:40:48.865543	2024-08-06 20:40:48.865543	239	15	2
274	Let's start the conversation!	2024-08-06 20:40:55.853124	2024-08-06 20:40:55.853124	240	16	2
275	Let's start the conversation!	2024-08-06 20:41:16.395592	2024-08-06 20:41:16.395592	241	17	2
276	Let's start the conversation!	2024-08-06 20:52:14.566313	2024-08-06 20:52:14.566313	244	13	2
277	Let's start the conversation!	2024-08-06 20:52:22.678262	2024-08-06 20:52:22.678262	245	14	2
278	Let's start the conversation!	2024-08-06 20:52:29.994184	2024-08-06 20:52:29.994184	246	15	2
279	Let's start the conversation!	2024-08-06 20:52:40.153582	2024-08-06 20:52:40.153582	247	16	2
281	Let's start the conversation!	2024-08-07 19:26:18.835671	2024-08-07 19:26:18.835671	250	13	2
280	Let's start the conversation!	2024-08-06 20:56:11.842918	2024-08-06 20:56:11.842918	248	17	2
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20240513193613
20240513200243
20240513202531
20240513202809
20240513203557
20240513203558
20240513211247
20240513211914
20240513220101
20240514001902
20240520191519
20240521155307
20240521155941
20240604020241
20240604021602
20240604022058
20240607213430
20240607214524
20240608153525
20240611001147
20240611033653
20240611034405
20240611040710
20240611041418
20240611041721
20240625004426
20240629235740
20240630000326
20240630000418
20240630032732
20240702064108
20240702065736
20240702070055
20240702154526
20240714003045
20240714015558
20240722002140
20240722002903
20240722003052
20240806185407
20240806194051
20240806202201
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, photo, first_name, last_name, completed_requests_count, user_id, jti) FROM stdin;
taja.long@yahoo.com	$2a$12$I45T3ik1W1SX9BCmm8LAxuTIwIx/B44tj0JSw8L/E55qiVK.c9mKS	\N	\N	\N	upload-59b48ebe-f21a-4a1a-997c-c768754a1cc1.jpg	taja	long	0	1	\N
blaise.ronspies@gmail.com	$2a$12$r4gVBYaS3efKl6e55n88aOiA3tSiJYXLaLPw7D6cWZC1EJENduPxu	\N	\N	\N	upload-78b3b693-dc7d-4094-bfc8-14ff2aea6538.jpg	Blaise	Ronspies	0	3	\N
blaise@gmail.com	$2a$12$By13wdoRZYw86t6JkUKfcuLX5a0hIiwjVHfLaN5VuRL1ZrTWvSxfe	\N	\N	\N	upload-55534543-d336-4593-8678-0d8d9e6cd2c2.jpg	Blaise	Ronspies	0	4	\N
newuser@yahoo.com	$2a$12$blU3YC7YlwH29zIHYw.57.fJMcA4Zzr0wXiJGC2fhRRFTv6AIXEGS	\N	\N	\N	\N	John	Doe	0	5	\N
jane.doe@gmail.com	$2a$12$5h2bvweyd4/d/ZT2gXgSkOjEAnHhc.c18thOwBZoyT4l8qDNbfuc2	\N	\N	\N	\N	Jane	Doe	0	6	\N
gen.doe@gmail.com	$2a$12$JOh7PiXc0cekzZcvPrgmHempxfwPGRrcypJWMe07an5CNqfZLwDgi	\N	\N	\N	BeachBattle.jpg	Gen	Doe	0	7	\N
newmans@yahoo.com	$2a$12$Dz2GeMb3vASGo1efNisHduWjlJJiz1hyZA./YQWikvqiVClgUt0/i	\N	\N	\N	\N	Jonathan	Doeseky	0	8	9d170f4c-e2ab-4b9d-b3fc-8eeb254a77ea
newmanssss@yahoo.com	$2a$12$L/jpZoWkSmN9kso/J5U4ou6W5jzW6vY9g3N92rOov2MglsPCHZOvq	\N	\N	\N	\N	Jonathan	Doeseky	0	9	81ac6ebe-63fb-47ca-986b-33e76d4f47c7
newmansdddssss@yahoo.com	$2a$12$rmn.3/YOWdB/G3IteTWca.o8J9UPyz0SDVnwVDRchp2k0myvv0N3u	\N	\N	\N	\N	Jonathan	Doesseky	0	10	4d1f1ba7-b51b-420b-89e4-84993e82cb11
newman2sdddssss@yahoo.com	$2a$12$bfPk43cA/YBAMOmv41K1O.Lz1.lAFF0B/xmgXXTzqNQw3cskv6qQW	\N	\N	\N	\N	Jonathan	Doesseky	0	11	686aa6b4-9e1a-4fb3-a518-2b22e860684c
blaise.rdsfsonspies@gmail.com	$2a$12$V2fxvYW8wrWpAmB6FWGMxevFdaiYPhkit2zBiZp8lgJzYD/.TiBry	\N	\N	\N	Fish_man.PNG	Blaise	Ronspies	0	12	3708e90c-8e15-4655-93f9-8d41e17f8a40
user3@yahoo.com	$2a$12$nWeqdUAVe786hU8ijAq7VODngDHUeJNhf42yOvclikstovt48Ij8.	\N	\N	\N	BasilStagHare.jpg	user3	user3	0	14	79aebe16-e3ba-4402-a7cd-08f7a7117886
user4@yahoo.com	$2a$12$7wqfCm8dZMwnE35Np/SY2.RiJuwvO/IiiQZp6lUzDD0GTYWeRUsXy	\N	\N	\N	Fish_man.PNG	user4	user4	0	15	10a1e2ed-3c8c-4239-aaa1-b1ca954ca829
user5@yahoo.com	$2a$12$EFnrUqR7pgTQkMmWzjo5LuOQ2OPwq4gRdgUeMqaF/jFDyj5DzSbOW	\N	\N	\N	FortTerminus.jpg	user5	user5	0	16	7bc18e65-73bf-46e5-8e6b-727de7689190
user6@yahoo.com	$2a$12$RLH/3irpftNmoOW2l.iDqu79T5/fXIoRJw/aWBVaMc7AP4ujwVuHu	\N	\N	\N	CountryRoad.jpg	user6	user6	0	17	0fe20ae6-48fc-437d-acc7-aaeb241e0c5d
user2@yahoo.com	$2a$12$RiA3J3fNDcFFR3FdNsWn1u6EfKGXDHegha5gq1GEI7JLcKXepQl7m	\N	\N	\N	Greek_Sailor_Hero_Armed.jpg	user2	user2	0	13	39881947-2017-4b37-a360-13b99d8a5f79
user@yahoo.com	$2a$12$VKRFld3fCyqoIVq3Vz7sp.Q613y3pTO8.YQNvs.2LeM.FcYh5j4sG	\N	\N	\N	upload-75b7fb06-f6df-43f0-9fb0-b89502fd9992.jpg	user	user	0	2	41314a98-120f-4302-9da3-10ea6d406d16
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 1, false);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 1, false);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_id_seq', 250, true);


--
-- Name: help_requests_request_count_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.help_requests_request_count_seq', 10, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 281, true);


--
-- Name: requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requests_id_seq', 1, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 17, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: help_requests help_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.help_requests
    ADD CONSTRAINT help_requests_pkey PRIMARY KEY (request_count);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: fki_conv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_conv ON public.messages USING btree (conversation_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_conversations_on_help_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_conversations_on_help_request_id ON public.conversations USING btree (help_request_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_jti; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_jti ON public.users USING btree (jti);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: messages fk_rails_7f927086d2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT fk_rails_7f927086d2 FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

