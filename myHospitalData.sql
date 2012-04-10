--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: citizen_has_disease_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('citizen_has_disease_record_id_seq', 1, false);


--
-- Name: citizen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('citizen_id_seq', 100, true);


--
-- Name: citizen_vaccinated_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('citizen_vaccinated_record_id_seq', 2, true);


--
-- Name: disease_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('disease_id_seq', 8, true);


--
-- Name: immunity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('immunity_id_seq', 1, false);


--
-- Name: vaccination_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('vaccination_id_seq', 1, false);


--
-- Data for Name: citizen; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY citizen (id, fullname, birth_date) FROM stdin;
1	Anna Ivanova	1976-04-24
2	Maria Ivanova	1992-10-02
3	Elena Ivanova	2008-08-11
4	Alexandra Ivanova	1967-07-01
5	Viktoria Ivanova	2008-01-11
6	Irina Ivanova	1993-04-11
7	Alena Ivanova	2005-03-14
8	Anna Petrova	1978-07-13
9	Maria Petrova	1972-08-08
10	Elena Petrova	1963-08-14
11	Alexandra Petrova	1968-09-18
12	Viktoria Petrova	1993-07-06
13	Irina Petrova	1967-04-25
14	Alena Petrova	1989-12-09
15	Anna Sidorova	1966-03-24
16	Maria Sidorova	1995-05-06
17	Elena Sidorova	1994-05-28
18	Alexandra Sidorova	1989-04-16
19	Viktoria Sidorova	1974-12-12
20	Irina Sidorova	1982-03-18
21	Alena Sidorova	1994-10-15
22	Anna Kuznetsova	1966-04-14
23	Maria Kuznetsova	1970-09-05
24	Elena Kuznetsova	2008-03-20
25	Alexandra Kuznetsova	1994-10-31
26	Viktoria Kuznetsova	2006-03-18
27	Irina Kuznetsova	1995-06-10
28	Alena Kuznetsova	1975-09-28
29	Anna Lebedeva	1962-08-16
30	Maria Lebedeva	1994-10-18
31	Elena Lebedeva	1965-04-25
32	Alexandra Lebedeva	1963-12-06
33	Viktoria Lebedeva	1972-04-10
34	Irina Lebedeva	1992-12-24
35	Alena Lebedeva	2001-06-17
36	Anna Zaiceva	2003-12-28
37	Maria Zaiceva	1988-06-08
38	Elena Zaiceva	1999-02-17
39	Alexandra Zaiceva	1989-07-02
40	Viktoria Zaiceva	1990-06-06
41	Irina Zaiceva	1964-09-15
42	Alena Zaiceva	2005-09-08
43	Anna Medvedeva	2002-06-24
44	Maria Medvedeva	1965-03-11
45	Elena Medvedeva	1996-02-25
46	Alexandra Medvedeva	1973-03-23
47	Viktoria Medvedeva	1995-05-06
48	Irina Medvedeva	1996-04-01
49	Alena Medvedeva	1988-08-29
50	Anna Ivanova	1976-03-23
51	Maria Ivanova	1978-08-30
52	Elena Ivanova	1980-06-18
53	Alexandra Ivanova	2003-08-03
54	Viktoria Ivanova	1986-02-25
55	Irina Ivanova	2004-02-21
56	Alena Ivanova	1967-10-28
57	Anna Petrova	1990-02-01
58	Maria Petrova	1976-04-04
59	Elena Petrova	1971-12-02
60	Alexandra Petrova	1964-10-24
61	Viktoria Petrova	1970-06-27
62	Irina Petrova	1997-10-30
63	Alena Petrova	1997-07-11
64	Anna Sidorova	2002-06-20
65	Maria Sidorova	2001-07-19
66	Elena Sidorova	1970-03-26
67	Alexandra Sidorova	1982-10-25
68	Viktoria Sidorova	1971-05-23
69	Irina Sidorova	1974-10-07
70	Alena Sidorova	2008-09-14
71	Anna Kuznetsova	1995-06-20
72	Maria Kuznetsova	1983-08-08
73	Elena Kuznetsova	1993-11-09
74	Alexandra Kuznetsova	1968-07-11
75	Viktoria Kuznetsova	2003-12-15
76	Irina Kuznetsova	1981-12-31
77	Alena Kuznetsova	1990-11-08
78	Anna Lebedeva	1989-08-04
79	Maria Lebedeva	1974-03-19
80	Elena Lebedeva	1997-05-21
81	Alexandra Lebedeva	1964-02-20
82	Viktoria Lebedeva	1997-11-24
83	Irina Lebedeva	1999-04-12
84	Alena Lebedeva	1982-08-26
85	Anna Zaiceva	1968-05-24
86	Maria Zaiceva	1998-11-30
87	Elena Zaiceva	2006-12-29
88	Alexandra Zaiceva	1984-05-29
89	Viktoria Zaiceva	2003-02-17
90	Irina Zaiceva	1989-08-23
91	Alena Zaiceva	1997-10-16
92	Anna Medvedeva	1993-02-20
93	Maria Medvedeva	1971-07-16
94	Elena Medvedeva	2002-12-13
95	Alexandra Medvedeva	1979-05-11
96	Viktoria Medvedeva	1980-06-19
97	Irina Medvedeva	1980-05-31
98	Alena Medvedeva	1998-08-05
99	Anna Ivanova	1995-04-10
100	Maria Ivanova	1986-01-27
\.


--
-- Data for Name: immunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY immunity (id) FROM stdin;
1
2
\.


--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY disease (id, name, immunity_id) FROM stdin;
2	Простуда	\N
3	Ишемич. б. сердца	\N
4	СПИД	\N
5	Чума	\N
6	Диабет	\N
7	Кашель	\N
8	Чесотка	\N
9	Ветрянка	1
1	Грипп	2
\.


--
-- Data for Name: citizen_has_disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY citizen_has_disease (record_id, citizen_id, disease_id, begin_date, end_date, cause_death) FROM stdin;
2	4	9	1986-12-01	1987-01-25	f
1	4	9	1975-11-01	1975-12-05	f
3	8	1	1980-03-01	1980-03-05	f
5	9	1	1990-10-10	1990-11-10	f
\.


--
-- Data for Name: vaccination; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vaccination (id, name) FROM stdin;
1	Грипп
2	Простуда
\.


--
-- Data for Name: citizen_vaccinated; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY citizen_vaccinated (citizen_id, vaccination_id, record_id) FROM stdin;
1	1	1
2	1	2
4	1	3
\.


--
-- Data for Name: disease_gives_immunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY disease_gives_immunity (record_id, immunity_id) FROM stdin;
1	1
3	2
5	2
\.


--
-- Data for Name: vaccination_from; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vaccination_from (vaccination_id, disease_id) FROM stdin;
\.


--
-- Data for Name: vaccination_gives_immunity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vaccination_gives_immunity (immunity_id, record_id) FROM stdin;
2	3
\.


--
-- PostgreSQL database dump complete
--

