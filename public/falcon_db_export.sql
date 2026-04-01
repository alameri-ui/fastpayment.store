--
-- PostgreSQL database dump
--

\restrict gbh0y0TIDKU6wYgt3YNjNeh1NkYLwNztxqGZmtFHt193kwbJSHUXzbZni7Y0QGR

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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

DROP INDEX IF EXISTS public."IDX_session_expire";
ALTER TABLE IF EXISTS ONLY public.whatsapp_otps DROP CONSTRAINT IF EXISTS whatsapp_otps_pkey;
ALTER TABLE IF EXISTS ONLY public.site_settings DROP CONSTRAINT IF EXISTS site_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.session DROP CONSTRAINT IF EXISTS session_pkey;
ALTER TABLE IF EXISTS ONLY public.server_updates DROP CONSTRAINT IF EXISTS server_updates_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.product_reviews DROP CONSTRAINT IF EXISTS product_reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.m3u_entries DROP CONSTRAINT IF EXISTS m3u_entries_pkey;
ALTER TABLE IF EXISTS ONLY public.m3u_entries DROP CONSTRAINT IF EXISTS m3u_entries_entry_hash_key;
ALTER TABLE IF EXISTS ONLY public.gateway_settings DROP CONSTRAINT IF EXISTS gateway_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.gateway_settings DROP CONSTRAINT IF EXISTS gateway_settings_gateway_id_unique;
ALTER TABLE IF EXISTS ONLY public.digital_cards DROP CONSTRAINT IF EXISTS digital_cards_pkey;
ALTER TABLE IF EXISTS ONLY public.customers DROP CONSTRAINT IF EXISTS customers_pkey;
ALTER TABLE IF EXISTS ONLY public.customers DROP CONSTRAINT IF EXISTS customers_email_key;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_username_unique;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_pkey;
ALTER TABLE IF EXISTS public.whatsapp_otps ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.server_updates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.products ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product_reviews ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.m3u_entries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.gateway_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.digital_cards ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_users ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.whatsapp_otps_id_seq;
DROP TABLE IF EXISTS public.whatsapp_otps;
DROP TABLE IF EXISTS public.site_settings;
DROP TABLE IF EXISTS public.session;
DROP SEQUENCE IF EXISTS public.server_updates_id_seq;
DROP TABLE IF EXISTS public.server_updates;
DROP SEQUENCE IF EXISTS public.products_id_seq;
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public.product_reviews_id_seq;
DROP TABLE IF EXISTS public.product_reviews;
DROP SEQUENCE IF EXISTS public.orders_id_seq;
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public.m3u_entries_id_seq;
DROP TABLE IF EXISTS public.m3u_entries;
DROP SEQUENCE IF EXISTS public.gateway_settings_id_seq;
DROP TABLE IF EXISTS public.gateway_settings;
DROP SEQUENCE IF EXISTS public.digital_cards_id_seq;
DROP TABLE IF EXISTS public.digital_cards;
DROP SEQUENCE IF EXISTS public.customers_id_seq;
DROP TABLE IF EXISTS public.customers;
DROP SEQUENCE IF EXISTS public.admin_users_id_seq;
DROP TABLE IF EXISTS public.admin_users;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    role text DEFAULT 'staff'::text NOT NULL,
    display_name text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: digital_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_cards (
    id integer NOT NULL,
    product_id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    host text NOT NULL,
    is_sold boolean DEFAULT false NOT NULL,
    order_id integer
);


--
-- Name: digital_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_cards_id_seq OWNED BY public.digital_cards.id;


--
-- Name: gateway_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gateway_settings (
    id integer NOT NULL,
    gateway_id text NOT NULL,
    name text NOT NULL,
    icon text DEFAULT '💳'::text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    redirect_url text,
    sort_order integer DEFAULT 0 NOT NULL,
    woocommerce_gateway text,
    api_key text,
    api_secret text
);


--
-- Name: gateway_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gateway_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gateway_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gateway_settings_id_seq OWNED BY public.gateway_settings.id;


--
-- Name: m3u_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.m3u_entries (
    id integer NOT NULL,
    entry_hash text NOT NULL,
    title text NOT NULL,
    group_title text,
    logo_url text,
    type text DEFAULT 'channel'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: m3u_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.m3u_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: m3u_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.m3u_entries_id_seq OWNED BY public.m3u_entries.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_name text NOT NULL,
    customer_email text NOT NULL,
    customer_phone text NOT NULL,
    total_amount integer NOT NULL,
    payment_gateway text NOT NULL,
    payment_status text DEFAULT 'pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    product_id integer,
    review_request_sent_at timestamp without time zone
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: product_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_reviews (
    id integer NOT NULL,
    product_id integer NOT NULL,
    reviewer_name text NOT NULL,
    rating integer NOT NULL,
    comment text DEFAULT ''::text NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    customer_email text
);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_reviews_id_seq OWNED BY public.product_reviews.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    price integer NOT NULL,
    features text[] DEFAULT '{}'::text[] NOT NULL,
    image_url text,
    cart_url text,
    tags text[] DEFAULT '{}'::text[],
    meta_keywords text,
    meta_description text,
    long_description text,
    purchase_count integer DEFAULT 0 NOT NULL,
    original_price integer,
    is_hidden boolean DEFAULT false NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: server_updates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_updates (
    id integer NOT NULL,
    title text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    image_url text,
    type text DEFAULT 'other'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: server_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.server_updates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.server_updates_id_seq OWNED BY public.server_updates.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_settings (
    key text NOT NULL,
    value text NOT NULL
);


--
-- Name: whatsapp_otps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_otps (
    id integer NOT NULL,
    phone text NOT NULL,
    code text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: whatsapp_otps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.whatsapp_otps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: whatsapp_otps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.whatsapp_otps_id_seq OWNED BY public.whatsapp_otps.id;


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: digital_cards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_cards ALTER COLUMN id SET DEFAULT nextval('public.digital_cards_id_seq'::regclass);


--
-- Name: gateway_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_settings ALTER COLUMN id SET DEFAULT nextval('public.gateway_settings_id_seq'::regclass);


--
-- Name: m3u_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.m3u_entries ALTER COLUMN id SET DEFAULT nextval('public.m3u_entries_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews ALTER COLUMN id SET DEFAULT nextval('public.product_reviews_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: server_updates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_updates ALTER COLUMN id SET DEFAULT nextval('public.server_updates_id_seq'::regclass);


--
-- Name: whatsapp_otps id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_otps ALTER COLUMN id SET DEFAULT nextval('public.whatsapp_otps_id_seq'::regclass);


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_users (id, username, password_hash, role, display_name, created_at) FROM stdin;
1	admin	$2b$12$kisRTEGU8zGcla1GvkaFn.XcJ8nMAWQfzyrolu46CJ2mZTcsFNTH6	owner	المدير العام	2026-03-28 20:46:57.946196
2	Amer	$2b$12$UpG4A3lUwWssPIaKVVnlROSAW23Pp9jJGRRM8aHyBx6tMQFvUCGSa	owner	amer	2026-03-28 21:56:53.462627
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, email, password_hash, name, phone, created_at) FROM stdin;
1	alzh64@gmail.com	$2b$10$tcNDl20JoOreVFX7Jb3wzunwOHn4jWXHyaOQdFQAylOLBAH9/zTUW	zaid	+966531832836	2026-03-29 18:47:11.693497
\.


--
-- Data for Name: digital_cards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_cards (id, product_id, username, password, host, is_sold, order_id) FROM stdin;
3	1	usar.73364734.passsord	host	falcom	f	\N
1	1	user1	pass1	http://falcon.tv:8080	t	50
2	1	user2	pass2	http://falcon.tv:8080	t	53
\.


--
-- Data for Name: gateway_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.gateway_settings (id, gateway_id, name, icon, enabled, redirect_url, sort_order, woocommerce_gateway, api_key, api_secret) FROM stdin;
1	myfatoorah	ماي فاتورة (MyFatoorah)	🏦	f	\N	1	\N	\N	\N
2	moyasar	ميسر (Moyasar)	💳	f	\N	2	\N	\N	\N
3	paytabs	بي تابس (PayTabs)	💳	f	https://aziz-d.com/	3	\N	\N	\N
4	telr	تيلر (Telr)	🌍	f	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062	4	\N	\N	\N
5	hyperpay	هايبر باي (HyperPay)	⚡	f	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062	5	\N	\N	\N
137	tap	تاب للمدفوعات (Tap Payments)	🔵	f	\N	6	\N	\N	\N
6	ott	أو تي تي (OTT)	🛡️	f	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062	6	\N	\N	\N
138	stcpay	STC Pay	📱	f	\N	7	\N	\N	\N
7	paypal	باي بال (PayPal)	🅿️	f	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062	7	\N	\N	\N
139	urpay	UrPay	💚	f	\N	8	\N	\N	\N
8	bitcoin	بيتكوين (Bitcoin)	₿	f	3AEobNzfD1ENEtPBwPD5yK7UKLwjhAo19h	8	\N	\N	\N
9	crypto	عملات مشفرة (Crypto)	🔐	f	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062	9	\N	\N	\N
18	usdt	USDT (تيثر)	💵	f	3AEobNzfD1ENEtPBwPD5yK7UKLwjhAo19h	9	\N	\N	\N
141	sadad	سداد (SADAD)	🏛️	f	\N	10	\N	\N	\N
30	trx	TRON (TRX)	⚡	f	\N	11	\N	\N	\N
31	ton	TON	💎	f	\N	12	\N	\N	\N
143	geidea	جيديا (Geidea)	💎	f	\N	12	\N	\N	\N
144	kashier	كاشير (Kashier)	🧾	t	\N	13	\N	\N	\N
33	link	Chainlink (LINK)	🔗	f	\N	14	\N	\N	\N
29	eth	Ethereum (ETH)	Ξ	t	\N	10	\N	\N	\N
32	usdc	USDC	💲	t	\N	13	\N	\N	\N
34	uni	Uniswap (UNI)	🦄	t	\N	15	\N	\N	\N
615	direct_checkout	الدفع المباشر	🖥️	t	https://aziz-d.com/wp-json/aziz/v1/sync-order	0	\N	azz_3e7fb8f2bd7b1a9100aa8670803cebb8896aa35f01feb3bd	cs_86800d56e90843eb2687dea686a9617c21efa49a
146	stripe	سترايب (Stripe)	💜	t	\N	21	\N	\N	\N
140	paylink	باي لينك (PayLink)	🔗	t	\N	9	\N	\N	\N
\.


--
-- Data for Name: m3u_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.m3u_entries (id, entry_hash, title, group_title, logo_url, type, created_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, customer_name, customer_email, customer_phone, total_amount, payment_gateway, payment_status, created_at, product_id, review_request_sent_at) FROM stdin;
57	شريفة الربعي	aziz.desigen1@gmail.com	0539477920	499	myfatoorah	paid	2026-03-29 20:21:00.523622	3	\N
56	شريفة الربعي	aziz.desigen1@gmail.com	0539477920	45	myfatoorah	paid	2026-03-29 19:25:41.05969	4	\N
55	aziz des	aziz.desigen1@gmail.com	0539477920	110	myfatoorah	paid	2026-03-29 19:24:34.853023	2	\N
54	aziz des	aziz.desigen1@gmail.com	0539477920	499	myfatoorah	paid	2026-03-29 19:24:22.523372	3	\N
53	aziz des	aziz.desigen1@gmail.com	0539477920	199	paytabs	paid	2026-03-29 18:48:19.166316	1	\N
52	aziz des	aziz.desigen1@gmail.com	0539477920	499	myfatoorah	paid	2026-03-29 18:47:56.673672	3	\N
51	aziz des	aziz.desigen1@gmail.com	0539477920	45	myfatoorah	paid	2026-03-29 18:47:41.416281	4	\N
50	aziz des	aziz.desigen1@gmail.com	0539477920	199	myfatoorah	paid	2026-03-29 18:46:33.769623	1	\N
49	aziz des	aziz.desigen1@gmail.com	0539477920	499	telr	paid	2026-03-29 17:50:53.760536	\N	\N
48	aziz des	aziz.desigen1@gmail.com	0539477920	499	myfatoorah	paid	2026-03-29 17:50:38.198387	\N	\N
4	aziz des	aziz.desigen1@gmail.com	0539477920	110	paypal	paid	2026-03-28 20:31:07.706583	\N	\N
5	aziz des	aziz.desigen1@gmail.com	0539477920	110	telr	paid	2026-03-28 20:31:11.323491	\N	\N
7	aziz des	aziz.desigen1@gmail.com	0539477920	110	usdc	paid	2026-03-28 21:25:48.288067	\N	\N
8	aziz des	aziz.desigen1@gmail.com	0539477920	110	myfatoorah	paid	2026-03-28 21:29:45.548922	\N	\N
3	aziz des	aziz.desigen1@gmail.com	0539477920	110	bitcoin	paid	2026-03-28 19:56:23.645105	\N	\N
2	aziz des	aziz.desigen1@gmail.com	0539477920	110	paytabs	paid	2026-03-28 19:51:30.626061	\N	\N
1	aziz des	aziz.desigen1@gmail.com	0539477920	110	paytabs	paid	2026-03-28 19:48:38.699233	\N	\N
9	aziz des	aziz.desigen1@gmail.com	0539477920	110	bitcoin	paid	2026-03-28 21:32:23.133607	\N	\N
6	aziz des	aziz.desigen1@gmail.com	0539477920	110	paytabs	paid	2026-03-28 20:31:14.506705	\N	\N
10	falcon	help@falcon-iptvpro.com	0531832836	45	urpay	paid	2026-03-29 14:59:07.655072	\N	\N
43	aziz des	aziz.desigen1@gmail.com	0539477920	45	myfatoorah	paid	2026-03-29 16:22:38.789944	\N	\N
44	aziz des	aziz.desigen1@gmail.com	0539477920	110	paytabs	paid	2026-03-29 17:23:40.371084	\N	\N
45	aziz des	aziz.desigen1@gmail.com	0539477920	499	moyasar	paid	2026-03-29 17:33:49.576849	\N	\N
46	aziz des	aziz.desigen1@gmail.com	0539477920	45	myfatoorah	paid	2026-03-29 17:49:59.166148	\N	\N
47	aziz des	aziz.desigen1@gmail.com	0539477920	45	moyasar	paid	2026-03-29 17:50:22.516336	\N	\N
59	aziz des	aziz.desigen1@gmail.com	0539477920	199	urpay	paid	2026-03-29 20:41:41.543554	289	\N
58	شريفة الربعي	aziz.desigen1@gmail.com	0539477920	199	link	paid	2026-03-29 20:41:26.749154	289	\N
60	aziz des	aziz.desigen1@gmail.com	0539477920	199	myfatoorah	paid	2026-03-29 20:43:21.717238	289	\N
77	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	paid	2026-03-29 22:26:10.809351	4	\N
72	aziz des	aziz.desigen1@gmail.com	0539477920	45	kashier	paid	2026-03-29 21:27:34.568712	4	\N
71	aziz des	aziz.desigen1@gmail.com	0539477920	110	kashier	paid	2026-03-29 21:27:17.144988	2	\N
70	aziz des	aziz.desigen1@gmail.com	0539477920	199	eth	paid	2026-03-29 21:27:02.884922	289	\N
69	aziz des	aziz.desigen1@gmail.com	0539477920	499	eth	paid	2026-03-29 21:26:45.927955	3	\N
68	aziz des	aziz.desigen1@gmail.com	0539477920	199	direct_checkout	paid	2026-03-29 21:22:55.245015	289	\N
67	aziz des	aziz.desigen1@gmail.com	0539477920	199	direct_checkout	paid	2026-03-29 21:21:32.087832	289	\N
66	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	paid	2026-03-29 21:18:12.024597	4	\N
65	احمد محمد	aziz.desigen1@gmail.com	0539477920	499	urpay	paid	2026-03-29 21:00:52.381772	3	\N
64	aziz des	aziz.desigen1@gmail.com	0539477920	45	ton	paid	2026-03-29 21:00:25.980483	4	\N
63	aziz des	aziz.desigen1@gmail.com	0539477920	110	link	paid	2026-03-29 21:00:14.96352	2	\N
62	aziz des	aziz.desigen1@gmail.com	0539477920	499	moyasar	paid	2026-03-29 20:59:58.815647	3	\N
61	aziz des	aziz.desigen1@gmail.com	0539477920	45	moyasar	paid	2026-03-29 20:59:38.646383	4	\N
74	aziz des	aziz.desigen1@gmail.com	0539477920	45	uni	paid	2026-03-29 21:29:06.330316	4	\N
75	aziz des	aziz.desigen1@gmail.com	0539477920	199	direct_checkout	pending	2026-03-29 21:42:32.854538	289	\N
76	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	pending	2026-03-29 22:24:46.033363	4	\N
78	aziz des	aziz.desigen1@gmail.com	0539477920	199	direct_checkout	pending	2026-03-29 22:34:08.091156	289	\N
73	aziz des	aziz.desigen1@gmail.com	0539477920	45	eth	paid	2026-03-29 21:27:55.98489	4	2026-03-29 22:37:35.574882
79	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	pending	2026-03-29 22:46:45.885876	4	\N
80	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	pending	2026-03-29 22:48:19.605845	4	\N
81	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	pending	2026-03-29 23:13:39.701799	4	\N
82	aziz des	aziz.desigen1@gmail.com	0539477920	45	direct_checkout	pending	2026-03-29 23:16:48.691787	4	\N
83	شريفة الربعي	aziz.desigen1@gmail.com	0539477920	199	eth	pending	2026-03-29 23:21:13.303363	289	\N
\.


--
-- Data for Name: product_reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_reviews (id, product_id, reviewer_name, rating, comment, approved, created_at, customer_email) FROM stdin;
170	4	خاطر الشلال	5	اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2025-03-28 22:14:05.115266	\N
171	289	صفاء الزبيدي	5	أكثر من رائع — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2022-01-05 23:38:06.15101	\N
172	2	مضاوي العنزي	5	يستاهل أكثر من خمس نجوم — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2021-01-25 17:43:17.07083	\N
173	3	غنى الفقيه	5	صراحة ممتاز — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2020-12-08 09:07:39.809666	\N
174	2	يعقوب السيف	5	يستاهل أكثر من خمس نجوم — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2024-10-08 15:42:25.893598	\N
175	2	طلال العسكر	5	يستاهل أكثر من خمس نجوم — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2021-11-10 17:21:54.275271	\N
176	289	وائل الفواز	5	محترفين — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2020-06-14 20:45:27.533723	\N
177	3	يُمنى المرشدي	5	أكثر من رائع — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2022-06-30 01:20:55.328085	\N
178	2	جنان السبيعي	4	ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2020-03-12 15:05:10.084274	\N
179	289	طارق الحمادي	5	خدمة استثنائية — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2022-02-10 23:52:00.034559	\N
180	4	شريان الحربي	5	ممتاز جداً — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2020-10-15 22:53:42.976041	\N
181	3	منيرة الزهراني	5	ممتاز جداً — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2022-12-11 22:44:53.370986	\N
182	289	عزيزة الربيعي	5	خدمة استثنائية — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2021-07-24 06:44:56.893512	\N
183	2	زينة الجابري	5	يستاهل أكثر من خمس نجوم — الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2024-02-11 19:07:15.132929	\N
184	2	ضيف الله العقيل	5	أكثر من رائع — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2024-03-18 00:05:42.721884	\N
185	3	هيفاء الصوينع	5	صراحة ممتاز — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-06-21 21:51:46.830292	\N
186	2	شهاب الخطيب	5	ممتاز جداً — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2022-12-08 01:57:24.981064	\N
187	3	نجلاء الصاعدي	5	تجربة لا تنسى — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2021-01-21 06:22:56.421419	\N
188	2	نيرة الشريف	5	محترفين — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-12-20 03:18:24.531957	\N
189	2	لطيف المطيري	5	رائع — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2025-11-27 07:44:14.549721	\N
190	289	ضياء الحميدان	5	الأفضل بدون منازع — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2021-07-24 09:42:22.442421	\N
191	2	نزار المحيميد	5	أكثر من رائع — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2024-12-12 02:51:54.433139	\N
192	4	قيس الفهد	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2024-04-14 18:36:26.804734	\N
193	2	دانة الحميد	4	الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2021-02-17 23:55:41.473135	\N
194	4	بدر المطرفي	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2020-07-15 02:31:30.62805	\N
195	3	حياة العتيق	4	واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2024-06-21 21:50:43.653061	\N
196	4	قمر السبيعي	5	خدمة استثنائية — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2023-04-13 15:26:14.619981	\N
197	4	مياسة المرواني	5	ممتاز جداً — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2021-01-10 06:42:23.494323	\N
198	4	ختام السليم	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2026-02-06 08:34:20.06484	\N
199	4	شفق العيسى	5	ما قصّروا — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2023-04-12 17:02:16.003897	\N
200	2	ريما الحصان	5	رائع — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2024-06-14 13:54:24.592341	\N
201	2	رافد الزهراني	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2020-12-16 08:06:33.825536	\N
202	289	جوهرة الشريدة	5	ممتاز جداً — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2021-03-20 07:28:30.008527	\N
203	2	يُمنى المرشدي	5	أنصح الكل — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2022-09-13 07:03:05.37909	\N
204	289	سارة الدوسري	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2022-11-19 05:50:57.016585	\N
205	4	بسام العبيد	4	تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2020-10-04 21:07:47.816429	\N
206	2	تماضر الرشيدي	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-01-09 09:07:10.182842	\N
207	3	حاتم الشراري	5	ما شاء الله — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2026-03-08 06:34:39.388265	\N
208	289	تيسير المزروع	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2025-01-17 14:19:09.109769	\N
209	3	شداد الصوينع	5	الأفضل بدون منازع — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2025-10-11 18:31:55.774015	\N
210	2	سماء الديحاني	4	ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2025-12-27 15:59:44.418426	\N
211	4	حميد الزهيري	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2021-01-11 11:12:35.323213	\N
212	289	حياة العتيق	4	خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2020-09-29 21:23:14.007327	\N
213	289	مشاري القرشي	5	خدمة استثنائية — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2026-01-11 18:26:12.462769	\N
214	2	نجمة السلوم	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2025-10-07 13:57:25.485737	\N
215	4	إياد المسلم	5	محترفين — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2022-05-23 11:07:08.963616	\N
216	3	أروى الدبيان	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2021-06-15 05:55:54.837061	\N
217	289	معاذ العريفي	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2023-05-26 07:18:29.477767	\N
218	289	ياسر العسيري	5	وايد زين — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2023-08-27 17:04:05.037373	\N
219	4	ندى العجمي	5	أنصح الكل — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2023-08-16 00:53:23.273214	\N
220	4	نادية السلطان	5	الأفضل بدون منازع — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2020-06-10 00:28:02.565574	\N
221	3	مريم الخلف	5	الأفضل بدون منازع — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2024-12-14 19:58:03.023616	\N
222	3	يحيى العوفي	5	يستاهل أكثر من خمس نجوم — كل الباقات بأسعار معقولة وما في خسارة	t	2026-01-11 12:43:01.318522	\N
223	4	مروان السبيعي	5	ممتاز جداً — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2020-05-24 15:57:47.951292	\N
224	3	هيام العسكر	4	التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2020-08-04 17:49:29.138731	\N
225	4	سناء الثبيتي	5	وايد زين — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2020-08-29 23:32:46.699655	\N
226	4	رهام الحربي	5	ممتاز جداً — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2022-08-26 14:53:59.649935	\N
227	4	سعود الفيفي	5	وايد زين — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2024-09-24 06:36:53.809864	\N
228	2	ثابت العتيبي	5	خدمة استثنائية — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2024-01-11 01:39:15.89111	\N
229	3	سجاد الهشيم	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2024-11-05 12:29:41.116423	\N
230	4	عنان الشثري	5	خدمة استثنائية — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2022-09-25 05:36:45.063281	\N
231	289	وسام البليهد	4	الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2026-02-16 14:20:00.379127	\N
232	289	وديع الزرعي	5	وايد زين — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2020-01-24 16:58:56.595122	\N
233	4	رغد الشلهوب	5	تجربة لا تنسى — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2022-08-30 08:57:25.60459	\N
234	289	وليد الزير	4	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-03-11 20:20:54.511125	\N
235	4	سليم الثبيتي	5	تجربة لا تنسى — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2025-12-18 17:31:25.266479	\N
236	2	غدير الحارثي	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2025-01-31 10:27:18.278487	\N
237	2	بديع الغانم	5	أكثر من رائع — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2022-03-26 00:36:34.40401	\N
238	2	غادة الحربي	5	يستاهل أكثر من خمس نجوم — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2022-10-09 14:56:56.116131	\N
239	2	عزام الربيعي	5	تجربة لا تنسى — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2020-03-07 00:34:51.959935	\N
240	289	عيد الدوسري	5	رائع — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2025-12-19 23:00:23.419451	\N
241	4	لافي المنصور	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2020-02-07 04:57:29.277906	\N
242	3	رنين العتيبي	4	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2023-02-02 10:15:44.350089	\N
243	4	بتول الفواز	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2024-03-28 02:10:37.082482	\N
244	4	منال البلوي	5	محترفين — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2020-11-19 08:09:56.303617	\N
245	4	بلال السلطان	5	رائع — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2021-04-29 19:24:15.885544	\N
246	2	ميساء السلمي	4	شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2023-08-09 03:52:39.054836	\N
247	3	حسين الغريب	5	اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2021-10-12 22:15:14.901549	\N
248	289	حمد السليم	5	رائع — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2024-04-29 09:17:23.47725	\N
249	289	وصل الزير	5	يستاهل أكثر من خمس نجوم — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2025-06-01 10:03:59.720627	\N
250	4	شيماء البارقي	5	الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2020-08-15 02:39:00.832747	\N
251	3	فارس الحارثي	5	ما قصّروا — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2022-10-04 16:28:34.236487	\N
252	3	سليمان العتيق	5	رائع — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2020-08-16 11:27:40.310276	\N
253	4	روضة الزيد	4	البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2020-08-11 09:42:28.844718	\N
254	2	عبدالله القحطاني	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2020-07-19 03:36:49.598478	\N
255	4	يوسف الجهني	5	خدمة استثنائية — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2021-05-18 15:18:14.002749	\N
256	2	وليد الزير	5	أنصح الكل — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2021-03-19 20:00:43.073955	\N
257	289	عزام الربيعي	4	الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2026-01-31 01:11:25.908797	\N
258	4	فاليا المحيميد	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2022-12-31 03:50:00.988341	\N
259	4	جنان السبيعي	4	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2023-10-28 10:56:08.39549	\N
260	4	سفيان الجفري	4	حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2020-03-11 17:37:33.65228	\N
261	289	يسرى البريكان	5	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2021-07-03 21:17:35.807228	\N
262	289	عامر الزبيدي	5	ما قصّروا — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2024-07-09 05:52:03.18989	\N
263	289	سعاد الجفري	5	ممتاز جداً — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2020-05-11 10:22:34.829078	\N
264	289	لارا العبدالله	5	محترفين — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2023-04-03 05:45:37.948033	\N
265	2	مريم الخلف	5	ممتاز جداً — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2022-11-04 11:38:14.953092	\N
266	289	مطلق الظفيري	4	اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2023-11-20 15:46:35.318276	\N
267	4	رولا الحمادي	5	وايد زين — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2020-06-11 15:53:17.435159	\N
268	289	رامي العبدالله	5	الأفضل بدون منازع — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2020-05-31 23:34:15.373076	\N
269	2	نواف البقمي	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2025-04-26 06:07:13.198455	\N
270	3	غيث الثميري	5	محترفين — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2020-03-14 07:33:22.28925	\N
271	3	عبدالجليل النفيعي	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2025-06-02 00:45:20.626581	\N
272	289	نسيم المنيع	5	أكثر من رائع — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-12-18 11:02:13.5171	\N
273	289	لطيفة الحربي	4	اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2025-05-29 13:52:11.828108	\N
274	4	ضيف الله العقيل	5	ممتاز جداً — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2023-01-21 11:51:45.707255	\N
275	2	سبأ الغانم	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2025-07-05 13:06:40.934904	\N
276	289	أمل الحمود	5	وايد زين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2022-04-11 23:42:49.77554	\N
277	289	دخيل السدحان	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2022-12-31 04:36:33.757907	\N
278	2	قاسم الحربي	5	ممتاز جداً — الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2022-10-24 23:30:01.392586	\N
279	2	لبنى العوفي	5	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-03-21 01:12:32.983704	\N
280	3	حصة الحميدي	5	يستاهل أكثر من خمس نجوم — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2023-07-31 20:15:31.459508	\N
281	4	جودة الرشيدي	5	ممتاز جداً — الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2022-11-18 08:40:13.013954	\N
282	4	صقر الشريدة	5	يستاهل أكثر من خمس نجوم — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2021-08-06 03:41:21.653011	\N
283	3	سلمى الخثلان	5	خدمة استثنائية — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2023-12-17 16:10:19.486947	\N
284	3	ماهر البريك	4	تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2022-03-31 04:19:16.717152	\N
285	4	شمس الثميري	4	تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2025-05-13 12:49:50.485555	\N
286	2	وليد الرشيدي	5	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2021-01-08 19:37:38.625593	\N
287	3	خليل المطرقاني	5	صراحة ممتاز — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2025-01-02 02:26:13.403973	\N
288	4	هزاع الشراري	5	رائع — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2021-11-19 08:37:36.428493	\N
289	289	كوثر الصالح	5	ما قصّروا — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-08-07 03:26:45.621061	\N
290	4	سهر الجريوي	5	ممتاز جداً — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-02-21 13:58:58.528962	\N
291	289	فضيلة الشمري	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2021-05-20 03:53:59.901989	\N
292	3	لجين الشهري	5	صراحة ممتاز — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2022-12-09 06:55:29.912723	\N
293	3	إياد المسلم	5	يستاهل أكثر من خمس نجوم — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2024-06-23 11:56:44.288889	\N
294	3	فاليا المحيميد	5	وايد زين — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2026-01-13 23:32:35.682781	\N
295	3	زينة الجابري	5	ما شاء الله — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2021-03-07 03:53:29.038476	\N
296	3	غازي البريكان	5	الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2021-06-30 11:18:42.64114	\N
297	2	سمر العازمي	4	الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2025-05-27 17:49:15.58875	\N
298	289	شمس الصاعدي	5	يستاهل أكثر من خمس نجوم — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2024-04-21 17:04:50.525957	\N
299	2	أسماء الحمدان	5	وايد زين — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2022-03-30 21:20:35.14044	\N
300	289	رانية المنصور	5	أكثر من رائع — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2020-06-25 09:19:37.49757	\N
301	4	فاطمة الخثلان	5	وايد زين — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2023-09-19 07:43:40.378073	\N
302	2	ميرة الظفيري	5	تجربة لا تنسى — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2020-01-05 15:45:28.915452	\N
303	4	سعد الزهراني	5	ما قصّروا — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2024-01-18 00:09:03.547766	\N
304	3	نجاح العتيبي	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2024-09-07 17:08:00.192491	\N
305	3	أمجد الفقيه	4	خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2024-01-21 17:27:52.096116	\N
306	289	فراج الدويش	5	يستاهل أكثر من خمس نجوم — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2021-03-03 06:32:41.524037	\N
307	289	يعقوب السيف	4	ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2022-12-04 14:32:58.378719	\N
308	2	وائل الفواز	4	اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2020-11-19 01:57:28.435981	\N
309	2	طارق الحمادي	4	اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2020-08-31 02:37:12.201383	\N
310	289	نهى الخطيب	5	وايد زين — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2023-03-07 09:02:30.803419	\N
311	4	ألاء التميمي	5	محترفين — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2020-02-24 04:27:33.232281	\N
312	3	فضيلة الشمري	4	اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2022-04-25 13:02:14.098494	\N
313	3	هيفاء الملحم	5	يستاهل أكثر من خمس نجوم — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2025-10-12 00:40:38.34712	\N
314	289	شافي النعيمي	5	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2025-03-21 05:37:11.130113	\N
315	4	فداء الشعلان	5	أكثر من رائع — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2024-03-26 14:22:16.889014	\N
316	4	غدير الحارثي	5	صراحة ممتاز — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2023-09-14 14:44:22.134511	\N
317	2	شمس الصاعدي	5	تجربة لا تنسى — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2023-04-26 10:43:56.590175	\N
318	3	بكر العمودي	5	محترفين — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2020-10-16 18:50:49.231558	\N
319	4	نوال السيف	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2021-02-02 21:43:52.444624	\N
320	289	رافع الديحاني	5	أنصح الكل — ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2025-03-20 15:44:27.471345	\N
321	289	فارس الحارثي	5	أنصح الكل — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2022-12-14 23:30:16.92897	\N
322	4	فلاح العوض	5	خدمة استثنائية — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2025-11-07 15:06:31.972182	\N
323	289	رنين العتيبي	5	وايد زين — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2021-01-16 02:59:26.356444	\N
324	3	فريدة المزروع	5	الأفضل بدون منازع — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2026-01-12 18:36:47.739658	\N
325	4	سليمان العتيق	5	يستاهل أكثر من خمس نجوم — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2022-09-02 18:09:19.216364	\N
326	289	شهاب الخطيب	5	ما شاء الله — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2023-04-05 03:49:47.002994	\N
327	3	أسماء الحمدان	4	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2020-12-15 10:05:18.799037	\N
328	3	محمد العتيبي	4	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2023-07-23 17:39:09.792055	\N
329	289	فرح الزهيري	5	الأفضل بدون منازع — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2022-04-02 16:32:30.450175	\N
330	289	كريم الصالح	4	صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2025-12-15 04:55:37.889652	\N
331	2	عثمان الربيعي	5	تجربة لا تنسى — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2026-02-20 04:29:40.506828	\N
332	2	خولة الوادعي	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2021-07-12 04:18:29.250807	\N
333	289	هند الحربي	4	الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2024-07-31 12:42:17.9206	\N
334	289	مضاوي المحمدي	5	ما قصّروا — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2024-10-17 12:16:24.883059	\N
335	3	كريم الصالح	5	محترفين — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2025-12-28 19:38:44.724228	\N
336	3	لارا العبدالله	5	يستاهل أكثر من خمس نجوم — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2020-05-01 03:31:09.555496	\N
337	3	روان الصاعدي	5	خدمة استثنائية — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2021-06-14 16:08:15.090246	\N
338	2	سفيان الجفري	5	ما شاء الله — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2022-01-28 01:48:27.51674	\N
339	3	بشار الراشد	5	جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2022-05-27 22:11:55.819151	\N
340	2	ياسر العسيري	5	ممتاز جداً — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2022-05-21 08:13:49.16134	\N
341	289	حميد الزهيري	4	واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2023-07-05 22:35:49.14728	\N
342	3	تغريد الحمادي	5	محترفين — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2021-06-12 16:20:26.834755	\N
557	3	لانا الزهراني	4	ما توقفت القنوات حتى في التحديثات، محترفين	t	2024-08-16 08:39:29.364633	\N
343	289	لبنى العوفي	5	أكثر من رائع — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2020-11-02 14:13:14.429615	\N
344	4	وليد الزير	5	أكثر من رائع — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2026-02-18 19:49:12.664135	\N
345	3	وديع الزرعي	5	ما شاء الله — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2024-10-21 03:39:59.025499	\N
346	289	حمود الطريف	5	يستاهل أكثر من خمس نجوم — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-07-15 13:49:13.150852	\N
347	2	لمياء القحطاني	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2026-01-22 12:33:27.548675	\N
348	2	لجين الشهري	5	جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2024-07-09 18:38:45.35294	\N
349	2	مصطفى التميمي	5	وايد زين — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2020-10-15 17:31:47.588439	\N
350	289	حاتم الشراري	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2022-04-24 17:26:33.692993	\N
351	4	هند السدحان	5	خدمة استثنائية — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2025-03-01 15:01:56.544609	\N
352	289	شيماء البارقي	4	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-02-23 09:04:23.354305	\N
353	289	حسين الغريب	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2020-01-21 03:42:48.6118	\N
354	289	شروق المطرفي	5	ما شاء الله — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2026-03-13 20:19:21.63295	\N
355	2	منال البلوي	5	صراحة ممتاز — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2023-07-26 06:29:35.813925	\N
356	289	نجلاء الصاعدي	5	أنصح الكل — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2021-11-21 22:29:10.873196	\N
357	2	سناء الثبيتي	5	محترفين — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2022-12-10 09:58:31.497381	\N
358	3	زياد المالكي	5	ممتاز جداً — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2020-06-19 09:18:15.20105	\N
359	3	تركي المطيري	5	ما قصّروا — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2025-03-17 03:04:25.271236	\N
360	2	مروان السبيعي	5	الأفضل بدون منازع — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2022-02-13 06:38:09.147175	\N
361	4	سراج الصقير	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2021-01-23 18:40:32.400758	\N
362	4	دينا الفهد	5	خدمة استثنائية — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2020-03-05 23:53:48.846695	\N
363	3	دينا الفهد	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2022-03-01 10:35:03.280756	\N
364	4	أمل الحمود	5	ما شاء الله — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2023-02-18 11:17:37.461713	\N
365	3	أمل الحمود	4	جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2022-06-29 05:41:09.741343	\N
366	289	خليل المطرقاني	4	الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2024-02-13 06:42:10.328496	\N
367	3	نهى الخطيب	5	صراحة ممتاز — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2020-02-10 07:37:06.685119	\N
368	289	مساعد الشمري	5	وايد زين — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2020-11-15 23:16:57.352213	\N
369	3	خيرالدين السلوم	4	ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2024-04-12 07:23:52.594469	\N
370	3	هادي الحازمي	5	أنصح الكل — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2020-09-22 22:13:25.524714	\N
371	3	سناء الثبيتي	5	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2024-10-18 06:42:50.519848	\N
372	3	حمد السليم	5	ممتاز جداً — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2021-03-22 07:44:19.858956	\N
373	3	نزار المحيميد	5	صراحة ممتاز — ما توقفت القنوات حتى في التحديثات، محترفين	t	2022-02-24 12:05:46.497548	\N
374	3	مروة الديحاني	5	أنصح الكل — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2020-12-02 20:26:03.183648	\N
375	2	وصال الوطيان	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2024-04-23 09:35:23.958118	\N
376	289	أوس المرزوق	5	وايد زين — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2026-03-19 14:14:31.498324	\N
377	289	هلا الراشد	5	اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2020-06-20 07:18:05.827145	\N
378	289	سناء الثبيتي	5	ممتاز جداً — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-04-09 10:06:36.541077	\N
379	289	صلاح الثبيتي	5	وايد زين — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2022-08-19 03:21:02.656264	\N
380	4	عادل العجمي	4	اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2020-01-16 12:17:49.110527	\N
381	3	فاطمة الخثلان	5	يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2021-12-01 13:14:00.700089	\N
382	4	رفيق الجريوي	5	ما شاء الله — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2024-03-10 15:22:38.219524	\N
383	4	مها الرويلي	5	رائع — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2020-06-28 02:27:57.745403	\N
384	2	طلال الخثلان	5	محترفين — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2025-01-29 02:48:43.284716	\N
385	4	إيناس المحيسن	5	رائع — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2021-06-06 15:07:35.08081	\N
386	2	بسام العبيد	5	صراحة ممتاز — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2025-07-16 05:11:49.071287	\N
387	289	منصور الحمادي	5	الأفضل بدون منازع — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2020-06-28 04:57:24.423124	\N
388	4	ماهر البريك	5	أنصح الكل — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2021-11-20 16:28:53.637411	\N
389	4	رنا الحميدان	5	رائع — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2022-03-24 09:31:11.585675	\N
390	2	رامي العبدالله	5	تجربة لا تنسى — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2023-06-07 22:56:11.758109	\N
391	2	لارا العبدالله	5	أكثر من رائع — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2024-04-01 21:15:42.720218	\N
392	3	ألاء التميمي	5	تجربة لا تنسى — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2025-08-04 16:06:38.13999	\N
393	3	مازن العمر	5	ما شاء الله — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2025-07-29 15:30:18.215548	\N
394	289	خلدون البارقي	5	ما شاء الله — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2021-05-05 06:13:54.813698	\N
395	3	وليد الوطيان	5	محترفين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2020-08-18 14:26:08.441392	\N
396	2	نايف الرشيدي	5	يستاهل أكثر من خمس نجوم — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2023-09-13 10:03:41.290963	\N
397	2	سلمى البلوي	4	التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2022-10-21 18:49:06.348072	\N
398	4	رندة الخلف	5	محترفين — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2022-12-29 13:43:54.464076	\N
399	4	وجد القرشي	5	أكثر من رائع — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2023-11-01 17:14:34.975832	\N
400	2	سهيلة الحربي	5	صراحة ممتاز — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2023-07-26 00:56:19.688687	\N
401	3	تماضر الرشيدي	5	تجربة لا تنسى — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-07-08 05:00:58.098067	\N
402	2	رنا الحميدان	5	الأفضل بدون منازع — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2023-12-07 12:27:16.134961	\N
403	4	لين العبيد	5	أكثر من رائع — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2024-02-02 20:47:24.434878	\N
404	3	نجم المالكي	5	رائع — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2025-11-05 11:58:48.389406	\N
405	2	بنان العقيل	5	خدمة استثنائية — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2022-05-19 00:34:19.164936	\N
406	289	نادية السلطان	5	رائع — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2025-01-02 19:49:52.971276	\N
407	289	شداد الصوينع	5	خدمة استثنائية — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2022-10-04 13:39:55.660369	\N
408	3	سعاد الجفري	5	صراحة ممتاز — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2024-03-28 14:10:46.096993	\N
409	3	كوثر الصالح	5	صراحة ممتاز — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2020-09-22 06:54:00.732826	\N
410	4	لجين الشهري	5	الأفضل بدون منازع — كل الباقات بأسعار معقولة وما في خسارة	t	2023-02-23 15:49:27.681195	\N
411	4	نسرين المطيري	5	الأفضل بدون منازع — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2025-08-06 21:57:55.763851	\N
412	2	شداد الصوينع	5	الأفضل بدون منازع — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-02-16 08:12:22.503721	\N
413	3	سنا النعيمي	5	ممتاز جداً — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2020-08-07 06:50:22.575449	\N
414	2	حمزة الثقفي	4	حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2023-12-17 08:14:56.727775	\N
415	4	هادي الحازمي	5	رائع — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2022-10-06 12:56:03.220973	\N
416	4	أروى الدبيان	5	الأفضل بدون منازع — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2021-03-04 15:44:00.430765	\N
417	2	جوهرة الشريدة	5	رائع — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2022-08-16 14:12:04.765119	\N
418	3	ندى العجمي	5	يستاهل أكثر من خمس نجوم — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2022-12-20 23:14:56.311771	\N
419	289	وصال الوطيان	4	جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2021-11-10 13:00:51.198718	\N
420	3	ثامر الحمود	5	أنصح الكل — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2023-08-21 12:11:10.683598	\N
421	289	منيرة الزهراني	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2022-05-08 16:51:19.91073	\N
422	4	شداد الصوينع	5	خدمة استثنائية — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2024-02-14 10:51:44.181777	\N
423	4	فريدة المزروع	5	صراحة ممتاز — الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2022-01-11 10:48:25.57886	\N
424	2	أريج السهلي	5	أكثر من رائع — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2025-06-12 18:54:02.927533	\N
425	3	جميل المرزوق	4	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-07-26 10:06:47.216035	\N
426	289	شفق العيسى	5	أنصح الكل — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2023-08-28 13:50:59.421775	\N
427	4	صالح الوادعي	5	الأفضل بدون منازع — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2022-09-22 11:21:29.923035	\N
428	2	نداء الكريم	5	خدمة استثنائية — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2021-01-08 15:56:58.909313	\N
429	4	إسراء السبيعي	5	خدمة استثنائية — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2023-07-18 02:32:39.968041	\N
430	289	خولة الوادعي	5	رائع — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2024-06-28 10:55:47.679545	\N
431	4	تركي المطيري	5	محترفين — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2020-08-10 19:29:33.62147	\N
432	2	فيصل الدوسري	4	شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2020-08-28 04:26:44.27328	\N
433	2	مياسة المرواني	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2024-06-15 09:35:31.507005	\N
434	2	عقيل العيسى	5	خدمة استثنائية — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2024-08-05 16:50:22.824067	\N
435	3	عصام الفهيد	5	محترفين — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2022-09-19 12:54:07.793103	\N
436	4	شافي النعيمي	5	صراحة ممتاز — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2023-01-31 04:42:54.040508	\N
437	4	فدوى الشراري	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2025-06-07 08:04:08.480025	\N
438	2	لين العبيد	5	رائع — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2021-06-24 14:01:05.379166	\N
439	289	سلمى الخثلان	5	يستاهل أكثر من خمس نجوم — ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2025-03-18 05:47:31.250657	\N
440	2	مها الرويلي	5	تجربة لا تنسى — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2024-03-17 20:08:52.101451	\N
441	3	نبيل الشعلان	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-03-11 22:45:22.915778	\N
442	289	تغريد الحمادي	4	تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2020-01-01 18:29:39.727276	\N
443	3	أميرة العمري	4	خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2024-09-23 10:55:26.609072	\N
444	3	صلاح الثبيتي	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2026-03-14 17:59:23.611559	\N
445	289	فداء الشعلان	5	ممتاز جداً — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2022-01-24 03:41:54.836861	\N
446	4	يحيى العوفي	5	تجربة لا تنسى — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2024-04-20 13:54:22.513539	\N
447	4	نبيل الشعلان	4	خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2022-12-17 04:02:13.070128	\N
448	4	شبيب المرشدي	4	صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2022-08-25 19:34:01.322283	\N
449	4	زينب الدوسري	5	ما قصّروا — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2022-03-26 11:08:20.304141	\N
450	289	جاسم المحيسن	5	يستاهل أكثر من خمس نجوم — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2024-01-08 17:26:39.492734	\N
451	289	بخيت المرواني	5	رائع — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2021-02-02 17:20:44.292806	\N
452	289	قيس العريفي	5	تجربة لا تنسى — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2024-08-04 17:11:08.247081	\N
453	3	قاسم الحربي	5	ما قصّروا — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2020-01-30 06:08:37.341383	\N
454	2	رشيد الحسيني	5	ممتاز جداً — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2020-09-04 23:36:17.771994	\N
455	289	هيفاء الملحم	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-08-20 10:25:18.513394	\N
456	4	رانية المنصور	5	أكثر من رائع — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2024-10-07 16:30:02.002634	\N
457	4	صفية الدويش	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2025-12-03 22:31:09.469729	\N
458	3	لين العبيد	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2021-10-11 05:31:27.543554	\N
459	2	عفاف الطريف	5	ممتاز جداً — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-04-14 22:49:46.191403	\N
460	3	وفاء العسيري	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2026-03-16 09:54:42.933151	\N
461	2	مضاوي المحمدي	5	وايد زين — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2024-07-13 17:36:04.795656	\N
462	289	لين العبيد	5	ما قصّروا — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2020-03-05 10:51:30.325886	\N
463	3	هزاع الشراري	5	يستاهل أكثر من خمس نجوم — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2021-01-19 05:23:12.303208	\N
464	289	نجاح العتيبي	5	ما شاء الله — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2025-08-11 02:28:25.038044	\N
465	2	زهرة الجهني	5	الأفضل بدون منازع — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2020-06-22 10:29:45.748917	\N
466	4	سوسن الحسين	5	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2022-08-15 15:10:31.380234	\N
467	3	جنان السبيعي	5	خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2023-03-05 11:57:45.314385	\N
468	4	غادة الحربي	5	يستاهل أكثر من خمس نجوم — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2022-01-06 13:50:41.470837	\N
469	289	أنس الزيد	5	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2021-02-09 22:59:18.181007	\N
470	2	بيان المسلم	5	تجربة لا تنسى — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2025-02-06 01:52:17.702421	\N
471	289	نجم المالكي	5	محترفين — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2021-11-02 13:01:55.604674	\N
472	4	حمزة الثقفي	5	يستاهل أكثر من خمس نجوم — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2025-01-08 17:57:55.524798	\N
473	2	غنى الفقيه	5	الأفضل بدون منازع — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2025-05-03 20:22:29.95979	\N
474	3	وائل الفواز	5	أكثر من رائع — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2021-07-21 16:04:00.487827	\N
475	3	شهاب الخطيب	5	أكثر من رائع — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2020-03-05 10:02:09.181101	\N
476	4	رهف البقمي	5	ما شاء الله — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2025-12-31 02:37:11.466257	\N
477	3	نفلاء العوض	4	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2026-02-11 16:14:49.956729	\N
478	289	بنان العقيل	5	خدمة استثنائية — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2023-02-28 08:07:09.452746	\N
479	4	علي الشريف	5	محترفين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2022-09-18 12:50:12.067857	\N
480	4	خولة الوادعي	5	وايد زين — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2020-11-05 16:07:00.413188	\N
481	4	رزان المطرقاني	5	ممتاز جداً — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2020-12-16 04:19:39.698304	\N
482	2	عنان الشثري	5	تجربة لا تنسى — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2022-09-16 05:01:46.930136	\N
483	289	وجد القرشي	5	يستاهل أكثر من خمس نجوم — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2023-12-09 07:34:43.888522	\N
484	289	زهرة الجهني	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2023-02-12 13:52:54.739742	\N
485	2	عبدالعزيز السديس	4	جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2024-06-12 17:38:29.44514	\N
486	2	أمل الحمود	5	وايد زين — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-11-17 00:35:41.359548	\N
487	3	صفاء الزبيدي	5	صراحة ممتاز — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2025-08-02 09:33:55.281868	\N
488	2	إبراهيم الحميدي	5	محترفين — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2023-04-10 12:34:28.397604	\N
490	4	عيد الدوسري	4	اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2024-02-21 07:09:49.117966	\N
491	2	خيرالدين السلوم	5	ما قصّروا — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2025-07-24 08:48:02.882768	\N
492	3	نعمة العمر	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2020-09-18 18:26:11.982894	\N
493	289	إياد المسلم	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2024-07-31 07:30:46.270799	\N
494	289	مؤيد الكريم	5	ممتاز جداً — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2025-06-04 03:48:04.610215	\N
495	4	وفاء العسيري	5	أكثر من رائع — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2021-09-14 09:58:04.564396	\N
496	4	مصطفى التميمي	5	يستاهل أكثر من خمس نجوم — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2024-02-15 04:11:10.298887	\N
497	289	نبيل الشعلان	5	محترفين — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2022-11-13 04:47:58.041556	\N
498	2	صفية الدويش	5	يستاهل أكثر من خمس نجوم — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2022-04-26 05:54:29.425637	\N
499	3	نادر السهلي	5	خدمة استثنائية — ما توقفت القنوات حتى في التحديثات، محترفين	t	2024-05-26 20:22:42.612091	\N
500	4	نايف الرشيدي	4	خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2021-03-25 01:54:15.240194	\N
501	2	منيرة الزهراني	5	أكثر من رائع — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2025-12-17 09:58:16.720172	\N
502	2	مازن العمر	5	وايد زين — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-09-04 20:02:27.814265	\N
503	4	تيسير المزروع	4	جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2021-02-04 09:29:22.339612	\N
504	289	خيرالدين السلوم	5	صراحة ممتاز — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2024-02-01 03:40:57.48623	\N
505	3	سامي الملحم	5	خدمة استثنائية — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2025-12-12 09:36:56.020892	\N
506	4	مطلق الظفيري	4	جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2021-05-11 06:12:46.638965	\N
507	3	عبدالله القحطاني	5	خدمة استثنائية — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2020-11-06 06:27:20.298887	\N
508	4	زياد المالكي	5	تجربة لا تنسى — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2022-03-17 16:30:06.941766	\N
509	3	عبدالكريم اليامي	5	محترفين — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2022-01-09 06:58:52.22745	\N
510	2	بكر العمودي	5	محترفين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2025-10-28 11:34:08.326532	\N
511	289	تماضر الرشيدي	5	صراحة ممتاز — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2021-05-28 11:05:07.625321	\N
512	4	هشام الحميد	5	خدمة استثنائية — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2020-10-22 22:07:52.902655	\N
513	289	دلال الرشيدي	5	ما شاء الله — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2022-03-20 15:27:34.35542	\N
514	2	رزان المطرقاني	5	يستاهل أكثر من خمس نجوم — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2021-11-09 08:32:37.990719	\N
515	4	خالد الحربي	5	ممتاز جداً — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2024-03-29 04:09:36.702026	\N
516	2	رهام الحربي	5	خدمة استثنائية — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2025-02-13 03:35:11.834879	\N
517	289	عمر الصاعدي	5	وايد زين — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2024-11-22 03:52:09.861904	\N
518	3	طلال الخثلان	5	أنصح الكل — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2020-07-02 13:21:15.926111	\N
519	3	وسام البليهد	5	أكثر من رائع — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-07-28 18:08:09.215139	\N
520	2	حاتم الشراري	5	الأفضل بدون منازع — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2021-02-18 20:19:32.807825	\N
521	2	يوسف الجهني	5	أنصح الكل — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-04-27 11:29:56.815916	\N
522	289	نوال السيف	5	محترفين — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2026-01-26 20:51:42.64551	\N
523	2	عبير المالكي	5	ما شاء الله — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2022-08-16 00:45:08.275783	\N
524	4	ماجد العمري	5	محترفين — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2025-12-11 13:04:14.718623	\N
525	289	محفوظ الحربي	5	خدمة استثنائية — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2024-02-21 15:17:04.405559	\N
526	2	سجاد الهشيم	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2021-04-27 04:16:27.633895	\N
527	289	نيلة الشراري	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2020-10-24 12:17:27.747748	\N
528	4	مشعل العتيبي	5	ما قصّروا — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2026-03-26 15:36:29.628947	\N
529	289	غادة الغامدي	5	ما قصّروا — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2021-05-10 07:38:10.126138	\N
530	289	رياض الحصان	4	دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2023-05-20 01:06:46.959372	\N
531	4	لبنى العوفي	4	جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2020-03-30 05:21:37.76823	\N
532	289	بسمة العنزي	5	محترفين — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-02-18 20:32:50.927033	\N
533	3	صبرين السهلي	5	ممتاز جداً — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2023-06-06 02:05:36.922577	\N
534	4	رياض البلوي	5	محترفين — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2024-10-25 08:55:40.651338	\N
535	289	نيرة الشريف	5	خدمة استثنائية — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2023-06-14 15:51:45.829448	\N
536	3	عيد الدوسري	5	أكثر من رائع — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2020-11-15 21:39:54.628397	\N
537	289	صبا البريك	5	يستاهل أكثر من خمس نجوم — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2023-04-15 06:46:48.890234	\N
538	2	هند الحربي	5	محترفين — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2023-02-13 15:56:18.208123	\N
539	289	نايف الرشيدي	5	ما شاء الله — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2022-04-14 01:31:11.201709	\N
540	2	حمد الفراج	5	تجربة لا تنسى — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2021-04-15 07:50:18.917898	\N
541	2	نايف البلوي	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2022-07-06 19:50:56.317765	\N
542	2	مساعد الشمري	4	البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2022-06-29 17:52:08.623388	\N
543	3	سعود الفيفي	5	تجربة لا تنسى — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2025-04-26 00:38:30.813592	\N
544	2	تغريد الحمادي	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2021-01-25 23:19:16.494412	\N
545	289	أيمن الخلف	5	ما شاء الله — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2024-07-29 18:44:25.959316	\N
546	3	صالح الوادعي	5	وايد زين — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2022-11-11 19:11:50.693345	\N
547	2	مشاري القرشي	5	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2020-11-16 12:10:11.672924	\N
548	3	عبير المالكي	5	الأفضل بدون منازع — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2023-10-20 08:21:42.760579	\N
549	289	نداء الكريم	4	الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-02-29 14:46:50.185855	\N
550	289	نعمة العمر	4	جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2020-05-10 13:59:06.14017	\N
551	4	خلدون البارقي	5	ممتاز جداً — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2024-01-21 05:46:31.739576	\N
552	3	سلطان الشمري	5	ما قصّروا — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2020-04-03 20:36:43.268856	\N
553	3	سهر الجريوي	5	أكثر من رائع — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2020-01-16 10:57:20.197779	\N
554	3	لافي المنصور	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2022-12-15 10:35:37.810128	\N
555	2	ديمة الداود	5	ما قصّروا — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2022-01-12 06:04:06.343537	\N
556	4	نيرة الشريف	5	أكثر من رائع — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2024-04-25 02:19:34.255199	\N
35	289	مشعل الرويلي	5	قنوات رياضية ممتازة والجودة 4K	t	2025-07-24 01:34:39.120966	\N
558	2	لطيفة الحربي	5	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2025-03-22 21:08:15.986008	\N
559	4	حياة العتيق	5	أنصح الكل — ما توقفت القنوات حتى في التحديثات، محترفين	t	2021-04-08 06:47:43.144296	\N
560	289	بدر المطرفي	5	تجربة لا تنسى — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2021-08-14 18:16:56.345352	\N
561	2	مضاوي الحارثي	5	أنصح الكل — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2020-09-09 06:43:04.716267	\N
562	2	لؤي الحسين	5	خدمة استثنائية — كل الباقات بأسعار معقولة وما في خسارة	t	2020-09-10 23:36:47.752833	\N
563	2	دخيل السدحان	4	من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2024-03-06 09:37:27.66003	\N
564	3	نايف الرشيدي	5	صراحة ممتاز — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2020-07-06 23:16:23.872901	\N
565	4	تغريد الحمادي	5	وايد زين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2024-03-16 06:10:10.855305	\N
566	3	مؤيد الكريم	5	ممتاز جداً — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2021-03-15 13:06:48.374526	\N
567	289	سامي الملحم	5	ما شاء الله — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2023-12-31 09:44:13.762006	\N
568	2	محمود الداود	5	وايد زين — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2022-04-14 19:49:05.999224	\N
569	3	صبا البريك	5	رائع — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2025-07-30 11:02:03.59837	\N
570	2	هيفاء الصوينع	5	ما قصّروا — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2024-10-21 11:56:20.700733	\N
571	3	عقيل العيسى	4	دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2023-09-05 03:40:53.493408	\N
572	4	سماء الديحاني	5	أنصح الكل — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2025-01-02 00:17:41.988148	\N
573	4	محفوظ الحربي	5	وايد زين — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-02-25 18:11:36.746784	\N
574	2	يحيى العوفي	5	ما قصّروا — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2020-03-19 11:10:45.325745	\N
575	3	ديمة الداود	5	أنصح الكل — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2025-01-24 06:50:18.986279	\N
576	4	فيصل الدوسري	4	حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2026-03-02 21:13:28.701535	\N
577	2	عمر الصاعدي	4	جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2020-08-30 14:42:01.352629	\N
578	2	بتول الفواز	4	ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2021-02-23 18:14:01.923691	\N
579	2	سهر الجريوي	5	يستاهل أكثر من خمس نجوم — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2022-04-18 15:11:47.872859	\N
580	289	بيان المسلم	5	أنصح الكل — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2024-02-19 03:01:08.85779	\N
581	2	دينا الفهد	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2020-10-01 08:25:02.806764	\N
582	4	مضاوي العنزي	5	وايد زين — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-02-20 09:09:41.521454	\N
583	289	بدر الشلال	5	تجربة لا تنسى — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2020-06-17 12:30:08.180305	\N
584	2	سلطان الشمري	5	خدمة استثنائية — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2026-02-09 12:55:16.404747	\N
585	4	وفاء الفيفي	5	رائع — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2021-11-07 03:35:51.546071	\N
586	4	ياسر العسيري	5	الأفضل بدون منازع — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2023-09-30 13:44:24.047336	\N
587	3	سماء الديحاني	5	وايد زين — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2023-06-28 04:37:28.947136	\N
588	2	عامر الزبيدي	5	أكثر من رائع — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2026-03-23 16:04:42.694937	\N
589	3	شمس الصاعدي	5	محترفين — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-02-10 07:00:22.917493	\N
590	4	دخيل السدحان	5	أنصح الكل — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2020-08-12 01:37:33.781371	\N
591	289	دينا الفهد	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-06-09 01:11:15.325585	\N
592	2	شروق المطرفي	4	اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2025-12-27 23:04:06.121876	\N
593	3	جابر الرويلي	4	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2023-04-09 14:06:29.881565	\N
594	3	عائشة الغريب	5	صراحة ممتاز — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2025-11-13 15:14:49.343295	\N
595	289	هند السدحان	5	يستاهل أكثر من خمس نجوم — ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2025-01-18 15:07:21.236306	\N
596	2	لافي المنصور	5	ما قصّروا — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2024-02-14 14:44:48.423203	\N
597	3	غانم الحارثي	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2023-04-06 13:32:27.006655	\N
598	4	إيمان الفراج	5	رائع — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2023-10-15 07:59:39.239171	\N
599	3	حميد الزهيري	5	وايد زين — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2025-06-14 18:54:15.734146	\N
600	4	هبة الجعيد	5	ما شاء الله — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2025-04-03 04:49:03.102696	\N
601	4	ناصر الحمدان	4	دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2025-04-06 08:22:58.545604	\N
602	2	وجد القرشي	5	أكثر من رائع — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2022-04-27 23:05:49.976315	\N
603	3	رافع الديحاني	5	أكثر من رائع — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2024-02-09 01:12:55.805607	\N
604	4	عزيزة الربيعي	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2022-11-27 23:43:38.968013	\N
605	4	بخيت المرواني	5	الأفضل بدون منازع — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2022-01-09 11:35:21.739627	\N
606	289	عثمان الربيعي	5	أكثر من رائع — كل الباقات بأسعار معقولة وما في خسارة	t	2024-10-11 13:14:17.316056	\N
607	2	ألاء التميمي	5	خدمة استثنائية — الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2022-03-21 19:33:12.113083	\N
608	2	سليم الثبيتي	5	تجربة لا تنسى — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2026-02-22 18:19:10.078332	\N
609	2	روان الصاعدي	5	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2025-05-03 16:45:11.844699	\N
610	4	سلمى البلوي	5	محترفين — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2025-06-11 00:00:57.471727	\N
611	4	لمياء القحطاني	5	ممتاز جداً — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2023-08-09 23:44:58.60129	\N
612	3	بندر العنزي	4	خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2025-10-29 18:54:15.118678	\N
613	4	وديع الزرعي	5	محترفين — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2020-10-05 19:23:02.479574	\N
614	289	ميساء السلمي	4	شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2025-03-04 22:50:05.231114	\N
615	3	هند السدحان	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2023-05-22 21:39:17.538141	\N
616	4	هيفاء الملحم	4	واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2021-07-31 08:14:23.678269	\N
617	2	رافع الديحاني	5	ما قصّروا — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2023-01-24 03:20:14.320081	\N
618	4	نوف الفيفي	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2024-01-29 19:37:23.471345	\N
619	3	عزة الربيعي	5	ما شاء الله — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2020-06-30 04:40:55.027337	\N
620	3	وليد الرشيدي	5	أنصح الكل — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2022-12-15 09:10:58.290021	\N
621	2	ملك الغامدي	5	صراحة ممتاز — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2022-12-02 23:01:01.329943	\N
622	3	هلا الراشد	5	أكثر من رائع — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2025-02-17 09:01:35.460983	\N
623	4	نسيم المنيع	4	جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2022-06-17 10:10:35.340486	\N
624	2	هند السدحان	5	ما شاء الله — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2020-06-20 08:51:33.738059	\N
625	3	نجاة المالكي	5	وايد زين — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2022-06-01 20:54:36.183782	\N
626	289	ضيدان العنزي	4	مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2021-04-28 02:12:25.819528	\N
627	3	روضة الزيد	5	محترفين — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2022-09-27 22:04:27.522998	\N
628	4	فضيلة الشمري	5	صراحة ممتاز — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2020-11-03 10:36:55.358692	\N
629	289	نايف البلوي	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2023-07-28 07:27:14.798954	\N
630	3	طارق الحمادي	5	ممتاز جداً — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2024-07-12 12:14:44.226969	\N
631	3	نيرة الشريف	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2022-09-08 02:51:42.693258	\N
632	2	ريم العتيبي	5	أنصح الكل — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2024-02-11 02:35:07.555407	\N
633	2	أروى الدبيان	4	شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2020-01-12 19:03:15.251094	\N
634	3	رافد الزهراني	5	محترفين — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2024-04-25 07:23:09.388106	\N
635	2	هيا الرشيدي	5	الأفضل بدون منازع — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2020-10-08 12:47:19.12929	\N
636	289	شعيب الفيفي	5	ما قصّروا — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2021-06-08 06:01:07.147557	\N
637	289	زياد المالكي	5	ممتاز جداً — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2021-10-08 00:45:41.778125	\N
638	289	دانيا الحازمي	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-06-23 00:16:15.917078	\N
639	4	زهير الغامدي	5	الأفضل بدون منازع — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2024-03-20 06:58:38.20856	\N
640	289	سجاد الهشيم	5	أنصح الكل — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-01-26 08:19:47.278597	\N
641	289	جنان السبيعي	5	شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2022-03-30 07:33:58.469862	\N
642	289	جميل المرزوق	4	من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2026-02-17 15:28:14.478092	\N
643	4	عصام الفهيد	5	وايد زين — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2025-01-19 20:40:15.258976	\N
1039	4	مريم الخلف	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2025-12-14 18:01:50.799789	\N
644	2	أميرة العمري	5	أنصح الكل — ما توقفت القنوات حتى في التحديثات، محترفين	t	2022-12-24 19:41:35.46486	\N
645	4	سمر العازمي	5	أنصح الكل — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2023-01-09 20:37:56.997357	\N
646	2	حنان الثقفي	5	رائع — الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2025-10-05 14:17:46.906584	\N
647	4	نزار المحيميد	5	وايد زين — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2024-10-02 12:18:49.266755	\N
648	289	طلال الخثلان	5	ما قصّروا — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2021-04-25 21:26:46.539933	\N
649	4	شمس الصاعدي	4	واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2020-07-09 06:47:25.073503	\N
650	4	لطيفة الحربي	5	رائع — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2024-12-18 05:32:46.67555	\N
651	2	عبير اليامي	4	كل الباقات بأسعار معقولة وما في خسارة	t	2020-03-21 00:53:27.642049	\N
652	2	خليل المطرقاني	4	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2023-10-06 03:55:14.990426	\N
653	4	طلال الخثلان	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-08-16 05:04:04.808004	\N
654	2	ضياء الحميدان	5	وايد زين — ما توقفت القنوات حتى في التحديثات، محترفين	t	2024-06-06 01:33:17.609632	\N
655	4	غادة الغامدي	5	أكثر من رائع — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2021-01-16 20:27:17.390603	\N
656	3	حمد الفراج	5	ما شاء الله — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2023-11-20 05:04:17.952283	\N
657	4	نجمة السلوم	5	أنصح الكل — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2020-04-22 09:07:32.009466	\N
658	3	مصطفى التميمي	5	ممتاز جداً — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2025-06-23 22:43:24.330935	\N
659	3	دانيا الحازمي	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2020-03-25 19:56:24.417617	\N
660	2	محمد العتيبي	5	تجربة لا تنسى — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2020-04-29 23:32:34.376283	\N
661	4	رداد الشمراني	5	ما قصّروا — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2022-10-17 18:35:48.749788	\N
662	289	عبدالكريم اليامي	4	اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2022-02-07 19:18:57.673827	\N
663	289	ثابت العتيبي	5	ممتاز جداً — كل الباقات بأسعار معقولة وما في خسارة	t	2024-10-14 18:06:42.767704	\N
664	289	ميادة الشثري	5	ما قصّروا — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2022-06-03 13:46:29.001859	\N
665	2	بشار الراشد	5	ما قصّروا — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2023-05-20 15:59:20.311803	\N
666	2	ماهر البريك	5	تجربة لا تنسى — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2020-12-27 21:38:40.392454	\N
667	2	قيس الفهد	5	ما قصّروا — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2023-11-22 00:53:21.684422	\N
668	4	نفلاء العوض	5	محترفين — ما توقفت القنوات حتى في التحديثات، محترفين	t	2023-10-06 12:01:33.942666	\N
669	4	نورة الشمري	5	ممتاز جداً — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2024-08-06 04:55:18.904084	\N
670	4	رشيد الحسيني	4	مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2022-06-20 17:58:36.801453	\N
671	4	عمر الصاعدي	5	خدمة استثنائية — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2021-01-13 04:42:34.156627	\N
672	289	فاليا المحيميد	4	جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2021-12-28 09:53:25.886565	\N
673	3	حنان الثقفي	5	رائع — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2022-06-25 01:19:37.818194	\N
674	3	فدوى الشراري	5	ما قصّروا — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2020-09-04 21:42:48.821088	\N
675	3	مياسة المرواني	5	أكثر من رائع — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2021-07-08 21:54:30.894396	\N
676	289	ضيف الله العقيل	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2023-04-27 18:31:10.492925	\N
677	3	سوسن الحسين	5	الأفضل بدون منازع — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2022-12-20 13:16:33.472481	\N
678	289	فدوى الشراري	5	رائع — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2021-12-03 05:33:56.391837	\N
679	4	يُمنى المرشدي	5	أكثر من رائع — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-04-28 17:59:18.182437	\N
680	2	علي الشريف	5	خدمة استثنائية — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2022-12-04 17:26:47.865023	\N
681	289	ألاء التميمي	5	ممتاز جداً — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2024-09-09 05:12:01.996189	\N
682	289	سلمى البلوي	5	أكثر من رائع — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2023-11-07 23:16:17.211459	\N
683	4	جابر الرويلي	5	يستاهل أكثر من خمس نجوم — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2025-08-27 22:03:58.095161	\N
684	4	عبير المالكي	5	وايد زين — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2024-12-03 23:33:01.476357	\N
685	4	عثمان الربيعي	5	اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2023-01-05 09:31:57.579133	\N
686	2	شمس الثميري	5	يستاهل أكثر من خمس نجوم — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2022-03-04 11:47:33.302256	\N
687	3	لطيفة الحربي	5	أنصح الكل — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2026-03-18 15:37:33.429135	\N
688	2	شافي النعيمي	4	الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2024-09-19 08:41:49.121395	\N
689	3	خولة الوادعي	4	اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2023-11-07 13:57:37.043857	\N
690	3	وصل الزير	5	أكثر من رائع — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2023-08-14 06:00:53.190552	\N
691	289	جودة الرشيدي	5	محترفين — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2024-05-16 22:20:24.518588	\N
692	289	عقيل العيسى	5	رائع — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2024-08-29 13:19:58.22373	\N
693	2	فرح الزهيري	5	يستاهل أكثر من خمس نجوم — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2025-04-05 08:24:45.011497	\N
694	4	وسام البليهد	4	التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2021-08-19 12:16:26.487348	\N
695	289	صقر الشريدة	5	محترفين — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2021-03-07 20:15:10.330265	\N
696	4	حنان الثقفي	5	الأفضل بدون منازع — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2026-02-03 07:35:24.116015	\N
697	289	فريدة المزروع	5	تجربة لا تنسى — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2021-01-16 21:05:27.923389	\N
698	289	ريما الحصان	5	ممتاز جداً — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2020-04-16 10:14:07.514486	\N
699	289	مصطفى التميمي	5	ما شاء الله — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2025-06-04 16:30:40.371073	\N
700	3	وصال الوطيان	5	ممتاز جداً — ما توقفت القنوات حتى في التحديثات، محترفين	t	2025-05-31 14:59:04.992406	\N
701	4	عامر الزبيدي	5	أنصح الكل — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2025-05-06 01:12:05.309311	\N
702	4	رافع الديحاني	5	ما شاء الله — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2022-06-03 19:49:23.486298	\N
703	4	رنين العتيبي	5	ما قصّروا — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2025-04-14 08:32:24.754917	\N
704	4	وليد الوطيان	5	يستاهل أكثر من خمس نجوم — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2022-10-04 05:24:59.117362	\N
705	289	طلال العسكر	4	كل الباقات بأسعار معقولة وما في خسارة	t	2022-07-11 20:53:28.39809	\N
706	4	مساعد الشمري	4	اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2022-12-19 04:46:15.868005	\N
707	2	نيلة الشراري	5	خدمة استثنائية — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2022-02-16 04:12:20.193884	\N
708	4	وصل الزير	5	محترفين — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2024-02-26 03:55:14.283535	\N
709	3	فهد الشهري	5	الأفضل بدون منازع — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2023-05-26 06:38:16.443701	\N
710	4	أميرة العمري	5	ما قصّروا — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2023-11-21 19:37:07.553206	\N
711	289	عزة الربيعي	5	ما قصّروا — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2020-04-16 23:29:22.852218	\N
712	2	إياد المسلم	4	حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2020-06-15 16:00:19.046474	\N
713	3	رهف البقمي	5	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2020-12-20 02:53:47.249229	\N
714	3	رولا الحمادي	5	ممتاز جداً — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2025-11-21 22:17:02.769206	\N
715	289	نورة الشمري	5	ما قصّروا — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2023-06-06 20:06:11.67968	\N
716	3	نورة الشمري	5	الأفضل بدون منازع — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2025-07-28 00:03:35.508351	\N
717	289	نزار المحيميد	5	أكثر من رائع — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2020-11-03 02:23:12.052275	\N
718	2	جودة الرشيدي	5	يستاهل أكثر من خمس نجوم — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2022-11-13 17:57:49.221711	\N
719	2	فلوة العريفي	5	ما قصّروا — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2025-01-14 00:42:55.740588	\N
720	4	صالح الخلف	5	خدمة استثنائية — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2023-12-02 10:37:36.349398	\N
721	3	حمود الطريف	5	خدمة استثنائية — الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2026-02-01 13:52:14.264747	\N
722	2	بخيت المرواني	5	الأفضل بدون منازع — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2024-11-19 19:22:04.782742	\N
723	289	عصام الفهيد	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2026-03-03 00:12:21.453328	\N
724	289	بلال السلطان	5	ممتاز جداً — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2024-03-05 11:11:14.044935	\N
725	2	إيناس المحيسن	5	يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2025-07-19 13:09:10.579458	\N
726	3	صالح الدبيان	4	سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2023-09-24 09:23:18.842028	\N
727	4	سبأ الغانم	4	الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2024-09-03 02:32:42.452387	\N
728	3	ميساء السلمي	5	أنصح الكل — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2025-02-05 19:46:19.110817	\N
729	3	خلدون البارقي	5	وايد زين — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2022-09-27 00:29:29.657204	\N
730	2	غادة الغامدي	5	ما قصّروا — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2024-03-13 16:12:27.154063	\N
731	3	دياب الشلهوب	5	رائع — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2021-09-12 10:30:36.369772	\N
732	4	دانة الحميد	4	اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2023-08-12 10:26:18.853396	\N
733	3	خاطر الشلال	4	ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2021-02-12 00:43:58.533752	\N
734	289	رؤى الحسيني	4	اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2024-09-21 04:16:09.793836	\N
735	3	رؤى الحسيني	5	أنصح الكل — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2022-12-14 01:14:17.037661	\N
736	289	ميرة الظفيري	4	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2022-10-06 10:04:45.642968	\N
737	289	سمر العازمي	5	رائع — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2022-03-15 08:08:46.754992	\N
738	4	ريم العتيبي	5	أنصح الكل — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2024-11-27 11:34:16.928043	\N
739	4	سارة الدوسري	5	أكثر من رائع — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2024-10-18 16:58:40.249201	\N
740	289	مشاري السبيعي	5	تجربة لا تنسى — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2020-05-29 09:01:08.624449	\N
741	289	حفيظ الجابري	5	يستاهل أكثر من خمس نجوم — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2022-07-27 10:30:40.257716	\N
742	3	بيان المسلم	5	محترفين — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2022-02-14 19:32:59.821218	\N
743	2	قيس العريفي	5	ما شاء الله — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2023-09-18 03:28:32.875714	\N
744	289	هزاع الشراري	5	خدمة استثنائية — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2020-07-23 18:25:43.593001	\N
745	4	حصة الحميدي	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2023-07-14 13:47:11.920839	\N
746	4	عفاف الطريف	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2026-02-23 02:06:24.061427	\N
747	2	عائشة الغريب	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2020-02-11 19:24:25.403538	\N
748	289	ديمة الداود	5	صراحة ممتاز — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2025-03-24 04:06:43.401513	\N
749	3	بدر الشلال	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2025-01-18 22:51:11.272474	\N
750	4	هند الحربي	4	سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2025-11-05 03:19:47.98061	\N
751	4	مضاوي المحمدي	5	ما قصّروا — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2024-07-10 04:04:28.643591	\N
752	289	شبيب المرشدي	5	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2026-03-16 10:55:47.004218	\N
753	3	ياسر العسيري	5	يستاهل أكثر من خمس نجوم — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2024-03-23 10:56:45.214371	\N
754	2	فلاح العوض	4	الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2021-06-19 06:14:29.284071	\N
755	2	ضيدان العنزي	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2023-10-03 01:39:49.075437	\N
756	4	ثابت العتيبي	5	محترفين — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2023-04-04 21:43:34.746691	\N
757	2	دلال الرشيدي	5	صراحة ممتاز — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2024-02-02 05:28:06.16402	\N
758	289	صالح الوادعي	5	خدمة استثنائية — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2020-06-26 21:39:15.726109	\N
759	2	سوسن الحسين	5	خدمة استثنائية — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2024-09-07 15:42:40.958851	\N
760	289	ماهر البريك	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2025-09-17 00:09:41.528008	\N
761	3	رامي العبدالله	5	خدمة استثنائية — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2023-05-01 07:29:08.825459	\N
762	2	راشد العازمي	5	أنصح الكل — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-05-10 20:25:19.444452	\N
763	289	سوسن الحسين	5	ما قصّروا — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2025-04-07 05:40:44.49304	\N
764	289	ماجد العمري	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2020-10-06 14:16:28.695031	\N
765	289	زينب الدوسري	5	رائع — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2024-12-23 03:14:44.782619	\N
766	3	وليد الزير	4	واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2023-02-01 19:54:18.32737	\N
767	2	عصام الفهيد	4	اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2023-06-25 07:51:55.710597	\N
768	4	منصور الحمادي	5	تجربة لا تنسى — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2022-10-07 00:35:48.773759	\N
769	2	قمر السبيعي	5	أكثر من رائع — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2024-05-12 06:51:59.046181	\N
770	3	صقر الشريدة	5	أكثر من رائع — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2025-05-23 06:40:14.292091	\N
771	4	داود المحمدي	5	الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-09-06 21:41:40.493435	\N
772	2	مشاري السبيعي	4	سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2024-01-05 17:05:52.36078	\N
773	2	بدر المطرفي	4	تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2023-06-16 13:38:12.898091	\N
774	289	نادر السهلي	5	خدمة استثنائية — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2020-07-31 13:53:35.3273	\N
775	2	مشعل العتيبي	5	محترفين — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2021-12-29 12:00:11.32211	\N
776	2	لانا الزهراني	5	خدمة استثنائية — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2020-05-30 13:51:57.203292	\N
777	2	عبدالجليل النفيعي	5	رائع — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2020-06-30 00:58:58.492232	\N
778	2	شادية الفهيد	5	ما شاء الله — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2024-11-29 07:36:01.900434	\N
779	289	فايز الجعيد	5	يستاهل أكثر من خمس نجوم — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2020-12-10 23:23:18.314295	\N
780	289	محمد العتيبي	4	يجيب كل القنوات العربية والعالمية بجودة عالية	t	2025-08-02 10:53:48.310294	\N
781	289	عائشة الغريب	4	واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2021-01-17 06:03:48.199701	\N
782	2	تركي المطيري	5	رائع — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2023-03-12 16:35:40.343969	\N
783	4	لؤي الحسين	5	صراحة ممتاز — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2020-08-28 20:25:48.695634	\N
784	3	رانية المنصور	5	رائع — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2021-09-17 17:20:18.152156	\N
785	289	رزان المطرقاني	5	ممتاز جداً — ما توقفت القنوات حتى في التحديثات، محترفين	t	2021-01-13 19:44:10.755392	\N
786	4	راشد العازمي	5	أكثر من رائع — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-10-16 06:08:44.436591	\N
787	4	جاسم المحيسن	4	دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2025-04-24 01:39:33.833535	\N
788	2	حسام السهلي	5	وايد زين — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2024-04-13 08:27:08.525729	\N
789	4	نداء الكريم	5	محترفين — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2025-08-18 11:37:28.326647	\N
790	4	حسام السهلي	5	محترفين — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2021-10-02 10:39:40.398993	\N
791	289	داود المحمدي	5	ممتاز جداً — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2022-10-14 13:35:18.464688	\N
792	3	ملك الغامدي	5	أنصح الكل — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2021-08-27 14:59:32.133859	\N
793	2	نسرين المطيري	4	اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2022-03-11 03:31:55.968058	\N
794	2	محفوظ الحربي	5	ممتاز جداً — ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2023-06-27 12:06:35.913101	\N
795	3	نجمة السلوم	4	من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2021-05-10 08:15:40.755288	\N
796	289	سبأ الغانم	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2021-08-20 02:59:51.519321	\N
797	3	إبراهيم الحميدي	5	تجربة لا تنسى — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-01-13 12:10:13.439564	\N
798	3	مضاوي المحمدي	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2021-12-24 22:38:42.995963	\N
799	4	عبير اليامي	5	خدمة استثنائية — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2020-07-04 22:38:09.538333	\N
800	289	إسراء السبيعي	5	خدمة استثنائية — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2022-01-23 21:59:46.483727	\N
801	3	ميرة الظفيري	5	تجربة لا تنسى — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2021-11-28 15:45:43.636455	\N
802	3	سبأ الغانم	4	ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2024-07-06 11:35:03.792048	\N
803	4	فهد الشهري	5	تجربة لا تنسى — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2024-01-24 22:44:58.972214	\N
804	2	معاذ العريفي	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2025-01-31 04:20:23.552905	\N
805	4	نيلة الشراري	5	الأفضل بدون منازع — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2020-12-01 12:55:03.052206	\N
806	2	نجم المالكي	5	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-07-29 15:19:00.642009	\N
807	2	حفيظ الجابري	5	ممتاز جداً — كل الباقات بأسعار معقولة وما في خسارة	t	2021-04-25 12:33:50.860146	\N
808	289	رافد الزهراني	5	ممتاز جداً — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2025-02-15 09:27:09.677753	\N
809	289	محمود الداود	5	صراحة ممتاز — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2020-07-22 16:02:09.291502	\N
810	4	صفاء الزبيدي	5	رائع — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2025-08-08 22:15:14.227846	\N
811	289	مها الرويلي	4	اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2020-07-25 17:41:10.446694	\N
812	2	نوف الفيفي	5	محترفين — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2024-07-27 15:23:46.915542	\N
813	2	حمد السليم	5	ما شاء الله — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2022-04-02 22:02:34.504045	\N
814	4	كوثر الصالح	4	دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2021-07-12 08:54:15.88825	\N
815	289	أريج السهلي	5	دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2025-05-12 06:03:41.131825	\N
816	289	زينة الجابري	5	خدمة استثنائية — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2024-07-28 00:32:07.25287	\N
817	3	قمر السبيعي	5	ما شاء الله — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2024-12-20 14:15:47.206158	\N
818	2	زياد المالكي	4	ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2021-05-28 19:33:32.588946	\N
819	3	معاذ العريفي	5	تجربة لا تنسى — ما توقفت القنوات حتى في التحديثات، محترفين	t	2025-02-08 23:07:59.704756	\N
820	3	لطيف المطيري	5	محترفين — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2021-12-06 14:07:31.401907	\N
821	4	صبرين السهلي	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2024-02-09 07:54:52.639951	\N
822	3	سارة الدوسري	5	يستاهل أكثر من خمس نجوم — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2023-07-06 18:39:17.817324	\N
823	3	رياض الحصان	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2025-08-11 10:35:48.972668	\N
824	4	لطيف المطيري	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-11-24 00:25:17.653666	\N
825	289	رندة الخلف	5	الأفضل بدون منازع — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2022-10-19 20:53:56.529148	\N
826	3	حمزة الثقفي	5	رائع — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2021-10-31 20:57:43.078934	\N
827	289	بكر العمودي	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2024-06-22 21:52:10.462751	\N
828	2	فريدة المزروع	5	يستاهل أكثر من خمس نجوم — ما توقفت القنوات حتى في التحديثات، محترفين	t	2020-01-26 09:50:49.361923	\N
829	3	شروق المطرفي	4	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2024-07-03 01:53:10.696932	\N
830	289	غازي البريكان	5	الأفضل بدون منازع — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2022-06-26 19:57:26.991277	\N
831	4	غنى الفقيه	5	ما قصّروا — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2024-12-31 22:02:51.885755	\N
832	3	ميادة الشثري	5	خدمة استثنائية — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2020-03-29 18:47:55.170249	\N
833	3	نيلة الشراري	4	اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2023-07-14 17:20:31.588497	\N
834	4	مروة الديحاني	5	ما قصّروا — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2023-10-30 04:34:34.564936	\N
835	2	كريم الصالح	5	صراحة ممتاز — مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2021-04-28 00:53:37.50365	\N
836	3	سراج الصقير	5	الأفضل بدون منازع — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2021-04-25 14:41:13.43886	\N
837	289	هيا الرشيدي	5	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2022-05-02 05:04:20.741398	\N
838	289	حمد الفراج	5	رائع — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2025-06-16 23:06:01.074657	\N
839	289	رغد الشلهوب	4	التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2020-12-03 03:36:54.502098	\N
840	4	مشاري القرشي	5	محترفين — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2020-09-11 19:12:49.71161	\N
841	2	رياض البلوي	5	صراحة ممتاز — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2020-04-23 01:28:31.844308	\N
842	3	فايز الجعيد	5	تجربة لا تنسى — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2021-09-13 06:43:15.692872	\N
843	3	منصور الحمادي	5	خدمة استثنائية — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2023-09-22 01:06:58.206602	\N
844	4	فلوة العريفي	5	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2024-06-25 12:56:38.564625	\N
845	4	طلال العسكر	4	دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2022-07-19 12:03:15.788352	\N
846	3	جوهرة الشريدة	5	أنصح الكل — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2022-09-01 00:46:47.754213	\N
847	289	قاسم الحربي	5	وايد زين — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2020-07-30 12:52:39.085085	\N
848	3	شعيب الفيفي	5	أنصح الكل — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2022-02-09 12:54:10.647156	\N
849	3	شهد المطيري	5	خدمة استثنائية — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2024-10-07 23:26:10.252634	\N
850	3	سليم الثبيتي	5	أنصح الكل — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2024-05-09 05:30:55.862254	\N
851	289	هبة الجعيد	4	ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2024-03-27 01:46:03.655122	\N
852	2	ثامر الحمود	4	ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2023-09-23 14:23:35.913416	\N
853	3	رفيق الجريوي	5	أكثر من رائع — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2022-01-25 18:46:10.509189	\N
854	4	دياب الشلهوب	4	شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2021-06-14 05:12:27.702902	\N
855	3	بلال السلطان	5	الأفضل بدون منازع — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-03-16 19:36:22.940904	\N
856	2	شريان الحربي	5	تجربة لا تنسى — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2024-01-22 16:58:29.276616	\N
857	4	حفيظ الجابري	4	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-01-17 15:40:07.093531	\N
858	289	ريم العتيبي	5	وايد زين — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2021-07-03 23:24:48.694899	\N
859	2	ماجد العمري	5	وايد زين — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2022-01-23 08:53:13.527061	\N
860	289	خالد الحربي	4	ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2026-01-21 07:19:41.051111	\N
861	2	فواز الحربي	4	كل الباقات بأسعار معقولة وما في خسارة	t	2021-08-22 23:23:31.695876	\N
862	289	بشار الراشد	5	أنصح الكل — ما توقفت القنوات حتى في التحديثات، محترفين	t	2021-11-20 00:06:35.50066	\N
863	2	مروة الديحاني	4	الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2022-02-22 07:15:16.030468	\N
864	3	بدر المطرفي	5	الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2021-06-28 21:24:56.62752	\N
865	289	أميرة العمري	5	وايد زين — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2025-12-24 01:35:54.389689	\N
866	4	أريج السهلي	4	تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2022-05-30 11:41:58.126071	\N
867	2	مضاوي البليهد	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2023-10-29 19:55:49.152661	\N
868	3	منار النفيعي	4	ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2025-07-10 10:03:56.983085	\N
869	289	عبدالرحمن الغامدي	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2025-06-30 23:21:28.835517	\N
870	4	هيفاء الصوينع	4	تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2023-03-22 13:05:07.075329	\N
871	3	عادل العجمي	4	اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2022-10-03 10:27:21.667085	\N
872	3	قيس الفهد	4	صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2023-10-08 10:28:15.789593	\N
873	4	فرح الزهيري	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2025-06-29 06:38:56.284091	\N
874	3	بسمة العنزي	4	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-01-02 21:40:53.927618	\N
875	3	أنس الزيد	5	ما قصّروا — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2023-07-31 11:11:49.873518	\N
876	2	فارس الحارثي	5	رائع — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2022-12-08 23:43:35.377438	\N
877	4	قاسم الحربي	5	محترفين — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2024-10-14 07:56:50.232676	\N
878	2	سامي الملحم	5	ما قصّروا — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2024-07-06 06:30:19.542406	\N
879	2	نجاح العتيبي	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2020-10-30 19:01:25.105624	\N
880	2	شهد المطيري	5	محترفين — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-06-27 20:23:05.202568	\N
881	289	رنا الحميدان	4	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2020-09-29 12:06:45.675354	\N
882	4	عبدالكريم اليامي	4	اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2026-02-13 17:01:47.703499	\N
1014	2	جابر الرويلي	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2024-02-11 05:34:11.252647	\N
883	4	عقيل العيسى	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2022-11-23 06:03:25.195247	\N
884	3	نداء الكريم	5	ما شاء الله — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2021-07-23 06:30:08.55752	\N
885	3	عزيزة الربيعي	5	تجربة لا تنسى — ما توقفت القنوات حتى في التحديثات، محترفين	t	2025-02-14 22:03:24.306344	\N
886	4	لانا الزهراني	5	ما شاء الله — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2020-01-08 07:47:50.820336	\N
887	289	هيام العسكر	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2021-01-27 03:55:25.96255	\N
888	289	يوسف الجهني	5	تجربة لا تنسى — عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2025-12-10 16:36:51.699417	\N
889	2	زهير الغامدي	5	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2024-01-06 03:44:19.847604	\N
890	289	حنان الثقفي	4	أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2023-11-04 16:53:11.737561	\N
891	2	منصور الحمادي	4	اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2024-04-09 00:28:03.996692	\N
892	289	صبرين السهلي	5	تجربة لا تنسى — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2023-07-07 22:59:52.416059	\N
893	2	حميد الزهيري	4	من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2022-06-18 11:27:50.049809	\N
894	2	عبدالرحمن الغامدي	5	محترفين — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2026-02-01 00:35:46.348549	\N
895	289	إبراهيم الحميدي	5	أنصح الكل — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2022-07-05 08:00:11.444887	\N
896	3	ضيدان العنزي	5	ما شاء الله — الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2025-08-02 15:59:03.626095	\N
897	3	يوسف الجهني	4	حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2021-09-04 10:08:29.312247	\N
898	289	علي الشريف	5	خدمة استثنائية — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2024-11-26 10:34:13.616659	\N
899	2	مطلق الظفيري	5	أكثر من رائع — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-10-18 18:54:00.095224	\N
900	289	فيصل الدوسري	5	أكثر من رائع — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2022-06-13 00:08:55.34426	\N
901	289	أسماء الحمدان	5	ممتاز جداً — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2023-09-10 02:25:45.098212	\N
902	4	زهرة الجهني	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2023-07-25 05:08:30.723117	\N
903	3	رداد الشمراني	5	يستاهل أكثر من خمس نجوم — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2021-06-30 12:07:31.08495	\N
904	4	معاذ العريفي	5	ما قصّروا — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-12-28 13:34:37.618126	\N
905	289	سهيلة الحربي	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2025-07-26 07:53:03.492095	\N
906	3	رشيد الحسيني	5	رائع — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2023-06-13 13:37:11.901633	\N
907	4	جوهرة الشريدة	5	تجربة لا تنسى — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2025-11-27 11:14:51.359175	\N
908	3	منال البلوي	5	تجربة لا تنسى — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2023-05-30 09:45:05.160216	\N
909	4	غانم الحارثي	5	صراحة ممتاز — تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2021-03-01 09:59:36.947077	\N
910	289	رياض البلوي	5	ما قصّروا — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2025-08-13 06:02:25.050114	\N
911	4	ملك الغامدي	4	اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2021-04-11 18:05:12.865633	\N
912	2	سلطان الخثلان	5	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2025-07-14 08:36:02.48335	\N
913	289	صفراء الشمراني	5	خدمة استثنائية — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2024-12-20 10:23:27.675924	\N
914	2	هيفاء الملحم	5	مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2020-09-25 04:34:03.210787	\N
915	2	وليد المنيع	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2023-11-13 17:03:17.132387	\N
916	4	نجاة المالكي	5	تجربة لا تنسى — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2024-01-31 11:50:13.152195	\N
917	2	رياض الحصان	5	يستاهل أكثر من خمس نجوم — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2023-08-29 22:11:32.069395	\N
918	4	أيمن الخلف	5	أكثر من رائع — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2021-01-26 00:04:25.770075	\N
919	3	صالح الخلف	5	ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2024-09-08 20:50:49.575044	\N
920	4	محمد العتيبي	5	تجربة لا تنسى — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2025-10-13 12:05:54.187997	\N
921	4	صبا البريك	4	ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2023-12-11 18:26:29.587764	\N
922	3	بسام العبيد	5	صراحة ممتاز — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2020-04-17 00:34:22.677816	\N
923	3	فيصل الدوسري	5	رائع — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2026-01-16 01:31:37.071373	\N
924	2	نجلاء الصاعدي	5	وايد زين — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2024-09-11 22:24:14.481807	\N
925	4	أسماء الحمدان	5	محترفين — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2020-02-17 13:56:47.67811	\N
926	4	حسين الغريب	5	يستاهل أكثر من خمس نجوم — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2022-11-07 14:41:40.984769	\N
927	3	هبة الجعيد	5	تجربة لا تنسى — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2020-07-12 03:29:25.09881	\N
928	3	دلال الرشيدي	4	اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2022-07-27 09:09:53.951468	\N
929	2	منار النفيعي	5	ما قصّروا — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2021-09-27 17:43:55.971322	\N
930	4	هيا الرشيدي	5	الأفضل بدون منازع — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2020-07-07 23:00:44.511898	\N
931	4	عزة الربيعي	5	محترفين — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-01-18 14:36:42.586243	\N
932	2	روضة الزيد	5	أكثر من رائع — ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2024-08-12 23:51:09.292928	\N
933	289	زهير الغامدي	5	محترفين — كل الباقات بأسعار معقولة وما في خسارة	t	2023-12-21 08:17:19.950673	\N
934	2	أيمن الخلف	4	البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2024-03-17 00:42:37.171	\N
935	2	دانيا الحازمي	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2020-03-10 06:02:52.699894	\N
936	4	ميساء السلمي	5	ما قصّروا — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2021-03-11 18:46:25.107257	\N
937	3	طلال العسكر	5	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2023-12-18 23:59:10.193322	\N
938	289	شادية الفهيد	5	الأفضل بدون منازع — سنة كاملة ما عندي أي شكوى، دايماً شغّال والصورة واضحة	t	2021-05-07 15:03:42.931998	\N
939	289	أمجد الفقيه	4	الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2021-06-04 20:01:45.433049	\N
940	289	سفيان الجفري	5	ممتاز جداً — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2024-04-30 01:54:21.298931	\N
941	2	إسراء السبيعي	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2020-05-22 03:05:37.355986	\N
942	289	لؤي الحسين	4	كل الباقات بأسعار معقولة وما في خسارة	t	2024-12-16 21:23:44.351451	\N
943	4	نجاح العتيبي	5	صراحة ممتاز — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2021-11-17 02:05:34.327375	\N
944	2	بسمة العنزي	5	وايد زين — جربت كثير مواقع وهذا الأفضل بفرق، خدمة العملاء ردوا علي بسرعة وحلوا المشكلة	t	2022-08-02 10:34:24.998559	\N
945	3	أيمن الخلف	5	صراحة ممتاز — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2022-08-11 02:42:36.614944	\N
946	4	رياض الحصان	5	محترفين — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2023-10-14 10:27:24.964265	\N
947	289	نفلاء العوض	4	ما قطع ولا في الأفلام الحية والمباريات المهمة	t	2022-09-04 00:08:16.748256	\N
948	289	غادة الحربي	5	ممتاز جداً — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2022-04-14 11:19:47.013767	\N
36	289	نايف السلمي	5	تجربة لا تنسى ممتازة	t	2020-08-07 17:31:20.766667	\N
949	3	بخيت المرواني	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2020-01-23 18:28:52.371463	\N
950	2	فداء الشعلان	5	ما قصّروا — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2023-05-19 10:17:02.367547	\N
951	289	منال البلوي	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2022-01-27 03:31:56.035597	\N
952	289	بتول الفواز	5	ممتاز جداً — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2020-08-23 20:03:57.756825	\N
953	3	هيا الرشيدي	5	محترفين — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2023-05-29 09:29:38.19241	\N
954	289	يحيى العوفي	5	الأفضل بدون منازع — جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2024-06-18 20:34:59.94972	\N
955	2	رداد الشمراني	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2026-01-19 03:15:39.620799	\N
956	3	عامر الزبيدي	4	ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2022-04-19 16:01:07.259285	\N
957	3	وفاء الفيفي	5	ما شاء الله — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2025-10-07 18:28:22.815714	\N
958	4	رافد الزهراني	5	أكثر من رائع — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2026-03-11 04:17:33.349066	\N
959	4	غازي البريكان	5	صراحة ممتاز — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-11-01 21:15:22.771002	\N
960	4	فواز الحربي	5	الأفضل بدون منازع — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2024-02-06 22:26:30.684813	\N
961	4	أنس الزيد	5	وايد زين — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2021-09-28 07:05:45.435452	\N
962	3	شادية الفهيد	5	أكثر من رائع — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2021-07-06 14:17:20.56574	\N
963	4	سلمى الخثلان	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2024-09-11 11:49:48.482103	\N
964	3	ناصر الحمدان	4	الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2021-04-18 23:43:09.603265	\N
965	289	أحمد السلمي	4	شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2022-10-08 05:16:48.442112	\N
966	289	إيناس المحيسن	5	وايد زين — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2020-04-01 11:59:14.137797	\N
967	2	رؤى الحسيني	5	خدمة استثنائية — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2022-07-06 10:10:18.739982	\N
968	289	رولا الحمادي	4	جديت سنتين متتاليتين ونفس الجودة، ما خذلوني	t	2021-01-19 01:38:40.979723	\N
969	4	يسرى البريكان	5	أنصح الكل — ما توقفت القنوات حتى في التحديثات، محترفين	t	2025-11-13 04:21:13.666066	\N
970	4	بيان المسلم	5	محترفين — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2022-08-07 07:45:15.08849	\N
972	4	عبدالعزيز السديس	5	أنصح الكل — الدعم الفني يرد حتى في الليل، هذا يفرق كثير	t	2024-01-02 01:28:39.904246	\N
973	3	فراج الدويش	4	جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2020-03-30 01:33:27.362434	\N
974	289	سليم الثبيتي	5	محترفين — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2023-09-13 02:17:57.490952	\N
975	4	شهد المطيري	5	ما قصّروا — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2020-11-16 13:43:34.410775	\N
976	2	نادر السهلي	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2022-11-11 06:55:34.964571	\N
977	4	ثامر الحمود	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2025-09-24 20:11:06.301405	\N
978	3	رزان المطرقاني	5	محترفين — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2024-07-12 13:11:16.758579	\N
979	3	سلمى البلوي	5	أنصح الكل — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2025-05-01 06:59:12.12187	\N
980	289	عبدالجليل النفيعي	5	تجربة لا تنسى — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2020-07-29 12:30:55.121564	\N
981	3	ثابت العتيبي	4	مباريات الدوري السعودي بجودة ممتازة وبدون انقطاع	t	2024-12-21 14:27:19.613198	\N
982	289	غدير الحارثي	4	اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2021-11-07 22:14:54.528421	\N
983	289	بسام العبيد	5	ممتاز جداً — اشتركت لوالدي وهو راضي جداً، كل القنوات الخليجية موجودة	t	2022-10-02 23:32:54.714123	\N
984	2	شبيب المرشدي	4	صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2021-02-17 12:44:47.544229	\N
985	289	فاطمة الخثلان	5	محترفين — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2023-08-11 20:22:59.662812	\N
986	2	عزيزة الربيعي	5	صراحة ممتاز — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2023-09-30 01:55:13.111472	\N
987	3	دخيل السدحان	5	رائع — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2025-08-22 01:55:39.964589	\N
988	4	بدر الشلال	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-09-25 03:52:45.82563	\N
989	4	خيرالدين السلوم	5	رائع — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2022-09-18 10:19:46.194094	\N
990	3	صفية الدويش	5	صراحة ممتاز — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2024-03-05 21:27:22.561651	\N
991	289	سراج الصقير	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-09-13 02:41:03.834394	\N
992	2	نوال السيف	5	وايد زين — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2020-08-29 00:58:52.202359	\N
993	289	سنا النعيمي	5	ممتاز جداً — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2021-05-13 07:39:50.647625	\N
994	289	قيس الفهد	5	تجربة لا تنسى — ما توقفت القنوات حتى في التحديثات، محترفين	t	2026-02-17 07:28:37.12966	\N
995	3	شافي النعيمي	5	يستاهل أكثر من خمس نجوم — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2020-05-04 11:14:53.781386	\N
996	2	نسيم المنيع	5	الأفضل بدون منازع — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2022-07-21 17:46:59.223148	\N
997	3	لمياء القحطاني	5	يستاهل أكثر من خمس نجوم — جربت غيره وما عجبني، رجعت لهذا لأنه الأضمن والأفضل	t	2020-05-23 23:27:58.563107	\N
998	2	صفراء الشمراني	5	خدمة استثنائية — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2024-08-17 07:28:35.388272	\N
999	4	حاتم الشراري	4	أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2025-07-27 08:54:30.190332	\N
1000	2	صبا البريك	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2020-04-16 01:04:21.793032	\N
1001	289	رهام الحربي	5	صراحة ممتاز — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2024-11-24 05:46:21.135943	\N
1002	289	عبير اليامي	5	صراحة ممتاز — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2021-03-04 12:02:19.99985	\N
1003	3	فداء الشعلان	5	ما شاء الله — البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2023-08-07 23:08:20.842766	\N
1004	289	وليد الرشيدي	4	يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2023-02-24 15:45:36.66006	\N
1005	289	راشد العازمي	4	أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2023-09-19 06:08:58.531014	\N
1006	3	هند الحربي	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2024-01-28 17:20:15.068411	\N
1007	4	غيث الثميري	5	صراحة ممتاز — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2020-08-24 01:26:37.021968	\N
1008	2	سليمان العتيق	5	ممتاز جداً — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2025-05-17 06:32:38.580667	\N
1009	3	مضاوي البليهد	5	صراحة ممتاز — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2024-02-13 09:10:06.394078	\N
1010	4	عبدالله القحطاني	5	الأفضل بدون منازع — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2020-04-30 22:18:35.842618	\N
1011	2	خلدون البارقي	4	كل الباقات بأسعار معقولة وما في خسارة	t	2024-12-29 04:33:28.819298	\N
1012	289	جابر الرويلي	4	أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-07-15 17:44:27.404644	\N
1013	3	رغد الشلهوب	4	خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2021-08-01 14:37:50.245	\N
1015	4	إبراهيم الحميدي	5	يستاهل أكثر من خمس نجوم — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2023-02-11 06:45:21.633752	\N
1016	3	محمود الداود	5	يستاهل أكثر من خمس نجوم — ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2025-05-19 14:32:09.774415	\N
1017	4	روان الصاعدي	5	ممتاز جداً — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2023-06-12 00:11:13.217584	\N
1018	4	ريما الحصان	5	أكثر من رائع — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-07-16 21:58:45.39001	\N
1019	3	بنان العقيل	5	ممتاز جداً — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2023-08-23 04:12:09.231313	\N
1020	3	أريج السهلي	5	وايد زين — دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2024-09-09 13:10:20.783872	\N
1021	4	عائشة الغريب	4	تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2023-07-19 14:24:08.898633	\N
1022	3	ختام السليم	4	خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2022-04-25 08:22:51.942065	\N
1023	3	مضاوي الحارثي	4	صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2023-06-12 07:27:34.583061	\N
1024	289	قمر السبيعي	5	محترفين — تسجيل سريع ودفع آمن والاشتراك يشتغل على طول	t	2025-01-31 11:02:31.212506	\N
1025	3	شمس الثميري	5	تجربة لا تنسى — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2023-06-11 20:14:47.828275	\N
1026	3	قيس العريفي	5	صراحة ممتاز — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2025-01-26 00:14:36.352656	\N
1027	2	عيد الدوسري	5	ما شاء الله — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2020-05-15 09:31:45.131025	\N
1028	3	بتول الفواز	5	تجربة لا تنسى — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2025-11-28 02:54:42.019379	\N
1029	4	زينة الجابري	5	يستاهل أكثر من خمس نجوم — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2021-07-18 20:55:41.243196	\N
1030	3	رنا الحميدان	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-11-12 01:49:16.21902	\N
1031	2	خالد الحربي	4	اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2024-10-21 06:51:34.46516	\N
1032	2	جاسم المحيسن	5	رائع — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-08-16 15:25:56.510229	\N
1033	289	صالح الخلف	5	خدمة استثنائية — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-06-19 16:29:25.319097	\N
1034	289	خاطر الشلال	5	الأفضل بدون منازع — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2020-06-28 16:49:51.800481	\N
1035	2	أمجد الفقيه	5	اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2023-03-07 12:17:28.215323	\N
1036	3	زينب الدوسري	5	محترفين — السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2020-04-05 23:59:36.569636	\N
1037	2	عادل العجمي	5	خدمة استثنائية — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2022-03-15 04:21:00.606212	\N
37	289	غانم المطيري	5	اشتركت وجدّدت مرتين ما شاء الله	t	2024-10-14 00:43:27.529016	\N
1038	289	عادل العجمي	5	صراحة ممتاز — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2020-10-16 01:17:49.787197	\N
1040	3	إيناس المحيسن	5	ما قصّروا — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2020-09-08 20:02:49.105895	\N
1041	289	ندى العجمي	5	الأفضل بدون منازع — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2023-08-14 16:00:39.433759	\N
1042	289	مازن العمر	4	ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-03-12 00:26:15.564273	\N
1043	2	رهف البقمي	5	رائع — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2021-05-10 04:22:45.500525	\N
1044	2	إيمان الفراج	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2026-01-28 23:43:45.144024	\N
1045	3	إيمان الفراج	5	محترفين — الاشتراك الشهري رخيص للتجربة وبعدها اشتريت السنوي فوراً	t	2020-05-23 01:50:08.421532	\N
1046	3	حفيظ الجابري	5	محترفين — خدمة تنافس أكبر المزودين العالميين بسعر أقل بكثير	t	2024-08-29 22:41:11.597597	\N
1047	289	ختام السليم	5	محترفين — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2025-07-19 21:32:24.973524	\N
1048	3	رهام الحربي	5	تجربة لا تنسى — واحد من أحسن الاشتراكات اللي جربتها، ويستاهل سعره والله	t	2025-10-09 06:16:08.3818	\N
1049	289	رشيد الحسيني	4	الموقع سهل والدفع آمن والباقة وصلت فوراً	t	2024-11-22 07:30:26.831348	\N
1050	2	كوثر الصالح	5	أنصح الكل — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2025-06-21 11:19:16.692855	\N
1051	2	هبة الجعيد	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2022-03-10 19:06:35.018657	\N
1052	2	ميادة الشثري	5	صراحة ممتاز — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2022-01-02 08:43:31.298905	\N
1053	4	عبدالجليل النفيعي	5	تجربة لا تنسى — صراحة خدمة رهيبة، القنوات كلها شغّالة حتى الرياضة والأفلام	t	2023-12-03 15:09:07.062309	\N
1054	289	سلطان الشمري	5	ما شاء الله — اشتراك يستاهل، سعر مناسب وجودة عالية ودعم ممتاز	t	2025-07-18 08:47:38.99223	\N
1055	3	ضيف الله العقيل	5	تجربة لا تنسى — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2020-01-19 13:18:33.682883	\N
1056	2	أوس المرزوق	4	استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2020-09-03 21:26:38.207105	\N
1057	4	شهاب الخطيب	5	أكثر من رائع — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2025-08-14 06:03:52.013632	\N
1058	4	سامي الملحم	4	دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2026-02-10 21:14:53.563804	\N
1059	289	نواف البقمي	5	وايد زين — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2021-09-29 11:38:39.60391	\N
1060	289	شهد المطيري	5	يستاهل أكثر من خمس نجوم — ما أقدر أتخيل أقل من هالجودة بعدها، صارت عادتي	t	2024-11-03 23:11:49.375197	\N
1061	3	دانة الحميد	5	خدمة استثنائية — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2020-10-29 03:50:37.653481	\N
1062	4	وليد المنيع	4	ما توقفت القنوات حتى في التحديثات، محترفين	t	2025-07-27 16:39:46.584721	\N
1063	4	بكر العمودي	5	رائع — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2023-02-02 17:33:14.355739	\N
1064	289	مياسة المرواني	4	والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2024-09-16 13:51:34.010709	\N
1065	4	طارق الحمادي	5	صراحة ممتاز — خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2021-10-22 13:05:02.210063	\N
1066	289	غيث الثميري	4	الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2023-08-15 19:55:10.26001	\N
1067	3	نسيم المنيع	5	رائع — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2021-05-25 20:18:24.801609	\N
1068	4	بنان العقيل	5	محترفين — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2026-01-04 09:11:30.070557	\N
1069	289	عنان الشثري	5	واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2026-02-21 10:24:11.979599	\N
1070	2	عبدالكريم اليامي	5	أنصح الكل — التجديد سهل وما فيه تعقيدات، تدفع وتشتغل على طول	t	2025-04-26 01:21:49.344302	\N
1071	4	دلال الرشيدي	5	وايد زين — أفضل من البث الاعتيادي بمراحل، والسعر معقول	t	2024-11-27 22:53:38.482952	\N
1072	4	نايف البلوي	5	رائع — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2020-08-20 14:41:57.000568	\N
1073	289	إيمان الفراج	5	أكثر من رائع — شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2020-11-19 16:10:55.827658	\N
1074	289	عبير المالكي	5	وايد زين — سرفرات قوية ما تحس بأي ثقل حتى في المباريات	t	2023-10-26 02:16:19.801502	\N
1075	4	لارا العبدالله	4	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2024-03-23 09:16:19.704542	\N
1076	289	ناصر الحمدان	4	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2024-10-05 20:25:26.11174	\N
1077	289	جواهر السديس	5	ممتاز جداً — دعم فني يفهم بسرعة ويحل المشكلة بدون تعقيد	t	2020-08-05 02:12:11.239414	\N
1078	4	سلطان الخثلان	4	الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2020-06-04 03:13:25.263798	\N
1079	4	صالح الدبيان	5	تجربة لا تنسى — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-03-10 04:19:55.840063	\N
1080	4	بشار الراشد	5	رائع — عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2025-02-01 19:12:17.629307	\N
1081	3	مروان السبيعي	4	اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2021-01-04 23:47:57.99233	\N
1082	3	زهير الغامدي	5	وايد زين — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-05-27 04:15:54.804375	\N
1083	2	فهد الشهري	5	ما قصّروا — واتساب الدعم نشيط وما يخلون أحد بدون حل	t	2022-01-04 02:04:47.980158	\N
1084	3	غدير الحارثي	5	محترفين — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2024-09-16 07:19:01.581107	\N
1085	2	غانم الحارثي	5	خدمة استثنائية — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2020-08-26 16:55:46.667465	\N
1086	289	حمزة الثقفي	5	اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2022-09-21 11:49:37.141442	\N
1087	2	حياة العتيق	5	ما شاء الله — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2024-09-15 22:05:48.00133	\N
1088	2	فراج الدويش	5	رائع — الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2025-10-20 04:24:38.965029	\N
1089	289	سماء الديحاني	5	محترفين — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2020-12-16 21:43:03.71796	\N
1090	2	رغد الشلهوب	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2022-01-03 01:36:31.727686	\N
1091	3	نايف البلوي	5	خدمة استثنائية — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2020-10-30 16:15:15.652097	\N
1092	2	بدر الشلال	5	رائع — اشتريت للمرة الثانية، دليل إنه خدمة ممتازة وموثوقة	t	2022-02-14 21:30:13.530682	\N
1093	289	عبدالعزيز السديس	5	وايد زين — كل الباقات بأسعار معقولة وما في خسارة	t	2024-12-22 01:14:08.368961	\N
1094	289	فلوة العريفي	5	يستاهل أكثر من خمس نجوم — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2025-01-30 10:20:14.046275	\N
1095	2	وليد الوطيان	5	أكثر من رائع — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2024-08-27 04:35:19.47872	\N
1096	3	مشاري القرشي	5	أكثر من رائع — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2021-12-07 17:15:25.115258	\N
1097	3	عمر الصاعدي	5	الأفضل بدون منازع — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2023-08-03 04:31:47.760997	\N
1098	3	جاسم المحيسن	5	أنصح الكل — اشتركت بسبب توصية صاحبي وما ندمت، شكراً له	t	2023-11-07 06:52:13.776577	\N
1099	4	بسمة العنزي	5	ما شاء الله — ما يحتاج سيتاب معقد، يشتغل من أول ما تدخل البيانات	t	2023-11-04 22:48:48.502692	\N
1100	2	نورة الشمري	5	تجربة لا تنسى — رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2022-10-09 21:02:10.307897	\N
1101	3	عبدالرحمن الغامدي	5	شغّال على التلفزيون والجوال والتابلت بدون أي مشكلة	t	2023-09-09 12:38:14.695914	\N
1102	4	تماضر الرشيدي	5	ما قصّروا — ما فيه لاق أفضل من كذا بهذا السعر في السوق	t	2025-01-13 00:53:34.477797	\N
1103	3	نوف الفيفي	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2021-12-03 03:02:13.269496	\N
1104	2	رانيا العريفي	5	وايد زين — حتى قنوات الأطفال موجودة بجودة ممتازة، العيال سعدوا	t	2024-05-09 23:41:06.073244	\N
1105	3	زهرة الجهني	5	محترفين — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2021-04-22 10:30:33.400213	\N
1106	4	وليد الرشيدي	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2021-08-26 05:33:25.819621	\N
1107	2	نادية السلطان	4	السرفر ما وقف ولا مرة خلال الشهر كله، احترافي	t	2024-08-16 20:08:21.571667	\N
1108	4	نعمة العمر	5	ما شاء الله — ما توقفت القنوات حتى في التحديثات، محترفين	t	2023-05-18 06:06:20.283502	\N
1109	4	دانيا الحازمي	5	الأفضل بدون منازع — جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2021-07-12 19:14:38.048519	\N
1110	289	روان الصاعدي	5	وايد زين — اشتراك ممتاز للعيلة، الأطفال والكبار كلهم راضين	t	2024-09-07 07:54:15.494587	\N
1111	4	خليل المطرقاني	5	وايد زين — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2022-10-06 16:22:14.224024	\N
1112	289	هادي الحازمي	4	ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2022-09-03 06:10:59.127877	\N
1113	2	حمود الطريف	5	أنصح الكل — الدفع سهل والتفعيل فوري، ما انتظرت ولا دقيقة	t	2020-06-01 15:56:26.706174	\N
1114	2	رنين العتيبي	5	ممتاز جداً — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2024-10-12 09:49:27.387137	\N
1115	2	هشام الحميد	5	ممتاز جداً — اشتراك ما أشوف عيوبه، كل شي تمام 100%	t	2024-01-12 08:39:02.036772	\N
1116	3	مساعد الشمري	5	وايد زين — اشتركت للعيلة كلها، كل واحد يشوف اللي يبيه بدون ما يعطل الثاني	t	2023-11-19 23:57:37.434671	\N
1117	289	روضة الزيد	4	سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2024-10-20 16:58:55.626104	\N
1118	2	صالح الدبيان	5	وايد زين — والله تجربة ممتازة، الاشتراك شغّال من أول ما اشتريت وما واجهت أي مشكلة	t	2023-02-17 19:40:42.347551	\N
1119	2	صالح الخلف	4	اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2024-12-24 16:38:47.919711	\N
1120	4	أمجد الفقيه	4	جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2024-07-09 09:56:44.954238	\N
1121	2	صفاء الزبيدي	5	تجربة لا تنسى — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2024-11-07 17:03:14.194672	\N
1122	289	ملك الغامدي	4	ما توقعت يكون زين كذا، الصورة 4K وما في تقطيع حتى في ساعات الذروة	t	2021-06-20 16:02:49.913284	\N
1123	3	وجد القرشي	5	خدمة استثنائية — جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2022-06-07 21:43:05.118888	\N
1124	2	رندة الخلف	5	خدمة استثنائية — اشتريت للجد عشان يشوف القنوات ومبسوط جداً	t	2025-03-07 20:26:52.128789	\N
1125	289	فهد الشهري	5	أنصح الكل — الاشتراك شغّال على الفايرستك بدون أي إضافات	t	2025-03-05 11:50:29.817777	\N
38	289	سلطان العنزي	5	يستاهل كل ريال دفعته	t	2020-01-27 12:23:22.472375	\N
1126	289	منار النفيعي	4	شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2021-09-18 12:51:09.158326	\N
1127	2	فاطمة الخثلان	4	عيلتي كلها صارت تطالبني بالتجديد قبل ما ينتهي	t	2024-11-22 02:48:45.583306	\N
1130	289	فلاح العوض	5	من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2025-10-06 11:26:57.742348	\N
1131	289	لانا الزهراني	5	محترفين — اشتراك سنوي بسعر شهرين من المنافسين، صفقة ما تتوقعها	t	2023-11-29 00:19:28.982497	\N
1132	4	صلاح الثبيتي	5	أنصح الكل — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2024-04-01 06:48:16.269567	\N
1133	289	دانة الحميد	4	تجربة اشتراك من الدرجة الأولى، حتى أصغر تفصيل مظبوط	t	2025-04-28 20:46:21.015289	\N
1134	4	ضيدان العنزي	5	ما قصّروا — خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2024-09-18 05:35:34.261195	\N
1135	4	هلا الراشد	5	رائع — يجيب كل القنوات العربية والعالمية بجودة عالية	t	2020-08-22 02:55:49.321732	\N
1136	289	غنى الفقيه	5	الأفضل بدون منازع — الاشتراك وصلني على طول، التفعيل لحظي ما انتظرت أبد	t	2026-01-25 21:34:18.620235	\N
1137	4	حمود الطريف	4	جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2022-01-01 04:04:27.798085	\N
1138	289	هشام الحميد	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2021-04-11 13:44:03.772568	\N
1139	4	جميل المرزوق	5	الأفضل بدون منازع — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2022-03-28 05:31:43.923071	\N
1140	3	يعقوب السيف	5	ما قصّروا — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2024-01-20 22:26:45.268649	\N
1141	2	أنس الزيد	5	أنصح الكل — أسرع دعم فني جربته في حياتي، ردوا علي خلال دقائق	t	2021-05-16 19:24:43.923788	\N
1142	2	بلال السلطان	5	صراحة ممتاز — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-01-15 08:07:40.381593	\N
1143	4	نجلاء الصاعدي	4	دفعت وجاء التفعيل خلال دقيقتين، ممتاز ويستاهل التجربة	t	2021-11-14 08:08:04.597589	\N
1144	3	راشد العازمي	5	خدمة استثنائية — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2025-03-12 02:38:43.603793	\N
1145	4	مضاوي الحارثي	4	خدمة من الدرجة الأولى، ما أندم على الاشتراك أبداً	t	2025-04-29 00:34:43.671837	\N
1146	2	شيماء البارقي	4	جودة الصورة رهيبة حتى على الإنترنت البطيء ما يتقطع	t	2021-09-26 10:23:54.512705	\N
1147	289	مريم الخلف	5	خدمة استثنائية — جربت الباقة الشهرية وبكرة أجدد للسنة بإذن الله، أثبت نفسه	t	2022-12-09 22:00:00.883807	\N
1148	3	داود المحمدي	5	البث مباشر للمباريات بدون أي تأخير، زين جداً	t	2021-10-24 23:52:37.302537	\N
1149	3	جودة الرشيدي	5	محترفين — من أفضل ما جربته في السوق السعودي، موثوق وسريع	t	2021-09-26 07:35:02.753717	\N
1150	2	جواهر السديس	5	الجودة تفوق السعر، ما شفت بهذا السعر خدمة بهالمستوى	t	2023-01-11 16:35:27.239085	\N
1151	4	نهى الخطيب	5	صراحة ممتاز — خدمة عملاء ممتازة، كل ما عندي سؤال يردون بسرعة على واتساب	t	2024-06-20 12:11:05.279932	\N
1152	4	أحمد السلمي	5	وايد زين — حتى في الاتصال البطيء ما في تقطيع، ضغطوا الصورة زين	t	2022-07-25 14:30:50.387392	\N
1153	4	أوس المرزوق	5	خليت أهلي يشتركون معي، كلهم سعيدين بالخدمة	t	2021-06-10 12:20:30.710749	\N
1154	2	بندر العنزي	4	جرّبت الشهر وعجبني فاشتريت سنة، كل شي تمام وبدون انقطاع	t	2020-11-21 23:08:28.839575	\N
1155	289	مضاوي الحارثي	5	خدمة استثنائية — ما جربت أي خدمة أفضل بهذا السعر في السوق العربي	t	2023-02-24 10:30:11.22728	\N
1156	4	بديع الغانم	4	رجّعت صاحبي الذي كان يدفع غالي على خدمة أرخص وأحسن	t	2021-04-21 09:12:24.043548	\N
1157	4	حمد الفراج	5	أنصح الكل — شغّال على كل الأجهزة بدون تعديلات أو إعدادات صعبة	t	2021-08-15 11:52:44.992318	\N
1158	289	سعود الفيفي	4	دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2026-01-15 16:43:25.946127	\N
1159	2	رانية المنصور	5	تجربة لا تنسى — جودة 4K حتى على الجوال، ما شفت كذا في غيره	t	2025-05-24 10:12:28.700356	\N
1160	2	شفق العيسى	5	رائع — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2022-12-07 13:54:55.061843	\N
1161	2	جميل المرزوق	5	صراحة ممتاز — أفضل استثمار عملته، بدل ما أدفع للباقات الغالية	t	2024-12-28 03:33:06.289195	\N
1162	2	سنا النعيمي	5	ما قصّروا — جودة الصورة تفوق التوقعات، خصوصاً المباريات والأخبار	t	2022-10-01 15:41:07.65349	\N
1163	3	خالد الحربي	5	أنصح الكل — دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2025-10-01 20:12:11.239757	\N
1164	4	قيس العريفي	5	ما شاء الله — تجربة اشتراك سلسة من البداية للنهاية، ممتاز	t	2022-12-14 03:28:51.039705	\N
1165	2	سارة الدوسري	5	وايد زين — اشتريت الاشتراك وما توقعت يكون بهالجودة، الصورة نقية والسرفر ما يقطع	t	2024-09-20 16:37:21.425566	\N
1166	3	صفراء الشمراني	5	رائع — استخدمته من شهرين والحمد لله ما انقطع ولا مرة، يستاهل كل ريال	t	2023-01-26 11:11:31.428181	\N
1167	289	شريان الحربي	5	محترفين — كل الباقات بأسعار معقولة وما في خسارة	t	2021-01-26 21:47:12.716289	\N
1168	3	رياض البلوي	5	ممتاز جداً — سنة كاملة من الراحة، ما احتجت أتصل بأي دعم فني	t	2020-08-06 02:54:02.348638	\N
1169	3	ضياء الحميدان	5	يستاهل أكثر من خمس نجوم — من أول ما فعّلت الاشتراك وأنا مبسوط، كل شي ماشي صح	t	2022-11-30 02:13:30.027996	\N
1	2	سلطان النمري	5	الاشتراك جميل جدا والجودة رهيبة 	t	2026-01-14 06:44:43.850682	\N
3	3	صالح الراشدي	5	ممتاز	t	2021-08-24 00:52:53.078972	\N
2	3	حمود االرشيدي	5		t	2020-12-22 18:55:27.017055	\N
4	1	سالم السميري	5	ممتاز حتى الان	t	2026-02-05 21:48:33.879897	\N
9	3	حمد اليامي	5	يستاهل مليون نجمة	t	2020-07-06 12:24:58.990631	\N
55	4	مساعد الرشيدي	5	ممتاز ١٠٠٪ اشتركت وما ندمت	t	2021-10-14 01:20:09.124646	\N
8	4	سامي الخالدي	5	ممتاز فوق المطلوب	t	2022-03-29 10:54:10.047702	\N
6	4	سلطان الشهراني	5	جميل وممتاز	t	2023-12-19 02:59:33.356821	\N
5	4	سالم المري	5	ممتاز	t	2026-03-26 19:23:49.865106	\N
7	2	احمد العليان	5	رهيب	t	2022-10-11 08:14:47.167407	\N
12	289	علي الاحمد	5	ممتاز الاشتراك 	t	2025-11-21 04:45:29.892173	\N
10	289	زايد الراشدي	5	منتج روعه	t	2024-10-17 14:13:28.766947	\N
11	289	حسن الشمري	5	ممتاز	t	2020-06-11 08:10:14.537728	\N
13	4	فهد العتيبي	5	ممتاز والجودة عالية	t	2021-08-27 12:47:09.995843	\N
14	4	سلطان الدوسري	5	خدمة ممتازة وسريعة	t	2021-05-23 17:59:05.392249	\N
15	4	عبدالله المطيري	5	كل شي تمام	t	2022-11-23 03:29:34.024005	\N
16	4	نواف الشهري	5	ما شاء الله رائع	t	2026-01-20 10:21:41.179699	\N
17	4	ماجد الزهراني	5	ممتاز ١٠٠٪	t	2023-04-13 16:08:56.485978	\N
18	4	طارق القحطاني	5	خير من الله وعل	t	2023-06-15 07:53:35.408399	\N
19	4	يوسف الحربي	4	كويس بس الاسعار غالية شوي	t	2025-04-19 17:54:03.983084	\N
20	4	خالد الرشيدي	5	تجربة رائعة وسريعة	t	2023-10-03 18:55:54.393844	\N
21	4	أحمد البقمي	5	اشتريت قبل وما ندمت	t	2020-02-15 23:45:43.452733	\N
22	4	عمر السبيعي	5	الافضل في السوق	t	2023-01-27 20:19:10.104824	\N
23	2	سعد الغامدي	5	والله يستاهل اشتريت مرة ثانية	t	2021-03-08 15:19:45.576369	\N
24	2	بدر العمري	5	قنوات كثيرة وجودة 4K رهيبة	t	2021-11-09 04:51:57.091478	\N
25	2	محمد الشمري	5	ممتاز جداً استمر	t	2025-05-27 20:41:17.340376	\N
26	2	عبدالرحمن الخالدي	5	أفضل اشتراك جربته	t	2021-06-22 03:45:45.41109	\N
27	2	صالح العجمي	5	بدون انقطاع ما شاء الله	t	2023-05-20 19:55:37.307769	\N
28	2	وليد المالكي	5	سرعة الاستجابة ممتازة	t	2024-02-28 07:56:53.512369	\N
29	2	حمدان الشريف	5	يستاهل مليون نجمة	t	2024-12-17 11:02:59.445486	\N
30	2	عيسى الدوسري	4	جيد جداً وسعر مناسب	t	2021-09-16 07:34:19.424792	\N
31	2	راشد المنصوري	5	أفضل من نتفليكس بكثير	t	2020-11-13 01:00:09.232751	\N
32	2	فيصل الحمدان	5	ما شاء الله جودة خيالية	t	2024-09-18 22:28:51.866376	\N
33	289	تركي الفيصل	5	الباقة الترا أفضل شي اشتريته	t	2023-12-08 12:29:06.737655	\N
34	289	منصور الحسن	5	١٢ شهر وما تقطعت ولا مرة	t	2023-06-03 02:52:13.629782	\N
39	289	بندر الحارثي	5	خدمة عملاء ممتازة وسرعة	t	2025-04-15 14:41:34.25015	\N
40	289	مبارك الصبيحي	5	رهيب ما شاء الله	t	2024-03-13 13:28:08.240189	\N
41	289	جاسم السعيد	5	الأفلام والمسلسلات محدثة دايم	t	2025-09-10 15:53:19.869761	\N
42	289	عادل الحربي	4	ممتاز لكن يتحسن اكثر	t	2023-02-13 21:40:13.498794	\N
43	289	وضاح المزروع	5	اشتراك سنة والله ما ندمت	t	2022-02-11 12:27:26.116233	\N
44	289	حمزة الشهراني	5	كل القنوات شغالة بجودة عالية	t	2024-06-29 05:34:08.381416	\N
45	3	عبدالله الصقر	5	سنتين والخدمة ما تغيرت ممتازة دايم	t	2025-11-21 14:12:08.320328	\N
46	3	محمد الخليفي	5	أفضل استثمار في الترفيه	t	2025-09-12 02:33:04.503669	\N
47	3	سالم الجابري	5	كل العيلة راضية بالاشتراك	t	2024-08-08 18:19:58.451132	\N
48	3	خميس المهندي	5	ما شاء الله خدمة لا تنقطع	t	2024-12-11 03:17:05.330294	\N
49	3	عمر الكندي	5	جدّدت لسنتين وما ندمت ابداً	t	2023-04-27 05:01:48.905603	\N
50	3	علي الحمادي	5	سعر السنتين وفّر علي كثير	t	2022-09-23 14:56:45.816369	\N
51	3	ناصر الراشدي	5	رهيب بكل المقاييس	t	2024-06-28 02:53:25.002188	\N
52	3	يعقوب العلي	5	الأفلام والمسلسلات تحديث مستمر	t	2024-06-25 21:15:30.917842	\N
53	3	حسين الزايد	4	ممتاز والسعر مقبول جداً	t	2023-10-15 05:32:45.23269	\N
54	3	إبراهيم الربيعي	5	افضل قرار اتخذته لعيلتي	t	2022-05-22 10:07:19.361328	\N
56	4	عبدالعزيز السهلي	5	سريع وبدون تقطيع	t	2024-06-05 15:58:10.578425	\N
57	289	حمود الحربي	5	اشتراك الترا الافضل على الاطلاق	t	2021-12-23 11:49:24.754768	\N
58	2	سطام العنزي	5	جودة رهيبة والقنوات ما تنتهي	t	2023-01-06 17:20:21.553084	\N
59	3	عبدالكريم الصبيحي	5	سنتين ما شاء الله بدون اي مشكلة	t	2022-02-15 18:42:54.508143	\N
60	289	ريان الحميدي	5	الترا يفوق التوقعات	t	2021-09-27 01:29:01.633807	\N
61	4	فلاح المطيري	5	اشتراك شهر وعملت تجديد مباشرة	t	2020-02-28 13:39:24.984271	\N
62	2	ناصر الدوسري	5	خدمة ممتازة ودعم فني سريع	t	2024-08-05 23:34:15.729337	\N
63	3	جابر العازمي	5	عيلتي كلها فرحانة بالاشتراك	t	2025-06-12 18:40:13.225142	\N
64	289	وليد الزهراني	5	١٢ شهر وكل شي تمام بالظبط	t	2023-06-23 15:34:51.647767	\N
65	4	شافي الغامدي	4	كويس ان شاء الله يطور اكثر	t	2020-11-02 08:12:39.108235	\N
66	2	سعيد المريخي	5	رهيب والاسعار تنافسية جداً	t	2021-08-26 10:10:48.419824	\N
67	3	عثمان الكعبي	5	افضل قرار شريت فيه هذا الاشتراك	t	2025-11-18 13:34:42.808063	\N
68	289	صالح الوهيبي	5	القنوات الرياضية ممتازة جداً	t	2025-12-04 20:50:39.876711	\N
69	4	زياد المنصور	5	جودة عالية وسعر مناسب	t	2021-09-29 09:19:57.650933	\N
70	2	هلال الأحمدي	5	الافلام والمسلسلات دايم محدثة	t	2021-10-11 02:07:07.49076	\N
71	3	عقيل الشمري	5	والله استحق كل ريال دفعته	t	2024-02-17 17:22:24.891805	\N
72	289	جمال الراشدي	5	ما تتوقع الجودة الى هالدرجة	t	2022-07-13 07:01:59.869122	\N
73	4	خليفة المزروعي	5	تجربة الشهر الاول رهيبة	t	2021-08-24 15:36:50.211029	\N
74	2	عبدالمجيد السلمي	5	ستة أشهر وكل يوم بتحسن	t	2020-01-16 00:00:56.800884	\N
75	3	حمد بن راشد	5	ما توقعت يكون بهالجودة	t	2023-08-18 00:48:04.53515	\N
76	289	سعود الهاجري	5	اشتراك الترا يستاهل كل ريال	t	2024-03-02 02:51:49.15687	\N
77	4	عبدالوهاب الكثيري	5	اسرع من اي خدمة جربتها	t	2022-03-25 04:58:47.14452	\N
78	2	مطر العمري	5	خدمة لا مثيل لها في السوق	t	2025-11-21 15:27:14.597591	\N
79	3	أنس الجهني	5	ما شاء الله سنتين بدون أي انقطاع	t	2020-08-14 00:46:35.841305	\N
80	289	هاشم الحبيل	5	الجودة 4K واضحة جداً	t	2020-08-24 19:25:14.225695	\N
81	4	راكان المسعد	5	شهر واشتركت مرة ثانية فوراً	t	2026-03-06 17:44:06.396339	\N
82	2	بسام القاسم	5	الرياضة والافلام كلها موجودة	t	2023-08-23 02:28:44.227638	\N
83	3	يحيى الثبيتي	5	للعائلة أفضل اختيار هذا الاشتراك	t	2022-12-11 18:26:14.728752	\N
84	289	حسن العمران	4	ممتاز لكن أتمنى يزيدون قنوات	t	2020-11-01 09:15:12.327796	\N
85	4	تيسير البلوي	5	الجودة تحدث عن نفسها	t	2020-09-07 10:49:01.107237	\N
86	2	ماهر الخرجي	5	سعر ومواصفات لا يصدق	t	2023-08-11 02:14:06.561418	\N
87	3	فضل القحطاني	5	سنتين والخدمة ما تغيرت	t	2020-12-03 16:25:42.214715	\N
88	289	مهند الرشيد	5	اشتريت للعائلة وكلهم راضيين	t	2023-03-16 18:27:26.100557	\N
89	4	ضيف الله الشراري	5	خدمة سريعة وتسليم فوري	t	2024-10-28 06:24:51.55022	\N
90	2	نزار الصقر	5	أفضل منصة IPTV جربتها	t	2022-12-05 07:49:12.167503	\N
91	3	أيمن الفيفي	5	ما وجدت أفضل منه بهذا السعر	t	2021-04-29 23:55:52.100378	\N
92	289	زيد الجارالله	5	الجودة مستمرة ما تقل	t	2024-07-22 15:46:33.840294	\N
93	4	مرعي القرني	5	اقتصادي وجودته عالية	t	2023-07-29 21:05:11.386567	\N
94	2	شعيب الحسيني	5	ممتاز ومحتوى ضخم	t	2022-12-17 21:24:51.660999	\N
95	3	زهير العبدالله	5	سنتين اشتراك والجودة ثابتة	t	2025-01-20 13:53:34.968573	\N
96	289	ربيع الحيدري	5	ترا الباقة الالترا حق كل واحد	t	2024-01-21 19:06:49.42238	\N
97	4	مطلق الرقيبة	5	قررت أجدد شهر آخر بعد التجربة	t	2022-10-30 13:48:46.579982	\N
98	2	عبدالناصر المولد	5	جودة ممتازة وتغطية شاملة	t	2022-01-05 20:03:16.042129	\N
99	3	سليمان البريكي	5	ما توقعت يكون بهالمستوى	t	2021-06-30 22:04:06.306706	\N
100	289	محسن الطويرقي	5	12 شهر وكل قناة تشتغل بدون مشكلة	t	2020-03-26 12:58:09.92567	\N
101	4	لافي المطرفي	5	للتجربة الشهرية ما أحسن منه	t	2025-10-04 03:53:19.749299	\N
102	2	قاسم الهاشمي	4	ممتاز والسعر معقول	t	2023-08-22 10:43:48.644964	\N
103	3	طلال القرشي	5	والله يستاهل أكثر من 5 نجوم	t	2024-03-14 12:00:14.607177	\N
104	289	عبدالحميد السدحان	5	الجودة 4K ما يصدق الفرق	t	2020-02-08 20:25:42.71625	\N
105	4	منيع الشلوي	5	أسرع تفعيل جربته في حياتي	t	2022-07-15 08:25:50.782429	\N
106	2	أسامة المنيع	5	6 أشهر وما في أي تقطيع	t	2022-12-02 01:24:27.273932	\N
107	3	مفرح الحسن	5	الاشتراك الامثل للعائلة بامتياز	t	2024-12-20 09:22:10.002821	\N
108	289	سفيان العتيبي	5	رهيب ما شاء الله ادومون عليه	t	2021-06-12 20:13:31.375995	\N
109	4	بركات الشريف	5	بداية ممتازة بالاشتراك الشهري	t	2025-06-21 18:20:19.40269	\N
110	2	أحمد الحازمي	5	كل القنوات العالمية موجودة	t	2021-09-19 09:15:11.256499	\N
111	3	غازي المعيقل	5	هذا الاشتراك وفّر علي الكثير	t	2024-11-04 05:46:37.466193	\N
112	289	مازن الدوسري	5	الافلام محدثة وبجودة خيالية	t	2021-12-21 18:55:10.577288	\N
113	4	حارب العتيبي	5	ممتاز من كل النواحي	t	2022-05-26 22:13:38.429802	\N
114	2	رشيد المالكي	5	تجربة رائعة سأجدد بالتأكيد	t	2024-06-16 20:14:53.28428	\N
115	289	فراس السبيعي	5	الترا ما في أحسن منها	t	2025-05-06 03:29:10.492361	\N
116	4	عبدالسلام العيسى	5	تجربة الشهر الأولى خيالية	t	2024-12-26 07:30:01.686987	\N
117	2	كريم الجحدلي	5	سعر ممتاز وقنوات لا تحصى	t	2023-10-09 17:40:40.556012	\N
118	3	لؤي الدغيري	5	سنتين وما غيرت اشتراكي	t	2025-12-25 09:52:55.524415	\N
119	289	مروان الحبشي	5	أفضل اشتراك في حياتي	t	2021-12-25 00:50:44.915389	\N
120	4	نصر الحربي	5	توصلت بيانات الاشتراك فوراً	t	2023-12-03 10:22:47.901514	\N
121	2	هاني البهيجي	5	6 أشهر بدون أي تقطيع ممتاز	t	2024-01-20 08:54:15.341482	\N
122	3	وائل الأسمري	5	يستاهل كل شيء	t	2025-11-26 22:10:08.082289	\N
123	289	يزيد الشريف	5	الجودة 4K تميز حقيقي	t	2025-04-06 17:56:57.819051	\N
124	4	أديب العبدالله	4	كويس وسعره مناسب للتجربة	t	2025-09-15 18:39:45.246376	\N
125	2	بلال الجبرين	5	جودة بجودة والدعم سريع	t	2024-06-13 09:44:36.802532	\N
126	3	جلال الجريسي	5	ما تحتاج تفكر اشترك مباشرة	t	2020-02-07 17:26:37.794659	\N
127	289	دخيل المطيري	5	أشتركت للثالثة هذا الاشتراك	t	2024-04-03 13:00:33.404406	\N
128	4	ذياب العنزي	5	سرعة التفعيل لم أتوقعها	t	2022-08-26 23:53:25.046652	\N
129	2	رامي الحسيني	5	أكثر من 10000 قناة بجودة عالية	t	2021-08-12 01:53:46.130184	\N
130	3	زكريا البحيري	5	للعائلة اختيار صح دائماً	t	2023-12-17 02:31:45.958435	\N
131	289	سامر الغيث	5	ما خذلني هذا الاشتراك ولا مرة	t	2022-03-17 20:19:55.880396	\N
132	4	شريف الزبيدي	5	تجربة رائعة بكل معنى الكلمة	t	2022-06-28 17:30:43.300705	\N
133	2	صالح البدراني	5	محتوى ضخم وتحديث مستمر	t	2021-02-17 02:27:33.452117	\N
134	3	ضرار الخليل	5	سنتين وأنا راضي جداً	t	2024-01-05 15:47:42.500036	\N
135	289	طالب الأنصاري	5	ثقتي في فالكون عالية جداً	t	2025-07-24 08:12:20.169935	\N
136	4	عارف الجندي	5	بداية ممتازة بالباقة الشهرية	t	2025-05-11 01:11:48.239466	\N
137	2	فارس الخشرمي	5	ممتاز وأنصح به الجميع	t	2021-11-06 04:17:44.590691	\N
138	3	قيس الدليمي	5	ادفع سنتين وترتاح من الهم	t	2020-04-03 20:32:22.786671	\N
139	289	كامل الصاعدي	5	جربت عدة مواقع وهذا الأفضل	t	2024-03-19 11:09:15.773498	\N
140	4	ماضي البلوي	5	الأسرع في التسليم بفارق كبير	t	2025-07-21 05:04:19.864416	\N
141	2	نبيل الخضيري	5	6 أشهر سبحان الله ما تأخرت ولا مرة	t	2023-11-03 00:12:01.639777	\N
142	289	أشرف الحجيلي	5	ما في أفضل من الترا بهالسعر	t	2026-02-25 22:02:39.365877	\N
143	4	بكر السليم	5	الشهر الأول أثبت كفاءة عالية	t	2022-11-19 14:09:57.859579	\N
144	2	جعفر القاسمي	5	6 شهور وما اشتكيت ولا مرة	t	2020-11-20 10:22:49.57776	\N
145	3	حيدر البزاز	5	أفضل اشتراك تلفزيوني عشته	t	2023-03-12 22:27:18.435392	\N
146	289	داوود الحمادي	5	الترا فعلاً تستحق اسمها	t	2022-03-18 13:41:27.523806	\N
147	4	راغب الشراري	5	أكثر من رائع للشهر الواحد	t	2025-09-13 07:52:50.779983	\N
148	2	زباري المطيري	5	قنوات تفوق التصور بجودة 4K	t	2021-03-03 03:10:59.729077	\N
149	3	سبأ الحميدي	5	أعيد الاشتراك سنتين بعد انتهائهم	t	2023-12-03 00:01:44.948698	\N
150	289	شهاب الخالدي	5	تميز حقيقي ما في كلام	t	2021-08-10 02:19:54.130155	\N
151	4	صقر النفيعي	5	سعر الشهر معقول وجودته عالية	t	2024-07-24 03:29:16.427275	\N
152	2	طيف الأزهري	4	كويس وأتمنى يزيدون المحتوى	t	2020-07-02 06:35:20.000882	\N
153	3	عامر السكران	5	سنتين تجربة لا تُقدر بثمن	t	2023-04-20 07:17:59.549479	\N
154	289	فهيد المقبل	5	كل يوم أشكر نفسي على قرار الاشتراك	t	2024-11-02 07:36:19.058058	\N
155	4	قدير الزيدي	5	بداية ممتازة وسأجدد بالتأكيد	t	2025-05-03 04:44:47.095509	\N
156	2	كاتب الرويلي	5	ما في منافس لهم في السوق	t	2020-10-23 12:50:09.289154	\N
157	3	لطيف الهذلي	5	كل العائلة سعيدة بهذا الاشتراك	t	2020-04-08 17:45:49.65603	\N
158	289	مدني العمير	5	12 شهر مرت كأنها يوم واحد	t	2020-02-11 05:03:18.78368	\N
159	4	نهار العتيبي	5	واجهة بسيطة وتفعيل سريع	t	2025-12-10 08:52:20.081948	\N
160	2	وسيم الصواط	5	ستة أشهر وما في أي مشكلة	t	2024-06-07 19:38:20.932261	\N
161	3	يامن الزبيدي	5	قيمة السنتين لا تقارن بما تحصل عليه	t	2021-02-09 06:15:22.143458	\N
162	3	سعد الغامدي	5	جدّدت لسنتين بعد ما جربت الجودة	t	2026-02-08 19:49:13.312346	\N
163	4	بندر الحارثي	5	جربت الشهر قبل ما اشتري الترا	t	2025-06-11 20:55:54.707877	\N
164	2	تركي الفيصل	5	كنت على 6 أشهر قبل ما أرقّي للترا	t	2023-03-15 23:17:31.012843	\N
165	4	ناصر الراشدي	5	الشهر الأول فيه كل القنوات	t	2022-07-24 10:18:56.915745	\N
166	289	أيمن الفيفي	5	رقّيت من سنتين للترا وفرق واضح	t	2024-04-21 15:24:00.301464	\N
167	2	قيس الدليمي	5	كنت على 6 أشهر وهو أفضل سعر	t	2022-02-04 19:42:49.803742	\N
168	289	إبراهيم الربيعي	5	الترا للأفلام والمسلسلات لا مثيل لها	t	2020-10-21 14:41:48.298939	\N
169	4	ضرار الخليل	5	جربت الشهر أولاً وكان رهيباً	t	2022-09-10 11:39:16.303874	\N
489	2	نعمة العمر	4	عندي اشتراك من سنة وما غيرت، يثبت جودته كل يوم	t	2025-03-27 02:27:22.827652	\N
971	4	جواهر السديس	4	دايماً أجدد عندهم لأني ما لقيت أحسن منهم	t	2021-12-16 04:14:29.286281	\N
1128	2	خاطر الشلال	5	أنصح الكل — يشتغل على الريسيفر القديم والجديد بدون مشاكل	t	2025-12-30 08:23:27.192454	\N
1129	289	لجين الشهري	5	تجربة لا تنسى — الباقة السنوية تستاهل، تحسب بالشهر يطلع بسعر رخيص جداً	t	2021-03-05 12:11:53.914323	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, name, description, price, features, image_url, cart_url, tags, meta_keywords, meta_description, long_description, purchase_count, original_price, is_hidden, deleted_at) FROM stdin;
3	اشتراك فالكون لمد عامين	فالكون برو الباقة الكاملة 	499	{"اكثر من 16000 الف قناة   8000  مسلسل  18000 فيلم"}	\N	\N	{}	\N	\N	\N	9	\N	f	\N
2	باقة فالكون برو - 6 شهور	اشتراك فالكون برو للمسلسلات والافلام والرياضة	110	{"جميع القنوات الرياضية","باقة نتفليكس وشاهد","دعم فني سريع"}	https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?auto=format&fit=crop&q=80&w=800	\N	{}	\N	\N	\N	4	\N	f	\N
4	اشنراك شهر	اشتراك فالكون برو للمسلسلات والافلام والرياضة	45	{"اكثر من16000"}	\N	\N	{}	\N	\N	\N	9	\N	f	\N
289	باقة فالكون الترا - 12 شهر	اشتراك فالكون الترا الافضل عالمياً وبدون تقطيع	199	{"اكثر من 10000 قناة\nمكتبة افلام ومسلسلات محدثة\nجودة 4K/FHD\nدعم فني 24/7"}	https://i0.wp.com/falconiptv.sa.com/wp-content/uploads/2024/10/WhatsApp-Image-2024-10-30-at-1.59.41-AM.jpeg?resize=768%2C768&ssl=1	\N	{}	\N	\N	\N	5	\N	f	\N
\.


--
-- Data for Name: server_updates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.server_updates (id, title, description, image_url, type, created_at) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.session (sid, sess, expire) FROM stdin;
9n_7WeS3KTWJ2-p0vpvWPbPxzjEaiSj5	{"cookie":{"originalMaxAge":604800000,"expires":"2026-04-05T14:56:18.947Z","secure":false,"httpOnly":true,"path":"/"},"adminId":1,"adminRole":"owner","adminUsername":"admin"}	2026-04-05 20:33:07
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site_settings (key, value) FROM stdin;
whatsapp_number	966531832836
whatsapp_message	
woocommerce_enabled	true
woocommerce_url	https://aziz-d.com
woocommerce_consumer_key	ck_08ca995605b7ffa34e25466b1093ae8fc6075f94
woocommerce_consumer_secret	cs_74ef81efad8d1b326207ee736099b386f17c1b0d
bitcoin_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
usdt_address	ETH
usdt_network	ERC20
eth_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
trx_address	TEWjMKCbHjMuqVktZUqWjaKcDxw34YqPaA
ton_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
usdc_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
link_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
uni_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
crypto_address	0xf9f9a4bd0bb5624ee6e170e8278cc507e8af2062
hero_badge	
hero_title_1	
hero_title_2	
hero_subtitle	أكثر من 16,000 قناة مباشرة...
hero_cta_primary	
hero_cta_secondary	
seo_og_title	
seo_og_description	
seo_og_image	
banner_enabled	false
banner_text	مرحبا بكم في  متجرنا بالشكل الجديد
banner_link	
banner_color	blue
feature_5_title	
feature_5_desc	
feature_count	4
feature_1_title	
feature_1_desc	
feature_2_title	
feature_2_desc	
feature_3_title	
feature_3_desc	
feature_4_title	
feature_4_desc	
\.


--
-- Data for Name: whatsapp_otps; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.whatsapp_otps (id, phone, code, expires_at, used, created_at) FROM stdin;
\.


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 2, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customers_id_seq', 1, true);


--
-- Name: digital_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_cards_id_seq', 3, true);


--
-- Name: gateway_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gateway_settings_id_seq', 1065, true);


--
-- Name: m3u_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.m3u_entries_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 83, true);


--
-- Name: product_reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_reviews_id_seq', 1169, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 289, true);


--
-- Name: server_updates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.server_updates_id_seq', 1, false);


--
-- Name: whatsapp_otps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.whatsapp_otps_id_seq', 1, false);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_username_unique UNIQUE (username);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: digital_cards digital_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_cards
    ADD CONSTRAINT digital_cards_pkey PRIMARY KEY (id);


--
-- Name: gateway_settings gateway_settings_gateway_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_settings
    ADD CONSTRAINT gateway_settings_gateway_id_unique UNIQUE (gateway_id);


--
-- Name: gateway_settings gateway_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gateway_settings
    ADD CONSTRAINT gateway_settings_pkey PRIMARY KEY (id);


--
-- Name: m3u_entries m3u_entries_entry_hash_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.m3u_entries
    ADD CONSTRAINT m3u_entries_entry_hash_key UNIQUE (entry_hash);


--
-- Name: m3u_entries m3u_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.m3u_entries
    ADD CONSTRAINT m3u_entries_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_reviews product_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_reviews
    ADD CONSTRAINT product_reviews_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: server_updates server_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_updates
    ADD CONSTRAINT server_updates_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (key);


--
-- Name: whatsapp_otps whatsapp_otps_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_otps
    ADD CONSTRAINT whatsapp_otps_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- PostgreSQL database dump complete
--

\unrestrict gbh0y0TIDKU6wYgt3YNjNeh1NkYLwNztxqGZmtFHt193kwbJSHUXzbZni7Y0QGR

