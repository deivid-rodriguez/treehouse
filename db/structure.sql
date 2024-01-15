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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: facilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facilities (
    id bigint NOT NULL,
    type character varying,
    name text,
    address text,
    external_id text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facilities_id_seq OWNED BY public.facilities.id;


--
-- Name: facility_geocodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.facility_geocodes (
    id bigint NOT NULL,
    facility_id bigint NOT NULL,
    geocode_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: facility_geocodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.facility_geocodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facility_geocodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.facility_geocodes_id_seq OWNED BY public.facility_geocodes.id;


--
-- Name: geocodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.geocodes (
    id bigint NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    certainty integer,
    address text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: geocodes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.geocodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geocodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.geocodes_id_seq OWNED BY public.geocodes.id;


--
-- Name: overpass_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.overpass_queries (
    id bigint NOT NULL,
    facility_type character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: overpass_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.overpass_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: overpass_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.overpass_queries_id_seq OWNED BY public.overpass_queries.id;


--
-- Name: queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queries (
    id bigint NOT NULL,
    queryable_type character varying NOT NULL,
    queryable_id character varying NOT NULL,
    name text NOT NULL,
    description text,
    body text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.queries_id_seq OWNED BY public.queries.id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.responses (
    id bigint NOT NULL,
    query_id bigint NOT NULL,
    request_body text NOT NULL,
    body text NOT NULL,
    retrieved_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: responses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.responses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.responses_id_seq OWNED BY public.responses.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: facilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facilities ALTER COLUMN id SET DEFAULT nextval('public.facilities_id_seq'::regclass);


--
-- Name: facility_geocodes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility_geocodes ALTER COLUMN id SET DEFAULT nextval('public.facility_geocodes_id_seq'::regclass);


--
-- Name: geocodes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geocodes ALTER COLUMN id SET DEFAULT nextval('public.geocodes_id_seq'::regclass);


--
-- Name: overpass_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overpass_queries ALTER COLUMN id SET DEFAULT nextval('public.overpass_queries_id_seq'::regclass);


--
-- Name: queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries ALTER COLUMN id SET DEFAULT nextval('public.queries_id_seq'::regclass);


--
-- Name: responses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responses ALTER COLUMN id SET DEFAULT nextval('public.responses_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: facilities facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);


--
-- Name: facility_geocodes facility_geocodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility_geocodes
    ADD CONSTRAINT facility_geocodes_pkey PRIMARY KEY (id);


--
-- Name: geocodes geocodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geocodes
    ADD CONSTRAINT geocodes_pkey PRIMARY KEY (id);


--
-- Name: overpass_queries overpass_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overpass_queries
    ADD CONSTRAINT overpass_queries_pkey PRIMARY KEY (id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (id);


--
-- Name: responses responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responses
    ADD CONSTRAINT responses_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_facilities_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_facilities_on_external_id ON public.facilities USING btree (external_id);


--
-- Name: index_facility_geocodes_on_facility_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facility_geocodes_on_facility_id ON public.facility_geocodes USING btree (facility_id);


--
-- Name: index_facility_geocodes_on_geocode_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_facility_geocodes_on_geocode_id ON public.facility_geocodes USING btree (geocode_id);


--
-- Name: index_queries_on_queryable_type_and_queryable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_queries_on_queryable_type_and_queryable_id ON public.queries USING btree (queryable_type, queryable_id);


--
-- Name: index_responses_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_query_id ON public.responses USING btree (query_id);


--
-- Name: responses fk_rails_1723310968; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.responses
    ADD CONSTRAINT fk_rails_1723310968 FOREIGN KEY (query_id) REFERENCES public.queries(id);


--
-- Name: facility_geocodes fk_rails_de97ecff28; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility_geocodes
    ADD CONSTRAINT fk_rails_de97ecff28 FOREIGN KEY (geocode_id) REFERENCES public.geocodes(id);


--
-- Name: facility_geocodes fk_rails_e8f0c6e594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.facility_geocodes
    ADD CONSTRAINT fk_rails_e8f0c6e594 FOREIGN KEY (facility_id) REFERENCES public.facilities(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20240114152544'),
('20240114152030'),
('20240114145319'),
('20240114144353'),
('20240114144122'),
('20240114143824'),
('0');

