--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: artifact_tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artifact_tags (
    id integer NOT NULL,
    artifact_id integer,
    tag_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: artifact_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artifact_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artifact_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artifact_tags_id_seq OWNED BY artifact_tags.id;


--
-- Name: artifacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artifacts (
    id integer NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: artifacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: artifacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE artifacts_id_seq OWNED BY artifacts.id;


--
-- Name: pictures; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pictures (
    id integer NOT NULL,
    artifact_id integer,
    image character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pictures_id_seq OWNED BY pictures.id;


--
-- Name: reflections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reflections (
    id integer NOT NULL,
    artifact_id integer,
    name character varying(255),
    text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: reflections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reflections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reflections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE reflections_id_seq OWNED BY reflections.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artifact_tags ALTER COLUMN id SET DEFAULT nextval('artifact_tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY artifacts ALTER COLUMN id SET DEFAULT nextval('artifacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pictures ALTER COLUMN id SET DEFAULT nextval('pictures_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY reflections ALTER COLUMN id SET DEFAULT nextval('reflections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: artifact_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artifact_tags
    ADD CONSTRAINT artifact_tags_pkey PRIMARY KEY (id);


--
-- Name: artifacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artifacts
    ADD CONSTRAINT artifacts_pkey PRIMARY KEY (id);


--
-- Name: pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id);


--
-- Name: reflections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reflections
    ADD CONSTRAINT reflections_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: index_on_artifacts_location; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_on_artifacts_location ON artifacts USING gist (st_geographyfromtext((((('SRID=4326;POINT('::text || latitude) || ' '::text) || longitude) || ')'::text)));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140410021202');

INSERT INTO schema_migrations (version) VALUES ('20140410021318');

INSERT INTO schema_migrations (version) VALUES ('20140410021424');

INSERT INTO schema_migrations (version) VALUES ('20140410021952');

INSERT INTO schema_migrations (version) VALUES ('20140410022045');

INSERT INTO schema_migrations (version) VALUES ('20140413025954');

INSERT INTO schema_migrations (version) VALUES ('20140413041539');
