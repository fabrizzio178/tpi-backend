DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'utn') THEN
    CREATE ROLE utn WITH LOGIN PASSWORD 'utn123';
  END IF;
END$$;
--
-- PostgreSQL database dump
--

\restrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

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

--
-- Name: logistica; Type: DATABASE; Schema: -; Owner: utn
--

CREATE DATABASE logistica WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE logistica OWNER TO utn;

\unrestrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH
\connect logistica
\restrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH

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

--
-- Name: logistica; Type: DATABASE PROPERTIES; Schema: -; Owner: utn
--

ALTER ROLE utn IN DATABASE logistica SET search_path TO 'logistica', 'public';


\unrestrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH
\connect logistica
\restrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH

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

--
-- Name: logistica; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA logistica;


ALTER SCHEMA logistica OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: barrio; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.barrio (
    id_barrio integer NOT NULL,
    nombre character varying(100) NOT NULL,
    calle character varying(100),
    numero character varying(20)
);


ALTER TABLE logistica.barrio OWNER TO postgres;

--
-- Name: barrio_id_barrio_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.barrio_id_barrio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.barrio_id_barrio_seq OWNER TO postgres;

--
-- Name: barrio_id_barrio_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.barrio_id_barrio_seq OWNED BY logistica.barrio.id_barrio;


--
-- Name: camion; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.camion (
    dominio_camion character varying(15) NOT NULL,
    capacidad_peso numeric(12,3),
    capacidad_volumen numeric(12,3),
    disponibilidad boolean DEFAULT true,
    consumo_combustible numeric(10,3),
    costo_base numeric(12,2),
    id_contenedor integer,
    id_transportista integer,
    latitud numeric(9,6),
    longitud numeric(9,6),
    CONSTRAINT chk_capacidades_pos CHECK ((((capacidad_peso IS NULL) OR (capacidad_peso > (0)::numeric)) AND ((capacidad_volumen IS NULL) OR (capacidad_volumen > (0)::numeric))))
);


ALTER TABLE logistica.camion OWNER TO postgres;

--
-- Name: ciudad; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.ciudad (
    id_ciudad integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_barrio integer
);


ALTER TABLE logistica.ciudad OWNER TO postgres;

--
-- Name: ciudad_id_ciudad_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.ciudad_id_ciudad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.ciudad_id_ciudad_seq OWNER TO postgres;

--
-- Name: ciudad_id_ciudad_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.ciudad_id_ciudad_seq OWNED BY logistica.ciudad.id_ciudad;


--
-- Name: cliente; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.cliente (
    id_cliente integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    dni character varying(20),
    mail character varying(150),
    numero character varying(30)
);


ALTER TABLE logistica.cliente OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.cliente_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.cliente_id_cliente_seq OWNER TO postgres;

--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.cliente_id_cliente_seq OWNED BY logistica.cliente.id_cliente;


--
-- Name: contenedor; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.contenedor (
    id_contenedor integer NOT NULL,
    peso numeric(12,3),
    altura numeric(10,3),
    ancho numeric(10,3),
    largo numeric(10,3),
    id_estado integer,
    id_cliente integer,
    volumen numeric(12,3) GENERATED ALWAYS AS (((COALESCE(altura, (0)::numeric) * COALESCE(ancho, (0)::numeric)) * COALESCE(largo, (0)::numeric))) STORED,
    CONSTRAINT chk_dimensiones_pos CHECK ((((altura IS NULL) OR (altura > (0)::numeric)) AND ((ancho IS NULL) OR (ancho > (0)::numeric)) AND ((largo IS NULL) OR (largo > (0)::numeric))))
);


ALTER TABLE logistica.contenedor OWNER TO postgres;

--
-- Name: contenedor_id_contenedor_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.contenedor_id_contenedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.contenedor_id_contenedor_seq OWNER TO postgres;

--
-- Name: contenedor_id_contenedor_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.contenedor_id_contenedor_seq OWNED BY logistica.contenedor.id_contenedor;


--
-- Name: deposito; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.deposito (
    id_deposito integer NOT NULL,
    nombre character varying(100) NOT NULL,
    costo_estadia numeric(12,2) DEFAULT 0,
    latitud numeric(9,6),
    longitud numeric(9,6),
    id_ciudad integer NOT NULL,
    direccion character varying(150)
);


ALTER TABLE logistica.deposito OWNER TO postgres;

--
-- Name: deposito_id_deposito_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.deposito_id_deposito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.deposito_id_deposito_seq OWNER TO postgres;

--
-- Name: deposito_id_deposito_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.deposito_id_deposito_seq OWNED BY logistica.deposito.id_deposito;


--
-- Name: estado; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.estado (
    id_estado integer NOT NULL,
    tipo_entidad character varying(50) NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE logistica.estado OWNER TO postgres;

--
-- Name: estado_id_estado_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.estado_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.estado_id_estado_seq OWNER TO postgres;

--
-- Name: estado_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.estado_id_estado_seq OWNED BY logistica.estado.id_estado;


--
-- Name: punto_tramo; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.punto_tramo (
    id_punto integer NOT NULL,
    tipo_punto character varying(50) NOT NULL,
    longitud numeric(9,6),
    latitud numeric(9,6),
    id_ciudad integer,
    id_deposito integer
);


ALTER TABLE logistica.punto_tramo OWNER TO postgres;

--
-- Name: punto_tramo_id_punto_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.punto_tramo_id_punto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.punto_tramo_id_punto_seq OWNER TO postgres;

--
-- Name: punto_tramo_id_punto_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.punto_tramo_id_punto_seq OWNED BY logistica.punto_tramo.id_punto;


--
-- Name: ruta; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.ruta (
    id_ruta integer NOT NULL,
    id_deposito integer
);


ALTER TABLE logistica.ruta OWNER TO postgres;

--
-- Name: ruta_id_ruta_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.ruta_id_ruta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.ruta_id_ruta_seq OWNER TO postgres;

--
-- Name: ruta_id_ruta_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.ruta_id_ruta_seq OWNED BY logistica.ruta.id_ruta;


--
-- Name: solicitud; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.solicitud (
    id_solicitud integer NOT NULL,
    costo_estimado numeric(12,2),
    tiempo_estimado interval,
    costo_final numeric(12,2),
    tiempo_real interval,
    id_cliente integer,
    id_contenedor integer,
    id_estado integer,
    id_tarifa integer,
    fecha_creacion timestamp without time zone DEFAULT now(),
    observaciones text,
    id_ruta integer
);


ALTER TABLE logistica.solicitud OWNER TO postgres;

--
-- Name: solicitud_id_solicitud_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.solicitud_id_solicitud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.solicitud_id_solicitud_seq OWNER TO postgres;

--
-- Name: solicitud_id_solicitud_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.solicitud_id_solicitud_seq OWNED BY logistica.solicitud.id_solicitud;


--
-- Name: tarifa; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.tarifa (
    id_tarifa integer NOT NULL,
    valor_costo_km_volumen numeric(12,4),
    valor_litro numeric(12,4),
    consumo_promedio numeric(10,3),
    id_deposito integer,
    dominio_camion character varying(15),
    id_contenedor integer,
    cargos_gestion numeric(12,2) DEFAULT 0,
    fecha_vigencia date DEFAULT CURRENT_DATE
);


ALTER TABLE logistica.tarifa OWNER TO postgres;

--
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.tarifa_id_tarifa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.tarifa_id_tarifa_seq OWNER TO postgres;

--
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.tarifa_id_tarifa_seq OWNED BY logistica.tarifa.id_tarifa;


--
-- Name: tramo; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.tramo (
    id_tramo integer NOT NULL,
    tipo character varying(50),
    id_punto integer,
    id_estado integer,
    costo_real numeric(12,2),
    fecha_hora_inicio timestamp without time zone,
    fecha_hora_fin timestamp without time zone,
    id_ruta integer NOT NULL,
    dominio_camion character varying(15),
    costo_estimado numeric(12,2),
    id_punto_destino integer
);


ALTER TABLE logistica.tramo OWNER TO postgres;

--
-- Name: tramo_id_tramo_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.tramo_id_tramo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.tramo_id_tramo_seq OWNER TO postgres;

--
-- Name: tramo_id_tramo_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.tramo_id_tramo_seq OWNED BY logistica.tramo.id_tramo;


--
-- Name: transportista; Type: TABLE; Schema: logistica; Owner: postgres
--

CREATE TABLE logistica.transportista (
    id_transportista integer NOT NULL,
    nombre character varying(120) NOT NULL,
    telefono character varying(30)
);


ALTER TABLE logistica.transportista OWNER TO postgres;

--
-- Name: transportista_id_transportista_seq; Type: SEQUENCE; Schema: logistica; Owner: postgres
--

CREATE SEQUENCE logistica.transportista_id_transportista_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE logistica.transportista_id_transportista_seq OWNER TO postgres;

--
-- Name: transportista_id_transportista_seq; Type: SEQUENCE OWNED BY; Schema: logistica; Owner: postgres
--

ALTER SEQUENCE logistica.transportista_id_transportista_seq OWNED BY logistica.transportista.id_transportista;


--
-- Name: barrio id_barrio; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.barrio ALTER COLUMN id_barrio SET DEFAULT nextval('logistica.barrio_id_barrio_seq'::regclass);


--
-- Name: ciudad id_ciudad; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ciudad ALTER COLUMN id_ciudad SET DEFAULT nextval('logistica.ciudad_id_ciudad_seq'::regclass);


--
-- Name: cliente id_cliente; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.cliente ALTER COLUMN id_cliente SET DEFAULT nextval('logistica.cliente_id_cliente_seq'::regclass);


--
-- Name: contenedor id_contenedor; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.contenedor ALTER COLUMN id_contenedor SET DEFAULT nextval('logistica.contenedor_id_contenedor_seq'::regclass);


--
-- Name: deposito id_deposito; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.deposito ALTER COLUMN id_deposito SET DEFAULT nextval('logistica.deposito_id_deposito_seq'::regclass);


--
-- Name: estado id_estado; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.estado ALTER COLUMN id_estado SET DEFAULT nextval('logistica.estado_id_estado_seq'::regclass);


--
-- Name: punto_tramo id_punto; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.punto_tramo ALTER COLUMN id_punto SET DEFAULT nextval('logistica.punto_tramo_id_punto_seq'::regclass);


--
-- Name: ruta id_ruta; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ruta ALTER COLUMN id_ruta SET DEFAULT nextval('logistica.ruta_id_ruta_seq'::regclass);


--
-- Name: solicitud id_solicitud; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud ALTER COLUMN id_solicitud SET DEFAULT nextval('logistica.solicitud_id_solicitud_seq'::regclass);


--
-- Name: tarifa id_tarifa; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tarifa ALTER COLUMN id_tarifa SET DEFAULT nextval('logistica.tarifa_id_tarifa_seq'::regclass);


--
-- Name: tramo id_tramo; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo ALTER COLUMN id_tramo SET DEFAULT nextval('logistica.tramo_id_tramo_seq'::regclass);


--
-- Name: transportista id_transportista; Type: DEFAULT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.transportista ALTER COLUMN id_transportista SET DEFAULT nextval('logistica.transportista_id_transportista_seq'::regclass);


--
-- Data for Name: barrio; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.barrio (id_barrio, nombre, calle, numero) FROM stdin;
1	Centro	Av. Colón	1200
2	Nueva Córdoba	Hipólito Yrigoyen	300
\.


--
-- Data for Name: camion; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.camion (dominio_camion, capacidad_peso, capacidad_volumen, disponibilidad, consumo_combustible, costo_base, id_contenedor, id_transportista, latitud, longitud) FROM stdin;
ABC123	12000.000	28.000	t	18.500	5200.00	\N	1	-31.420000	-64.190000
XYZ789	8000.000	20.000	t	15.000	4300.00	\N	2	-31.300000	-64.300000
JDK456	10000.000	26.000	t	17.000	4900.00	\N	3	\N	\N
HTH321	14000.000	32.000	t	19.500	5600.00	\N	4	\N	\N
\.


--
-- Data for Name: ciudad; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.ciudad (id_ciudad, nombre, id_barrio) FROM stdin;
1	Córdoba	1
2	Villa Allende	2
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.cliente (id_cliente, nombre, apellido, dni, mail, numero) FROM stdin;
1	Juan	Pérez	30111222	juanp@gmail.com	3515550000
2	Ana	García	40222333	ana.g@gmail.com	3514441111
3	Carlos	López	28123456	carlos.l@gmail.com	351-111-2222
4	María	Suárez	37222333	msuarez@gmail.com	351-222-3333
\.


--
-- Data for Name: contenedor; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.contenedor (id_contenedor, peso, altura, ancho, largo, id_estado, id_cliente) FROM stdin;
1	3500.000	2.600	2.400	6.000	9	1
2	5000.000	2.900	2.500	12.000	9	2
3	4200.000	2.600	2.400	12.000	9	3
4	6500.000	2.900	2.500	12.000	9	4
\.


--
-- Data for Name: deposito; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.deposito (id_deposito, nombre, costo_estadia, latitud, longitud, id_ciudad, direccion) FROM stdin;
1	Depósito Central	2500.00	-31.420100	-64.188800	1	Av. Sabattini 4500
2	Depósito Norte	2200.00	-31.287000	-64.294000	2	Ruta E53 km 9
\.


--
-- Data for Name: estado; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.estado (id_estado, tipo_entidad, nombre) FROM stdin;
1	solicitud	borrador
2	solicitud	programada
3	solicitud	en tránsito
4	solicitud	entregada
5	tramo	estimado
6	tramo	asignado
7	tramo	iniciado
8	tramo	finalizado
9	contenedor	disponible
10	contenedor	en tránsito
11	contenedor	entregado
\.


--
-- Data for Name: punto_tramo; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.punto_tramo (id_punto, tipo_punto, longitud, latitud, id_ciudad, id_deposito) FROM stdin;
1	origen	-64.210000	-31.430000	1	\N
3	destino	-64.295000	-31.280000	2	\N
2	deposito	-64.188800	-31.420100	1	1
4	deposito	-64.188800	-31.420100	1	1
5	deposito	-64.294000	-31.287000	2	2
6	origen	-64.250000	-31.450000	1	\N
7	destino	-64.330000	-31.300000	2	\N
\.


--
-- Data for Name: ruta; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.ruta (id_ruta, id_deposito) FROM stdin;
1	1
3	2
\.


--
-- Data for Name: solicitud; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.solicitud (id_solicitud, costo_estimado, tiempo_estimado, costo_final, tiempo_real, id_cliente, id_contenedor, id_estado, id_tarifa, fecha_creacion, observaciones, id_ruta) FROM stdin;
1	250000.00	2 days 05:00:00	\N	\N	1	1	2	1	2025-10-21 12:45:41.558997	Entrega prioritaria	1
2	350000.00	3 days 04:00:00	\N	\N	4	4	2	2	2025-10-21 13:05:59.863959	Ruta con depósitos intermedios (auto-generada)	3
\.


--
-- Data for Name: tarifa; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.tarifa (id_tarifa, valor_costo_km_volumen, valor_litro, consumo_promedio, id_deposito, dominio_camion, id_contenedor, cargos_gestion, fecha_vigencia) FROM stdin;
1	0.9500	1200.0000	16.500	1	ABC123	1	1500.00	2025-10-21
2	1.0500	1250.0000	17.200	2	HTH321	4	2000.00	2025-10-21
\.


--
-- Data for Name: tramo; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.tramo (id_tramo, tipo, id_punto, id_estado, costo_real, fecha_hora_inicio, fecha_hora_fin, id_ruta, dominio_camion, costo_estimado, id_punto_destino) FROM stdin;
1	origen-deposito	1	6	\N	2025-10-21 12:45:41.558997	\N	1	ABC123	800.00	\N
2	deposito-destino	2	7	\N	2025-10-21 12:45:41.558997	\N	1	XYZ789	1200.00	\N
4	origen-deposito	6	6	\N	2025-10-21 13:01:30.225404	\N	3	ABC123	900.00	4
5	deposito-deposito	4	6	\N	\N	\N	3	HTH321	1500.00	5
6	deposito-destino	5	6	\N	\N	\N	3	JDK456	1300.00	7
\.


--
-- Data for Name: transportista; Type: TABLE DATA; Schema: logistica; Owner: postgres
--

COPY logistica.transportista (id_transportista, nombre, telefono) FROM stdin;
1	Logística Sur	351-777-5555
2	Rutas del Centro	351-666-4444
3	Flete Arg	351-500-1000
4	Norte Cargo	351-500-2000
\.


--
-- Name: barrio_id_barrio_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.barrio_id_barrio_seq', 2, true);


--
-- Name: ciudad_id_ciudad_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.ciudad_id_ciudad_seq', 2, true);


--
-- Name: cliente_id_cliente_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.cliente_id_cliente_seq', 4, true);


--
-- Name: contenedor_id_contenedor_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.contenedor_id_contenedor_seq', 4, true);


--
-- Name: deposito_id_deposito_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.deposito_id_deposito_seq', 2, true);


--
-- Name: estado_id_estado_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.estado_id_estado_seq', 11, true);


--
-- Name: punto_tramo_id_punto_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.punto_tramo_id_punto_seq', 7, true);


--
-- Name: ruta_id_ruta_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.ruta_id_ruta_seq', 3, true);


--
-- Name: solicitud_id_solicitud_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.solicitud_id_solicitud_seq', 2, true);


--
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.tarifa_id_tarifa_seq', 2, true);


--
-- Name: tramo_id_tramo_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.tramo_id_tramo_seq', 6, true);


--
-- Name: transportista_id_transportista_seq; Type: SEQUENCE SET; Schema: logistica; Owner: postgres
--

SELECT pg_catalog.setval('logistica.transportista_id_transportista_seq', 4, true);


--
-- Name: barrio barrio_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.barrio
    ADD CONSTRAINT barrio_pkey PRIMARY KEY (id_barrio);


--
-- Name: camion camion_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.camion
    ADD CONSTRAINT camion_pkey PRIMARY KEY (dominio_camion);


--
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (id_ciudad);


--
-- Name: cliente cliente_dni_key; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.cliente
    ADD CONSTRAINT cliente_dni_key UNIQUE (dni);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente);


--
-- Name: contenedor contenedor_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.contenedor
    ADD CONSTRAINT contenedor_pkey PRIMARY KEY (id_contenedor);


--
-- Name: deposito deposito_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.deposito
    ADD CONSTRAINT deposito_pkey PRIMARY KEY (id_deposito);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado);


--
-- Name: punto_tramo punto_tramo_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.punto_tramo
    ADD CONSTRAINT punto_tramo_pkey PRIMARY KEY (id_punto);


--
-- Name: ruta ruta_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (id_ruta);


--
-- Name: solicitud solicitud_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT solicitud_pkey PRIMARY KEY (id_solicitud);


--
-- Name: tarifa tarifa_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tarifa
    ADD CONSTRAINT tarifa_pkey PRIMARY KEY (id_tarifa);


--
-- Name: tramo tramo_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_pkey PRIMARY KEY (id_tramo);


--
-- Name: transportista transportista_pkey; Type: CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.transportista
    ADD CONSTRAINT transportista_pkey PRIMARY KEY (id_transportista);


--
-- Name: idx_camion_disp; Type: INDEX; Schema: logistica; Owner: postgres
--

CREATE INDEX idx_camion_disp ON logistica.camion USING btree (disponibilidad);


--
-- Name: idx_cont_cliente; Type: INDEX; Schema: logistica; Owner: postgres
--

CREATE INDEX idx_cont_cliente ON logistica.contenedor USING btree (id_cliente);


--
-- Name: idx_deposito_ciudad; Type: INDEX; Schema: logistica; Owner: postgres
--

CREATE INDEX idx_deposito_ciudad ON logistica.deposito USING btree (id_ciudad);


--
-- Name: idx_sol_cliente; Type: INDEX; Schema: logistica; Owner: postgres
--

CREATE INDEX idx_sol_cliente ON logistica.solicitud USING btree (id_cliente);


--
-- Name: idx_tramo_ruta; Type: INDEX; Schema: logistica; Owner: postgres
--

CREATE INDEX idx_tramo_ruta ON logistica.tramo USING btree (id_ruta);


--
-- Name: camion camion_id_contenedor_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.camion
    ADD CONSTRAINT camion_id_contenedor_fkey FOREIGN KEY (id_contenedor) REFERENCES logistica.contenedor(id_contenedor);


--
-- Name: camion camion_id_transportista_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.camion
    ADD CONSTRAINT camion_id_transportista_fkey FOREIGN KEY (id_transportista) REFERENCES logistica.transportista(id_transportista);


--
-- Name: ciudad ciudad_id_barrio_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ciudad
    ADD CONSTRAINT ciudad_id_barrio_fkey FOREIGN KEY (id_barrio) REFERENCES logistica.barrio(id_barrio);


--
-- Name: contenedor contenedor_id_cliente_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.contenedor
    ADD CONSTRAINT contenedor_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES logistica.cliente(id_cliente);


--
-- Name: contenedor contenedor_id_estado_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.contenedor
    ADD CONSTRAINT contenedor_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES logistica.estado(id_estado);


--
-- Name: deposito deposito_id_ciudad_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.deposito
    ADD CONSTRAINT deposito_id_ciudad_fkey FOREIGN KEY (id_ciudad) REFERENCES logistica.ciudad(id_ciudad);


--
-- Name: solicitud fk_solicitud_ruta; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT fk_solicitud_ruta FOREIGN KEY (id_ruta) REFERENCES logistica.ruta(id_ruta) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: solicitud fk_solicitud_tarifa; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT fk_solicitud_tarifa FOREIGN KEY (id_tarifa) REFERENCES logistica.tarifa(id_tarifa);


--
-- Name: punto_tramo punto_tramo_id_ciudad_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.punto_tramo
    ADD CONSTRAINT punto_tramo_id_ciudad_fkey FOREIGN KEY (id_ciudad) REFERENCES logistica.ciudad(id_ciudad);


--
-- Name: punto_tramo punto_tramo_id_deposito_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.punto_tramo
    ADD CONSTRAINT punto_tramo_id_deposito_fkey FOREIGN KEY (id_deposito) REFERENCES logistica.deposito(id_deposito);


--
-- Name: ruta ruta_id_deposito_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.ruta
    ADD CONSTRAINT ruta_id_deposito_fkey FOREIGN KEY (id_deposito) REFERENCES logistica.deposito(id_deposito);


--
-- Name: solicitud solicitud_id_cliente_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT solicitud_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES logistica.cliente(id_cliente);


--
-- Name: solicitud solicitud_id_contenedor_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT solicitud_id_contenedor_fkey FOREIGN KEY (id_contenedor) REFERENCES logistica.contenedor(id_contenedor);


--
-- Name: solicitud solicitud_id_estado_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.solicitud
    ADD CONSTRAINT solicitud_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES logistica.estado(id_estado);


--
-- Name: tarifa tarifa_dominio_camion_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tarifa
    ADD CONSTRAINT tarifa_dominio_camion_fkey FOREIGN KEY (dominio_camion) REFERENCES logistica.camion(dominio_camion);


--
-- Name: tarifa tarifa_id_contenedor_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tarifa
    ADD CONSTRAINT tarifa_id_contenedor_fkey FOREIGN KEY (id_contenedor) REFERENCES logistica.contenedor(id_contenedor);


--
-- Name: tarifa tarifa_id_deposito_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tarifa
    ADD CONSTRAINT tarifa_id_deposito_fkey FOREIGN KEY (id_deposito) REFERENCES logistica.deposito(id_deposito);


--
-- Name: tramo tramo_dominio_camion_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_dominio_camion_fkey FOREIGN KEY (dominio_camion) REFERENCES logistica.camion(dominio_camion);


--
-- Name: tramo tramo_id_estado_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES logistica.estado(id_estado);


--
-- Name: tramo tramo_id_punto_destino_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_id_punto_destino_fkey FOREIGN KEY (id_punto_destino) REFERENCES logistica.punto_tramo(id_punto);


--
-- Name: tramo tramo_id_punto_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_id_punto_fkey FOREIGN KEY (id_punto) REFERENCES logistica.punto_tramo(id_punto);


--
-- Name: tramo tramo_id_ruta_fkey; Type: FK CONSTRAINT; Schema: logistica; Owner: postgres
--

ALTER TABLE ONLY logistica.tramo
    ADD CONSTRAINT tramo_id_ruta_fkey FOREIGN KEY (id_ruta) REFERENCES logistica.ruta(id_ruta);


--
-- Name: SCHEMA logistica; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA logistica TO utn;


--
-- Name: TABLE barrio; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.barrio TO utn;


--
-- Name: SEQUENCE barrio_id_barrio_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.barrio_id_barrio_seq TO utn;


--
-- Name: TABLE camion; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.camion TO utn;


--
-- Name: TABLE ciudad; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.ciudad TO utn;


--
-- Name: SEQUENCE ciudad_id_ciudad_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.ciudad_id_ciudad_seq TO utn;


--
-- Name: TABLE cliente; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.cliente TO utn;


--
-- Name: SEQUENCE cliente_id_cliente_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.cliente_id_cliente_seq TO utn;


--
-- Name: TABLE contenedor; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.contenedor TO utn;


--
-- Name: SEQUENCE contenedor_id_contenedor_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.contenedor_id_contenedor_seq TO utn;


--
-- Name: TABLE deposito; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.deposito TO utn;


--
-- Name: SEQUENCE deposito_id_deposito_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.deposito_id_deposito_seq TO utn;


--
-- Name: TABLE estado; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.estado TO utn;


--
-- Name: SEQUENCE estado_id_estado_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.estado_id_estado_seq TO utn;


--
-- Name: TABLE punto_tramo; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.punto_tramo TO utn;


--
-- Name: SEQUENCE punto_tramo_id_punto_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.punto_tramo_id_punto_seq TO utn;


--
-- Name: TABLE ruta; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.ruta TO utn;


--
-- Name: SEQUENCE ruta_id_ruta_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.ruta_id_ruta_seq TO utn;


--
-- Name: TABLE solicitud; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.solicitud TO utn;


--
-- Name: SEQUENCE solicitud_id_solicitud_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.solicitud_id_solicitud_seq TO utn;


--
-- Name: TABLE tarifa; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.tarifa TO utn;


--
-- Name: SEQUENCE tarifa_id_tarifa_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.tarifa_id_tarifa_seq TO utn;


--
-- Name: TABLE tramo; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.tramo TO utn;


--
-- Name: SEQUENCE tramo_id_tramo_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.tramo_id_tramo_seq TO utn;


--
-- Name: TABLE transportista; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT ON TABLE logistica.transportista TO utn;


--
-- Name: SEQUENCE transportista_id_transportista_seq; Type: ACL; Schema: logistica; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE logistica.transportista_id_transportista_seq TO utn;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: logistica; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA logistica GRANT SELECT,USAGE ON SEQUENCES TO utn;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: logistica; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA logistica GRANT ALL ON FUNCTIONS TO utn;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: logistica; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA logistica GRANT SELECT ON TABLES TO utn;


--
-- PostgreSQL database dump complete
--

\unrestrict NUocPK2ivn39KUVmrTPykafbVsgUYTtddpnT3WYqWTnj6BsmRnn1oqFDuwaeyZH

