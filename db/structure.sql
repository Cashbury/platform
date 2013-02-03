--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: jasdeep; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA jasdeep;


--
-- Name: jasdeep123; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA jasdeep123;


--
-- Name: starbucks21; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA starbucks21;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA jasdeep;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = jasdeep, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authentications; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: businesses; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE businesses (
    id integer NOT NULL,
    name character varying(255),
    logo character varying(255),
    description text,
    country_id integer,
    legal_name character varying(255),
    featured boolean,
    currency_id integer,
    notes text,
    billing_address_id integer,
    mailing_address_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying(255) NOT NULL,
    master_pin character varying(255)
);


--
-- Name: businesses_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE businesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: businesses_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE businesses_id_seq OWNED BY businesses.id;


--
-- Name: campaign_types; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE campaign_types (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: campaign_types_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE campaign_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaign_types_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE campaign_types_id_seq OWNED BY campaign_types.id;


--
-- Name: campaigns; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE campaigns (
    id integer NOT NULL,
    name character varying(255),
    campaign_type_id integer,
    start_date timestamp without time zone,
    end_time timestamp without time zone,
    state character varying(255)
);


--
-- Name: campaigns_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE campaigns_id_seq OWNED BY campaigns.id;


--
-- Name: events; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    start timestamp without time zone,
    finish timestamp without time zone,
    name character varying(255),
    dispatcher text,
    receiver text,
    payload text
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: locations; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    business_id integer,
    is_mobile boolean,
    name character varying(255),
    street_address character varying(255),
    latitude double precision,
    longitude double precision,
    phone_number character varying(255),
    description text,
    featured_image character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    city character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    postal_code character varying(255) NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: marketing_campaigns; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE marketing_campaigns (
    id integer NOT NULL,
    name character varying(255),
    campaign_type_id integer,
    business_id integer,
    start_date timestamp without time zone,
    end_time timestamp without time zone,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: marketing_campaigns_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE marketing_campaigns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketing_campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE marketing_campaigns_id_seq OWNED BY marketing_campaigns.id;


--
-- Name: marketing_money_account; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE marketing_money_account (
    id integer NOT NULL,
    owner_id integer,
    state character varying(255),
    business_id integer,
    balance numeric(8,2) DEFAULT 0.0,
    "limit" numeric(8,2) DEFAULT 1000.0
);


--
-- Name: marketing_money_account_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE marketing_money_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketing_money_account_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE marketing_money_account_id_seq OWNED BY marketing_money_account.id;


--
-- Name: marketing_prizes; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE marketing_prizes (
    id integer NOT NULL,
    name character varying(255),
    prizeable_type character varying(255),
    prizeable_id character varying(255),
    campaign_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: marketing_prizes_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE marketing_prizes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: marketing_prizes_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE marketing_prizes_id_seq OWNED BY marketing_prizes.id;


--
-- Name: prize_items; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE prize_items (
    id integer NOT NULL,
    prize_name character varying(255),
    description character varying(255),
    picture character varying(255),
    redemption_method character varying(255),
    quantity_available integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value numeric(8,2) DEFAULT 0.0,
    cost numeric(8,2) DEFAULT 0.0
);


--
-- Name: prize_items_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE prize_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prize_items_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE prize_items_id_seq OWNED BY prize_items.id;


--
-- Name: prize_marketing_money; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE prize_marketing_money (
    id integer NOT NULL,
    prize_name character varying(255),
    description character varying(255),
    picture character varying(255),
    redemption_method character varying(255),
    quantity_available integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    value numeric(8,2) DEFAULT 0.0,
    cost numeric(8,2) DEFAULT 0.0
);


--
-- Name: prize_marketing_money_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE prize_marketing_money_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prize_marketing_money_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE prize_marketing_money_id_seq OWNED BY prize_marketing_money.id;


--
-- Name: roles; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    activation_state character varying(255),
    activation_token character varying(255),
    activation_token_expires_at character varying(255),
    reset_password_token character varying(255),
    reset_password_token_expires_at character varying(255),
    reset_password_email_sent_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255),
    date_of_birth date,
    phone_number character varying(255),
    is_male boolean,
    account_status character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: jasdeep; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


SET search_path = jasdeep123, pg_catalog;

--
-- Name: authentications; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: jasdeep123; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep123; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: businesses; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE businesses (
    id integer NOT NULL,
    name character varying(255),
    logo character varying(255),
    description text,
    country_id integer,
    legal_name character varying(255),
    featured boolean,
    currency_id integer,
    notes text,
    billing_address_id integer,
    mailing_address_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying(255) NOT NULL,
    master_pin character varying(255)
);


--
-- Name: businesses_id_seq; Type: SEQUENCE; Schema: jasdeep123; Owner: -
--

CREATE SEQUENCE businesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: businesses_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep123; Owner: -
--

ALTER SEQUENCE businesses_id_seq OWNED BY businesses.id;


--
-- Name: locations; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    business_id integer,
    is_mobile boolean,
    name character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    phone_number character varying(255),
    description text,
    featured_image character varying(255)
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: jasdeep123; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep123; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: roles; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: jasdeep123; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep123; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    activation_state character varying(255),
    activation_token character varying(255),
    activation_token_expires_at character varying(255),
    reset_password_token character varying(255),
    reset_password_token_expires_at character varying(255),
    reset_password_email_sent_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255),
    date_of_birth date,
    phone_number character varying(255),
    is_male boolean,
    account_status character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: jasdeep123; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: jasdeep123; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


SET search_path = public, pg_catalog;

--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: businesses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE businesses (
    id integer NOT NULL,
    name character varying(255),
    logo character varying(255),
    description text,
    country_id integer,
    legal_name character varying(255),
    featured boolean,
    currency_id integer,
    notes text,
    billing_address_id integer,
    mailing_address_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying(255) NOT NULL,
    master_pin character varying(255)
);


--
-- Name: businesses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE businesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: businesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE businesses_id_seq OWNED BY businesses.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    business_id integer,
    is_mobile boolean,
    name character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    phone_number character varying(255),
    description text,
    featured_image character varying(255)
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    activation_state character varying(255),
    activation_token character varying(255),
    activation_token_expires_at character varying(255),
    reset_password_token character varying(255),
    reset_password_token_expires_at character varying(255),
    reset_password_email_sent_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255),
    date_of_birth date,
    phone_number character varying(255),
    is_male boolean,
    account_status character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


SET search_path = starbucks21, pg_catalog;

--
-- Name: authentications; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE authentications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: starbucks21; Owner: -
--

CREATE SEQUENCE authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: starbucks21; Owner: -
--

ALTER SEQUENCE authentications_id_seq OWNED BY authentications.id;


--
-- Name: businesses; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE businesses (
    id integer NOT NULL,
    name character varying(255),
    logo character varying(255),
    description text,
    country_id integer,
    legal_name character varying(255),
    featured boolean,
    currency_id integer,
    notes text,
    billing_address_id integer,
    mailing_address_id integer,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying(255) NOT NULL,
    master_pin character varying(255)
);


--
-- Name: businesses_id_seq; Type: SEQUENCE; Schema: starbucks21; Owner: -
--

CREATE SEQUENCE businesses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: businesses_id_seq; Type: SEQUENCE OWNED BY; Schema: starbucks21; Owner: -
--

ALTER SEQUENCE businesses_id_seq OWNED BY businesses.id;


--
-- Name: locations; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    business_id integer,
    is_mobile boolean,
    name character varying(255),
    address character varying(255),
    latitude double precision,
    longitude double precision,
    phone_number character varying(255),
    description text,
    featured_image character varying(255)
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: starbucks21; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: starbucks21; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: roles; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: starbucks21; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: starbucks21; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    crypted_password character varying(255),
    salt character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    activation_state character varying(255),
    activation_token character varying(255),
    activation_token_expires_at character varying(255),
    reset_password_token character varying(255),
    reset_password_token_expires_at character varying(255),
    reset_password_email_sent_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    authentication_token character varying(255),
    date_of_birth date,
    phone_number character varying(255),
    is_male boolean,
    account_status character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: starbucks21; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: starbucks21; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


SET search_path = jasdeep, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY businesses ALTER COLUMN id SET DEFAULT nextval('businesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY campaign_types ALTER COLUMN id SET DEFAULT nextval('campaign_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY campaigns ALTER COLUMN id SET DEFAULT nextval('campaigns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY marketing_campaigns ALTER COLUMN id SET DEFAULT nextval('marketing_campaigns_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY marketing_money_account ALTER COLUMN id SET DEFAULT nextval('marketing_money_account_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY marketing_prizes ALTER COLUMN id SET DEFAULT nextval('marketing_prizes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY prize_items ALTER COLUMN id SET DEFAULT nextval('prize_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY prize_marketing_money ALTER COLUMN id SET DEFAULT nextval('prize_marketing_money_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = jasdeep123, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: jasdeep123; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep123; Owner: -
--

ALTER TABLE ONLY businesses ALTER COLUMN id SET DEFAULT nextval('businesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep123; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep123; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: jasdeep123; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY businesses ALTER COLUMN id SET DEFAULT nextval('businesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = starbucks21, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: starbucks21; Owner: -
--

ALTER TABLE ONLY authentications ALTER COLUMN id SET DEFAULT nextval('authentications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: starbucks21; Owner: -
--

ALTER TABLE ONLY businesses ALTER COLUMN id SET DEFAULT nextval('businesses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: starbucks21; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: starbucks21; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: starbucks21; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = jasdeep, pg_catalog;

--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: businesses_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY businesses
    ADD CONSTRAINT businesses_pkey PRIMARY KEY (id);


--
-- Name: campaign_types_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campaign_types
    ADD CONSTRAINT campaign_types_pkey PRIMARY KEY (id);


--
-- Name: campaigns_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: marketing_campaigns_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_campaigns
    ADD CONSTRAINT marketing_campaigns_pkey PRIMARY KEY (id);


--
-- Name: marketing_money_account_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_money_account
    ADD CONSTRAINT marketing_money_account_pkey PRIMARY KEY (id);


--
-- Name: marketing_prizes_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_prizes
    ADD CONSTRAINT marketing_prizes_pkey PRIMARY KEY (id);


--
-- Name: prize_items_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prize_items
    ADD CONSTRAINT prize_items_pkey PRIMARY KEY (id);


--
-- Name: prize_marketing_money_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prize_marketing_money
    ADD CONSTRAINT prize_marketing_money_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: jasdeep; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = jasdeep123, pg_catalog;

--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: jasdeep123; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: businesses_pkey; Type: CONSTRAINT; Schema: jasdeep123; Owner: -; Tablespace: 
--

ALTER TABLE ONLY businesses
    ADD CONSTRAINT businesses_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: jasdeep123; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: jasdeep123; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: jasdeep123; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: businesses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY businesses
    ADD CONSTRAINT businesses_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = starbucks21, pg_catalog;

--
-- Name: authentications_pkey; Type: CONSTRAINT; Schema: starbucks21; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: businesses_pkey; Type: CONSTRAINT; Schema: starbucks21; Owner: -; Tablespace: 
--

ALTER TABLE ONLY businesses
    ADD CONSTRAINT businesses_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: starbucks21; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: starbucks21; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: starbucks21; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


SET search_path = jasdeep, pg_catalog;

--
-- Name: index_roles_on_name; Type: INDEX; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: jasdeep; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = jasdeep123, pg_catalog;

--
-- Name: index_roles_on_name; Type: INDEX; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: jasdeep123; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = public, pg_catalog;

--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


SET search_path = starbucks21, pg_catalog;

--
-- Name: index_roles_on_name; Type: INDEX; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: starbucks21; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121227185615');

INSERT INTO schema_migrations (version) VALUES ('20121227185830');

INSERT INTO schema_migrations (version) VALUES ('20121227202357');

INSERT INTO schema_migrations (version) VALUES ('20121230194851');

INSERT INTO schema_migrations (version) VALUES ('20130102053831');

INSERT INTO schema_migrations (version) VALUES ('20130103233654');

INSERT INTO schema_migrations (version) VALUES ('20130104000129');

INSERT INTO schema_migrations (version) VALUES ('20130109033411');

INSERT INTO schema_migrations (version) VALUES ('20130110042425');

INSERT INTO schema_migrations (version) VALUES ('20130123032438');

INSERT INTO schema_migrations (version) VALUES ('20130124030147');

INSERT INTO schema_migrations (version) VALUES ('20130131173846');

INSERT INTO schema_migrations (version) VALUES ('20130131232805');

INSERT INTO schema_migrations (version) VALUES ('20130131235707');

INSERT INTO schema_migrations (version) VALUES ('20130201010136');

INSERT INTO schema_migrations (version) VALUES ('20130201023602');