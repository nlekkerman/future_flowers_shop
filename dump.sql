--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Ubuntu 16.2-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-1.pgdg22.04+1)

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
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: dict_int; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;


--
-- Name: EXTENSION dict_int; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';


--
-- Name: dict_xsyn; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;


--
-- Name: EXTENSION dict_xsyn; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgrowlocks; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;


--
-- Name: EXTENSION pgrowlocks; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';


--
-- Name: pgstattuple; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;


--
-- Name: EXTENSION pgstattuple; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: xml2; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;


--
-- Name: EXTENSION xml2; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO dpawoazs;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.account_emailaddress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO dpawoazs;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.account_emailconfirmation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.account_emailconfirmation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO dpawoazs;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO dpawoazs;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO dpawoazs;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO dpawoazs;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO dpawoazs;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO dpawoazs;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart_cart; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.cart_cart (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer,
    session_id character varying(255),
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.cart_cart OWNER TO dpawoazs;

--
-- Name: cart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.cart_cart ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cart_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: cart_cartitem; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.cart_cartitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    deleted boolean NOT NULL,
    cart_id bigint NOT NULL,
    seed_id bigint NOT NULL,
    CONSTRAINT cart_cartitem_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.cart_cartitem OWNER TO dpawoazs;

--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.cart_cartitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cart_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_adminactivity; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_adminactivity (
    id bigint NOT NULL,
    action character varying(50) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    details text NOT NULL,
    admin_id integer NOT NULL,
    chat_session_id bigint NOT NULL
);


ALTER TABLE public.chat_adminactivity OWNER TO dpawoazs;

--
-- Name: chat_adminactivity_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_adminactivity ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_adminactivity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_chatbotresponse; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_chatbotresponse (
    id bigint NOT NULL,
    query character varying(255) NOT NULL,
    response text NOT NULL
);


ALTER TABLE public.chat_chatbotresponse OWNER TO dpawoazs;

--
-- Name: chat_chatbotresponse_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_chatbotresponse ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_chatbotresponse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_chatmessage; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_chatmessage (
    id bigint NOT NULL,
    sender character varying(10) NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    status character varying(10) NOT NULL,
    session_id bigint NOT NULL
);


ALTER TABLE public.chat_chatmessage OWNER TO dpawoazs;

--
-- Name: chat_chatmessage_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_chatmessage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_chatmessage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_chatsession; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_chatsession (
    id bigint NOT NULL,
    started_at timestamp with time zone NOT NULL,
    ended_at timestamp with time zone,
    status character varying(10) NOT NULL,
    admin_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.chat_chatsession OWNER TO dpawoazs;

--
-- Name: chat_chatsession_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_chatsession ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_chatsession_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: conversation; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.conversation (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.conversation OWNER TO dpawoazs;

--
-- Name: chat_conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.conversation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_conversation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_conversation_participants; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_conversation_participants (
    id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.chat_conversation_participants OWNER TO dpawoazs;

--
-- Name: chat_conversation_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_conversation_participants ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_conversation_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_message; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_message (
    id bigint NOT NULL,
    content text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    conversation_id bigint NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer
);


ALTER TABLE public.chat_message OWNER TO dpawoazs;

--
-- Name: chat_message_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_message ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: chat_supportticket; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.chat_supportticket (
    id bigint NOT NULL,
    subject character varying(255) NOT NULL,
    description text NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.chat_supportticket OWNER TO dpawoazs;

--
-- Name: chat_supportticket_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.chat_supportticket ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chat_supportticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: checkout_order; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.checkout_order (
    id bigint NOT NULL,
    order_number character varying(32) NOT NULL,
    full_name character varying(50) NOT NULL,
    email character varying(254) NOT NULL,
    phone_number character varying(20) NOT NULL,
    country character varying(2) NOT NULL,
    postcode character varying(20),
    town_or_city character varying(40) NOT NULL,
    street_address1 character varying(80) NOT NULL,
    street_address2 character varying(80),
    county character varying(80),
    date timestamp with time zone NOT NULL,
    delivery_cost numeric(6,2) NOT NULL,
    order_total numeric(10,2) NOT NULL,
    grand_total numeric(10,2) NOT NULL,
    original_bag text NOT NULL,
    stripe_pid character varying(254) NOT NULL,
    user_profile_id bigint
);


ALTER TABLE public.checkout_order OWNER TO dpawoazs;

--
-- Name: checkout_order_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.checkout_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.checkout_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: checkout_orderlineitem; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.checkout_orderlineitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    lineitem_total numeric(6,2) NOT NULL,
    order_id bigint NOT NULL,
    seed_id bigint NOT NULL,
    CONSTRAINT checkout_orderlineitem_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.checkout_orderlineitem OWNER TO dpawoazs;

--
-- Name: checkout_orderlineitem_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.checkout_orderlineitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.checkout_orderlineitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: communications_chatconversation; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.communications_chatconversation (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    superuser_id integer NOT NULL,
    user_id integer NOT NULL,
    is_active boolean NOT NULL,
    started_at timestamp with time zone NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.communications_chatconversation OWNER TO dpawoazs;

--
-- Name: communications_chatconversation_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.communications_chatconversation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.communications_chatconversation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: communications_chatmessage; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.communications_chatmessage (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    conversation_id bigint NOT NULL,
    sender_id integer NOT NULL,
    received_at timestamp with time zone,
    seen boolean NOT NULL,
    sent_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.communications_chatmessage OWNER TO dpawoazs;

--
-- Name: communications_message_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.communications_chatmessage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.communications_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: custom_accounts_userprofile; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.custom_accounts_userprofile (
    id bigint NOT NULL,
    address character varying(255),
    phone_number character varying(20),
    profile_image character varying(255),
    about_self character varying(255),
    receives_newsletter boolean NOT NULL,
    email character varying(254),
    user_id integer
);


ALTER TABLE public.custom_accounts_userprofile OWNER TO dpawoazs;

--
-- Name: custom_accounts_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.custom_accounts_userprofile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.custom_accounts_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO dpawoazs;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO dpawoazs;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO dpawoazs;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO dpawoazs;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO dpawoazs;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.django_site ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: human_human; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.human_human (
    id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    age integer NOT NULL,
    email character varying(254) NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.human_human OWNER TO dpawoazs;

--
-- Name: human_human_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.human_human ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.human_human_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reviews_comment; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.reviews_comment (
    id bigint NOT NULL,
    text text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    review_id bigint NOT NULL,
    status character varying(20) NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.reviews_comment OWNER TO dpawoazs;

--
-- Name: reviews_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.reviews_comment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reviews_review; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.reviews_review (
    id bigint NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    status character varying(20) NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL
);


ALTER TABLE public.reviews_review OWNER TO dpawoazs;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.reviews_review ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: seeds_seed; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.seeds_seed (
    id bigint NOT NULL,
    name character varying(200) NOT NULL,
    scientific_name character varying(200) NOT NULL,
    description text NOT NULL,
    planting_months_from integer NOT NULL,
    planting_months_to integer NOT NULL,
    flowering_months_from integer NOT NULL,
    flowering_months_to integer NOT NULL,
    category character varying(100) NOT NULL,
    sun_preference character varying(20) NOT NULL,
    price numeric(10,2) NOT NULL,
    discount numeric(5,2) NOT NULL,
    height_from numeric(5,2) NOT NULL,
    height_to numeric(5,2) NOT NULL,
    image character varying(255),
    created_at timestamp with time zone NOT NULL,
    deleted boolean NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    is_in_stock boolean NOT NULL,
    CONSTRAINT seeds_seed_flowering_months_from_check CHECK ((flowering_months_from >= 0)),
    CONSTRAINT seeds_seed_flowering_months_to_check CHECK ((flowering_months_to >= 0)),
    CONSTRAINT seeds_seed_planting_months_from_check CHECK ((planting_months_from >= 0)),
    CONSTRAINT seeds_seed_planting_months_to_check CHECK ((planting_months_to >= 0))
);


ALTER TABLE public.seeds_seed OWNER TO dpawoazs;

--
-- Name: seeds_seed_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.seeds_seed ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.seeds_seed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.social_auth_association (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE public.social_auth_association OWNER TO dpawoazs;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.social_auth_association ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.social_auth_association_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.social_auth_code (
    id bigint NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_code OWNER TO dpawoazs;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.social_auth_code ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.social_auth_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.social_auth_nonce (
    id bigint NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE public.social_auth_nonce OWNER TO dpawoazs;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.social_auth_nonce ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.social_auth_nonce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.social_auth_partial (
    id bigint NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    data jsonb NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE public.social_auth_partial OWNER TO dpawoazs;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.social_auth_partial ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.social_auth_partial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.social_auth_usersocialauth (
    id bigint NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    user_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    modified timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL
);


ALTER TABLE public.social_auth_usersocialauth OWNER TO dpawoazs;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.social_auth_usersocialauth ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.social_auth_usersocialauth_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(200) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data jsonb NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO dpawoazs;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.socialaccount_socialaccount ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL,
    provider_id character varying(200) NOT NULL,
    settings jsonb NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO dpawoazs;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.socialaccount_socialapp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id bigint NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO dpawoazs;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.socialaccount_socialapp_sites ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: dpawoazs
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO dpawoazs;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: dpawoazs
--

ALTER TABLE public.socialaccount_socialtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.socialaccount_socialtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add site	7	add_site
26	Can change site	7	change_site
27	Can delete site	7	delete_site
28	Can view site	7	view_site
29	Can add email address	8	add_emailaddress
30	Can change email address	8	change_emailaddress
31	Can delete email address	8	delete_emailaddress
32	Can view email address	8	view_emailaddress
33	Can add email confirmation	9	add_emailconfirmation
34	Can change email confirmation	9	change_emailconfirmation
35	Can delete email confirmation	9	delete_emailconfirmation
36	Can view email confirmation	9	view_emailconfirmation
37	Can add social account	10	add_socialaccount
38	Can change social account	10	change_socialaccount
39	Can delete social account	10	delete_socialaccount
40	Can view social account	10	view_socialaccount
41	Can add social application	11	add_socialapp
42	Can change social application	11	change_socialapp
43	Can delete social application	11	delete_socialapp
44	Can view social application	11	view_socialapp
45	Can add social application token	12	add_socialtoken
46	Can change social application token	12	change_socialtoken
47	Can delete social application token	12	delete_socialtoken
48	Can view social application token	12	view_socialtoken
49	Can add seed	13	add_seed
50	Can change seed	13	change_seed
51	Can delete seed	13	delete_seed
52	Can view seed	13	view_seed
53	Can add cart	14	add_cart
54	Can change cart	14	change_cart
55	Can delete cart	14	delete_cart
56	Can view cart	14	view_cart
57	Can add cart item	15	add_cartitem
58	Can change cart item	15	change_cartitem
59	Can delete cart item	15	delete_cartitem
60	Can view cart item	15	view_cartitem
61	Can add association	16	add_association
62	Can change association	16	change_association
63	Can delete association	16	delete_association
64	Can view association	16	view_association
65	Can add code	17	add_code
66	Can change code	17	change_code
67	Can delete code	17	delete_code
68	Can view code	17	view_code
69	Can add nonce	18	add_nonce
70	Can change nonce	18	change_nonce
71	Can delete nonce	18	delete_nonce
72	Can view nonce	18	view_nonce
73	Can add user social auth	19	add_usersocialauth
74	Can change user social auth	19	change_usersocialauth
75	Can delete user social auth	19	delete_usersocialauth
76	Can view user social auth	19	view_usersocialauth
77	Can add partial	20	add_partial
78	Can change partial	20	change_partial
79	Can delete partial	20	delete_partial
80	Can view partial	20	view_partial
81	Can add user profile	21	add_userprofile
82	Can change user profile	21	change_userprofile
83	Can delete user profile	21	delete_userprofile
84	Can view user profile	21	view_userprofile
85	Can add order line item	22	add_orderlineitem
86	Can change order line item	22	change_orderlineitem
87	Can delete order line item	22	delete_orderlineitem
88	Can view order line item	22	view_orderlineitem
89	Can add order	23	add_order
90	Can change order	23	change_order
91	Can delete order	23	delete_order
92	Can view order	23	view_order
93	Can add comment	24	add_comment
94	Can change comment	24	change_comment
95	Can delete comment	24	delete_comment
96	Can view comment	24	view_comment
97	Can add review	25	add_review
98	Can change review	25	change_review
99	Can delete review	25	delete_review
100	Can view review	25	view_review
101	Can add chat bot response	26	add_chatbotresponse
102	Can change chat bot response	26	change_chatbotresponse
103	Can delete chat bot response	26	delete_chatbotresponse
104	Can view chat bot response	26	view_chatbotresponse
105	Can add admin activity	27	add_adminactivity
106	Can change admin activity	27	change_adminactivity
107	Can delete admin activity	27	delete_adminactivity
108	Can view admin activity	27	view_adminactivity
109	Can add chat message	28	add_chatmessage
110	Can change chat message	28	change_chatmessage
111	Can delete chat message	28	delete_chatmessage
112	Can view chat message	28	view_chatmessage
113	Can add support ticket	29	add_supportticket
114	Can change support ticket	29	change_supportticket
115	Can delete support ticket	29	delete_supportticket
116	Can view support ticket	29	view_supportticket
117	Can add chat session	30	add_chatsession
118	Can change chat session	30	change_chatsession
119	Can delete chat session	30	delete_chatsession
120	Can view chat session	30	view_chatsession
121	Can add conversation	31	add_conversation
122	Can change conversation	31	change_conversation
123	Can delete conversation	31	delete_conversation
124	Can view conversation	31	view_conversation
125	Can add message	32	add_message
126	Can change message	32	change_message
127	Can delete message	32	delete_message
128	Can view message	32	view_message
129	Can add chat conversation	33	add_chatconversation
130	Can change chat conversation	33	change_chatconversation
131	Can delete chat conversation	33	delete_chatconversation
132	Can view chat conversation	33	view_chatconversation
133	Can add message	34	add_message
134	Can change message	34	change_message
135	Can delete message	34	delete_message
136	Can view message	34	view_message
137	Can add chat message	34	add_chatmessage
138	Can change chat message	34	change_chatmessage
139	Can delete chat message	34	delete_chatmessage
140	Can view chat message	34	view_chatmessage
141	Can add human	35	add_human
142	Can change human	35	change_human
143	Can delete human	35	delete_human
144	Can view human	35	view_human
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
45	pbkdf2_sha256$870000$Kvy7Iq7E6PgJasyNWqQloo$LPq4N3Skt4SGLBfFnSfdg2MIw9fD+IBE+UptbDz41Fw=	2024-10-26 14:14:31.248106+00	f	sokica			so@mail.com	f	t	2024-10-26 14:14:28.222533+00
35	pbkdf2_sha256$870000$ldsZx37RgfGUGQNr3fNXOZ$+Z+NzcraRlHxEYfrWEDowuCUuGxNziiHVw3PB92zI1A=	\N	f	Bajka			bajkovitia@mail.com	f	t	2024-10-26 13:06:16.914734+00
47	pbkdf2_sha256$870000$sUubNfwzXRy2BOBdpPeHrR$vxxy96LsIBA8CrzRjvFgyVeQUgiPM5fEv2uVTBHLlm0=	2024-10-27 10:05:20.823388+00	f	Kola			bra@mail.com	f	t	2024-10-27 10:05:17.824014+00
24	pbkdf2_sha256$870000$1kyielYDR8Q0RDe22xCRCA$MPkBvQYnXOiPeiKnq5gMxD4jXjbMx27AMY3m0psdAfo=	\N	f	Solomon				f	t	2024-10-26 10:09:03.894315+00
16	pbkdf2_sha256$870000$n1IuikcsovgEhtXevPITkL$5MRHMnkWHizcWQ5D8HGo8lxNoBJFvCQckRys6Zfb4oE=	2024-08-29 14:13:47.496813+00	f	liki				f	t	2024-08-29 14:13:44.571201+00
20	pbkdf2_sha256$870000$KSU7ZqicePJD1Buq08j0Vm$OrBlUe557Pl/twUgkEXWrlehQpB/XEOR4MXf7t9dTGE=	2024-10-11 10:57:08.319949+00	f	tijana				f	t	2024-09-13 10:36:48.664064+00
17	pbkdf2_sha256$870000$ozc1sKdGD4JimrGVnXU75I$oYL7GqjxvgD8dWzCC/LWpbFCKqvdX27x+XNtZ+EhSgU=	2024-08-29 14:35:15.87344+00	f	bosko				f	t	2024-08-29 14:25:49.37623+00
18		\N	f	chatbot	Chat	Bot	chatbot@example.com	f	t	2024-08-29 14:36:21.353514+00
8	pbkdf2_sha256$870000$QypMXrx7sSJ0C4fMzsozRI$XFVbt1q+o/AFebIDelhG4ML/LvsPU1lOUrDuQKSINRI=	\N	f	Sladja				f	t	2024-08-21 11:09:14.837467+00
9	pbkdf2_sha256$870000$H68nVnPjwOm6pwTXwejwOd$bRE3ikDgAIF6oFSKTrKkUDPVdIu475Gv/Qtw22y8lAQ=	\N	f	Miki				f	t	2024-08-21 11:12:36.068222+00
10	pbkdf2_sha256$870000$eYdk7r9NB53jzaacZcUaIP$pCoxDT3ybyuIUqbFB0OoF4fcmp4i4IGWHuUgvo04jsY=	\N	f	george				f	t	2024-08-21 11:15:59.437605+00
11	pbkdf2_sha256$870000$y6aIO0pkyrniXQsVZI6zpL$ng/eL02jaIC4x3QzOAzz/LPmYHvUc5YMZkjiWOGhv2g=	2024-08-21 11:17:41.139641+00	f	Simke				f	t	2024-08-21 11:17:38.217503+00
12	pbkdf2_sha256$870000$KWXLvau964AkTbhn1a1IwU$JkayT78cOnZPLF2vZR8rNip71m3hw8MLQE7A4+HAj+0=	2024-08-21 11:19:12.006112+00	f	saed				f	t	2024-08-21 11:19:09.108294+00
36	pbkdf2_sha256$870000$ckhx6cz1PG4FJvFGFyM1eG$4ud947jQJE5GibP/61eh9SMliaKWlGhtwegvhPBuhAE=	\N	f	nikolaus			nikio@mail.com	f	t	2024-10-26 13:14:07.995649+00
13	pbkdf2_sha256$870000$ShQF8P7dbbCJvkvXXlYYbe$V7YzJ3EboStI64uLkLlHWBDRntyT0vJYEJOS5jahh+w=	2024-08-24 17:01:43.519266+00	f	Sudo				f	t	2024-08-24 17:01:40.543179+00
26	pbkdf2_sha256$870000$zEPA8EPAUg1Fu15dMKWMUt$C6QnLUUNVxOEltqnngNlkQ8LLfg35gJKyzG44bkCQ84=	\N	f	Brka			brka@mail.com	f	t	2024-10-26 10:40:00.533294+00
27	pbkdf2_sha256$870000$mENfzlZ3vEPHmYX0whWWg6$ZYr6qtKb6won9BKnIwkFOrxVXyZtIgDNxepnpUYQnlo=	\N	f	Okitax			oki@mail.com	f	t	2024-10-26 10:47:59.924373+00
14	pbkdf2_sha256$870000$IWNXabgOEHGZZChsRclKzM$5rEvdj6mT+sH1aqHbolgbv6jXYgcajcgYpg8n2PURTY=	2024-08-26 17:20:07.412723+00	f	kile				f	t	2024-08-26 17:20:04.492388+00
28	pbkdf2_sha256$870000$NhoNa9JGXNFlRAu7cxR7zA$fljznlUSco6d/XccqGqMHSQuTY3hBc8PZCiux2Errqs=	\N	f	Savanah			h2we@mail.com	f	t	2024-10-26 10:51:02.013716+00
46	pbkdf2_sha256$870000$vJY309uZVCBi6xXTu8N5WC$OXGYAt0EseOhsKKK4qgce+eVbmDfkn0g/TicPBtF8i0=	2024-10-26 14:26:56.694299+00	f	finalko			fi@mail.com	f	t	2024-10-26 14:26:53.697414+00
29	pbkdf2_sha256$870000$lEnF9nq5qhLhyI6wHLgaUM$XGPlP4TdGrXnl3EIVss4HTUQJ5iGNZcB8L/ZiAZIF5U=	\N	f	DOritos			rita@mail.com	f	t	2024-10-26 11:03:48.816509+00
30	pbkdf2_sha256$870000$lQc61DrdalMkMgQL7kZUG8$hnYpFYuuYJR80hdP2nB4p4c24NvemTb9J+Nnx62IGu0=	\N	f	Zijo			zi@mail.com	f	t	2024-10-26 11:40:13.405889+00
37	pbkdf2_sha256$870000$JcDR4IKvAUxIKD4SboxvXI$dj/rgONBEtntyemiooC+HFHjvXCVRIf9R4By1JSljZ4=	\N	f	nikolausko			nikioss@mail.com	f	t	2024-10-26 13:15:19.025311+00
21	pbkdf2_sha256$870000$PUxUt5dXeUP21eKlnYFftp$lHQx28bdyqq7VLDzfBeHAZQ7gHCWm+SkrnebyeVKDms=	2024-10-04 12:55:58.35616+00	f	lozica				f	t	2024-10-04 12:55:55.477069+00
31	pbkdf2_sha256$870000$ztByv2wLpTSFbw5jPA5Gzj$/TPYc4Nh1CcS0ONIBDohcCOGL1+BjlMGef7QPBuCpUw=	\N	f	Dona			do@mail.com	f	t	2024-10-26 12:03:28.457673+00
32	pbkdf2_sha256$870000$RntsWqHaqYwA9PlbAYbvvn$BmtGoTIf78cxZhDCzsMrjTxOQ1AZL+K5gE3eRkbeOTU=	\N	f	Flores			flo@mail.com	f	t	2024-10-26 12:06:23.905251+00
38	pbkdf2_sha256$870000$EnL2fdKpqpXXhsDZcuvTEu$/r9y07eg2hM3JPO4KDzbc7TPZx65YzYM9VD3X43H3BM=	\N	f	fiki			fix@mail.com	f	t	2024-10-26 13:16:17.347084+00
39	pbkdf2_sha256$870000$DOvCHPgkN1WwnC54RoB0jX$Y+UtdTIRsk9p/OMBUR6pNa3WA1zJugNmq1O8x/W3V4o=	\N	f	Tina			ti@mail.com	f	t	2024-10-26 13:21:59.075039+00
22	pbkdf2_sha256$870000$JkXSzqAzpFN0urYTat2F7i$QcZHINglRBBlaIKZUy1kR45BMWPvFig8+WZRMYZ0L2k=	2024-10-05 16:33:20.088113+00	f	Sanja				f	t	2024-10-05 16:33:17.215705+00
23	pbkdf2_sha256$870000$KS2qGfg011V7hdD0XUC9mC$QIETLpRJYtLN+5SYp+KyMFn/ok24uskGg/oPSV6tQ8M=	2024-10-05 21:24:49.94191+00	f	Bakir				f	t	2024-10-05 21:24:47.083588+00
40	pbkdf2_sha256$870000$fHBkdGT5f48jk79L8vDsKI$yDvpCSq6YToFraDRSNPvvP/cQstQQcN7VJWVvoMHB+o=	2024-10-26 13:27:26.464819+00	f	koloko			ko@mail.com	f	t	2024-10-26 13:27:23.16573+00
33	pbkdf2_sha256$870000$qTRzY3627Qt8DSGVLY7aq1$JWRyfbPdj4cHCx9493h2+kU5+rCJDwQYXTLx3hfL6SY=	\N	f	Som			mos@mail.com	f	t	2024-10-26 12:31:42.939706+00
41	pbkdf2_sha256$870000$zCv4C5pCkHeVsA4zslmsB0$K3Ml3bBhDH8qcJKdN/4tOHws3dekKUvl8osFVMyiY8k=	\N	f	shinobi			sh@mail.com	f	t	2024-10-26 13:34:57.610362+00
42	pbkdf2_sha256$870000$9jr0eKyvMDasSw5aMlKTVn$pyVMcvtobIgx4V0728k5ABgm/qMhYpsr9lC3HVja1zQ=	\N	f	Sonja			so@mail.com	f	t	2024-10-26 14:03:17.771112+00
43	pbkdf2_sha256$870000$ngbjeTzBUfNWp5jFQTotKM$f4ThEjjxV1CCxmCc7su+Gpk6/A/YygmwKOMmc3lmUDE=	\N	f	borna			bo@mail.com	f	t	2024-10-26 14:05:27.759644+00
50	pbkdf2_sha256$870000$shN1IW5OQ7jEOt8DkaS3vO$scbUYJ1J25kHXgZOMWJ9YYqRNADZkpXbprACPfnn3K4=	2024-10-27 10:20:44.482505+00	f	bologna			bola@mail.com	f	t	2024-10-27 10:20:41.377653+00
34	pbkdf2_sha256$870000$2bVrq1I6FBCGDk85oPWKpB$AtuM81jfYeZD0zEOm+hIcmQbBrXl40FdiLRulrWMM8M=	\N	f	combo			com@mail.com	f	t	2024-10-26 12:58:11.575702+00
44	pbkdf2_sha256$870000$Xe7X4BS7ftxsLZvYt2oNwh$87WhpGGaJdOn/wS+qoaFGH8lo2X4QNwK/LKzZsyR8tE=	\N	f	folio			fo@mail.com	f	t	2024-10-26 14:11:57.221501+00
48	pbkdf2_sha256$870000$Y9hxVK6xW644AY4Ms7VL0J$MDTRxJPMG4zobXgLyHRXZp8fWlXLI6qDrSuJMzQarwU=	2024-10-27 10:12:06.307402+00	f	tugi			ti@mail.com	f	t	2024-10-27 10:12:03.339508+00
49	pbkdf2_sha256$870000$lJWQgZBZha2rgwYx6M23LM$cIitTNHDPs5JqdqO+QHa6UzN/8qhT9iFmzye1liRdVY=	2024-10-27 10:18:04.64392+00	f	fikro			fi@mail.com	f	t	2024-10-27 10:18:01.53217+00
51	pbkdf2_sha256$870000$n8dXXwuBcfdflQnqMGRWR1$jEaGTWO4hRLGUjAfhb9UcjTiz9WdkznTcxj9p0U7lXA=	2024-10-27 10:38:33.030233+00	f	Sladjana			sanja.cookies@gmail.com	f	t	2024-10-27 10:38:29.918933+00
52	pbkdf2_sha256$870000$0fnaQSDwBu2IQgOHssBCRF$Sn+5JwYhr6PtLd9vrXTKSks1tOX1/sUZZ8NHjUBj738=	2024-10-28 13:30:08.497385+00	f	Samko			sa@mail.com	f	t	2024-10-27 12:51:38.469251+00
53	pbkdf2_sha256$870000$EiYjvpKdl8UXd51cl8gfJH$TkKKh3AfBl5SFM5JTYrCBT90kybHQacoqRjcDkMbcy4=	2024-10-29 23:30:55.452774+00	f	Vrtlarica			sanja.killarney@gmail.com	f	t	2024-10-29 23:30:52.224946+00
54	pbkdf2_sha256$870000$1MCCDFNRo7l22c8vzI1nlg$rsCtC+xd7AkG4bY4ZNIIGv2T2c9J1pDZc86rjqTIjkc=	2024-10-29 23:36:09.121216+00	f	uskok			bebiartnikola@gmail.com	f	t	2024-10-29 23:36:05.888613+00
15	pbkdf2_sha256$870000$waJizrZgiZ5QcZ9ntB617H$KcqA/3gj3q3fagN7UockUpdYpj0OyasDWhPf6ssyAw0=	2024-11-09 13:28:18.444744+00	f	safeT			sajo@mail.com	f	t	2024-08-28 21:16:21+00
55	pbkdf2_sha256$870000$rHkTqaYhflHd0Z2Np4z9HR$dqHwS2zAq91j6kg4TQjzxKNKxOgWLwZivcEdHcF4lEM=	2024-11-06 11:54:08.581528+00	f	zagor			bebiartnikola@gmail.com	f	t	2024-11-06 11:54:05.419358+00
1	pbkdf2_sha256$870000$DXEBRrp1NpdTRqppA4fbhs$t2a8kHYctnwV6fuFwfP1qXA3dzXI74mCplUlt6dPh2k=	2024-12-11 07:10:53.684377+00	t	nikola			nlekkerman@gmail.com	t	t	2024-08-19 10:52:53+00
19	pbkdf2_sha256$870000$XWHtfe4pfzYkKke6BiBCEn$D5LQJXiDb+qgU+lNaTBkpBGZfBwkhfPjM5HelIewPqs=	2024-11-10 15:20:13.258758+00	f	marko				f	t	2024-08-30 09:20:29.952482+00
56	pbkdf2_sha256$870000$VL41FvFDgjsy0Fzi8er5gX$l9DOU9RPFKjToV5OCi2cTZg+YuS1rEyzeOtU2Ih78fo=	2024-11-07 12:36:57.93056+00	f	bukica			nlekkerman@gmail.com	f	t	2024-11-07 12:36:54.817633+00
57	pbkdf2_sha256$870000$gwK15Hp739eFY5WQhNP7ns$ammNiy1qfc9nkhDvN3kHUtEjBW6pq9iFbbE0M5797Is=	2024-11-09 18:05:56.208201+00	f	Anja			sanja.killarney@gmail.com	f	t	2024-11-09 18:05:53.015477+00
58	pbkdf2_sha256$870000$vm2essx2YULZdzr6qKtWnc$tuvWPgVZNtc5NsVN/WALMLZvPSkJK102HU6ZVFz7jIU=	2024-11-09 20:06:16.301523+00	f	Vanja			sanja.killarney@gmail.com	f	t	2024-11-09 20:06:12.862138+00
59	pbkdf2_sha256$870000$p6HCBbDTQv3FeBG7ozfpdK$bbTN4qK+p8g77QkAcIcKLvxfW8+dqBtGz+8qcJnysKQ=	2024-11-10 13:32:47.936422+00	f	Dora			sanja.killarney@gmail.com	f	t	2024-11-10 13:32:44.777331+00
60	pbkdf2_sha256$870000$7togZ0RbpXn95NvmXjqI8l$fQBLjk8uGl/RWVxNkGOkPXoGmMkRfNvpUPMQhuyBmg8=	2024-12-10 11:12:09.458477+00	f	testUser123			gikekap826@pokeline.com	f	t	2024-12-10 11:12:06.33592+00
61	pbkdf2_sha256$870000$PUpFXfWdBtbHrZaoer48WN$KnD2UzvQi8B8bcT3X3+OPCq3i3zC/XiI0h93w4N7Gwc=	2024-12-11 07:20:49.459404+00	f	eval			sehidoc136@ckuer.com	f	t	2024-12-11 07:11:57.012016+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: cart_cart; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.cart_cart (id, created_at, updated_at, user_id, session_id, deleted, last_modified) FROM stdin;
193	2024-10-11 12:04:14.302878+00	2024-10-11 12:04:14.302892+00	\N	kdk3jspgz1vvfaspxaccos5h6ejytxx8	f	2024-10-11 12:04:14.302896+00
197	2024-10-11 12:29:26.727947+00	2024-10-11 12:29:26.727963+00	19	\N	f	2024-10-11 12:29:26.727967+00
201	2024-10-11 12:49:33.044461+00	2024-10-11 12:49:33.044474+00	\N	s5wtpapqf9pft2j85lwrxsq3b34ts6oa	f	2024-10-11 12:49:33.044478+00
203	2024-10-11 12:50:42.440876+00	2024-10-11 12:50:42.440886+00	\N	f9ejzvotk0w8efrix83mo1rfacnoybqm	f	2024-10-11 12:50:42.440889+00
207	2024-10-11 13:03:50.814697+00	2024-10-11 13:03:50.814708+00	\N	s1jszd0u41vorxkeea2alcpqjyuai0df	f	2024-10-11 13:03:50.814711+00
211	2024-10-11 13:22:05.299345+00	2024-10-11 13:22:05.299357+00	\N	63w0xugwt4k73iwtowzdkg65nc5h8zv7	f	2024-10-11 13:22:05.299362+00
215	2024-10-11 13:34:02.986873+00	2024-10-11 13:34:02.986887+00	\N	l98a5279hpgxicv9aeknge3rmr96di99	f	2024-10-11 13:34:02.986891+00
217	2024-10-11 13:34:12.37747+00	2024-10-11 13:34:12.377485+00	\N	v2g7g8e7u0o3o8tdvhs6had2bokap7tj	f	2024-10-11 13:34:12.377488+00
219	2024-10-11 13:34:35.495749+00	2024-10-11 13:34:35.495761+00	\N	ablo3i7zckrev5uv079i9aod8wrdd9sn	f	2024-10-11 13:34:35.495765+00
221	2024-10-11 13:35:00.285906+00	2024-10-11 13:35:00.285919+00	\N	9ewze12ck63rcu6ityh48r3qja3tidqx	f	2024-10-11 13:35:00.285923+00
253	2024-10-24 10:34:06.150947+00	2024-10-24 10:34:06.15096+00	\N	k3sj8aah4sbllcde0p0lqgg7jfq3oekc	f	2024-10-24 10:34:06.150963+00
255	2024-10-24 10:42:47.338973+00	2024-10-24 10:42:47.338985+00	\N	7jog9eofxhwyz8emaotkjgupsn277gur	f	2024-10-24 10:42:47.338989+00
259	2024-10-25 10:01:59.890387+00	2024-10-25 10:01:59.890395+00	\N	9n85798sdwsv3ejqox2u2cp5qja56088	f	2024-10-25 10:01:59.890398+00
261	2024-10-26 10:24:29.077904+00	2024-10-26 10:24:29.077914+00	\N	slzk6ydgq2zqabitoryd3ypc5878uqub	f	2024-10-26 10:24:29.077918+00
263	2024-10-26 10:39:16.320788+00	2024-10-26 10:39:16.320797+00	\N	9xo03wik8envitoh6vsntchst9zcmc6f	f	2024-10-26 10:39:16.320801+00
265	2024-10-26 12:02:40.137423+00	2024-10-26 12:02:40.137436+00	\N	vf5c3rvd8bqvamekifkwohfztwq4of9j	f	2024-10-26 12:02:40.13744+00
267	2024-10-26 12:31:02.211923+00	2024-10-26 12:31:02.211937+00	\N	94kqqvr9g78v3thpxhr9wnm950c9ox1z	f	2024-10-26 12:31:02.211941+00
269	2024-10-26 12:31:07.401415+00	2024-10-26 12:31:07.401427+00	\N	spdcjeez30co9z2v1t866cu7o7xfm4s9	f	2024-10-26 12:31:07.40143+00
271	2024-10-26 12:57:46.952991+00	2024-10-26 12:57:46.953002+00	\N	assnzyar0xam6qduhtqlpjxbiugiko84	f	2024-10-26 12:57:46.953006+00
273	2024-10-26 13:02:39.836325+00	2024-10-26 13:02:39.836337+00	\N	oad0te16bgthzrcad0n1ojhx50wg3yvy	f	2024-10-26 13:02:39.836341+00
275	2024-10-26 13:05:40.705742+00	2024-10-26 13:05:40.705755+00	\N	ushtko16xsiqaw5sb54n08o275yt3vlu	f	2024-10-26 13:05:40.705758+00
277	2024-10-26 13:13:00.609763+00	2024-10-26 13:13:00.609775+00	\N	pxpeugxwsrbwqjm3yjd4nav5ca6rsh4l	f	2024-10-26 13:13:00.609778+00
279	2024-10-26 13:27:30.353452+00	2024-10-26 13:27:30.353465+00	40	\N	f	2024-10-26 13:27:30.353469+00
281	2024-10-26 13:34:13.369196+00	2024-10-26 13:34:13.369209+00	\N	yrf8ae6hkd3jc09tlotyrb7zxsobs434	f	2024-10-26 13:34:13.369241+00
283	2024-10-26 14:02:47.851462+00	2024-10-26 14:02:47.851476+00	\N	ve7cvyjt10cxluw6j0gsyai28ayw910q	f	2024-10-26 14:02:47.85148+00
285	2024-10-26 14:14:45.906648+00	2024-10-26 14:14:45.90666+00	\N	ficr1c00dthsrardmf1hwnnje5kie3o8	f	2024-10-26 14:14:45.906663+00
287	2024-10-26 14:27:00.517687+00	2024-10-26 14:27:00.517699+00	46	\N	f	2024-10-26 14:27:00.517703+00
289	2024-10-26 14:27:09.118673+00	2024-10-26 14:27:09.118687+00	\N	f5wkjmywvfoi21t899tanon2cpq3770w	f	2024-10-26 14:27:09.11869+00
291	2024-10-27 10:03:20.336835+00	2024-10-27 10:03:20.336847+00	\N	butnqmprmwzm25550g52m4j3rilsyaa3	f	2024-10-27 10:03:20.336851+00
293	2024-10-27 10:05:25.904889+00	2024-10-27 10:05:25.904902+00	47	\N	f	2024-10-27 10:05:25.904908+00
295	2024-10-27 10:11:00.023949+00	2024-10-27 10:11:00.023962+00	\N	jm5h75g37t9ypwj1pepk5kjixf6afedl	f	2024-10-27 10:11:00.023966+00
297	2024-10-27 10:12:23.94046+00	2024-10-27 10:12:23.940472+00	\N	9njw44l3whx3a78six16uh4avcll2382	f	2024-10-27 10:12:23.940475+00
299	2024-10-27 10:18:09.302391+00	2024-10-27 10:18:09.302404+00	49	\N	f	2024-10-27 10:18:09.302408+00
301	2024-10-27 10:18:43.838442+00	2024-10-27 10:18:43.838456+00	\N	4nnros0f5pgbqe1044phfj7pi60dqal2	f	2024-10-27 10:18:43.83846+00
303	2024-10-27 10:20:49.89562+00	2024-10-27 10:20:49.895631+00	50	\N	f	2024-10-27 10:20:49.895635+00
305	2024-10-27 10:37:48.204384+00	2024-10-27 10:37:48.204397+00	\N	zvs42vm69jx2obklz06z5a1hgggz8di1	f	2024-10-27 10:37:48.204402+00
307	2024-10-27 10:47:28.997334+00	2024-10-27 10:47:28.997345+00	\N	0nr49gsbr9za7uyjj3vnfp7galiupx65	f	2024-10-27 10:47:28.997349+00
309	2024-10-27 10:52:12.857587+00	2024-10-27 10:52:12.857599+00	\N	o30ur04vfenmg4t2b2f283mt5wfchiyq	f	2024-10-27 10:52:12.857603+00
311	2024-10-27 11:01:02.728124+00	2024-10-27 11:01:02.728136+00	\N	lu3mz0mr6droqbwmr1i9nj5xf9xvt46r	f	2024-10-27 11:01:02.72814+00
313	2024-10-27 11:41:26.92843+00	2024-10-27 11:41:26.928443+00	\N	jtv1h935lkefumjx4nht63wks8kecuk4	f	2024-10-27 11:41:26.928446+00
315	2024-10-27 11:47:05.546348+00	2024-10-27 11:47:05.546361+00	\N	ytt0hol6ndjzkmr5wpn5cufj9y5ux5hd	f	2024-10-27 11:47:05.546365+00
317	2024-10-27 11:48:15.871279+00	2024-10-27 11:48:15.871291+00	\N	09zmkkowhrlrnty82oahq3kdtbkvqly5	f	2024-10-27 11:48:15.871294+00
319	2024-10-27 11:53:28.528709+00	2024-10-27 11:53:28.528718+00	\N	8vtycqc9dnoo7s5urmmi74h9mgas2rev	f	2024-10-27 11:53:28.528722+00
321	2024-10-27 11:54:49.163709+00	2024-10-27 11:54:49.163722+00	\N	m5o4muqqocgutc8a8x5aw9simzn1fqf4	f	2024-10-27 11:54:49.163725+00
323	2024-10-27 12:00:48.374575+00	2024-10-27 12:00:48.374585+00	\N	rnqd1s58jnu6e1xoqm41kbvg6qlbww6x	f	2024-10-27 12:00:48.374588+00
325	2024-10-27 12:03:52.035678+00	2024-10-27 12:03:52.035691+00	\N	54afrh1sa3fehma6gio0e5l14d7rsop9	f	2024-10-27 12:03:52.035695+00
339	2024-10-27 12:55:04.677293+00	2024-10-27 12:55:04.677308+00	\N	f91302q0hx7b0optabanyolrazlctk3r	f	2024-10-27 12:55:04.677311+00
341	2024-10-27 12:58:33.306732+00	2024-10-27 12:58:33.306744+00	\N	bgswvm5l7tqim0eh6w0tth1sjigvdxd2	f	2024-10-27 12:58:33.306748+00
343	2024-10-27 13:10:37.502184+00	2024-10-27 13:10:37.502197+00	\N	twxx93ck4gmi1v4yt6qissi5h5av6fxt	f	2024-10-27 13:10:37.5022+00
345	2024-10-27 13:16:54.854544+00	2024-10-27 13:16:54.854558+00	\N	pvbqg7ns0czxes1qcu9wtw9bvdror2tj	f	2024-10-27 13:16:54.854562+00
347	2024-10-27 13:18:45.819029+00	2024-10-27 13:18:45.819041+00	\N	y2drnf9aks27bmjuixznuxsio10pu7hy	f	2024-10-27 13:18:45.819044+00
351	2024-10-28 13:29:59.327676+00	2024-10-28 13:29:59.327688+00	\N	riggf92y81n67dp2d4oxphc31pyvqg5y	f	2024-10-28 13:29:59.327691+00
361	2024-10-28 15:06:01.814523+00	2024-10-28 15:06:01.814535+00	52	\N	f	2024-10-28 15:06:01.814539+00
363	2024-10-29 08:21:30.518752+00	2024-10-29 08:21:30.518767+00	\N	dp8to38skbmwklu7p4pqgkeel89qcs8d	f	2024-10-29 08:21:30.518771+00
365	2024-10-29 23:29:37.691367+00	2024-10-29 23:29:37.691382+00	\N	h02q21qh6wp2i2x2pn5zqh4pil5x518o	f	2024-10-29 23:29:37.691386+00
367	2024-10-29 23:30:36.09431+00	2024-10-29 23:30:36.094331+00	\N	kqvgkmcqek98jdy6irxcse5sm4w8os6m	f	2024-10-29 23:30:36.09434+00
371	2024-10-29 23:33:43.71461+00	2024-10-29 23:33:43.714637+00	\N	3fl6dysdm3xlyhkl3e6wm9w7kw46nmir	f	2024-10-29 23:33:43.714645+00
373	2024-10-29 23:34:59.587001+00	2024-10-29 23:34:59.58703+00	\N	lgptkwslhvi4og4jt3j4e8oz0q4kk1d4	f	2024-10-29 23:34:59.587034+00
375	2024-10-29 23:37:11.477206+00	2024-10-29 23:37:11.477226+00	\N	jzj2ycxrl6g9vfe8fiejk66r9kyfvdr5	f	2024-10-29 23:37:11.477232+00
377	2024-10-30 15:34:10.934736+00	2024-10-30 15:34:10.934749+00	\N	asor32qwkrgalb54l8v8du0gtw1kdbdp	f	2024-10-30 15:34:10.934753+00
379	2024-10-30 15:35:19.657756+00	2024-10-30 15:35:19.657776+00	\N	hmq9yi4rrp9fqr2nunaexc5ofdm7lmj6	f	2024-10-30 15:35:19.657785+00
381	2024-11-03 12:49:07.40288+00	2024-11-03 12:49:07.402894+00	\N	prsjjdb2f6wtvmc4nc4v4jb1s5c440r7	f	2024-11-03 12:49:07.402899+00
383	2024-11-03 13:26:30.955637+00	2024-11-03 13:26:30.955649+00	\N	ag5z9kv8otlm23tleurd83n34rdqp9v4	f	2024-11-03 13:26:30.955653+00
387	2024-11-05 14:34:25.039829+00	2024-11-05 14:34:25.039842+00	\N	0g8ilwfvf205u4yq3nyntkxovb0739sh	f	2024-11-05 14:34:25.039845+00
389	2024-11-05 14:37:21.898417+00	2024-11-05 14:37:21.898436+00	\N	5hfmw71e060wsav0gl5dndxzce0cwwb9	f	2024-11-05 14:37:21.898441+00
391	2024-11-05 14:37:30.863575+00	2024-11-05 14:37:30.863589+00	\N	qft0ce3tetxlc1az9b15xxwkc1jde0i5	f	2024-11-05 14:37:30.863592+00
393	2024-11-05 14:42:01.615125+00	2024-11-05 14:42:01.615134+00	\N	xp440u2y4fcfcpcikhn82v51xyywks9z	f	2024-11-05 14:42:01.615138+00
395	2024-11-05 14:50:25.051051+00	2024-11-05 14:50:25.051063+00	\N	v7tbbb4r3480n91f6cbk4ain4cm4u117	f	2024-11-05 14:50:25.051066+00
397	2024-11-05 14:56:36.933441+00	2024-11-05 14:56:36.933451+00	\N	g0x68xtqspg1xba22a5vwbsknfq3jttf	f	2024-11-05 14:56:36.933455+00
399	2024-11-05 14:57:28.206086+00	2024-11-05 14:57:28.206094+00	\N	erp1c6bff3m095hsdz6ykkeyka5pip81	f	2024-11-05 14:57:28.206097+00
400	2024-11-05 14:58:06.849413+00	2024-11-05 14:58:06.849423+00	\N	rkf28zxdoyjfrmh6cjfnea879oj0o36m	f	2024-11-05 14:58:06.849426+00
401	2024-11-05 15:00:04.201744+00	2024-11-05 15:00:04.201759+00	\N	x9fs1wxu3aag4oiu43dfxfjrw6eil06p	f	2024-11-05 15:00:04.201762+00
402	2024-11-05 15:00:05.662429+00	2024-11-05 15:00:05.662439+00	\N	39yf2hekl09nw0p5d02ctqa0mdf0uu65	f	2024-11-05 15:00:05.662443+00
403	2024-11-06 11:14:51.41021+00	2024-11-06 11:14:51.410224+00	\N	9mpyt0koa0p0l734oq18nx50eh4zwxil	f	2024-11-06 11:14:51.410229+00
404	2024-11-06 11:22:34.860722+00	2024-11-06 11:22:34.860736+00	\N	iczyojjf7ze5c0el6m0om0o4wih8u16d	f	2024-11-06 11:22:34.86074+00
192	2024-10-11 12:04:06.201287+00	2024-10-11 12:04:06.201302+00	\N	01quzb8p543iu8jradwil2ezyfhbtnqu	f	2024-10-11 12:04:06.201305+00
194	2024-10-11 12:04:17.711048+00	2024-10-11 12:04:17.71106+00	\N	7487ra9z06k1vswjwu3f9rqiqphzr4sr	f	2024-10-11 12:04:17.711064+00
196	2024-10-11 12:29:06.926979+00	2024-10-11 12:29:06.926994+00	\N	hv0ele7rid7k53fokypx0p1xh9dopld3	f	2024-10-11 12:29:06.926998+00
198	2024-10-11 12:35:14.996789+00	2024-10-11 12:35:14.996804+00	\N	veo4c4ze0e9qigzkhewvh1tlrncuuchd	f	2024-10-11 12:35:14.996808+00
200	2024-10-11 12:41:20.868226+00	2024-10-11 12:41:20.868242+00	\N	mn1u9huxe7huwc4mwclxz5f5n459p7e4	f	2024-10-11 12:41:20.868246+00
202	2024-10-11 12:49:47.437436+00	2024-10-11 12:49:47.437446+00	\N	dbl9nb51ajk4sjxy4erah8i3repxp584	f	2024-10-11 12:49:47.437449+00
206	2024-10-11 13:03:36.780479+00	2024-10-11 13:03:36.780493+00	\N	9unsx0zn6k63hq3rxpyx9ksb3jivv849	f	2024-10-11 13:03:36.780496+00
208	2024-10-11 13:08:54.535532+00	2024-10-11 13:08:54.535545+00	\N	soaxkr1mpeio82quxf8dn4cguu0r21h4	f	2024-10-11 13:08:54.535549+00
210	2024-10-11 13:21:54.963986+00	2024-10-11 13:21:54.963997+00	15	\N	f	2024-10-11 13:21:54.964+00
212	2024-10-11 13:22:12.029524+00	2024-10-11 13:22:12.029537+00	\N	ysujs1irkijo2lzw26vtcmxroombmqtj	f	2024-10-11 13:22:12.02954+00
216	2024-10-11 13:34:05.650795+00	2024-10-11 13:34:05.650808+00	\N	5llkq32owsglse36eopz6afv3dqofsuv	f	2024-10-11 13:34:05.650812+00
218	2024-10-11 13:34:17.384678+00	2024-10-11 13:34:17.384692+00	\N	8fvvad8c10sefbwz1wx2ht7izmuq8qh5	f	2024-10-11 13:34:17.384695+00
220	2024-10-11 13:34:48.130164+00	2024-10-11 13:34:48.130177+00	\N	l1n6ypcvvk0nmsvg9ndrr03a225nken1	f	2024-10-11 13:34:48.130181+00
250	2024-10-24 09:04:48.238792+00	2024-10-24 09:04:48.238804+00	\N	rzclo0mn67wn1qkqazjpvwb21to9gasc	f	2024-10-24 09:04:48.238809+00
252	2024-10-24 10:14:54.872892+00	2024-10-24 10:14:54.872905+00	\N	8ez1bi4mqmct95y5wkyms07ku3wc6dzk	f	2024-10-24 10:14:54.872908+00
254	2024-10-24 10:42:14.728464+00	2024-10-24 10:42:14.728477+00	\N	w5zva9h02zxht1kybyexboir9ovimrnv	f	2024-10-24 10:42:14.72848+00
258	2024-10-25 08:43:56.330902+00	2024-10-25 08:43:56.330912+00	\N	cgqkcd6jkijlfbpsm4w03h5jcwx76d5k	f	2024-10-25 08:43:56.330915+00
260	2024-10-26 10:08:36.162151+00	2024-10-26 10:08:36.162161+00	\N	yd1fekmegqfvqiu62eu2yrxlnjhx5ha0	f	2024-10-26 10:08:36.162164+00
262	2024-10-26 10:39:13.52493+00	2024-10-26 10:39:13.524945+00	\N	upni29tqaxeqqrp9s6112e1qlny7uh4f	f	2024-10-26 10:39:13.524963+00
264	2024-10-26 10:39:21.479593+00	2024-10-26 10:39:21.479606+00	\N	vdns4om8vvazor3c51gm2bsjg7svxllh	f	2024-10-26 10:39:21.479609+00
266	2024-10-26 12:17:19.983842+00	2024-10-26 12:17:19.983856+00	\N	8t3spwn01ljm725qj4kyhal1fpdqbxxr	f	2024-10-26 12:17:19.98386+00
268	2024-10-26 12:31:04.610638+00	2024-10-26 12:31:04.610652+00	\N	m1f5kweyt0bnm3m0pzqqqkk4vc1d3urk	f	2024-10-26 12:31:04.610656+00
270	2024-10-26 12:57:43.914041+00	2024-10-26 12:57:43.914055+00	\N	nmovq00xtlox87qg2bvlrwojq5ftdbq3	f	2024-10-26 12:57:43.914059+00
272	2024-10-26 13:00:40.224162+00	2024-10-26 13:00:40.224173+00	\N	m5ctpnlrts45lisop50l9aezi27f2bs9	f	2024-10-26 13:00:40.22419+00
274	2024-10-26 13:02:46.34618+00	2024-10-26 13:02:46.346193+00	\N	rr60vixvqwhxfvbg2p55jjeu31pvk2qa	f	2024-10-26 13:02:46.346196+00
276	2024-10-26 13:12:57.349187+00	2024-10-26 13:12:57.349203+00	\N	vcla7zuaar5ic9w03u03vws3w67zz0hb	f	2024-10-26 13:12:57.349209+00
278	2024-10-26 13:26:57.129899+00	2024-10-26 13:26:57.129913+00	\N	ovf2gn6euzyjhv3zpq6agwg3ilzavzas	f	2024-10-26 13:26:57.129916+00
280	2024-10-26 13:27:45.964622+00	2024-10-26 13:27:45.964632+00	\N	q7xu9rlywcdznssb6v299nccno503zwi	f	2024-10-26 13:27:45.964636+00
282	2024-10-26 13:34:15.906689+00	2024-10-26 13:34:15.906701+00	\N	ii6erq67ozdpnpixmhh4d2oy1qp01vl8	f	2024-10-26 13:34:15.906705+00
284	2024-10-26 14:14:35.211412+00	2024-10-26 14:14:35.211423+00	45	\N	f	2024-10-26 14:14:35.211427+00
286	2024-10-26 14:21:07.177616+00	2024-10-26 14:21:07.177628+00	\N	ht440yfl4qn8m9ren797vpcotz62cgtj	f	2024-10-26 14:21:07.177632+00
288	2024-10-26 14:27:06.717942+00	2024-10-26 14:27:06.717955+00	\N	9we9w8ccz4fadrx50timw9p8827b7zq1	f	2024-10-26 14:27:06.717959+00
290	2024-10-26 14:27:15.366456+00	2024-10-26 14:27:15.366467+00	\N	oj23kk0imbytva4bklrzyziwwnhxregk	f	2024-10-26 14:27:15.36647+00
292	2024-10-27 10:03:26.751204+00	2024-10-27 10:03:26.751218+00	\N	ye629u41rm5vw9l9mrggo3wlmtenbkow	f	2024-10-27 10:03:26.751221+00
294	2024-10-27 10:05:44.364669+00	2024-10-27 10:05:44.364693+00	\N	ng3mujeop3ton6pyo1w3wigom2q9zged	f	2024-10-27 10:05:44.364696+00
296	2024-10-27 10:12:11.330471+00	2024-10-27 10:12:11.330484+00	48	\N	f	2024-10-27 10:12:11.330488+00
298	2024-10-27 10:17:20.667285+00	2024-10-27 10:17:20.667298+00	\N	5h9lypoprund8czpjy4ldyq8rp8h4dg7	f	2024-10-27 10:17:20.667301+00
300	2024-10-27 10:18:20.009743+00	2024-10-27 10:18:20.009769+00	\N	o98z4ip20p5qrh9pm9opfnld813q37ax	f	2024-10-27 10:18:20.009773+00
302	2024-10-27 10:20:10.011431+00	2024-10-27 10:20:10.011439+00	\N	gbqa4qmukc28kw00sq2rmjmhqs6v4gk8	f	2024-10-27 10:20:10.011443+00
304	2024-10-27 10:21:05.712767+00	2024-10-27 10:21:05.712782+00	\N	7d4ofh5ojlfen2rerevpec20pqfnbjba	f	2024-10-27 10:21:05.712785+00
306	2024-10-27 10:38:37.673239+00	2024-10-27 10:38:37.673248+00	51	\N	f	2024-10-27 10:38:37.673252+00
308	2024-10-27 10:52:01.341308+00	2024-10-27 10:52:01.341321+00	\N	8bmjzbqrxnyvb1koje0j98p9660zcozf	f	2024-10-27 10:52:01.341325+00
310	2024-10-27 10:56:00.415574+00	2024-10-27 10:56:00.415586+00	\N	6xu4pdra8aci7nyzveaytmso530u1lpj	f	2024-10-27 10:56:00.415589+00
312	2024-10-27 11:41:15.114024+00	2024-10-27 11:41:15.114065+00	\N	hb1nnkax5bnlemebiduq2fm9se3gmayu	f	2024-10-27 11:41:15.114069+00
314	2024-10-27 11:46:59.145942+00	2024-10-27 11:46:59.145955+00	\N	3yidwe3opkbp64tpkxeup65b61zq0tgj	f	2024-10-27 11:46:59.145959+00
316	2024-10-27 11:48:04.32365+00	2024-10-27 11:48:04.323662+00	\N	o7v0pmxdg2ytvfhcpkjvrhgqnfiuh5px	f	2024-10-27 11:48:04.323665+00
318	2024-10-27 11:53:26.110382+00	2024-10-27 11:53:26.110395+00	\N	8qoz1rk8rfi93f2boxd8mh66ftsvdvf5	f	2024-10-27 11:53:26.110399+00
320	2024-10-27 11:53:34.091747+00	2024-10-27 11:53:34.091761+00	\N	qbk844btijj9ghccqitsnnvig4cweais	f	2024-10-27 11:53:34.091764+00
322	2024-10-27 12:00:02.059597+00	2024-10-27 12:00:02.059609+00	\N	y3crfta108kd7d5nado40fbafwn3ypnm	f	2024-10-27 12:00:02.059613+00
324	2024-10-27 12:00:59.738328+00	2024-10-27 12:00:59.73834+00	\N	9tml4p2iesrv4wehvp1ia2eynkobgd1f	f	2024-10-27 12:00:59.738343+00
326	2024-10-27 12:04:41.31395+00	2024-10-27 12:04:41.313964+00	\N	cidihdd9rrqe9ov3jempe3djffpf0p5c	f	2024-10-27 12:04:41.313967+00
328	2024-10-27 12:07:48.208865+00	2024-10-27 12:07:48.208879+00	\N	ltawqof6pdpeoi8xxzsd3ur59s5jqsj9	f	2024-10-27 12:07:48.208883+00
336	2024-10-27 12:47:16.274735+00	2024-10-27 12:47:16.274748+00	\N	f1lro85a2a1va3mawrb7u6gu7qzlor8b	f	2024-10-27 12:47:16.274752+00
338	2024-10-27 12:52:12.415238+00	2024-10-27 12:52:12.415248+00	\N	vw8gxnhq940g6vvct2jff3cy0zp916s8	f	2024-10-27 12:52:12.415251+00
340	2024-10-27 12:58:26.915937+00	2024-10-27 12:58:26.91595+00	\N	6qya88rgiooylo7suo8e9lxw6cthzjne	f	2024-10-27 12:58:26.915953+00
342	2024-10-27 12:59:22.53038+00	2024-10-27 12:59:22.530393+00	\N	lyfkl3oruylizebj7fxdlbdsfneq9s7o	f	2024-10-27 12:59:22.530396+00
344	2024-10-27 13:12:17.842009+00	2024-10-27 13:12:17.842022+00	\N	berha60qj4mmn9f2a64yvvxm7yqcg55o	f	2024-10-27 13:12:17.842025+00
346	2024-10-27 13:17:06.624615+00	2024-10-27 13:17:06.624626+00	\N	huuhodoldlns2h8kpjrwtflmpyg2a1uk	f	2024-10-27 13:17:06.62463+00
362	2024-10-28 16:37:25.002641+00	2024-10-28 16:37:25.002649+00	\N	0xnw47pnlituvahpeldfkc8ggdky9dt7	f	2024-10-28 16:37:25.002653+00
364	2024-10-29 23:29:32.627004+00	2024-10-29 23:29:32.627023+00	\N	hdi7cf1jld3b6nje5rqfd3sy11ua78a1	f	2024-10-29 23:29:32.627029+00
366	2024-10-29 23:29:45.251931+00	2024-10-29 23:29:45.251945+00	\N	i7xk7jx5aq8669jemcscxytpb6d2ca37	f	2024-10-29 23:29:45.251949+00
368	2024-10-29 23:30:43.80039+00	2024-10-29 23:30:43.800409+00	\N	tt54eo1qekye6x3gdg6j7io954w9k50a	f	2024-10-29 23:30:43.800415+00
370	2024-10-29 23:32:53.224697+00	2024-10-29 23:32:53.224712+00	\N	1guic5e1g7cgf79updvyqfdnu431xn0i	f	2024-10-29 23:32:53.224715+00
372	2024-10-29 23:34:53.531302+00	2024-10-29 23:34:53.531318+00	\N	bmt2i39rcme0oxqu9kka7c229xaq3npx	f	2024-10-29 23:34:53.531321+00
374	2024-10-29 23:36:18.642904+00	2024-10-29 23:36:18.642922+00	54	\N	f	2024-10-29 23:36:18.642928+00
378	2024-10-30 15:35:15.551784+00	2024-10-30 15:35:15.551798+00	\N	s1kbzv04hbxvodlzclhrn2or57skpbv9	f	2024-10-30 15:35:15.551802+00
380	2024-11-03 12:46:56.99905+00	2024-11-03 12:46:56.999064+00	\N	ygt0lq4ar565f3mzwoz668hp1wi4jq3d	f	2024-11-03 12:46:56.999068+00
382	2024-11-03 13:19:31.777925+00	2024-11-03 13:19:31.777936+00	\N	9ojtbncoxgskujt207hiq0l3nafzegis	f	2024-11-03 13:19:31.777939+00
384	2024-11-03 15:40:27.280744+00	2024-11-03 15:40:27.280756+00	\N	bn0240pwwnftc7narchjottxg1cjqath	f	2024-11-03 15:40:27.28076+00
386	2024-11-05 14:33:00.641672+00	2024-11-05 14:33:00.641686+00	\N	6ee05ncps00g561qnli0blilaqtw88fe	f	2024-11-05 14:33:00.64169+00
388	2024-11-05 14:36:57.455822+00	2024-11-05 14:36:57.455832+00	\N	79zxbbdglls83ttjkru4ajthhpeci793	f	2024-11-05 14:36:57.455836+00
390	2024-11-05 14:37:24.289173+00	2024-11-05 14:37:24.289186+00	\N	lo253jg7rufxzqqmwbp3ecpe0djf3sba	f	2024-11-05 14:37:24.289189+00
392	2024-11-05 14:41:57.858954+00	2024-11-05 14:41:57.858967+00	\N	dk4hec2tl84zkoe64febyigefoxu4ghq	f	2024-11-05 14:41:57.858971+00
394	2024-11-05 14:45:30.810176+00	2024-11-05 14:45:30.810186+00	\N	jbxmqthaluv3ceax2hvm53r6jts1e9s7	f	2024-11-05 14:45:30.810189+00
396	2024-11-05 14:56:31.305131+00	2024-11-05 14:56:31.305144+00	\N	6t40a56lu9jyt89900jljfgra2isx281	f	2024-11-05 14:56:31.305148+00
398	2024-11-05 14:57:25.122691+00	2024-11-05 14:57:25.122704+00	\N	ny6mx5bqykvppwet9w8kj1xat0gj20ip	f	2024-11-05 14:57:25.122707+00
405	2024-11-06 11:22:40.830131+00	2024-11-06 11:22:40.830145+00	\N	ysv9es78ns1gc0h2p3dg43citkehxq73	f	2024-11-06 11:22:40.830148+00
406	2024-11-06 11:23:47.510945+00	2024-11-06 11:23:47.51096+00	\N	x1a1260ipycrldixuwahsuqe362p39dc	f	2024-11-06 11:23:47.510963+00
407	2024-11-06 11:23:53.56803+00	2024-11-06 11:23:53.568046+00	\N	9gf4lb7kkv71rhxnrzripusur7yt8aqa	f	2024-11-06 11:23:53.56805+00
408	2024-11-06 11:24:32.265061+00	2024-11-06 11:24:32.265081+00	\N	0lwv7w9m3kdnvt8mjvf2np2bo8ph0zim	f	2024-11-06 11:24:32.265087+00
409	2024-11-06 11:34:00.790845+00	2024-11-06 11:34:00.790866+00	\N	iouqvvcz4i9i9yr2msr912gmoxyjm24k	f	2024-11-06 11:34:00.790873+00
410	2024-11-06 11:34:06.803579+00	2024-11-06 11:34:06.803596+00	\N	631u0kaf33s01k20fhhd1gzqmdp4ipvs	f	2024-11-06 11:34:06.8036+00
411	2024-11-06 11:54:14.792663+00	2024-11-06 11:54:14.792682+00	55	\N	f	2024-11-06 11:54:14.792685+00
412	2024-11-06 12:09:35.837635+00	2024-11-06 12:09:35.837649+00	\N	bte0ixf4wh2zemcxvq3o1j4rgbij7bgi	f	2024-11-06 12:09:35.837652+00
413	2024-11-06 12:09:41.309968+00	2024-11-06 12:09:41.309981+00	\N	soudfmrvkchekot2kgnjatuwp6lj0fiv	f	2024-11-06 12:09:41.309985+00
414	2024-11-06 12:45:12.239202+00	2024-11-06 12:45:12.239215+00	\N	ttgr55q18zw3s3bvjxp07v5khnrkqvk6	f	2024-11-06 12:45:12.23922+00
415	2024-11-06 12:45:14.733726+00	2024-11-06 12:45:14.733778+00	\N	75111j1owm1s1wmcjyaqbcz0tcnen407	f	2024-11-06 12:45:14.733782+00
416	2024-11-06 12:49:28.726962+00	2024-11-06 12:49:28.726974+00	\N	q0trvwtvrlqgelflppp4qyj894ra5ysc	f	2024-11-06 12:49:28.726979+00
417	2024-11-06 12:49:51.099566+00	2024-11-06 12:49:51.099588+00	\N	l8cj4u88r68hty72gcu4yxc6js5cre85	f	2024-11-06 12:49:51.099595+00
418	2024-11-06 12:49:56.859376+00	2024-11-06 12:49:56.85939+00	\N	ya4zrb9ivlivggbeyai2382iclcpvicb	f	2024-11-06 12:49:56.859394+00
419	2024-11-06 13:08:31.211184+00	2024-11-06 13:08:31.211198+00	\N	dn825iggwt8rji68l8uxzqhaudzof0au	f	2024-11-06 13:08:31.211201+00
420	2024-11-06 13:08:33.892654+00	2024-11-06 13:08:33.892667+00	\N	aag8tlodd2ygxy6uzadswyiio7owwv1m	f	2024-11-06 13:08:33.892671+00
421	2024-11-06 13:12:39.169307+00	2024-11-06 13:12:39.169322+00	\N	ky43zhlu34hfatw768opi0c6y7m415qj	f	2024-11-06 13:12:39.169326+00
422	2024-11-06 13:15:30.644201+00	2024-11-06 13:15:30.644216+00	\N	f3buwnzntzjvwol3zvz820vgkhfxu98m	f	2024-11-06 13:15:30.64422+00
423	2024-11-06 13:17:16.942073+00	2024-11-06 13:17:16.942087+00	\N	t6je2roc1975zfeerai39ilrbgtnjrs0	f	2024-11-06 13:17:16.942091+00
424	2024-11-06 13:17:22.508981+00	2024-11-06 13:17:22.508994+00	\N	0srczpm5nwxc3vczt54qvb1v4j0qh8ep	f	2024-11-06 13:17:22.508999+00
425	2024-11-06 13:18:07.929352+00	2024-11-06 13:18:07.929367+00	\N	70hkoi56iv1pnuviidr0t9zrxml0ypo2	f	2024-11-06 13:18:07.929371+00
426	2024-11-06 13:18:13.847335+00	2024-11-06 13:18:13.847347+00	\N	p94wgjsrjkua9olndwpty3zg3ox7x42i	f	2024-11-06 13:18:13.847351+00
427	2024-11-06 13:19:44.991632+00	2024-11-06 13:19:44.991645+00	\N	dzazynwm65bgzj7gxptt9r3kv6tc9evs	f	2024-11-06 13:19:44.991648+00
428	2024-11-06 13:20:14.679418+00	2024-11-06 13:20:14.679437+00	\N	isy17b7jc6piascaj5kwh3z4z83rt3lo	f	2024-11-06 13:20:14.679443+00
429	2024-11-06 13:28:14.26668+00	2024-11-06 13:28:14.266694+00	\N	rnaer92btub0cbx13kv81bjh4ltslq3c	f	2024-11-06 13:28:14.266697+00
430	2024-11-06 13:32:16.23854+00	2024-11-06 13:32:16.238557+00	\N	72ucd66eb7lcczv6w5qrf2sno76m5rf2	f	2024-11-06 13:32:16.238561+00
431	2024-11-06 13:32:21.9439+00	2024-11-06 13:32:21.943915+00	\N	5f5zdvon5ckxx8oj1j97gvdc1pvlyztc	f	2024-11-06 13:32:21.943919+00
432	2024-11-06 13:33:25.910336+00	2024-11-06 13:33:25.910351+00	\N	vbujedf9j6hin9u79w5x4mansfqpksvn	f	2024-11-06 13:33:25.910355+00
433	2024-11-06 13:33:43.371605+00	2024-11-06 13:33:43.371619+00	\N	zt8lja460flddqz2c7d0urqvd95j8cit	f	2024-11-06 13:33:43.371623+00
434	2024-11-06 13:33:49.037186+00	2024-11-06 13:33:49.037199+00	\N	zrp5ixi1mfr7cgormgxjzg3rcajfdpcy	f	2024-11-06 13:33:49.037203+00
435	2024-11-06 13:34:06.278803+00	2024-11-06 13:34:06.278816+00	\N	jwg4cnonc2t0qtdkur0a75yz8wz216b6	f	2024-11-06 13:34:06.27882+00
436	2024-11-06 13:34:27.082914+00	2024-11-06 13:34:27.082932+00	\N	j0mq6xq1fezzdypw7mhro8k6f5620vw4	f	2024-11-06 13:34:27.082938+00
437	2024-11-06 13:35:10.709523+00	2024-11-06 13:35:10.709537+00	\N	47xh77jtrynsuk546l2yopkwptbf41el	f	2024-11-06 13:35:10.709541+00
438	2024-11-06 13:35:30.506192+00	2024-11-06 13:35:30.506206+00	\N	vmyxg4l85jemidjlx63avd6j3bghrzml	f	2024-11-06 13:35:30.50621+00
439	2024-11-06 13:35:36.396847+00	2024-11-06 13:35:36.396865+00	\N	rg98x0myockj7d2wxxy7mjexmd54ukx5	f	2024-11-06 13:35:36.396871+00
440	2024-11-06 13:36:07.790001+00	2024-11-06 13:36:07.790017+00	\N	2w3ucrlgvu25hvzfu2b4x2mezifm8746	f	2024-11-06 13:36:07.790021+00
441	2024-11-06 13:36:13.712639+00	2024-11-06 13:36:13.712657+00	\N	t1enqqewgxovf1zde56ndylpf8j2v0tp	f	2024-11-06 13:36:13.712663+00
442	2024-11-06 13:36:44.167798+00	2024-11-06 13:36:44.167813+00	\N	0ay35jknycs6s9fkl03mz8w16as0c2ti	f	2024-11-06 13:36:44.167816+00
443	2024-11-06 13:36:49.971166+00	2024-11-06 13:36:49.971185+00	\N	iflqbk3gpp9mno3ge7tch2jih242pyio	f	2024-11-06 13:36:49.971189+00
444	2024-11-06 13:37:02.937152+00	2024-11-06 13:37:02.93717+00	\N	yp2kr22pxwjeqn6pm8z3izd1sri38lx7	f	2024-11-06 13:37:02.937176+00
445	2024-11-06 13:37:40.860849+00	2024-11-06 13:37:40.860863+00	\N	uwo6tdu82mr3nekju7jnh0zrib18r5co	f	2024-11-06 13:37:40.860867+00
446	2024-11-06 13:38:26.597416+00	2024-11-06 13:38:26.597431+00	\N	q12h6jax1kn2mk7jvt9nhxpbu23jppi3	f	2024-11-06 13:38:26.597436+00
447	2024-11-06 13:38:29.655886+00	2024-11-06 13:38:29.655906+00	\N	9p4kvt49toy9mg2akerl5silb19k7tdj	f	2024-11-06 13:38:29.655912+00
448	2024-11-06 13:39:03.106487+00	2024-11-06 13:39:03.106502+00	\N	ztexum279uzfkeut5rpjcavtr7dxr11c	f	2024-11-06 13:39:03.106506+00
449	2024-11-06 13:39:07.293003+00	2024-11-06 13:39:07.293017+00	\N	we75gm4kxh6pqq8vdcx224u1vokj7615	f	2024-11-06 13:39:07.293021+00
450	2024-11-06 13:39:12.511565+00	2024-11-06 13:39:12.511579+00	\N	nc9mjn3h550fb3cm2vbeotlhapxvdkum	f	2024-11-06 13:39:12.511583+00
451	2024-11-06 13:40:02.527743+00	2024-11-06 13:40:02.527757+00	\N	zdbhdvbvvrvtnvgfro98us7xhdka68vs	f	2024-11-06 13:40:02.527761+00
452	2024-11-06 13:40:37.312796+00	2024-11-06 13:40:37.312814+00	\N	kl5wi4517jwcy3xt6qmw82h2luju2y9r	f	2024-11-06 13:40:37.31282+00
453	2024-11-06 13:40:43.179479+00	2024-11-06 13:40:43.179494+00	\N	hfpf7wjfp0t592t67isfrhp9jdr3ywkb	f	2024-11-06 13:40:43.179498+00
454	2024-11-06 13:40:57.463882+00	2024-11-06 13:40:57.463898+00	\N	emul634afc8us73ngm2kfrfj15m0nu4m	f	2024-11-06 13:40:57.463902+00
455	2024-11-06 13:41:43.645649+00	2024-11-06 13:41:43.645663+00	\N	123y3c51dmxjnfp5ohilgue2xb9j0s9d	f	2024-11-06 13:41:43.645667+00
456	2024-11-06 13:44:16.426428+00	2024-11-06 13:44:16.426446+00	\N	fymuqziqrrvz53tigw8rs4jjyv8gptd4	f	2024-11-06 13:44:16.426452+00
457	2024-11-06 13:44:20.406119+00	2024-11-06 13:44:20.406137+00	\N	78zdirxep9l0ono3kp8axz2ngb0zef3c	f	2024-11-06 13:44:20.406143+00
458	2024-11-06 13:44:41.141907+00	2024-11-06 13:44:41.141927+00	\N	1jyp689xdinw35qo3kyb5wzcvrzfyfou	f	2024-11-06 13:44:41.141933+00
459	2024-11-06 13:44:46.663681+00	2024-11-06 13:44:46.663702+00	\N	9ttftjhdo6pxt6zbapsigyz4jo4ayrqi	f	2024-11-06 13:44:46.663708+00
460	2024-11-06 13:45:45.965782+00	2024-11-06 13:45:45.965797+00	\N	2ddpfjsk81xvijbwf23z1gerxu6w028b	f	2024-11-06 13:45:45.965801+00
461	2024-11-06 13:46:20.361972+00	2024-11-06 13:46:20.36199+00	\N	gstv72ckuq72gimxz1avj80dev89tsps	f	2024-11-06 13:46:20.361995+00
462	2024-11-06 13:50:58.410032+00	2024-11-06 13:50:58.410045+00	\N	pct9sn7s53cp5b025e2yod3r1b9qxvzr	f	2024-11-06 13:50:58.410049+00
463	2024-11-06 13:51:02.015271+00	2024-11-06 13:51:02.015288+00	\N	hcbwx32t7gvlb1n6zwg9xizelqubh5on	f	2024-11-06 13:51:02.015294+00
464	2024-11-06 13:51:28.243767+00	2024-11-06 13:51:28.243776+00	\N	o74l1z96byoveoy7jx09s00cw4ehhvox	f	2024-11-06 13:51:28.243779+00
465	2024-11-06 13:57:42.160223+00	2024-11-06 13:57:42.160234+00	\N	5y7uykyajnmadneebzm2tt8hzhouo1s6	f	2024-11-06 13:57:42.160238+00
466	2024-11-06 14:00:42.852083+00	2024-11-06 14:00:42.852096+00	\N	1fwz4trdokfbwv1rqs9goqry62vh0141	f	2024-11-06 14:00:42.852099+00
467	2024-11-06 14:00:45.827487+00	2024-11-06 14:00:45.827497+00	\N	trjar1i9texlm1z9rrrd7cqvqhye5enn	f	2024-11-06 14:00:45.8275+00
468	2024-11-06 14:01:36.550522+00	2024-11-06 14:01:36.550535+00	\N	z730sogjwprj4dv0ywnkd1rwe2ft8kji	f	2024-11-06 14:01:36.550539+00
469	2024-11-06 14:01:39.537197+00	2024-11-06 14:01:39.537206+00	\N	0kwitpquz83djej6ys87zt6162gjxkc5	f	2024-11-06 14:01:39.537209+00
470	2024-11-06 14:06:01.485645+00	2024-11-06 14:06:01.485657+00	\N	4br7dxkvja8urogek5c31fe3stxvw1fz	f	2024-11-06 14:06:01.485661+00
471	2024-11-06 14:06:04.056992+00	2024-11-06 14:06:04.057003+00	\N	mda6swakre3h6cwiql0b5h9wvtx01eum	f	2024-11-06 14:06:04.057006+00
472	2024-11-06 14:07:08.340459+00	2024-11-06 14:07:08.340471+00	\N	hpokj5p56z1ceo42bbzzm9gpntznca93	f	2024-11-06 14:07:08.340474+00
473	2024-11-06 15:45:20.945699+00	2024-11-06 15:45:20.945712+00	\N	sneuykeva2s0iddsm1exd6reymlc39o1	f	2024-11-06 15:45:20.945716+00
474	2024-11-06 16:01:45.03592+00	2024-11-06 16:01:45.03593+00	\N	sqi6jji5fpnzvx9v6t7svyde1vn5rb6o	f	2024-11-06 16:01:45.035934+00
475	2024-11-06 16:28:15.664725+00	2024-11-06 16:28:15.664735+00	\N	zf7c9euvttt40pehlr8snp5dpuvnklpx	f	2024-11-06 16:28:15.664739+00
476	2024-11-06 16:31:53.766035+00	2024-11-06 16:31:53.766044+00	\N	xrmkzxqwvcqfswn3b11m4tgx0un6je7n	f	2024-11-06 16:31:53.766047+00
477	2024-11-06 16:33:57.687802+00	2024-11-06 16:33:57.687815+00	\N	f7hpaz4rslvbt7nrh5chfqxldcbjrrfw	f	2024-11-06 16:33:57.687818+00
478	2024-11-06 16:34:01.801474+00	2024-11-06 16:34:01.801483+00	\N	dhtmbk7wmafg7rha7b87o87b9gk8qp0v	f	2024-11-06 16:34:01.801487+00
479	2024-11-06 17:54:53.178405+00	2024-11-06 17:54:53.17842+00	\N	eys6xksp2pllpa3e01oxejh3ehlnue5o	f	2024-11-06 17:54:53.178424+00
480	2024-11-06 17:56:34.863397+00	2024-11-06 17:56:34.863411+00	\N	85wu1zmmzp7wjdag8vt8c0yayfqbisxz	f	2024-11-06 17:56:34.863415+00
481	2024-11-06 17:57:31.12173+00	2024-11-06 17:57:31.121744+00	\N	tadsb9hh46h2ygtnpppg4xrwmnzyuvip	f	2024-11-06 17:57:31.121748+00
482	2024-11-06 17:58:11.676836+00	2024-11-06 17:58:11.67685+00	\N	sgwjg4c9egke6olm3dx5opt9vhxnmy1r	f	2024-11-06 17:58:11.676854+00
483	2024-11-06 17:58:58.027904+00	2024-11-06 17:58:58.027924+00	\N	t31tak0p6w58feddny5pa2wtzx190v0s	f	2024-11-06 17:58:58.02793+00
484	2024-11-06 18:01:09.133509+00	2024-11-06 18:01:09.133523+00	\N	hku3ll1le9cksxr7nfn0foaijhqn17iw	f	2024-11-06 18:01:09.133527+00
485	2024-11-06 18:01:11.780191+00	2024-11-06 18:01:11.780206+00	\N	4bm0iq5shl9shazx6q82mufione0t8kl	f	2024-11-06 18:01:11.78021+00
486	2024-11-06 18:03:53.074366+00	2024-11-06 18:03:53.074379+00	\N	9hn1h4d71vj17rna1gn9y4u4vcs91779	f	2024-11-06 18:03:53.074384+00
487	2024-11-06 18:03:56.957716+00	2024-11-06 18:03:56.957735+00	\N	f5w04ix3h69hckyqi35nkiy0e0wc2tg9	f	2024-11-06 18:03:56.957741+00
488	2024-11-06 18:06:48.805412+00	2024-11-06 18:06:48.805426+00	\N	2ove3rsonnz3vbuy2ryasq6fjwoydhyx	f	2024-11-06 18:06:48.80543+00
489	2024-11-06 18:07:17.205807+00	2024-11-06 18:07:17.205825+00	\N	bivv8swhazpj3hduf723zmld7k0vl2kw	f	2024-11-06 18:07:17.20583+00
490	2024-11-06 18:07:58.993937+00	2024-11-06 18:07:58.993951+00	\N	y1lcfn75bb54mkye72zqmiy39rci9z7z	f	2024-11-06 18:07:58.993955+00
491	2024-11-06 18:08:42.376481+00	2024-11-06 18:08:42.376495+00	\N	afu1i23fbm23kxr6yelq34xzb1bcx1fb	f	2024-11-06 18:08:42.376499+00
492	2024-11-06 18:23:06.238029+00	2024-11-06 18:23:06.238044+00	\N	zpoylgz1mvh8dfu6s0odjgz7idygxev6	f	2024-11-06 18:23:06.238048+00
493	2024-11-06 18:23:19.688546+00	2024-11-06 18:23:19.688563+00	\N	xqji7jnnejtv3gynn53cc2142o5dv0qv	f	2024-11-06 18:23:19.688569+00
494	2024-11-06 18:23:28.760859+00	2024-11-06 18:23:28.760873+00	\N	7pjzvrwbcardhni675c83uj0un0phrnp	f	2024-11-06 18:23:28.760877+00
495	2024-11-06 18:23:54.07933+00	2024-11-06 18:23:54.079347+00	\N	pi3lqoba4y9oz96wzo33y7qvjy9q9zt0	f	2024-11-06 18:23:54.079353+00
496	2024-11-06 18:27:04.210029+00	2024-11-06 18:27:04.21004+00	\N	zh1d53zvkg1juuq2ykyr9gxeirz2cpt6	f	2024-11-06 18:27:04.210043+00
497	2024-11-06 18:27:10.804979+00	2024-11-06 18:27:10.804992+00	\N	vtma6kk4lln07g2d1r768obeojmm2t8b	f	2024-11-06 18:27:10.804995+00
498	2024-11-06 18:28:44.519279+00	2024-11-06 18:28:44.519297+00	\N	5pzr4q0jriflp0qzm5pbay87rt5d6bw2	f	2024-11-06 18:28:44.519304+00
499	2024-11-06 18:49:08.642328+00	2024-11-06 18:49:08.642345+00	\N	swlc8zp05tn7qx13jso8bwr097p6yupu	f	2024-11-06 18:49:08.642352+00
500	2024-11-06 18:49:25.51725+00	2024-11-06 18:49:25.517262+00	\N	e0ei2xkuceo2ees79m5oo2i4340rfnqe	f	2024-11-06 18:49:25.517266+00
501	2024-11-06 19:06:37.199063+00	2024-11-06 19:06:37.199076+00	\N	ouqasydixvdcj9b4h1dvpj6gxzf3mw2c	f	2024-11-06 19:06:37.19908+00
502	2024-11-06 19:07:06.17507+00	2024-11-06 19:07:06.175084+00	\N	rgbfj6t7g4u0kjb73lc22zum5sh8xi0r	f	2024-11-06 19:07:06.175088+00
503	2024-11-06 19:09:25.38748+00	2024-11-06 19:09:25.387495+00	\N	cmv09e3235zrogh0a1rcnmtz0duteu3n	f	2024-11-06 19:09:25.387498+00
504	2024-11-06 19:09:31.831915+00	2024-11-06 19:09:31.83193+00	\N	3tmc51993fhhle1sce1eql9jhi01qwic	f	2024-11-06 19:09:31.831933+00
505	2024-11-06 19:16:35.778719+00	2024-11-06 19:16:35.778733+00	\N	ux2x6kgcsaa4kysbccls2gi0m6dibq14	f	2024-11-06 19:16:35.778738+00
506	2024-11-06 19:21:05.325224+00	2024-11-06 19:21:05.325237+00	\N	iarikwwtrrj5r3l8yf4hkf1fnhisd8cu	f	2024-11-06 19:21:05.325242+00
507	2024-11-06 19:21:20.187861+00	2024-11-06 19:21:20.187875+00	\N	i5diy7e3j9ctasl55rluahhbzzfnfog3	f	2024-11-06 19:21:20.187879+00
508	2024-11-06 19:23:01.108067+00	2024-11-06 19:23:01.10808+00	\N	p9h5y7du2lbg72aghgqyx9zhs0oal14d	f	2024-11-06 19:23:01.108084+00
509	2024-11-06 19:23:03.716764+00	2024-11-06 19:23:03.716775+00	\N	i3n1jl07bmto7ni8r5pu8ibwbrs1ipfz	f	2024-11-06 19:23:03.716778+00
510	2024-11-06 19:24:27.080421+00	2024-11-06 19:24:27.080435+00	\N	35unwftnb4h3wotm2u5du6o08p2870ox	f	2024-11-06 19:24:27.080439+00
511	2024-11-06 19:27:06.425655+00	2024-11-06 19:27:06.42567+00	\N	wyt0lovceowny3kdzqrtdnrpgypceyoo	f	2024-11-06 19:27:06.425674+00
512	2024-11-06 19:27:06.795996+00	2024-11-06 19:27:06.79601+00	\N	wyt0lovceowny3kdzqrtdnrpgypceyoo	f	2024-11-06 19:27:06.796014+00
513	2024-11-06 19:27:55.356092+00	2024-11-06 19:27:55.356105+00	\N	njqtl69ipv2e0qpjv35mwzipf6a4a8vn	f	2024-11-06 19:27:55.356109+00
514	2024-11-06 19:27:58.045679+00	2024-11-06 19:27:58.045693+00	\N	kf1x6dwmpzkkrs8jizav38ovvxlcn54a	f	2024-11-06 19:27:58.045697+00
515	2024-11-06 19:29:11.374588+00	2024-11-06 19:29:11.374604+00	\N	20zmjbm7uuic8ekwr17ijos4lfqrvo08	f	2024-11-06 19:29:11.374609+00
516	2024-11-06 19:40:12.137757+00	2024-11-06 19:40:12.137772+00	\N	5mg0vj2wy75tzoxb87ygjmtrztz7mho5	f	2024-11-06 19:40:12.137775+00
517	2024-11-06 19:40:28.208929+00	2024-11-06 19:40:28.208947+00	\N	6ripn2t85sonan7g8xnr7n9khvmt3v5g	f	2024-11-06 19:40:28.208953+00
518	2024-11-06 19:53:31.267536+00	2024-11-06 19:53:31.26755+00	\N	1f32e8voftjlgbmxfgs6a2hr2hpjkkut	f	2024-11-06 19:53:31.267554+00
519	2024-11-06 20:23:38.941964+00	2024-11-06 20:23:38.941976+00	\N	g7su20wt7iuhi6un3wtf5bwf7v4kwzs3	f	2024-11-06 20:23:38.941981+00
520	2024-11-06 20:23:40.93648+00	2024-11-06 20:23:40.936492+00	\N	8r6lqnynjjtbplek3vya1eegm17n3jxc	f	2024-11-06 20:23:40.936495+00
521	2024-11-06 20:26:44.012359+00	2024-11-06 20:26:44.012371+00	\N	kxztrxmgqnttsousvnfo39atuife8644	f	2024-11-06 20:26:44.012375+00
522	2024-11-07 12:35:54.376321+00	2024-11-07 12:35:54.376334+00	\N	b6fw4zakbh7itqhr045kwhcv4tlarsiq	f	2024-11-07 12:35:54.376338+00
523	2024-11-07 12:36:05.305562+00	2024-11-07 12:36:05.305575+00	\N	29qs5qfg0dktwtvqehifvw5mdj3aois3	f	2024-11-07 12:36:05.305578+00
524	2024-11-07 12:36:23.477603+00	2024-11-07 12:36:23.477616+00	\N	fxvdq2o1j4j5tpxg9k0wofh95ofufou9	f	2024-11-07 12:36:23.477619+00
525	2024-11-07 12:37:03.111751+00	2024-11-07 12:37:03.111764+00	56	\N	f	2024-11-07 12:37:03.111768+00
526	2024-11-07 15:06:01.947115+00	2024-11-07 15:06:01.947128+00	\N	umydpst0w1vfb9xyqhqj1cudx71ekef1	f	2024-11-07 15:06:01.947132+00
527	2024-11-07 15:20:14.392952+00	2024-11-07 15:20:14.392967+00	\N	fe211mxuvjcajagrwgwtpxs28bcbiudv	f	2024-11-07 15:20:14.392972+00
528	2024-11-07 15:20:54.9603+00	2024-11-07 15:20:54.960315+00	\N	csvoa5k5kpnzn7h541pxx3gkm8zpptav	f	2024-11-07 15:20:54.96032+00
529	2024-11-07 15:21:56.558483+00	2024-11-07 15:21:56.558497+00	\N	clt40sf6trveuqwguebg7yiihmcwrfus	f	2024-11-07 15:21:56.5585+00
530	2024-11-07 15:22:00.676773+00	2024-11-07 15:22:00.676788+00	\N	w76kdicl6d66ca7kalzbuuaiz5o2i1oc	f	2024-11-07 15:22:00.676793+00
531	2024-11-07 15:22:04.544236+00	2024-11-07 15:22:04.544251+00	\N	wi0ulij460x4xj1lysy7urfsnpsdi28y	f	2024-11-07 15:22:04.544255+00
532	2024-11-07 15:24:08.22588+00	2024-11-07 15:24:08.225897+00	\N	rtxfd25xgwjmkf8xkj8nhrtxal26vi9n	f	2024-11-07 15:24:08.225903+00
533	2024-11-09 12:53:58.631774+00	2024-11-09 12:53:58.631787+00	\N	dpzzq5yw62109qzc884g0w4l7xwkb4w7	f	2024-11-09 12:53:58.631791+00
534	2024-11-09 13:13:44.519598+00	2024-11-09 13:13:44.51961+00	\N	mrl99vh91ik0qqp1c8odveu0oy69ia9q	f	2024-11-09 13:13:44.519613+00
535	2024-11-09 13:29:15.018062+00	2024-11-09 13:29:15.018076+00	\N	p14opnoc65wbdxyn4yy01ou77508w9h1	f	2024-11-09 13:29:15.01808+00
536	2024-11-09 13:34:30.921182+00	2024-11-09 13:34:30.921192+00	\N	jfz02akzd7lisiyzatxkafq2mwfvbx9a	f	2024-11-09 13:34:30.921195+00
537	2024-11-09 13:34:33.849515+00	2024-11-09 13:34:33.849529+00	\N	bubepy9990rs1rv53hmgdtxce5kxm9ww	f	2024-11-09 13:34:33.849532+00
538	2024-11-09 13:59:06.642381+00	2024-11-09 13:59:06.642391+00	\N	c2na506ogyaatcb90z8ydn51h18bevuv	f	2024-11-09 13:59:06.642395+00
539	2024-11-09 14:00:53.852154+00	2024-11-09 14:00:53.852166+00	\N	xymbzzi0a97036iby0eni7rz3zavjp74	f	2024-11-09 14:00:53.852169+00
540	2024-11-09 14:02:14.428494+00	2024-11-09 14:02:14.428507+00	\N	na8n71bu3fxn89jpzbznpxi1agzrpncy	f	2024-11-09 14:02:14.42851+00
541	2024-11-09 18:06:00.687849+00	2024-11-09 18:06:00.687865+00	57	\N	f	2024-11-09 18:06:00.687869+00
542	2024-11-09 18:22:10.781308+00	2024-11-09 18:22:10.781321+00	\N	gca7xdx4hqvv9iq3w3mhw2qw3do50qn0	f	2024-11-09 18:22:10.781325+00
543	2024-11-09 18:42:53.67231+00	2024-11-09 18:42:53.672324+00	\N	2clgwhc9hrz24wb3lzr3jziotxxpzewn	f	2024-11-09 18:42:53.672328+00
544	2024-11-09 18:43:09.224551+00	2024-11-09 18:43:09.224569+00	\N	l8axitmp0w7ma4esko76eux9cmmekeub	f	2024-11-09 18:43:09.224575+00
545	2024-11-09 19:22:43.435655+00	2024-11-09 19:22:43.435667+00	\N	d6di4f9ot51txykqswo0buskzz6s4k9v	f	2024-11-09 19:22:43.435671+00
546	2024-11-09 19:27:00.94439+00	2024-11-09 19:27:00.944404+00	\N	z347lkk7g6mmkgnuxccm7nar9xyni8zo	f	2024-11-09 19:27:00.944408+00
547	2024-11-09 19:27:20.242445+00	2024-11-09 19:27:20.242459+00	\N	xwucck433xch1w9x31jo84wdzqu661ch	f	2024-11-09 19:27:20.242462+00
548	2024-11-09 19:27:38.726377+00	2024-11-09 19:27:38.72639+00	\N	378fg09t114fljfxpqk6ny8bel8ik909	f	2024-11-09 19:27:38.726394+00
550	2024-11-09 20:26:53.722732+00	2024-11-09 20:26:53.722746+00	58	\N	f	2024-11-09 20:26:53.72275+00
551	2024-11-09 20:35:38.796004+00	2024-11-09 20:35:38.796018+00	\N	0hk2xaayv9vbk8kpbc4fstw3425g2wm6	f	2024-11-09 20:35:38.796022+00
552	2024-11-10 13:28:47.243682+00	2024-11-10 13:28:47.243695+00	\N	u0f9rth176ewlaqb67oo2l95br1clp05	f	2024-11-10 13:28:47.2437+00
553	2024-11-10 13:28:51.314631+00	2024-11-10 13:28:51.314643+00	\N	9h4kffdttg4tnngwetvcaxgqigioq8ud	f	2024-11-10 13:28:51.314647+00
554	2024-11-10 13:32:52.646772+00	2024-11-10 13:32:52.646787+00	59	\N	f	2024-11-10 13:32:52.646791+00
555	2024-11-10 13:35:40.494246+00	2024-11-10 13:35:40.494258+00	\N	btwnxaqhgv3rutklb3gsya8jlb80yawm	f	2024-11-10 13:35:40.494262+00
583	2024-11-10 15:16:09.921966+00	2024-11-10 15:16:09.921981+00	\N	4uip2csd2h07fknrlj3punokwaenmn8m	f	2024-11-10 15:16:09.921985+00
584	2024-11-10 15:17:34.051932+00	2024-11-10 15:17:34.051946+00	\N	oxnx8ebacx5kkwghprfhs08upctzojkv	f	2024-11-10 15:17:34.051949+00
585	2024-11-10 15:19:45.938821+00	2024-11-10 15:19:45.938835+00	\N	wkblvax6h756nn9mjo1l50h0nszw8o2d	f	2024-11-10 15:19:45.938839+00
588	2024-11-10 20:29:50.907168+00	2024-11-10 20:29:50.907182+00	\N	8e54b6li5ve2f00nwmsferzlclgve9wz	f	2024-11-10 20:29:50.907185+00
589	2024-11-11 10:03:21.91851+00	2024-11-11 10:03:21.918523+00	\N	fha39jm4ghz5d44ov37y8jwaz8jd9tjw	f	2024-11-11 10:03:21.918527+00
590	2024-11-11 10:03:24.721703+00	2024-11-11 10:03:24.721717+00	\N	gtwtc4cs6c8nlzsbgmr4rmku5yuov5s5	f	2024-11-11 10:03:24.72172+00
591	2024-11-11 10:03:28.591607+00	2024-11-11 10:03:28.591623+00	\N	7ebmkw6cotbqjv2sm09s3y6d9fr6z2kz	f	2024-11-11 10:03:28.591626+00
592	2024-11-11 10:03:31.467599+00	2024-11-11 10:03:31.467612+00	\N	gm4jwz0gqt4j1lzvc39hym6wl02gw5sr	f	2024-11-11 10:03:31.467615+00
593	2024-11-11 10:03:31.810704+00	2024-11-11 10:03:31.810717+00	\N	el439jac1fq5f1sdk24kz8tutq0p7ktg	f	2024-11-11 10:03:31.810721+00
594	2024-11-11 10:03:34.041594+00	2024-11-11 10:03:34.041606+00	\N	hc3v5i5vmoaowcr04h5xo0eiz9vm7dqh	f	2024-11-11 10:03:34.041609+00
595	2024-11-11 10:03:36.885246+00	2024-11-11 10:03:36.88526+00	\N	lb8krs1lhjz6t0opw4fqlcblw9aw4c9f	f	2024-11-11 10:03:36.885263+00
596	2024-11-11 10:03:39.677405+00	2024-11-11 10:03:39.677419+00	\N	x4btkf946cm0wo3vtgqtk0tnsy0v1ztg	f	2024-11-11 10:03:39.677423+00
597	2024-11-11 10:03:42.483065+00	2024-11-11 10:03:42.483079+00	\N	t7b0pr2fjoescp7rzfy9eehmbpgkenw5	f	2024-11-11 10:03:42.483083+00
598	2024-11-11 10:03:45.339175+00	2024-11-11 10:03:45.339188+00	\N	qfwlv6olovjdtrxlko3pilbf6vq2hyzt	f	2024-11-11 10:03:45.339192+00
599	2024-11-11 10:03:48.140307+00	2024-11-11 10:03:48.14032+00	\N	8oexsj1qi8sikdb5dz2krf8ngx6ehjci	f	2024-11-11 10:03:48.140323+00
600	2024-11-11 10:03:50.89667+00	2024-11-11 10:03:50.896683+00	\N	pskexuh1xrg0lpgkwxtuez8l3oowzgz0	f	2024-11-11 10:03:50.896687+00
601	2024-11-11 10:03:53.664662+00	2024-11-11 10:03:53.664676+00	\N	fonatxkeq5lgl8fr7fqmm6ue5hwgcqi4	f	2024-11-11 10:03:53.66468+00
602	2024-11-11 10:11:18.368063+00	2024-11-11 10:11:18.368075+00	\N	5tgeubia6f0igwwhnwecyz33sy0n4w82	f	2024-11-11 10:11:18.368079+00
603	2024-11-11 10:11:21.143729+00	2024-11-11 10:11:21.143743+00	\N	aekvjaw7pi27k5ywwalgjs596bf1lgwx	f	2024-11-11 10:11:21.143747+00
604	2024-11-11 10:11:23.917992+00	2024-11-11 10:11:23.918004+00	\N	y17d6pc6jyso6lj9vy1r982l4x8l192u	f	2024-11-11 10:11:23.918008+00
605	2024-11-11 10:11:55.699668+00	2024-11-11 10:11:55.69968+00	\N	0zo8osoap2vu65lhgnu7idjuw9i8vvlf	f	2024-11-11 10:11:55.699683+00
606	2024-11-11 10:11:58.562894+00	2024-11-11 10:11:58.562907+00	\N	fasxw5d3js6gnlbcgk8gm1r44m3hbi0v	f	2024-11-11 10:11:58.56291+00
607	2024-11-11 10:12:01.427037+00	2024-11-11 10:12:01.42705+00	\N	f3ly0bhzdf5umo0x0l3px084oxndws4q	f	2024-11-11 10:12:01.427054+00
608	2024-11-11 10:12:04.293277+00	2024-11-11 10:12:04.29329+00	\N	wfm5xi1g9p22ktn2pg38bblmmb4ygu9p	f	2024-11-11 10:12:04.293294+00
609	2024-11-11 10:12:07.209579+00	2024-11-11 10:12:07.209592+00	\N	1d4isciln7offgs0an3u8rjm3u8poj8c	f	2024-11-11 10:12:07.209596+00
610	2024-11-11 10:12:10.023969+00	2024-11-11 10:12:10.023982+00	\N	s04weyo2qlvh102mu2er1k105ogb45v0	f	2024-11-11 10:12:10.023985+00
611	2024-11-11 10:12:12.957679+00	2024-11-11 10:12:12.957691+00	\N	zouomik9bm22k4mo0qvi0nvnmx8tjpjp	f	2024-11-11 10:12:12.957694+00
612	2024-11-11 10:12:15.745981+00	2024-11-11 10:12:15.745993+00	\N	6bl8tt2a9ul48sf9iu8brit8npiyvf33	f	2024-11-11 10:12:15.745997+00
613	2024-11-12 12:55:33.084631+00	2024-11-12 12:55:33.084652+00	\N	i5w6cm4kydx3iz5s1nosbdkxdhhpek72	f	2024-11-12 12:55:33.084659+00
614	2024-11-21 16:03:17.534644+00	2024-11-21 16:03:17.534656+00	\N	ecnr63u9a6nkv9qlwj1hpq8ltpjo2x65	f	2024-11-21 16:03:17.53466+00
615	2024-11-21 16:03:35.573182+00	2024-11-21 16:03:35.573195+00	\N	u8gj6mwcp36qddfniv0u04n4gvgbt3if	f	2024-11-21 16:03:35.573198+00
616	2024-12-05 13:31:59.646983+00	2024-12-05 13:31:59.646997+00	\N	lsfdpgv2wokbac2unzgwmj3n6rq8pyjs	f	2024-12-05 13:31:59.647001+00
617	2024-12-06 12:46:25.600657+00	2024-12-06 12:46:25.600675+00	\N	5p505dq952rr2icyqsg6wu6fkzwz0ak4	f	2024-12-06 12:46:25.600682+00
618	2024-12-06 12:59:13.047564+00	2024-12-06 12:59:13.047582+00	1	\N	f	2024-12-06 12:59:13.047589+00
619	2024-12-10 11:08:14.506643+00	2024-12-10 11:08:14.506661+00	\N	ejxfw0tro4eus42u98rcmciylcoupohu	f	2024-12-10 11:08:14.506666+00
620	2024-12-10 11:12:13.32237+00	2024-12-10 11:12:13.322384+00	60	\N	f	2024-12-10 11:12:13.322388+00
621	2024-12-10 11:32:27.334125+00	2024-12-10 11:32:27.33414+00	\N	yzbtcq2yggvxiln7ik6fsl9mmnmxvmyo	f	2024-12-10 11:32:27.334144+00
622	2024-12-11 07:07:11.259282+00	2024-12-11 07:07:11.259301+00	\N	7lbup53xocru1lfu4tf6w1lzhefir7nm	f	2024-12-11 07:07:11.259307+00
623	2024-12-11 07:07:39.848141+00	2024-12-11 07:07:39.84816+00	\N	mbqajaeld71f7i354zmlk9rg4lwr0pv9	f	2024-12-11 07:07:39.848167+00
624	2024-12-11 07:11:23.693254+00	2024-12-11 07:11:23.693267+00	\N	ln0n8ch31h4rw5x2z2mgqhzkau3nagqk	f	2024-12-11 07:11:23.693271+00
625	2024-12-11 07:12:07.487993+00	2024-12-11 07:12:07.488007+00	61	\N	f	2024-12-11 07:12:07.488011+00
626	2024-12-11 07:14:55.939628+00	2024-12-11 07:14:55.939645+00	\N	q150z8xmrd8smyu22b0ye91dsa911y2z	f	2024-12-11 07:14:55.939651+00
627	2024-12-11 07:17:30.777579+00	2024-12-11 07:17:30.777592+00	\N	g8ff8oxfnu726mgwr3y7x17z8k0tdeim	f	2024-12-11 07:17:30.777622+00
628	2024-12-11 07:17:34.530819+00	2024-12-11 07:17:34.530834+00	\N	mnkugudey8w2j0ixj8g05b9qds4b76xs	f	2024-12-11 07:17:34.530838+00
629	2024-12-11 07:18:05.507258+00	2024-12-11 07:18:05.507272+00	\N	i71fi86ie0rccnfrxg7m5bk3uzkslyvz	f	2024-12-11 07:18:05.507276+00
630	2024-12-11 07:19:11.784594+00	2024-12-11 07:19:11.784609+00	\N	69m0rlenmj3eavx23bv0mpxxhsindrg7	f	2024-12-11 07:19:11.784613+00
631	2024-12-11 07:19:18.499331+00	2024-12-11 07:19:18.499346+00	\N	75mudlhbuw5qk91gmknbqq0du0ooq7yw	f	2024-12-11 07:19:18.49935+00
632	2024-12-11 07:19:26.077407+00	2024-12-11 07:19:26.07742+00	\N	g41jqr0wjklar9rc3d6dm5fuyyx0gprb	f	2024-12-11 07:19:26.077424+00
633	2024-12-11 07:21:47.6718+00	2024-12-11 07:21:47.671814+00	\N	vdzpr981ovt5gn5g86g9u2q2msjtjjpl	f	2024-12-11 07:21:47.671818+00
634	2024-12-11 11:07:17.01677+00	2024-12-11 11:07:17.016784+00	\N	98999gxvancnnphrsjry2g1w9n6agae3	f	2024-12-11 11:07:17.016789+00
635	2025-01-14 12:14:44.765989+00	2025-01-14 12:14:44.76601+00	\N	wqm0liw4ae9by4ell846kqs7qt82ffbu	f	2025-01-14 12:14:44.766018+00
\.


--
-- Data for Name: cart_cartitem; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.cart_cartitem (id, quantity, last_modified, deleted, cart_id, seed_id) FROM stdin;
297	2	2024-10-29 23:31:30.86817+00	f	368	6
159	1	2024-10-11 12:50:01.009423+00	f	202	6
160	1	2024-10-11 12:50:03.331177+00	f	202	1
305	1	2024-11-05 14:34:41.738315+00	f	387	1
306	1	2024-11-05 15:38:58.389544+00	f	402	6
223	1	2024-10-24 10:16:34.588318+00	f	252	10
308	1	2024-11-06 11:23:02.102598+00	f	405	1
309	1	2024-11-06 11:23:04.822561+00	f	405	10
310	1	2024-11-06 11:36:48.413534+00	f	410	1
311	1	2024-11-06 11:36:52.334818+00	f	410	10
229	1	2024-10-24 10:34:19.855762+00	f	253	1
230	1	2024-10-24 10:40:05.248148+00	f	253	6
231	1	2024-10-24 10:43:11.972005+00	f	255	1
322	1	2024-11-07 14:33:18.721501+00	f	525	6
323	1	2024-11-07 14:45:33.433483+00	f	525	1
151	1	2024-10-11 12:04:40.215479+00	f	194	4
152	1	2024-10-11 12:04:42.489507+00	f	194	13
333	1	2024-12-06 13:34:22.099067+00	f	618	4
334	1	2024-12-06 13:34:25.885407+00	f	618	3
335	3	2024-12-10 11:10:47.159817+00	f	619	6
337	1	2024-12-10 11:35:17.694111+00	f	621	9
338	1	2024-12-11 07:08:35.97225+00	f	623	6
339	1	2024-12-11 07:08:42.274767+00	f	622	6
332	2	2024-12-11 07:14:21.477479+00	f	618	1
340	1	2024-12-11 07:15:48.498711+00	f	626	1
343	1	2024-12-11 07:19:37.284934+00	f	632	6
344	1	2024-12-11 07:21:10.534328+00	f	625	6
345	1	2024-12-11 11:07:39.869305+00	f	634	10
\.


--
-- Data for Name: chat_adminactivity; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_adminactivity (id, action, "timestamp", details, admin_id, chat_session_id) FROM stdin;
\.


--
-- Data for Name: chat_chatbotresponse; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_chatbotresponse (id, query, response) FROM stdin;
\.


--
-- Data for Name: chat_chatmessage; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_chatmessage (id, sender, content, "timestamp", status, session_id) FROM stdin;
\.


--
-- Data for Name: chat_chatsession; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_chatsession (id, started_at, ended_at, status, admin_id, user_id) FROM stdin;
\.


--
-- Data for Name: chat_conversation_participants; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_conversation_participants (id, conversation_id, user_id) FROM stdin;
\.


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_message (id, content, "timestamp", conversation_id, sender_id, receiver_id) FROM stdin;
\.


--
-- Data for Name: chat_supportticket; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.chat_supportticket (id, subject, description, status, created_at, updated_at, user_id) FROM stdin;
\.


--
-- Data for Name: checkout_order; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.checkout_order (id, order_number, full_name, email, phone_number, country, postcode, town_or_city, street_address1, street_address2, county, date, delivery_cost, order_total, grand_total, original_bag, stripe_pid, user_profile_id) FROM stdin;
1	5EBB547A81DF4393B5D609056B192CAE	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-09 10:13:01.994513+00	0.00	0.00	0.00			\N
2	B1CCD8855BA74745999D5E28E766C650	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-09 10:23:16.831667+00	0.00	0.00	0.00			\N
6	8240B5FAEACB44CF8E5B503208E1DE68	Niki miki	nlekkerman@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:02:06.211307+00	0.00	489.20	489.20			\N
18	6F7B3169C97C476A9FE630E618445B16	Marko Toti	kamil@mail.com	083443554567	IE	v93 f7k9	killareney	31 high Street	building one	Kerry	2024-10-10 10:20:25.10859+00	0.50	4.95	5.45			\N
15	ED45DEE30336483E83D5E27BE02E7158	Niki miki	mikitiki@gmail.com	009988776655	BA	v93 n2f1	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:49:42.776292+00	0.00	1449.20	1449.20			\N
19	38A8EE9C2E9C412F8FF79644E165F18A	Marko Toti	kamil@mail.com	083443554567	IE	v93 f7k9	killareney	31 high Street	building one	Kerry	2024-10-10 10:20:26.779276+00	0.50	4.95	5.45			\N
3	AB652C02F0044EF19CD867AAA1DDE036	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-09 10:25:53.482392+00	0.00	489.20	489.20			\N
24	3DE6E1BFDAD74204BADDA76FAD0C5846	Sajo login	Shimic@mail.com	083443554567	AG	v93 f7k9	Killarney	skocaj bb	mali skocaj	Kerry	2024-10-10 11:26:01.250938+00	0.00	338.35	338.35			\N
10	F5F5CD9F498C4358962C0B9AA59A9CC6	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:33:29.036432+00	0.00	1449.20	1449.20			\N
7	40056F16873E4D45BF93779523339E95	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:15:30.482387+00	0.00	489.20	489.20			\N
13	DB898172E836488F972FD5A96CEFD37A	Niki miki	mikitiki@gmail.com	009988776655	BA	v93 n2f1	Bihac	skocaj bb	\N	Usk	2024-10-10 09:40:45.584182+00	0.00	1449.20	1449.20			\N
4	B6CEF9E63D1D40B29A6617E8D884C664	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-09 10:28:46.707397+00	0.00	489.20	489.20			\N
20	7F1F46F936CB4BA1996127B1392AE73F	Marko Toti	mikitiki@gmail.com	083443554567	IE	v65 m32n4	killareney	nova 21	nocva21314	Kerry	2024-10-10 10:44:00.426512+00	0.00	180.80	180.80			\N
21	4F5FBD56F2794BBBB8ABEEE9BB04DCBF	Marko Toti	mikitiki@gmail.com	083443554567	IE	v65 m32n4	killareney	nova 21	nocva21314	Kerry	2024-10-10 10:44:02.142442+00	0.00	180.80	180.80			\N
16	D1FD1FAEE44841AC8CEFF70EB853E25C	Niki miki	mikitiki@gmail.com	009988776655	BA	v93 n2f1	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:55:21.786037+00	0.00	1449.20	1449.20			\N
8	641DE30F8E57474C8D78549B55858528	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:25:32.744867+00	0.00	489.20	489.20			\N
5	7083E22A96104999A2E90B0C377A65C7	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 08:57:38.944501+00	0.00	489.20	489.20			\N
11	91C8AF2A8027499C948CFCCE417C3EE1	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:36:46.905763+00	0.00	1449.20	1449.20			\N
129	037A454342114F97B1B8BFB39064C43E	Faki Bakic	nlekkerman@gmail.com	00385830945102	AR	v93 n2f1	killarney	kjn	mali skocaj	Usk	2024-10-23 14:07:47.845287+00	0.00	160.00	160.00	{}	pi_3QD5DIRwsosTYqRm1qkVgq3R	3
14	E5BC8D889B124335913F6FE1429CF57D	Niki miki	mikitiki@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:47:44.531322+00	0.00	1449.20	1449.20			\N
9	503C18F7A25346A197275174C4FA834E	nikola simic	nlekkerman@gmail.com	009988776655	BA	bb	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:29:47.020779+00	0.00	489.20	489.20			\N
133	B63285FB7A014E4AAFC80E46297A35B0	Marko Toti	Shimic@mail.com	00385830945102	AW	v93 f7k9	Bihac	skocaj bb	nocva21314	kERRY	2024-10-24 10:23:46.907077+00	0.00	160.00	160.00	{}	pi_3QDOCBRwsosTYqRm1sAA8Tdy	\N
22	AD4967C19A8D4A4DAAAF89D5E0050140	nikola simic	nlekkerman@gmail.com	00385830945102	IE	v93 n2 f1	Killarney	Arbutus grove 31	kjn	Kerry	2024-10-10 11:08:04.71885+00	0.00	1449.20	1449.20			\N
12	7C538D9E8D95418F91E91C80D5A95907	Niki miki	mikitiki@gmail.com	009988776655	BA	v93 n2f1	Bihac	skocaj bb	\N	Usk	2024-10-10 09:39:43.801894+00	0.00	1449.20	1449.20			\N
130	23210864552A4121B0689870AFE2A20E	Marko Toti	nlekkerman@gmail.com	083443554567	AZ	v93 n2f1	Killarney	31 arbutus grove	nocva21314	Usk	2024-10-23 14:54:55.58029+00	0.00	170.40	170.40	{}	pi_3QD5wwRwsosTYqRm1lVZcrr2	3
17	0CB1C3A776404E8A9B6AE69D9388EDAF	Niki miki	mikitiki@gmail.com	009988776655	BA	v93 n2f1	Bihac	Skocaj	mali skocaj	Usk	2024-10-10 09:56:02.770209+00	0.00	1449.20	1449.20			\N
134	BB0CD752390D44C3B81E557F0BF4A301	nikola simic	bra@mail.com	009909	AR	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-10-24 11:06:14.833014+00	0.80	7.95	8.75	{}	pi_3QDOpHRwsosTYqRm1fzezjEE	3
131	F67E6E64D2E5420A8587BB3309AB0BB0	Nikola Simic	nlekkerman@gmail.com	00385830945102	IE	v93 n2f1	Killarney	31 arbutus grove	building one	kERRY	2024-10-24 10:13:53.145862+00	0.00	198.15	198.15	{}	pi_3QD7o5RwsosTYqRm0kjk0Cur	3
23	06D5D9662D9E4E1092A57DD55889BE23	nikola simic	nlekkerman@gmail.com	00385830945102	IE	v93 n2 f1	Killarney	Arbutus grove 31	kjn	Kerry	2024-10-10 11:08:06.939514+00	0.00	1449.20	1449.20			\N
132	AD25F7C93D8F40ED934D9760AD5FB9B6	Braju ABkic	bakido@mail.com	06998696913	AS	V54 M7I8	Samiotana	nova 21	nocva21314	Usk	2024-10-24 10:18:07.673604+00	0.00	160.00	160.00	{}	pi_3QDO5xRwsosTYqRm0QZEOqka	\N
135	B76D1A20588246EC955AA6F0DFA09C03	nikola simic	nlekkerman@gmail.com	009909	DZ	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-10-24 11:09:40.3892+00	0.00	160.00	160.00	{}	pi_3QDOsfRwsosTYqRm0LihqjEX	3
138	535A5470044D4D61BC74DE5DBBEC0130	Nikola Simic	nlekkerman@gmail.com	083443554567	AW	v65 m32n4	Killarney	kjn	building one	Usk	2024-10-27 12:23:51.176516+00	0.00	160.00	160.00	{}	pi_3QEVUwRwsosTYqRm06DTfk5l	40
136	1E0685945F17465CB1698DA31CB2B638	Marko Toti	sida@gmail.com	083443554567	BS	v65 m32n4	Killarney	31 high Street	mali skocaj	Usk	2024-10-27 12:07:22.89416+00	0.00	180.80	180.80	{}	pi_3QEVEtRwsosTYqRm0CH1lmbx	40
137	F322936F4E224B66BFB07E0604CC883E	Nikola Simic	bra@mail.com	009909	BA	v93 n2f1	Bihac	Arbutus grove 31	any	Usk	2024-10-27 12:22:30.933526+00	1.04	10.40	11.44	{}	pi_3QEVTdRwsosTYqRm16VCbdoy	40
139	963769290D034778A5A209819F903F96	nikola simic	nlekkerman@gmail.com	009909	AF	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-10-27 12:26:42.472072+00	0.00	156.70	156.70	{}	pi_3QEVXbRwsosTYqRm07H3qR8W	40
140	DF6D4CE1A18549FB8B4F1346A718BCCF	nikola simic	nlekkerman@gmail.com	00385830945102	BS	v93 n2f1	Killarney	Arbutus grove 31	any	anywhere	2024-10-27 12:29:53.348344+00	0.00	170.40	170.40	{}	pi_3QEVarRwsosTYqRm0eZpq3ev	40
141	2DABCFD54D204EDD9C424351F41DF899	Nikola Simic	nlekkerman@gmail.com	083443554567	AW	v93 f7k9	Killarney	Arbutus grove 31	mali skocaj	kjnkjn	2024-10-27 12:43:12.135208+00	0.00	148.75	148.75	{}	pi_3QEVnVRwsosTYqRm0LdWpy0b	40
142	E8470D779A2A41ABAA342E05489D6491	Sajo login	nlekkerman@gmail.com	083443554567	AT	v93 n2 f1	killarney	Arbutus grove 31	nocva21314	Kerry	2024-10-28 13:02:11.926779+00	0.00	170.40	170.40	{}	pi_3QEsZPRwsosTYqRm1PjpfUvO	66
154	62FE7A56A6E74DEDA99CE5BD59FF0740	Faki Bakic	bra@mail.com	009909	AR	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-10-28 15:05:53.857601+00	0.00	170.40	170.40	{}	pi_3QEuVORwsosTYqRm0ErGnGor	66
143	1D4B0F3968564A3F94D228F49398CB10	Sajo login	nlekkerman@gmail.com	083443554567	AQ	v65 m32n4	Bihac	skocaj bb	mali skocaj	kjnkjn	2024-10-28 13:11:04.704789+00	0.00	178.35	178.35	{}	pi_3QEshcRwsosTYqRm08xUcLLc	66
144	FB33D3791DCF4474A6BF7BA67D932084	Faki Bakic	nlekkerman@gmail.com	083443554567	BS	v93 f7k9	Bihac	nova 21	building one	kERRY	2024-10-28 13:15:54.412911+00	0.00	160.00	160.00	{}	pi_3QEsmoRwsosTYqRm0LFmrBi2	66
145	535C0D364BD445A986BA771310BCC26C	Faki Bakic	nlekkerman@gmail.com	083443554567	AM	v93 f7k9	Killarney	skocaj bb	building one	kERRY	2024-10-28 13:31:13.80439+00	0.00	160.00	160.00	{}	pi_3QEt1bRwsosTYqRm07bHTovQ	66
146	18B18922F9174AFDA3C6E4BB81D6494B	Sajo login	sida@gmail.com	kmjnk	AT	v93 f7k9	Bihac	nova 21	mali skocaj	kjnkjn	2024-10-28 13:48:29.687747+00	0.80	7.95	8.75	{}	pi_3QEt3oRwsosTYqRm019AKxve	66
147	6D38640A0AAF4A93AA63CFA706D0E290	Faki Bakic	nlekkerman@gmail.com	00385830945102	AQ	v65 m32n4	Killarney	skocaj bb	building one	Usk	2024-10-28 14:09:33.212844+00	0.00	160.00	160.00	{}	pi_3QEtcoRwsosTYqRm0XHLtvY0	66
148	B78E9554B267460C9C4C9DAC742AAB6A	Faki Bakic	Shimic@mail.com	009909	AU	v93 f7k9	Bihac	skocaj bb	nocva21314	kERRY	2024-10-28 14:16:16.479562+00	0.00	148.75	148.75	{}	pi_3QEtjNRwsosTYqRm10cWhfmK	66
149	458A9257AD4442EE82CF676247F9620D	Sajo login	sida@gmail.com	099292712716222	AM	v65 m32n4	Killarney	kjn	building one	Usk	2024-10-28 14:26:20.237841+00	2.88	28.75	31.63	{}	pi_3QEttBRwsosTYqRm0EPBFbW2	66
162	D66A74FD3EDB49DD90BAEF9D20A962D4	first last	sehidoc136@ckuer.com	12345678	KR	test	test	test	\N	test	2024-12-11 07:09:43.912334+00	0.80	7.95	8.75	{}	pi_3QUk2aRwsosTYqRm037j8Oo7	\N
155	C845AAACA7734B4AA8DE4583BAF2AE11	Sanja Golac	sanja.killarney@gmail.com	O84283629	IE	V93 N2F1	Killarney	31 Arbutus Grove	\N	Co. Kerry	2024-10-29 23:44:18.739187+00	0.00	375.30	375.30	{}	pi_3QFP3bRwsosTYqRm1qw0lZh9	67
150	7704D61FA54B40B98406B227488CD9CB	Sajo login	sida@gmail.com	00385830945102	AR	v93 f7k9	Bihac	skocaj bb	mali skocaj	Usk	2024-10-28 14:27:56.812449+00	0.00	167.20	167.20	{}	pi_3QEtuiRwsosTYqRm1Xui6rFm	66
151	82C4BD6DEE3D4EADB1CD5D833C736551	Faki Bakic	sanja.cookies@gmail.com	099292712716222	AF	v65 m32n4	Killarney	Skocaj	building one	Usk	2024-10-28 14:31:20.122809+00	0.00	160.00	160.00	{}	pi_3QEtxiRwsosTYqRm0BvRMj6d	66
152	5B429C5006AB4C65B17E4583BC8CC014	Marko Toti	sida@gmail.com	009909	AR	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-10-28 14:41:00.305007+00	0.00	160.00	160.00	{}	pi_3QEu77RwsosTYqRm16pTLm3Z	66
156	74D220EC68594478A581D4140640BF36	george ante	gantoniou23s@gmail.com	083443554567	AT	v93 n2f1	killareney	Arbutus grove 31	any	anywhere	2024-11-04 15:44:54.158924+00	1.04	10.40	11.44	{}	pi_3QHSOCRwsosTYqRm0ymjZ235	40
153	B1EB1807A4A14917B325EBE1817A5AE9	Faki Bakic	kamil@mail.com	099292712716222	AU	v65 m32n4	Bihac	nova 21	building one	kERRY	2024-10-28 15:04:53.576105+00	0.00	508.75	508.75	{}	pi_3QEuUKRwsosTYqRm0w1oOcX2	66
163	C49ACAF2363C49E2AFFE3FEEB27AA9A9	Sourojit sourojit	sourojit@abc.com	2333	AT	sssss90	knkdnkndk	dnndK	kknkdnkdkn	sksss	2024-12-11 07:16:16.719793+00	1.04	10.40	11.44	{}	pi_3QUk9JRwsosTYqRm0Yk9vEma	\N
157	852A3FD648B54D5EBFCDB3557D54D2BA	Nikola Simic	nlekkerman@gmail.com	0008887776666	IE	V93 N2F1	Killarney	31 Arbutus Grove	32	Co. Kerry	2024-11-06 11:37:52.946314+00	0.00	170.40	170.40	{}	pi_3QI7XsRwsosTYqRm1Z73nFwm	\N
158	CBFE7713DF424FED9C08102A4C4F1F49	Vanja Smith	sanja.killarney@gmail.com	023 345 543	IE	V93 N2F1	Killarney	31 Arbitus Grove	\N	Co Kerry	2024-11-09 20:26:45.314328+00	0.80	7.95	8.75	{}	pi_3QJKxDRwsosTYqRm1hwDtJMs	73
159	5951DB8C152946F6915EF56D87F91496	nikola simic	nlekkerman@gmail.com	00385830945102	AW	v65 m32n4	bihac	skocaj bb	mali skocaj	Kerry	2024-11-10 14:23:05.631482+00	1.04	10.40	11.44	{}	pi_3QJbL5RwsosTYqRm1ypvk3iC	40
160	87AF8A9E1AEA4414A5F7F181FD547542	Nikola Simic	nlekkerman@gmail.com	0830945102	IE	V93 N2F1	Killarney	31 Arbutus Grove	\N	Co. Kerry	2024-12-06 12:59:02.506976+00	0.00	167.95	167.95	{}	pi_3QT172RwsosTYqRm1KumO00L	40
161	E4312CB6EF3A4083A65B5A9D1E885319	test	jorexe5011@craftapk.com	1234567890	AT	qwrq	fqrwq	12412	123123	wrq	2024-12-10 11:11:19.986084+00	2.39	23.85	26.24	{}	pi_3QURLBRwsosTYqRm0jAirSNq	\N
\.


--
-- Data for Name: checkout_orderlineitem; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.checkout_orderlineitem (id, quantity, lineitem_total, order_id, seed_id) FROM stdin;
1	2	320.00	3	10
2	1	12.95	3	2
3	3	14.85	3	7
4	1	14.95	3	4
5	5	39.75	3	6
6	2	20.80	3	1
7	1	20.90	3	13
8	1	18.00	3	14
9	2	27.00	3	3
10	2	320.00	4	10
11	1	12.95	4	2
12	3	14.85	4	7
13	1	14.95	4	4
14	5	39.75	4	6
15	2	20.80	4	1
16	1	20.90	4	13
17	1	18.00	4	14
18	2	27.00	4	3
19	2	320.00	5	10
20	1	12.95	5	2
21	3	14.85	5	7
22	1	14.95	5	4
23	5	39.75	5	6
24	2	20.80	5	1
25	1	20.90	5	13
26	1	18.00	5	14
27	2	27.00	5	3
28	2	320.00	6	10
29	1	12.95	6	2
30	3	14.85	6	7
31	1	14.95	6	4
32	5	39.75	6	6
33	2	20.80	6	1
34	1	20.90	6	13
35	1	18.00	6	14
36	2	27.00	6	3
37	2	320.00	7	10
38	1	12.95	7	2
39	3	14.85	7	7
40	1	14.95	7	4
41	5	39.75	7	6
42	2	20.80	7	1
43	1	20.90	7	13
44	1	18.00	7	14
45	2	27.00	7	3
46	2	320.00	8	10
47	1	12.95	8	2
48	3	14.85	8	7
49	1	14.95	8	4
50	5	39.75	8	6
51	2	20.80	8	1
52	1	20.90	8	13
53	1	18.00	8	14
54	2	27.00	8	3
55	2	320.00	9	10
56	1	12.95	9	2
57	3	14.85	9	7
58	1	14.95	9	4
59	5	39.75	9	6
60	2	20.80	9	1
61	1	20.90	9	13
62	1	18.00	9	14
63	2	27.00	9	3
64	1	12.95	10	2
65	8	1280.00	10	10
66	3	14.85	10	7
67	1	14.95	10	4
68	5	39.75	10	6
69	2	20.80	10	1
70	1	20.90	10	13
71	1	18.00	10	14
72	2	27.00	10	3
73	1	12.95	11	2
74	8	1280.00	11	10
75	3	14.85	11	7
76	1	14.95	11	4
77	5	39.75	11	6
78	2	20.80	11	1
79	1	20.90	11	13
80	1	18.00	11	14
81	2	27.00	11	3
82	1	12.95	12	2
83	8	1280.00	12	10
84	3	14.85	12	7
85	1	14.95	12	4
86	5	39.75	12	6
87	2	20.80	12	1
88	1	20.90	12	13
89	1	18.00	12	14
90	2	27.00	12	3
91	1	12.95	13	2
92	8	1280.00	13	10
93	3	14.85	13	7
94	1	14.95	13	4
95	5	39.75	13	6
96	2	20.80	13	1
97	1	20.90	13	13
98	1	18.00	13	14
99	2	27.00	13	3
100	1	12.95	14	2
101	8	1280.00	14	10
102	3	14.85	14	7
103	1	14.95	14	4
104	5	39.75	14	6
105	2	20.80	14	1
106	1	20.90	14	13
107	1	18.00	14	14
108	2	27.00	14	3
109	1	12.95	15	2
110	8	1280.00	15	10
111	3	14.85	15	7
112	1	14.95	15	4
113	5	39.75	15	6
114	2	20.80	15	1
115	1	20.90	15	13
116	1	18.00	15	14
117	2	27.00	15	3
118	1	12.95	16	2
119	8	1280.00	16	10
120	3	14.85	16	7
121	1	14.95	16	4
122	5	39.75	16	6
123	2	20.80	16	1
124	1	20.90	16	13
125	1	18.00	16	14
126	2	27.00	16	3
127	1	12.95	17	2
128	8	1280.00	17	10
129	3	14.85	17	7
130	1	14.95	17	4
131	5	39.75	17	6
132	2	20.80	17	1
133	1	20.90	17	13
134	1	18.00	17	14
135	2	27.00	17	3
136	1	4.95	18	7
137	1	4.95	19	7
138	1	160.00	20	10
139	2	20.80	20	1
140	1	160.00	21	10
141	2	20.80	21	1
142	1	12.95	22	2
143	8	1280.00	22	10
144	3	14.85	22	7
145	1	14.95	22	4
146	1	12.95	23	2
147	5	39.75	22	6
148	8	1280.00	23	10
149	2	20.80	22	1
150	3	14.85	23	7
151	1	20.90	22	13
152	1	14.95	23	4
153	1	18.00	22	14
154	5	39.75	23	6
155	2	27.00	22	3
156	2	20.80	23	1
157	1	20.90	23	13
158	1	18.00	23	14
159	2	27.00	23	3
160	1	7.95	24	6
161	1	10.40	24	1
162	2	320.00	24	10
367	1	160.00	129	10
368	1	10.40	130	1
369	1	160.00	130	10
370	1	148.75	131	9
371	1	20.90	131	13
372	2	28.50	131	8
373	1	160.00	132	10
374	1	160.00	133	10
375	1	7.95	134	6
376	1	160.00	135	10
377	2	20.80	136	1
378	1	160.00	136	10
379	1	10.40	137	1
380	1	160.00	138	10
381	1	7.95	139	6
382	1	148.75	139	9
383	1	160.00	140	10
384	1	10.40	140	1
385	1	148.75	141	9
386	1	10.40	142	1
387	1	160.00	142	10
388	1	7.95	143	6
389	1	10.40	143	1
390	1	160.00	143	10
391	1	160.00	144	10
392	1	160.00	145	10
393	1	7.95	146	6
394	1	160.00	147	10
395	1	148.75	148	9
396	1	7.95	149	6
397	2	20.80	149	1
398	1	13.50	150	3
399	1	148.75	150	9
400	1	4.95	150	7
401	1	160.00	151	10
402	1	160.00	152	10
403	1	7.95	153	6
404	2	20.80	153	1
405	3	480.00	153	10
406	1	160.00	154	10
407	1	10.40	154	1
408	2	297.50	155	9
409	2	41.80	155	13
410	2	36.00	155	14
411	1	10.40	156	1
412	1	10.40	157	1
413	1	160.00	157	10
414	1	7.95	158	6
415	1	10.40	159	1
416	1	160.00	160	10
417	1	7.95	160	6
418	3	23.85	161	6
419	1	7.95	162	6
420	1	10.40	163	1
\.


--
-- Data for Name: communications_chatconversation; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.communications_chatconversation (id, created_at, updated_at, superuser_id, user_id, is_active, started_at, deleted, last_modified) FROM stdin;
3	2024-08-29 18:41:54.353574+00	2024-08-29 18:41:54.353579+00	1	15	t	2024-08-29 18:41:54.353357+00	f	2024-08-31 21:52:56.835953+00
7	2024-08-30 09:21:22.510989+00	2024-08-30 09:21:22.510995+00	1	19	t	2024-08-30 09:21:22.510739+00	f	2024-08-31 21:52:56.835953+00
8	2024-08-30 23:01:01.0674+00	2024-08-30 23:01:01.067405+00	1	1	t	2024-08-30 23:01:01.067192+00	f	2024-08-31 21:52:56.835953+00
10	2024-10-27 13:19:16.765938+00	2024-10-27 13:19:16.765943+00	1	52	t	2024-10-27 13:19:16.7657+00	f	2024-10-27 13:19:16.765946+00
11	2024-10-29 23:31:15.191625+00	2024-10-29 23:31:15.191631+00	1	53	t	2024-10-29 23:31:15.191373+00	f	2024-10-29 23:31:15.191634+00
12	2024-10-29 23:36:36.204636+00	2024-10-29 23:36:36.204643+00	1	54	t	2024-10-29 23:36:36.204401+00	f	2024-10-29 23:36:36.204649+00
13	2024-11-06 11:54:25.234336+00	2024-11-06 11:54:25.234341+00	1	55	t	2024-11-06 11:54:25.234091+00	f	2024-11-06 11:54:25.234345+00
14	2024-11-07 12:37:21.137171+00	2024-11-07 12:37:21.137176+00	1	56	t	2024-11-07 12:37:21.13693+00	f	2024-11-07 12:37:21.137179+00
15	2024-11-09 18:06:11.806157+00	2024-11-09 18:06:11.806164+00	1	57	t	2024-11-09 18:06:11.805804+00	f	2024-11-09 18:06:11.80617+00
16	2024-11-09 20:06:34.47747+00	2024-11-09 20:06:34.477475+00	1	58	t	2024-11-09 20:06:34.477214+00	f	2024-11-09 20:06:34.477479+00
17	2024-11-10 13:33:04.126728+00	2024-11-10 13:33:04.126734+00	1	59	t	2024-11-10 13:33:04.126423+00	f	2024-11-10 13:33:04.126737+00
18	2024-12-11 07:12:21.599306+00	2024-12-11 07:12:21.599311+00	1	61	t	2024-12-11 07:12:21.599056+00	f	2024-12-11 07:12:21.599315+00
\.


--
-- Data for Name: communications_chatmessage; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.communications_chatmessage (id, content, created_at, conversation_id, sender_id, received_at, seen, sent_at, updated_at, deleted, last_modified) FROM stdin;
137	Hi	2024-10-03 12:26:58.853579+00	3	1	\N	t	2024-10-03 12:26:58.853319+00	2024-10-03 12:26:58.853584+00	f	2024-10-03 12:26:58.853587+00
123	caaaaaaaaaaaaaaaasaa	2024-09-28 09:59:23.360737+00	3	15	\N	t	2024-09-28 09:59:23.360545+00	2024-09-28 09:59:23.360742+00	f	2024-09-28 09:59:23.360745+00
140	ima aj bujrum.	2024-10-04 19:47:32.451895+00	3	1	\N	t	2024-10-04 19:47:32.451685+00	2024-10-04 19:47:32.451899+00	f	2024-10-04 19:47:32.451903+00
67	sczx	2024-08-29 22:33:26.114226+00	3	1	\N	t	2024-08-29 22:33:26.114009+00	2024-09-28 11:16:33.236822+00	f	2024-09-28 11:16:33.236828+00
44	hi	2024-08-29 20:48:30.773905+00	3	15	\N	t	2024-08-29 20:48:30.639441+00	2024-09-28 11:15:55.560386+00	f	2024-09-28 11:15:55.560391+00
98	DI si saki	2024-09-13 09:32:20.999656+00	3	1	\N	t	2024-09-13 09:32:20.999242+00	2024-09-13 09:32:20.999661+00	f	2024-09-13 09:32:20.999664+00
87	E Sajo how is new life?	2024-08-30 10:10:31.923964+00	3	1	\N	t	2024-08-30 10:10:31.923504+00	2024-08-30 10:10:31.923969+00	f	2024-08-31 21:52:57.362674+00
99	sadasdasd	2024-09-23 13:13:26.265457+00	8	1	\N	f	2024-09-23 13:13:26.265192+00	2024-09-23 13:13:26.265462+00	f	2024-09-23 13:13:26.265465+00
68	sczx	2024-08-29 22:33:27.512551+00	3	1	\N	t	2024-08-29 22:33:27.512394+00	2024-08-29 22:33:27.512555+00	f	2024-08-31 21:52:57.362674+00
159	Hello, I'm enjoying in your shop, it is amazing!!	2024-10-29 23:32:46.165417+00	11	53	\N	t	2024-10-29 23:32:46.16496+00	2024-10-29 23:32:46.165425+00	f	2024-10-29 23:32:46.165431+00
162	Puno te volim.	2024-10-29 23:45:20.57228+00	11	1	\N	f	2024-10-29 23:45:20.572054+00	2024-10-29 23:45:20.572285+00	f	2024-10-29 23:45:20.572288+00
165	TWO	2024-11-05 17:17:54.275531+00	7	19	\N	t	2024-11-05 17:17:54.275312+00	2024-11-05 17:17:54.275535+00	f	2024-11-05 17:17:54.275538+00
168	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-11-09 18:06:11.940986+00	15	1	\N	t	2024-11-09 18:06:11.940689+00	2024-11-09 18:06:11.940994+00	f	2024-11-09 18:06:11.940999+00
171	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-11-10 13:33:04.261384+00	17	1	\N	f	2024-11-10 13:33:04.261116+00	2024-11-10 13:33:04.261389+00	f	2024-11-10 13:33:04.261393+00
174	hfgsdfg	2024-12-11 07:14:37.912402+00	18	61	\N	f	2024-12-11 07:14:37.911977+00	2024-12-11 07:14:37.912412+00	f	2024-12-11 07:14:37.912418+00
100	toliko o tome	2024-09-23 14:26:25.398274+00	8	1	\N	f	2024-09-23 14:26:25.39797+00	2024-09-23 14:26:25.398279+00	f	2024-09-23 14:26:25.398283+00
101	koli	2024-09-23 14:35:26.055163+00	8	1	\N	f	2024-09-23 14:35:26.054945+00	2024-09-23 14:35:26.055168+00	f	2024-09-23 14:35:26.05517+00
102	zsdf	2024-09-23 14:37:31.80522+00	8	1	\N	f	2024-09-23 14:37:31.804927+00	2024-09-23 14:37:31.805225+00	f	2024-09-23 14:37:31.805228+00
103	asdasdasdasdasd	2024-09-23 14:40:53.205755+00	8	1	\N	f	2024-09-23 14:40:53.20555+00	2024-09-23 14:40:53.205759+00	f	2024-09-23 14:40:53.205762+00
104	tokio	2024-09-23 14:43:12.906894+00	8	1	\N	f	2024-09-23 14:43:12.906677+00	2024-09-23 14:43:12.906899+00	f	2024-09-23 14:43:12.906901+00
105	vino	2024-09-23 14:46:19.263905+00	8	1	\N	f	2024-09-23 14:46:19.263686+00	2024-09-23 14:46:19.26391+00	f	2024-09-23 14:46:19.263913+00
106	kozije	2024-09-23 14:51:23.604709+00	8	1	\N	f	2024-09-23 14:51:23.604517+00	2024-09-23 14:51:23.604714+00	f	2024-09-23 14:51:23.604717+00
107	moje	2024-09-23 14:52:02.580393+00	8	1	\N	f	2024-09-23 14:52:02.580199+00	2024-09-23 14:52:02.580397+00	f	2024-09-23 14:52:02.580401+00
108	tokio	2024-09-23 14:55:12.751145+00	8	1	\N	f	2024-09-23 14:55:12.75095+00	2024-09-23 14:55:12.75115+00	f	2024-09-23 14:55:12.751152+00
109	now	2024-09-23 15:04:59.525797+00	8	1	\N	f	2024-09-23 15:04:59.525495+00	2024-09-23 15:04:59.525802+00	f	2024-09-23 15:04:59.525806+00
96	kjbj	2024-09-13 09:31:23.164793+00	8	1	\N	t	2024-09-13 09:31:23.164284+00	2024-09-13 09:31:23.164799+00	f	2024-09-13 09:31:23.164802+00
97	loki	2024-09-13 09:31:37.123452+00	8	1	\N	t	2024-09-13 09:31:37.123012+00	2024-09-13 09:31:37.123457+00	f	2024-09-13 09:31:37.12346+00
110	ola	2024-09-23 15:07:18.268397+00	8	1	\N	f	2024-09-23 15:07:18.268174+00	2024-09-23 15:07:18.268402+00	f	2024-09-23 15:07:18.268405+00
153	yo	2024-10-27 12:59:08.716301+00	7	19	\N	t	2024-10-27 12:59:08.716034+00	2024-10-27 12:59:08.716306+00	f	2024-10-27 12:59:08.716309+00
89	How	2024-08-30 10:35:11.452554+00	7	19	\N	t	2024-08-30 10:35:11.452163+00	2024-09-28 11:16:52.500664+00	f	2024-09-28 11:16:52.500672+00
125	fggfdf	2024-09-28 13:56:41.93957+00	7	1	\N	t	2024-09-28 13:56:41.939277+00	2024-09-28 13:56:41.939575+00	f	2024-09-28 13:56:41.939578+00
127	asssa	2024-10-01 14:04:25.505325+00	7	1	\N	t	2024-10-01 14:04:25.505033+00	2024-10-01 14:04:25.50533+00	f	2024-10-01 14:04:25.505333+00
129	bfdbf	2024-10-01 14:08:44.160454+00	7	1	\N	t	2024-10-01 14:08:44.160264+00	2024-10-01 14:08:44.160459+00	f	2024-10-01 14:08:44.160461+00
131	xasxa	2024-10-01 14:12:51.75651+00	7	1	\N	t	2024-10-01 14:12:51.756298+00	2024-10-01 14:12:51.756515+00	f	2024-10-01 14:12:51.756518+00
121	sdfdsf	2024-09-28 09:54:35.874175+00	7	1	\N	t	2024-09-28 09:54:35.873859+00	2024-09-28 09:54:35.87418+00	f	2024-09-28 09:54:35.874184+00
88	YIO didi ya cek sit	2024-08-30 10:13:26.836023+00	7	1	\N	t	2024-08-30 10:13:26.835612+00	2024-08-30 10:13:26.836028+00	f	2024-08-31 21:52:57.362674+00
90	alo	2024-08-30 10:46:28.302652+00	7	19	\N	t	2024-08-30 10:46:28.302102+00	2024-08-30 10:46:28.302658+00	f	2024-08-31 21:52:57.362674+00
91	1.1 Check out our Q&A page or 1.2 Chat with us.	2024-08-30 10:50:34.005322+00	7	1	\N	t	2024-08-30 10:50:34.00509+00	2024-08-30 10:50:34.005327+00	f	2024-08-31 21:52:57.362674+00
92	lsdmc	2024-08-30 11:06:49.144145+00	7	19	\N	t	2024-08-30 11:06:49.143659+00	2024-08-30 11:06:49.14415+00	f	2024-08-31 21:52:57.362674+00
136	asdasdasdasdasdasda	2024-10-01 14:39:22.154112+00	7	19	\N	t	2024-10-01 14:39:22.153893+00	2024-10-01 14:39:22.154116+00	f	2024-10-01 14:39:22.154119+00
156	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-10-27 13:19:16.896797+00	10	1	\N	t	2024-10-27 13:19:16.896588+00	2024-10-27 13:19:16.896802+00	f	2024-10-27 13:19:16.896805+00
141	aloooooha..	2024-10-05 08:38:02.198996+00	7	19	\N	t	2024-10-05 08:38:02.198784+00	2024-10-05 08:38:02.199002+00	f	2024-10-05 08:38:02.199005+00
86	AKoloako	2024-08-30 09:56:35.412935+00	7	1	\N	t	2024-08-30 09:56:35.412556+00	2024-08-30 09:56:35.412939+00	f	2024-08-31 21:52:57.362674+00
94	Ola	2024-08-30 15:07:47.393427+00	7	19	\N	t	2024-08-30 15:07:47.39263+00	2024-08-30 22:39:33.315321+00	f	2024-08-31 21:52:57.362674+00
111	vccvbcvb	2024-09-26 15:05:49.4705+00	7	19	\N	t	2024-09-26 15:05:49.470193+00	2024-09-26 15:05:49.470505+00	f	2024-09-26 15:05:49.470508+00
112	TEST UNSEEN.	2024-09-27 13:02:38.434259+00	7	1	\N	t	2024-09-27 13:02:38.433979+00	2024-09-27 13:02:38.434264+00	f	2024-09-27 13:02:38.434268+00
114	Oki man	2024-09-27 14:18:47.85544+00	7	19	\N	t	2024-09-27 14:18:47.855158+00	2024-09-27 14:18:47.855445+00	f	2024-09-27 14:18:47.855448+00
115	asdasdasdasdasdasd	2024-09-27 14:28:28.944046+00	7	19	\N	t	2024-09-27 14:28:28.943865+00	2024-09-27 14:28:28.94405+00	f	2024-09-27 14:28:28.944053+00
116	sup maki?	2024-09-27 14:29:47.917202+00	7	1	\N	t	2024-09-27 14:29:47.916993+00	2024-09-27 14:29:47.917207+00	f	2024-09-27 14:29:47.91721+00
118	zcxczxc	2024-09-27 15:05:05.719208+00	7	19	\N	t	2024-09-27 15:05:05.719019+00	2024-09-27 15:05:05.719213+00	f	2024-09-27 15:05:05.719216+00
122	NIKIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII	2024-09-28 09:58:11.953193+00	7	19	\N	t	2024-09-28 09:58:11.952984+00	2024-09-28 09:58:11.953197+00	f	2024-09-28 09:58:11.9532+00
157	Tnx	2024-10-27 13:19:39.445428+00	10	52	\N	t	2024-10-27 13:19:39.445225+00	2024-10-27 13:19:39.445432+00	f	2024-10-27 13:19:39.445435+00
160	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-10-29 23:36:36.337884+00	12	1	\N	f	2024-10-29 23:36:36.337675+00	2024-10-29 23:36:36.337888+00	f	2024-10-29 23:36:36.337892+00
163	mohje	2024-11-04 13:33:15.282442+00	3	1	\N	f	2024-11-04 13:33:15.282139+00	2024-11-04 13:33:15.282448+00	f	2024-11-04 13:33:15.282451+00
166	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-11-06 11:54:25.370284+00	13	1	\N	f	2024-11-06 11:54:25.370041+00	2024-11-06 11:54:25.370289+00	f	2024-11-06 11:54:25.370293+00
169	ljuba moja	2024-11-09 19:20:44.854352+00	15	1	\N	f	2024-11-09 19:20:44.854048+00	2024-11-09 19:20:44.854357+00	f	2024-11-09 19:20:44.854361+00
172	Hi there agin.	2024-12-06 13:10:10.446091+00	17	1	\N	f	2024-12-06 13:10:10.445791+00	2024-12-06 13:10:10.446096+00	f	2024-12-06 13:10:10.446099+00
69	sczx	2024-08-29 22:33:28.632373+00	3	1	\N	t	2024-08-29 22:33:28.63224+00	2024-08-29 22:33:28.632377+00	f	2024-08-31 21:52:57.362674+00
70	sczx	2024-08-29 22:34:22.867058+00	3	1	\N	t	2024-08-29 22:34:22.866914+00	2024-08-29 22:34:22.867062+00	f	2024-08-31 21:52:57.362674+00
71	ti	2024-08-29 22:35:11.601267+00	3	1	\N	t	2024-08-29 22:35:11.601126+00	2024-08-29 22:35:11.601271+00	f	2024-08-31 21:52:57.362674+00
133	zxczxc	2024-10-01 14:26:16.799113+00	3	1	\N	t	2024-10-01 14:26:16.798927+00	2024-10-01 14:26:16.799117+00	f	2024-10-01 14:26:16.79912+00
143	dsffs	2024-10-05 09:33:41.258842+00	3	1	\N	t	2024-10-05 09:33:41.258637+00	2024-10-05 09:33:41.258847+00	f	2024-10-05 09:33:41.25885+00
146	ola	2024-10-05 09:53:28.37475+00	3	1	\N	t	2024-10-05 09:53:28.374506+00	2024-10-05 09:53:28.374755+00	f	2024-10-05 09:53:28.374758+00
149	hi.	2024-10-05 10:09:06.15993+00	3	1	\N	t	2024-10-05 10:09:06.159721+00	2024-10-05 10:09:06.159935+00	f	2024-10-05 10:09:06.159938+00
144	sdsdsd	2024-10-05 09:34:30.325906+00	3	1	\N	t	2024-10-05 09:34:30.325695+00	2024-10-05 09:34:30.32591+00	f	2024-10-05 09:34:30.325914+00
170	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-11-09 20:06:34.620794+00	16	1	\N	f	2024-11-09 20:06:34.62055+00	2024-11-09 20:06:34.620799+00	f	2024-11-09 20:06:34.620803+00
173	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-12-11 07:12:21.730299+00	18	1	\N	t	2024-12-11 07:12:21.729946+00	2024-12-11 07:12:21.730307+00	f	2024-12-11 07:12:21.730313+00
93	Posalji	2024-08-30 14:08:41.957665+00	7	19	\N	t	2024-08-30 14:08:41.957199+00	2024-08-30 14:08:41.957671+00	f	2024-08-31 21:52:57.362674+00
147	dfdsfs	2024-10-05 09:59:43.636366+00	3	1	\N	t	2024-10-05 09:59:43.636166+00	2024-10-05 09:59:43.63637+00	f	2024-10-05 09:59:43.636373+00
83	INITIATE	2024-08-30 09:22:47.497036+00	7	19	\N	t	2024-08-30 09:22:47.496527+00	2024-08-30 09:22:47.497041+00	f	2024-08-31 21:52:57.362674+00
84	hiu	2024-08-30 09:46:35.793912+00	7	1	\N	t	2024-08-30 09:46:35.793445+00	2024-08-30 09:46:35.793918+00	f	2024-08-31 21:52:57.362674+00
85	Look it is nice outside	2024-08-30 09:48:05.060686+00	7	19	\N	t	2024-08-30 09:48:05.060307+00	2024-08-30 09:48:05.06069+00	f	2024-08-31 21:52:57.362674+00
113	Ide rezervacija.	2024-09-27 13:57:20.277995+00	7	19	\N	t	2024-09-27 13:57:20.277707+00	2024-09-28 11:37:57.998829+00	f	2024-09-28 11:37:57.998834+00
128	asxasx	2024-10-01 14:06:14.026238+00	7	1	\N	t	2024-10-01 14:06:14.02602+00	2024-10-01 14:06:14.026243+00	f	2024-10-01 14:06:14.026246+00
135	daa	2024-10-01 14:28:21.524238+00	7	19	\N	t	2024-10-01 14:28:21.524036+00	2024-10-01 14:28:21.524242+00	f	2024-10-01 14:28:21.524246+00
150	dxczxc	2024-10-05 10:14:21.513975+00	3	1	\N	t	2024-10-05 10:14:21.513775+00	2024-10-05 10:14:21.513979+00	f	2024-10-05 10:14:21.513982+00
138	alo bre	2024-10-04 19:45:15.939449+00	3	1	\N	t	2024-10-04 19:45:15.939176+00	2024-10-04 19:45:15.939453+00	f	2024-10-04 19:45:15.939457+00
72	dsad	2024-08-29 22:39:31.533801+00	3	1	\N	t	2024-08-29 22:39:31.533562+00	2024-08-29 22:39:31.533806+00	f	2024-08-31 21:52:57.362674+00
73	aaaaaaaaaaaaa	2024-08-29 22:39:58.726063+00	3	1	\N	t	2024-08-29 22:39:58.725907+00	2024-08-29 22:39:58.726068+00	f	2024-08-31 21:52:57.362674+00
74	dss	2024-08-29 22:42:47.564346+00	3	1	\N	t	2024-08-29 22:42:47.56412+00	2024-08-29 22:42:47.564351+00	f	2024-08-31 21:52:57.362674+00
75	zsdcz	2024-08-29 22:46:55.206032+00	3	1	\N	t	2024-08-29 22:46:55.205803+00	2024-08-29 22:46:55.206037+00	f	2024-08-31 21:52:57.362674+00
76	poli	2024-08-29 22:47:14.380892+00	3	1	\N	t	2024-08-29 22:47:14.380731+00	2024-08-29 22:47:14.380896+00	f	2024-08-31 21:52:57.362674+00
77	oki	2024-08-29 22:48:25.969391+00	3	1	\N	t	2024-08-29 22:48:25.969167+00	2024-08-29 22:48:25.969395+00	f	2024-08-31 21:52:57.362674+00
78	NUi	2024-08-30 08:45:15.630798+00	3	15	\N	t	2024-08-30 08:45:15.499042+00	2024-08-30 08:45:15.630805+00	f	2024-08-31 21:52:57.362674+00
79	NUi	2024-08-30 08:45:57.688942+00	3	15	\N	t	2024-08-30 08:45:57.557339+00	2024-08-30 08:45:57.688949+00	f	2024-08-31 21:52:57.362674+00
80	HI i nmm writhngasa	2024-08-30 08:46:15.964223+00	3	15	\N	t	2024-08-30 08:46:15.83149+00	2024-08-30 08:46:15.964229+00	f	2024-08-31 21:52:57.362674+00
81	New life.	2024-08-30 09:12:44.307596+00	3	15	\N	t	2024-08-30 09:12:44.172065+00	2024-08-30 09:12:44.307603+00	f	2024-08-31 21:52:57.362674+00
95	e	2024-08-30 21:09:14.596973+00	3	1	\N	t	2024-08-30 21:09:14.59644+00	2024-08-30 23:00:52.996192+00	f	2024-08-31 21:52:57.362674+00
117	czxxzczcz	2024-09-27 14:52:53.129576+00	3	1	\N	t	2024-09-27 14:52:53.129301+00	2024-09-27 14:52:53.129581+00	f	2024-09-27 14:52:53.129585+00
119	AY AY Capitain	2024-09-28 09:20:13.240997+00	3	1	\N	t	2024-09-28 09:20:13.240718+00	2024-09-28 09:20:13.241002+00	f	2024-09-28 09:20:13.241006+00
120	di si niki..	2024-09-28 09:21:26.988813+00	3	15	\N	t	2024-09-28 09:21:26.988603+00	2024-09-28 09:21:26.988817+00	f	2024-09-28 09:21:26.98882+00
124	zzasdasdadasdas	2024-09-28 10:00:05.611691+00	3	15	\N	t	2024-09-28 10:00:05.611476+00	2024-09-28 10:00:05.611695+00	f	2024-09-28 10:00:05.611698+00
126	sup	2024-10-01 13:16:54.944108+00	3	1	\N	t	2024-10-01 13:16:54.9438+00	2024-10-01 13:16:54.944113+00	f	2024-10-01 13:16:54.944117+00
130	dasdasd	2024-10-01 14:11:15.742086+00	3	1	\N	t	2024-10-01 14:11:15.741875+00	2024-10-01 14:11:15.742091+00	f	2024-10-01 14:11:15.742094+00
132	asxasx	2024-10-01 14:15:53.92584+00	3	1	\N	t	2024-10-01 14:15:53.925628+00	2024-10-01 14:15:53.925844+00	f	2024-10-01 14:15:53.925848+00
134	czxczxc	2024-10-01 14:27:04.30222+00	3	1	\N	t	2024-10-01 14:27:04.302019+00	2024-10-01 14:27:04.302225+00	f	2024-10-01 14:27:04.302229+00
139	E imal ribe?	2024-10-04 19:46:20.012077+00	3	15	\N	t	2024-10-04 19:46:20.01187+00	2024-10-04 19:46:20.012082+00	f	2024-10-04 19:46:20.012085+00
142	dsffs	2024-10-05 09:33:33.760374+00	3	1	\N	t	2024-10-05 09:33:33.760164+00	2024-10-05 09:33:33.760378+00	f	2024-10-05 09:33:33.760382+00
145	dfsdfsd	2024-10-05 09:51:49.036322+00	3	1	\N	t	2024-10-05 09:51:49.036112+00	2024-10-05 09:51:49.036326+00	f	2024-10-05 09:51:49.036329+00
148	\\Aax	2024-10-05 10:04:21.5511+00	3	1	\N	t	2024-10-05 10:04:21.550904+00	2024-10-05 10:04:21.551105+00	f	2024-10-05 10:04:21.551108+00
151	ss\\dcjhsbdcsbckjsbckjsdb dzkc sdjcnskjcn sjdcn sdkjcnsdkjcn sdkcjnskdjcn skjcnskdcnsodicj osdicjsoikcj osdjcoskdcnlsdknmclskdn clksdnclsknckldnsclskjcpsdjc opisj  iojncoisjhc osjnc sc soijcsoijcosidjc sdcc	2024-10-05 10:24:18.506925+00	3	1	\N	t	2024-10-05 10:24:18.506717+00	2024-10-05 10:24:18.506929+00	f	2024-10-05 10:24:18.506933+00
152	oko	2024-10-11 07:25:56.649963+00	3	15	\N	t	2024-10-11 07:25:56.649652+00	2024-10-11 07:25:56.649968+00	f	2024-10-11 07:25:56.649971+00
158	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-10-29 23:31:15.325499+00	11	1	\N	t	2024-10-29 23:31:15.325245+00	2024-10-29 23:31:15.325504+00	f	2024-10-29 23:31:15.325508+00
161	Thank you, but you are more amazing.	2024-10-29 23:38:50.943184+00	11	1	\N	t	2024-10-29 23:38:50.942925+00	2024-10-29 23:38:50.943189+00	f	2024-10-29 23:38:50.943192+00
164	ONE	2024-11-05 17:17:21.658775+00	3	15	\N	t	2024-11-05 17:17:21.658516+00	2024-11-05 17:17:21.658781+00	f	2024-11-05 17:17:21.658785+00
167	Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us.	2024-11-07 12:37:21.269559+00	14	1	\N	f	2024-11-07 12:37:21.269339+00	2024-11-07 12:37:21.269564+00	f	2024-11-07 12:37:21.269567+00
\.


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.conversation (id, created_at) FROM stdin;
\.


--
-- Data for Name: custom_accounts_userprofile; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.custom_accounts_userprofile (id, address, phone_number, profile_image, about_self, receives_newsletter, email, user_id) FROM stdin;
23	\N	\N	placeholder_image	\N	f	sanja.cookies@gmail.com	\N
16	\N	\N	placeholder_image	\N	f	\N	\N
4	\N	\N	placeholder_image	\N	f	\N	\N
6	\N	\N	placeholder_image	\N	f	\N	\N
7	\N	\N	placeholder_image	\N	f	\N	\N
8	\N	\N	placeholder_image	\N	f	\N	\N
18	\N	\N	placeholder_image	\N	f	\N	\N
9	\N	\N	placeholder_image	\N	f	\N	\N
14	\N	\N	placeholder_image	\N	f	\N	\N
15	\N	\N	placeholder_image	\N	f	\N	\N
63	\N	\N	image/upload/placeholder_image	\N	t	fi@mail.com	49
25	\N	\N	placeholder_image	\N	f	brka@mail.com	\N
10	\N	\N	placeholder_image	\N	f	\N	\N
27	\N	\N	placeholder_image	\N	f	oki@mail.com	\N
29	\N	\N	placeholder_image	\N	f	h2we@mail.com	\N
11	\N	\N	placeholder_image	\N	f	\N	\N
31	\N	\N	placeholder_image	\N	f	rita@mail.com	\N
19	\N	\N	placeholder_image	\N	f	\N	\N
33	\N	\N	placeholder_image	\N	f	zi@mail.com	\N
20	\N	\N	placeholder_image	\N	f	\N	\N
3	31 Arbutus Grove	083443554567	image/upload/v1729702192/bfsbaing0qfcd3orihss.png	Seed MA5ter Above all	t	nlekkerman@gmail.com	\N
64	\N	\N	image/upload/placeholder_image	\N	t	bola@mail.com	50
38	\N	\N	placeholder_image	\N	f	\N	34
73	\N	\N	\N	\N	t	sanja.killarney@gmail.com	58
65	\N	\N	image/upload/placeholder_image	\N	t	sanja.cookies@gmail.com	51
42	\N	\N	placeholder_image	\N	f	\N	35
13	\N	\N	placeholder_image	\N	f	\N	\N
44	\N	\N	placeholder_image	\N	f	\N	36
46	\N	\N	placeholder_image	\N	f	\N	37
17	\N	\N	placeholder_image	\N	f	\N	\N
48	\N	\N	placeholder_image	\N	f	\N	38
50	\N	\N	placeholder_image	\N	f	\N	39
51	\N	\N	image/upload/placeholder_image	\N	f	\N	40
74	\N	\N	\N	\N	f	sanja.killarney@gmail.com	59
52	\N	\N	placeholder_image	\N	f	\N	41
12	\N	\N	image/upload/placeholder_image	\N	t	sajo@mail.com	\N
21	\N	\N	placeholder_image	\N	f		\N
54	\N	\N	placeholder_image	\N	f	\N	42
55	\N	\N	placeholder_image	\N	f	\N	43
57	\N	\N	placeholder_image	\N	f	\N	44
66	\N	\N	image/upload/placeholder_image	\N	t	sa@mail.com	52
59	\N	\N	image/upload/placeholder_image	\N	f	\N	45
60	\N	\N	image/upload/placeholder_image	\N	f	\N	46
71	\N	\N	image/upload/v1730983549/kc7dhjkslknkxjldbsor.png	\N	t	nlekkerman@gmail.com	56
61	\N	\N	image/upload/placeholder_image	\N	f	\N	47
62	\N	\N	image/upload/placeholder_image	\N	f	\N	48
41	31 Arbutus Grove	083443554567	image/upload/v1730900633/bnsikr8ud9sjk2muiawo.png	Self panker	f	\N	19
68	\N	\N	image/upload/placeholder_image	\N	t	bebiartnikola@gmail.com	54
70	\N	\N	image/upload/placeholder_image	\N	f	\N	15
69	\N	\N	image/upload/placeholder_image	\N	t	bebiartnikola@gmail.com	55
67	31 Arbutus Grove	085279522	image/upload/v1730245003/h10vrjcjqv6ansbzetji.jpg	I'm passionate about the flowers 🥰	t	sanja.killarney@gmail.com	53
75	\N	\N	\N	\N	f	gikekap826@pokeline.com	60
40	31 Arbutus Grove	00385830945102	image/upload/v1730644178/fhphxwgf8cul1c7xky9i.png	MAgician of green	f	\N	1
72	\N	\N	\N	\N	f	sanja.killarney@gmail.com	57
76	\N	\N	\N	\N	t	sehidoc136@ckuer.com	61
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-08-20 06:56:16.23525+00	15	Currant Bush	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
2	2024-08-20 07:00:51.410816+00	15	Currant Bush	2	[{"changed": {"fields": ["Category", "Image"]}}]	13	1
3	2024-08-20 07:01:52.778843+00	14	Gooseberry Bush	2	[{"changed": {"fields": ["Category", "Sun preference"]}}]	13	1
4	2024-08-20 07:01:53.627413+00	14	Gooseberry Bush	2	[]	13	1
5	2024-08-20 07:06:05.338853+00	13	Raspberry Bush	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
6	2024-08-20 07:08:36.845586+00	12	Blueberry Bush	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
7	2024-08-20 07:11:27.990569+00	14	Gooseberry Bush	2	[{"changed": {"fields": ["Image"]}}]	13	1
8	2024-08-20 07:13:45.412182+00	15	Black Currant Bush	2	[{"changed": {"fields": ["Name", "Image"]}}]	13	1
9	2024-08-20 11:14:08.688268+00	11	Lemon Tree	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
10	2024-08-21 11:08:22.913378+00	3	Biki	3		4	1
11	2024-08-21 11:08:22.91343+00	2	Nik	3		4	1
12	2024-08-21 11:08:22.91346+00	4	niko	3		4	1
13	2024-08-21 11:08:22.913475+00	6	Sanja	3		4	1
14	2024-08-21 11:08:22.913499+00	7	Sladja	3		4	1
15	2024-08-21 11:08:22.913513+00	5	sony	3		4	1
16	2024-08-21 14:18:27.105703+00	14	Gooseberry Bush	2	[{"changed": {"fields": ["In stock"]}}]	13	1
17	2024-08-21 15:37:59.328294+00	11	Lemon Tree	2	[{"changed": {"fields": ["In stock"]}}]	13	1
18	2024-08-21 15:40:44.440447+00	11	Lemon Tree	2	[{"changed": {"fields": ["In stock"]}}]	13	1
19	2024-08-23 08:28:04.595441+00	1	Red Climbing Rose	2	[{"changed": {"fields": ["Category", "Sun preference", "In stock"]}}]	13	1
20	2024-08-23 08:32:26.119952+00	2	White Climbing Rose	2	[{"changed": {"fields": ["Category", "Sun preference"]}}]	13	1
21	2024-08-24 07:28:05.957565+00	12	Cart 12 for session z1qivkdppftmqesac5cnd4br6vxf2j68	3		14	1
22	2024-08-24 07:28:05.957616+00	11	Cart 11 for session yrqcikdfobv2gyx57cx0rq6aximud72f	3		14	1
23	2024-08-24 07:28:05.957635+00	10	Cart 10 for session mzhuu8i3jk5ro3qjfpjmeap9lsog9y72	3		14	1
24	2024-08-24 07:28:05.95765+00	9	Cart 9 for session ks08bxdfcv3l6nur168wpoqdho6urxg5	3		14	1
25	2024-08-24 07:28:05.957664+00	8	Cart 8 for session 0vwszvf4s1s0p4o3z3womaexfv3a0iwt	3		14	1
26	2024-08-24 07:28:05.957679+00	7	Cart 7 for session h99c6zthpiuav6jrgz3l37b3u3mwtjha	3		14	1
27	2024-08-24 07:28:05.957692+00	6	Cart 6 for session 2peef7dfcp3m6b4xetq6ykxbq0mbnup0	3		14	1
28	2024-08-24 07:28:05.957706+00	5	Cart 5 for session i4hqhyrb02ub6lcy3orx0k5bisba74no	3		14	1
29	2024-08-24 07:28:05.95772+00	4	Cart 4 for session 21e45sf481ctwebwzgm7vg8dzyhtfavx	3		14	1
30	2024-08-24 07:28:05.957734+00	3	Cart 3 for session ahk4ip96db0nxb2c5j1zac1puai6fd86	3		14	1
31	2024-08-24 07:28:05.957748+00	2	Cart 2 for session wavxkrfmn3725juhjpyqwy7ikh57orl4	3		14	1
32	2024-08-24 07:28:05.957764+00	1	Cart 1 for nikola	3		14	1
33	2024-08-24 07:30:56.13475+00	13	Cart 13 for nikola	3		14	1
34	2024-08-24 07:36:08.986456+00	14	Cart 14 for nikola	3		14	1
35	2024-08-24 07:39:24.136637+00	15	Cart 15 for nikola	3		14	1
36	2024-08-24 07:42:14.064608+00	16	Cart 16 for nikola	3		14	1
37	2024-08-24 07:43:59.379865+00	17	Cart 17 for nikola	3		14	1
38	2024-08-24 08:18:57.898096+00	18	Cart 18 for nikola	3		14	1
39	2024-08-24 08:20:02.072445+00	19	Cart 19 for nikola	3		14	1
40	2024-08-24 13:53:15.542049+00	10	Cherry Tree	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
41	2024-08-24 13:53:41.800005+00	9	Maple Tree	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
42	2024-08-24 13:55:20.252487+00	8	Oak Tree	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
43	2024-08-24 13:55:39.884508+00	7	Marigold	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
44	2024-08-24 13:56:14.593815+00	6	Lavender	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
45	2024-08-24 13:56:33.958493+00	5	Sunflower	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
46	2024-08-24 13:57:22.357469+00	4	Pink Rose	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
47	2024-08-24 13:57:38.897701+00	3	Yellow Rose	2	[{"changed": {"fields": ["Category", "Sun preference", "Image"]}}]	13	1
48	2024-08-24 14:05:48.571316+00	2	White Rose	2	[{"changed": {"fields": ["Name", "Description", "Image"]}}]	13	1
49	2024-08-24 14:05:56.204158+00	3	Yellow Rose	2	[]	13	1
50	2024-08-24 14:07:24.760891+00	1	Red  Rose	2	[{"changed": {"fields": ["Name", "Description", "Image"]}}]	13	1
51	2024-08-24 14:12:47.77311+00	8	Oak Tree	2	[{"changed": {"fields": ["Price", "Discount", "In stock"]}}]	13	1
52	2024-08-24 14:15:23.731145+00	7	Marigold	2	[{"changed": {"fields": ["Image"]}}]	13	1
53	2024-08-24 14:44:25.603799+00	7	Marigold	2	[{"changed": {"fields": ["Image"]}}]	13	1
54	2024-08-25 08:22:53.10915+00	1	Review for Yellow Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
55	2024-08-25 08:27:11.216456+00	4	Comment by nikola on Review for Yellow Rose by nikola	3		24	1
56	2024-08-25 08:27:11.216508+00	3	Comment by nikola on Review for Yellow Rose by nikola	3		24	1
57	2024-08-25 08:27:11.216531+00	2	Comment by nikola on Review for Yellow Rose by nikola	3		24	1
58	2024-08-25 09:02:40.165307+00	2	Review for Yellow Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
59	2024-08-25 10:34:24.09487+00	3	Review for Lemon Tree by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
60	2024-08-25 10:46:40.779945+00	5	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
61	2024-08-25 11:00:19.264827+00	6	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
62	2024-08-25 11:09:08.465708+00	7	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
63	2024-08-25 11:41:15.550265+00	7	Review for Red  Rose by nikola	3		25	1
64	2024-08-25 11:41:15.550308+00	6	Review for Red  Rose by nikola	3		25	1
65	2024-08-25 11:41:15.550327+00	5	Review for Red  Rose by nikola	3		25	1
66	2024-08-25 11:41:15.550343+00	4	Review for Lemon Tree by nikola	3		25	1
67	2024-08-25 11:41:15.550359+00	3	Review for Lemon Tree by nikola	3		25	1
68	2024-08-25 11:41:15.550373+00	2	Review for Yellow Rose by nikola	3		25	1
69	2024-08-25 11:41:15.550386+00	1	Review for Yellow Rose by nikola	3		25	1
70	2024-08-25 11:42:31.705466+00	8	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
71	2024-08-25 12:06:34.193681+00	9	Review for Yellow Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
72	2024-08-26 08:04:37.745006+00	11	Review for Yellow Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
73	2024-08-26 08:06:27.063979+00	8	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
74	2024-08-26 08:10:53.711389+00	12	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
75	2024-08-26 08:15:53.92442+00	13	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
76	2024-08-26 08:24:15.738408+00	13	Review for Red  Rose by nikola	3		25	1
77	2024-08-26 08:24:15.738453+00	12	Review for Red  Rose by nikola	3		25	1
78	2024-08-26 08:24:15.738469+00	11	Review for Yellow Rose by nikola	3		25	1
79	2024-08-26 08:24:15.738484+00	10	Review for Yellow Rose by nikola	3		25	1
80	2024-08-26 08:24:15.738497+00	9	Review for Yellow Rose by nikola	3		25	1
81	2024-08-26 08:24:15.738511+00	8	Review for Red  Rose by nikola	3		25	1
82	2024-08-26 08:32:54.81964+00	14	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
83	2024-08-26 08:33:44.936319+00	14	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
84	2024-08-26 08:34:34.198657+00	15	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
85	2024-08-26 08:53:19.019188+00	14	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
86	2024-08-26 08:53:51.647763+00	16	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
87	2024-08-26 11:47:49.001171+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
88	2024-08-26 11:50:22.789368+00	16	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
89	2024-08-26 11:51:34.969104+00	16	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
90	2024-08-26 11:55:46.777489+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
91	2024-08-26 11:56:39.853606+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
92	2024-08-26 12:04:19.593065+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
93	2024-08-26 12:14:22.264717+00	18	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
94	2024-08-26 12:15:33.803103+00	15	Review for Red  Rose by nikola	3		25	1
95	2024-08-26 12:15:33.803146+00	14	Review for Red  Rose by nikola	3		25	1
96	2024-08-26 12:15:50.652105+00	19	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
97	2024-08-26 12:16:44.943152+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
98	2024-08-26 12:17:36.528333+00	18	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
99	2024-08-26 12:21:11.784441+00	20	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
100	2024-08-26 12:22:51.052311+00	19	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
101	2024-08-26 12:28:07.311768+00	17	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
102	2024-08-26 12:30:28.252587+00	20	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Comment"]}}]	25	1
103	2024-08-26 12:31:53.762082+00	21	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
104	2024-08-26 12:54:21.339209+00	27	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
105	2024-08-28 07:26:31.546422+00	32	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
106	2024-08-28 07:27:03.390746+00	31	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
107	2024-08-28 07:29:29.404671+00	30	Review for Red  Rose by kile	2	[{"changed": {"fields": ["Is approved"]}}]	25	1
108	2024-08-28 08:25:58.870989+00	10	Comment by nikola on Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	24	1
109	2024-08-28 11:13:35.850826+00	34	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Rating", "Status"]}}]	25	1
110	2024-08-29 10:34:41.637281+00	1	Conversation between safeT and Superuser nikola	1	[{"added": {}}]	33	1
111	2024-08-29 18:40:58.822413+00	2	Conversation between bosko and nikola started at 2024-08-29 14:36:20.820824+00:00	3		33	1
112	2024-08-29 18:40:58.822467+00	1	Conversation between safeT and nikola started at 2024-08-29 11:59:44.698062+00:00	3		33	1
113	2024-08-29 21:28:21.622754+00	60	Message from nikola at 2024-08-29 21:28:21.490310+00:00	1	[{"added": {}}]	34	1
114	2024-08-30 10:09:35.317946+00	6	Conversation between kile and kile started at 2024-08-29 21:49:03.506179+00:00	3		33	1
115	2024-08-30 10:09:35.317996+00	5	Conversation between nikola and nikola started at 2024-08-29 21:28:31.365306+00:00	3		33	1
116	2024-08-30 10:09:35.318019+00	4	Conversation between safeT and safeT started at 2024-08-29 20:49:27.786551+00:00	3		33	1
117	2024-08-30 22:35:39.92222+00	95	Message from nikola at 2024-08-30 21:09:14.596440+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
118	2024-08-30 22:38:53.949028+00	95	Message from nikola at 2024-08-30 21:09:14.596440+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
119	2024-08-30 22:39:33.447307+00	94	Message from marko at 2024-08-30 15:07:47.392630+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
120	2024-08-30 22:45:50.509891+00	95	Message from nikola at 2024-08-30 21:09:14.596440+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
121	2024-08-30 22:49:16.979494+00	95	Message from nikola at 2024-08-30 21:09:14.596440+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
122	2024-08-30 23:00:53.129442+00	95	Message from nikola at 2024-08-30 21:09:14.596440+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
123	2024-08-31 07:58:26.164342+00	1	Asham Misic	1	[{"added": {}}]	35	1
124	2024-08-31 08:58:35.474141+00	4	brko brkati	1	[{"added": {}}]	35	1
125	2024-08-31 08:59:45.751404+00	5	Sila asa	1	[{"added": {}}]	35	1
126	2024-08-31 09:09:14.284317+00	5	Sila asa	2	[{"changed": {"fields": ["Age"]}}]	35	1
127	2024-08-31 09:12:57.960632+00	4	brko brkati	2	[{"changed": {"fields": ["Age"]}}]	35	1
128	2024-08-31 09:16:10.928503+00	5	Sila asad	2	[{"changed": {"fields": ["Last name", "Age"]}}]	35	1
129	2024-08-31 09:18:56.857573+00	5	Sila asad	2	[{"changed": {"fields": ["Age"]}}]	35	1
130	2024-08-31 09:22:20.329911+00	5	Sila asad	2	[{"changed": {"fields": ["Age"]}}]	35	1
131	2024-08-31 09:23:34.190362+00	5	Sila LAsi	2	[{"changed": {"fields": ["Last name"]}}]	35	1
132	2024-08-31 09:24:24.763045+00	2	CAsh Antoinou	2	[{"changed": {"fields": ["First name", "Age", "Email"]}}]	35	1
133	2024-08-31 09:43:43.607367+00	3	spike Antoinou	2	[{"changed": {"fields": ["First name"]}}]	35	1
134	2024-08-31 10:09:24.941009+00	5	Sila LAsi	2	[{"changed": {"fields": ["Age"]}}]	35	1
135	2024-08-31 11:00:55.285339+00	5	Sila LAsi	2	[{"changed": {"fields": ["Age"]}}]	35	1
136	2024-08-31 11:15:43.808412+00	1	Asham Misic	2	[{"changed": {"fields": ["Age"]}}]	35	1
137	2024-08-31 13:30:10.158178+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "5 of White Rose", "fields": ["Quantity"]}}]	14	1
138	2024-08-31 13:31:26.991279+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "6 of White Rose", "fields": ["Quantity"]}}]	14	1
139	2024-08-31 13:34:41.978063+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "13 of White Rose", "fields": ["Quantity"]}}]	14	1
140	2024-08-31 13:37:51.010513+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "9 of White Rose", "fields": ["Quantity"]}}]	14	1
141	2024-08-31 13:43:10.963182+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "33 of White Rose", "fields": ["Quantity"]}}]	14	1
142	2024-08-31 14:16:19.649918+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "8 of White Rose", "fields": ["Quantity"]}}]	14	1
143	2024-08-31 14:18:48.642518+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "17 of White Rose", "fields": ["Quantity"]}}]	14	1
144	2024-08-31 14:23:53.17011+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "1 of White Rose", "fields": ["Quantity"]}}]	14	1
145	2024-08-31 14:24:32.064912+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "25 of White Rose", "fields": ["Quantity"]}}]	14	1
146	2024-08-31 14:26:17.395798+00	20	Cart 20 for nikola	2	[{"changed": {"name": "cart item", "object": "39 of White Rose", "fields": ["Quantity"]}}]	14	1
147	2024-08-31 15:00:46.591608+00	20	Cart 20 for nikola	3		14	1
148	2024-08-31 15:06:58.666405+00	104	2 of White Rose	1	[{"added": {}}]	15	1
149	2024-09-03 17:19:20.950128+00	26	Cart 26 for nikola	2	[{"changed": {"name": "cart item", "object": "1 of Black Currant Bush", "fields": ["Quantity"]}}]	14	1
150	2024-09-04 11:54:31.908629+00	2	White Rose	2	[{"changed": {"fields": ["In stock"]}}]	13	1
151	2024-09-04 21:43:28.131423+00	10	Cherry Tree	2	[{"changed": {"fields": ["In stock"]}}]	13	1
152	2024-09-05 13:17:07.352874+00	41	Review for Red  Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
153	2024-09-05 13:19:35.361518+00	42	Review for White Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
154	2024-09-05 13:31:03.302933+00	13	Comment by nikola on Review for White Rose by nikola	2	[{"changed": {"fields": ["Status"]}}]	24	1
155	2024-09-09 06:50:18.906111+00	15	Black Currant Bush	2	[{"changed": {"fields": ["Is in stock"]}}]	13	1
156	2024-09-09 11:54:16.573141+00	14	Gooseberry Bush	2	[{"changed": {"fields": ["Image"]}}]	13	1
157	2024-09-09 11:57:13.509333+00	12	Blueberry Bush	2	[{"changed": {"fields": ["Is in stock", "Image"]}}]	13	1
158	2024-09-09 11:59:26.799801+00	11	Lemon Tree	2	[{"changed": {"fields": ["Is in stock", "Image"]}}]	13	1
159	2024-09-16 11:35:31.197615+00	117	1 of Red  Rose	2	[{"changed": {"fields": ["Deleted"]}}]	15	1
160	2024-09-16 11:36:22.172319+00	26	Cart 26 for nikola	2	[{"changed": {"name": "cart item", "object": "22 of White Rose", "fields": ["Deleted"]}}]	14	1
161	2024-09-16 12:06:14.54346+00	117	1 of Red  Rose	3		15	1
162	2024-09-16 12:06:14.543528+00	116	1 of Lavender	3		15	1
163	2024-09-16 12:06:14.54355+00	114	20 of Yellow Rose	3		15	1
164	2024-09-16 12:06:14.543567+00	113	24 of Cherry Tree	3		15	1
165	2024-09-16 12:06:14.543582+00	112	12 of Pink Rose	3		15	1
166	2024-09-16 12:06:14.543597+00	111	6 of Lavender	3		15	1
167	2024-09-16 12:06:14.543611+00	110	1 of Oak Tree	3		15	1
168	2024-09-16 12:06:14.543626+00	109	18 of Raspberry Bush	3		15	1
169	2024-09-16 12:06:14.543649+00	108	6 of Marigold	3		15	1
170	2024-09-16 12:06:14.543667+00	107	13 of Sunflower	3		15	1
171	2024-09-16 12:06:14.543681+00	106	9 of Maple Tree	3		15	1
172	2024-09-16 12:06:14.543696+00	105	76 of Black Currant Bush	3		15	1
173	2024-09-16 12:06:14.54371+00	104	22 of White Rose	3		15	1
174	2024-09-16 12:06:14.543724+00	96	1 of Oak Tree	3		15	1
175	2024-09-16 12:06:14.543737+00	95	9 of Black Currant Bush	3		15	1
176	2024-09-16 12:06:14.543751+00	88	1 of White Rose	3		15	1
177	2024-09-16 12:06:14.543764+00	87	1 of Marigold	3		15	1
178	2024-09-16 12:06:14.543777+00	86	1 of Black Currant Bush	3		15	1
179	2024-09-16 12:06:14.543802+00	83	12 of Oak Tree	3		15	1
180	2024-09-16 12:06:39.343576+00	41	Cart 41 for session 363w2y1puwtda71vgk0rz4dx0vqzim4b	3		14	1
181	2024-09-16 12:06:39.343637+00	40	Cart 40 for session ek6n43nbpinflozdpxktvktfmvlcjdj3	3		14	1
182	2024-09-16 12:06:39.343657+00	39	Cart 39 for tijana	3		14	1
183	2024-09-16 12:06:39.343674+00	26	Cart 26 for nikola	3		14	1
184	2024-09-16 12:06:39.343689+00	25	Cart 25 for kile	3		14	1
185	2024-09-16 12:06:39.343704+00	24	Cart 24 for session p4qpy4bb1ydn9lllnd5bet7c8wiyy6wm	3		14	1
186	2024-09-16 12:06:39.343718+00	23	Cart 23 for session ew5lqks5tnu8c1d7xuont8gvh2wi70yg	3		14	1
187	2024-09-16 12:06:39.343732+00	22	Cart 22 for Sudo	3		14	1
188	2024-09-16 12:06:39.343746+00	21	Cart 21 for session gvfesnbze1uv5zpdnuugsajpj4ojd7ht	3		14	1
189	2024-09-16 12:12:10.346076+00	42	Cart 42 for nikola	2	[{"added": {"name": "cart item", "object": "1 of Lavender"}}]	14	1
190	2024-09-16 15:37:22.448025+00	43	Cart 43 for session 363w2y1puwtda71vgk0rz4dx0vqzim4b	3		14	1
191	2024-09-16 15:37:22.448076+00	42	Cart 42 for nikola	3		14	1
192	2024-09-17 16:58:29.986623+00	44	Cart 44 for nikola	3		14	1
193	2024-09-17 18:34:37.643021+00	46	Cart 46 for nikola	3		14	1
194	2024-09-18 11:50:16.48267+00	32	5 of Yellow Rose	1	[{"added": {}}]	15	1
195	2024-09-24 11:54:54.654767+00	16	nikica	2	[{"changed": {"fields": ["Is in stock"]}}]	13	1
196	2024-09-24 17:45:20.169963+00	44	Review by nikola	3		25	1
197	2024-09-24 17:45:20.170014+00	43	Review by nikola	3		25	1
198	2024-09-24 17:45:20.170034+00	42	Review by nikola	3		25	1
199	2024-09-24 17:45:20.17005+00	41	Review by nikola	3		25	1
200	2024-09-24 17:45:20.170065+00	40	Review by nikola	3		25	1
201	2024-09-24 17:45:20.170079+00	39	Review by nikola	3		25	1
202	2024-09-24 17:45:20.170092+00	38	Review by nikola	3		25	1
203	2024-09-24 17:45:20.170105+00	37	Review by nikola	3		25	1
204	2024-09-24 17:45:20.170118+00	30	Review by kile	3		25	1
205	2024-09-24 17:45:20.17013+00	29	Review by nikola	3		25	1
206	2024-09-24 17:45:20.170143+00	28	Review by nikola	3		25	1
207	2024-09-24 17:45:20.170156+00	27	Review by nikola	3		25	1
208	2024-09-24 17:45:58.772503+00	45	Review by nikola	1	[{"added": {}}]	25	1
209	2024-09-24 17:49:42.141518+00	14	Comment by safeT on review 45	1	[{"added": {}}]	24	1
210	2024-09-26 10:49:05.575547+00	46	Review by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
211	2024-09-26 10:49:42.184697+00	46	Review by nikola	2	[{"changed": {"fields": ["Status"]}}]	25	1
212	2024-09-27 13:02:38.565529+00	112	Message from nikola at 2024-09-27 13:02:38.433979+00:00	1	[{"added": {}}]	34	1
213	2024-09-27 14:28:29.079465+00	115	Message from marko at 2024-09-27 14:28:28.943865+00:00	1	[{"added": {}}]	34	1
438	2024-10-23 14:05:03.318417+00	74	30346F1BE99F464E9E364C57EB147406	3		23	1
214	2024-09-27 14:52:53.261637+00	117	Message from nikola at 2024-09-27 14:52:53.129301+00:00	1	[{"added": {}}]	34	1
215	2024-09-27 15:05:05.852033+00	118	Message from marko at 2024-09-27 15:05:05.719019+00:00	1	[{"added": {}}]	34	1
216	2024-09-28 09:20:13.380585+00	119	Message from nikola at 2024-09-28 09:20:13.240718+00:00	1	[{"added": {}}]	34	1
217	2024-09-28 09:25:59.680157+00	43	Message from chatbot at 2024-08-29 18:41:54.878576+00:00	3		34	1
218	2024-09-28 09:59:23.498311+00	123	Message from safeT at 2024-09-28 09:59:23.360545+00:00	1	[{"added": {}}]	34	1
219	2024-09-28 10:00:05.749212+00	124	Message from safeT at 2024-09-28 10:00:05.611476+00:00	1	[{"added": {}}]	34	1
220	2024-09-28 11:15:55.697595+00	44	Message from safeT at 2024-08-29 20:48:30.639441+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
221	2024-09-28 11:16:33.37574+00	67	Message from nikola at 2024-08-29 22:33:26.114009+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
222	2024-09-28 11:16:52.641299+00	89	Message from marko at 2024-08-30 10:35:11.452163+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
223	2024-09-28 11:37:58.127456+00	113	Message from marko at 2024-09-27 13:57:20.277707+00:00	2	[{"changed": {"fields": ["Seen"]}}]	34	1
224	2024-09-28 13:30:34.916305+00	15	Comment by nikola on review 47	1	[{"added": {}}]	24	1
225	2024-09-30 14:57:24.031531+00	16	Comment by Miki on review 47	1	[{"added": {}}]	24	1
226	2024-10-02 10:05:30.69398+00	37	Comment by nikola on review 48	3		24	1
227	2024-10-02 10:05:30.694028+00	36	Comment by nikola on review 48	3		24	1
228	2024-10-02 10:05:30.694047+00	35	Comment by nikola on review 48	3		24	1
229	2024-10-02 10:05:30.694063+00	34	Comment by nikola on review 48	3		24	1
230	2024-10-02 10:05:30.694077+00	33	Comment by nikola on review 48	3		24	1
231	2024-10-02 10:05:30.694091+00	32	Comment by nikola on review 47	3		24	1
232	2024-10-02 10:05:30.694105+00	31	Comment by nikola on review 47	3		24	1
233	2024-10-02 10:05:30.694119+00	30	Comment by nikola on review 47	3		24	1
234	2024-10-02 10:05:30.694133+00	29	Comment by nikola on review 47	3		24	1
235	2024-10-02 10:05:30.694146+00	28	Comment by nikola on review 47	3		24	1
236	2024-10-02 10:05:30.69416+00	27	Comment by nikola on review 47	3		24	1
237	2024-10-02 10:05:30.694174+00	26	Comment by nikola on review 47	3		24	1
238	2024-10-02 10:05:30.694186+00	25	Comment by nikola on review 48	3		24	1
239	2024-10-02 10:05:30.694199+00	24	Comment by nikola on review 48	3		24	1
240	2024-10-02 10:05:30.694212+00	23	Comment by nikola on review 47	3		24	1
241	2024-10-02 10:05:30.694224+00	22	Comment by nikola on review 47	3		24	1
242	2024-10-02 10:05:30.694237+00	21	Comment by nikola on review 48	3		24	1
243	2024-10-02 10:05:30.694249+00	20	Comment by nikola on review 47	3		24	1
244	2024-10-02 10:05:30.694263+00	19	Comment by nikola on review 47	3		24	1
245	2024-10-02 10:05:30.694276+00	18	Comment by nikola on review 47	3		24	1
246	2024-10-02 10:05:30.694289+00	17	Comment by nikola on review 47	3		24	1
247	2024-10-02 10:05:30.694303+00	16	Comment by Miki on review 47	3		24	1
248	2024-10-02 10:05:30.694316+00	15	Comment by nikola on review 47	3		24	1
249	2024-10-04 19:46:20.141902+00	139	Message from safeT at 2024-10-04 19:46:20.011870+00:00	1	[{"added": {}}]	34	1
250	2024-10-05 08:38:02.330597+00	141	Message from marko at 2024-10-05 08:38:02.198784+00:00	1	[{"added": {}}]	34	1
251	2024-10-11 11:54:54.980675+00	47	Cart 47 for nikola	3		14	1
252	2024-10-11 11:57:06.577125+00	187	Cart 187 for nikola	3		14	1
253	2024-10-11 11:57:06.577218+00	186	Cart 186 for session hsjb9g53dg0j0px2vuy1q146srdkfjhw	3		14	1
254	2024-10-11 11:57:06.577239+00	185	Cart 185 for tijana	3		14	1
255	2024-10-11 11:57:06.577255+00	180	Cart 180 for session 4okv01yaqhptgvzm2kkjdntx3t5v455v	3		14	1
256	2024-10-11 11:57:06.577271+00	179	Cart 179 for session 24lxdc2faqpsek445e7sip1o8dij5msn	3		14	1
257	2024-10-11 11:57:06.577285+00	178	Cart 178 for session 125zgup0bqzq2tob9xn5h4a8dwl6qkqq	3		14	1
258	2024-10-11 11:57:06.577315+00	171	Cart 171 for session sfrqohxx180euyt2dl142n7rq6mo45pp	3		14	1
259	2024-10-11 11:57:06.57733+00	170	Cart 170 for session 5qzqhc63dje1zohc8i7broxjogd1prdy	3		14	1
260	2024-10-11 11:57:06.577344+00	169	Cart 169 for session ip399at6tvxce6ie4u216y8jq8my3602	3		14	1
261	2024-10-11 11:57:06.577357+00	168	Cart 168 for session 222m32moq7y2gq6yop48i2pvh5d3b825	3		14	1
262	2024-10-11 11:57:06.577371+00	167	Cart 167 for session dpn0f9j396b1xc516r1cyamsrdrtq1dj	3		14	1
263	2024-10-11 11:57:06.577385+00	166	Cart 166 for session 9vtgfductnsegylq7ek0qzxwikce2d4j	3		14	1
264	2024-10-11 11:57:06.577398+00	165	Cart 165 for session warj3v3xox4qtd4q36n9lzrl3d6ohbq4	3		14	1
265	2024-10-11 11:57:06.577412+00	164	Cart 164 for session xh212uyawrdgx12pww04miq8k6z6r4pk	3		14	1
266	2024-10-11 11:57:06.577424+00	163	Cart 163 for session 4yvemwd5pihceshq96c28awnfppaj4ez	3		14	1
267	2024-10-11 11:57:06.577452+00	162	Cart 162 for session 06q4qixv6ku1ycp17tdrk8id7ck4ml19	3		14	1
268	2024-10-11 11:57:06.577467+00	161	Cart 161 for session kvbmfrtbmixhef2rauokhcq4r0uqjsi5	3		14	1
269	2024-10-11 11:57:06.577481+00	160	Cart 160 for session 95cl02kletqsrrd162rhsmnmncik2v7z	3		14	1
270	2024-10-11 11:57:06.577495+00	159	Cart 159 for session 0lzr7b4noetxc0a8990sanc2k97b4gu3	3		14	1
271	2024-10-11 11:57:06.577509+00	158	Cart 158 for session z33y5i8xe53mmy0v3c7owejmldyn4uni	3		14	1
272	2024-10-11 11:57:06.577522+00	157	Cart 157 for session 44yxa2h76zxk4fsh6jr5jw6e96ixrnqn	3		14	1
273	2024-10-11 11:57:06.577536+00	156	Cart 156 for session yujoi1i62tirkt1pwml2p1tqxobpp33r	3		14	1
274	2024-10-11 11:57:06.577548+00	155	Cart 155 for session 9hrbzctici11vphipfn8fp5d7sttmur9	3		14	1
275	2024-10-11 11:57:06.577561+00	154	Cart 154 for session urvnrgdnmzqa5k5bmah0xzsem6wz46bx	3		14	1
276	2024-10-11 11:57:06.577575+00	153	Cart 153 for session fxzgx9gaasyn889wvv3n8v0nv638ua2i	3		14	1
277	2024-10-11 11:57:06.577589+00	152	Cart 152 for session vuci4mfclcjy4jxkqod0o8a3hm83kl7k	3		14	1
278	2024-10-11 11:57:06.577603+00	151	Cart 151 for session jbykth8p0gcbxun77nlw5d7b2vyovaq1	3		14	1
279	2024-10-11 11:57:06.577615+00	150	Cart 150 for session a1tnv2okw0pbbnnbq2fnpk8sfu8tjidk	3		14	1
280	2024-10-11 11:57:06.577628+00	149	Cart 149 for session by5t9xql61j6qgc5jngbkt0q1ecudzgk	3		14	1
281	2024-10-11 11:57:06.577641+00	148	Cart 148 for session d5youjhpzkyzoh4flui3y6ty59cmpy4u	3		14	1
282	2024-10-11 11:57:06.577654+00	147	Cart 147 for session 74m6ztgid52r1z623cj7xe1pftdna5ef	3		14	1
283	2024-10-11 11:57:06.577667+00	146	Cart 146 for session 6vua7m2iamu2tpn8gn9aok95z0xjaoxw	3		14	1
284	2024-10-11 11:57:06.57768+00	145	Cart 145 for session dm0suuco5n02y5dnf6uag0rn61x77u6j	3		14	1
285	2024-10-11 11:57:06.577692+00	144	Cart 144 for session oon7sjnt6a4khdhmhx8oq1xs4cy9gpvv	3		14	1
286	2024-10-11 11:57:06.577705+00	143	Cart 143 for session i6rcewtym0zj3uglzg1kgooa3sn8qpio	3		14	1
439	2024-10-23 14:05:03.318429+00	73	78123BEDF54D44098475D0B148DC1646	3		23	1
287	2024-10-11 11:57:06.577717+00	142	Cart 142 for session 16o0iivdy473p29g7qsijkfa2hqs2r0j	3		14	1
288	2024-10-11 11:57:06.57773+00	141	Cart 141 for session lmgy1h5487l2y8tdf6r04900oxzsj4jz	3		14	1
289	2024-10-11 11:57:06.577742+00	140	Cart 140 for session c88omc3nd83qqkwsnjzc00x5mhkug965	3		14	1
290	2024-10-11 11:57:06.577755+00	139	Cart 139 for session f61ly69e4zdo5bdsq8aabsxaptx53yod	3		14	1
291	2024-10-11 11:57:06.577767+00	138	Cart 138 for session 6594552sxkwq8tdvbio4893urvxw3nmo	3		14	1
292	2024-10-11 11:57:06.57778+00	137	Cart 137 for session m3yxx8oyzfmdm7y7n24peynb0tbccrbb	3		14	1
293	2024-10-11 11:57:06.577792+00	136	Cart 136 for session zvkmgejtmghvn1ojo5n0olcvopbpfe5a	3		14	1
294	2024-10-11 11:57:06.577805+00	135	Cart 135 for session olbptv4wao02db9asuh9qfiw6rp83wie	3		14	1
295	2024-10-11 11:57:06.577817+00	134	Cart 134 for session w48zsvnxo52t3g69bqh5oo52b7m06znu	3		14	1
296	2024-10-11 11:57:06.577829+00	133	Cart 133 for session 303wrjgsaee1dw0no3n4avni77t58bfx	3		14	1
297	2024-10-11 11:57:06.577841+00	132	Cart 132 for session fwk21ig080hed7hp7u4mq7tdgmc9zcln	3		14	1
298	2024-10-11 11:57:06.577853+00	131	Cart 131 for session e4hnzp3jaidpfp5dxiff2rref0fo3hb6	3		14	1
299	2024-10-11 11:57:06.577865+00	130	Cart 130 for session mp3ow6cmfopbssmxtxmh0l8r1f0ipnt2	3		14	1
300	2024-10-11 11:57:06.577877+00	129	Cart 129 for session x9j6ntm753kvoflrbxhrazo5rekdr23w	3		14	1
301	2024-10-11 11:57:06.57789+00	128	Cart 128 for session fn70scza9sqnvnfj1q6o4cpao6bu1nk0	3		14	1
302	2024-10-11 11:57:06.577902+00	127	Cart 127 for Bakir	3		14	1
303	2024-10-11 11:57:06.577915+00	126	Cart 126 for session c2umz9vu0kwnn2qljb0czwnughvstjih	3		14	1
304	2024-10-11 11:57:06.577928+00	125	Cart 125 for session r40nx45skwkx26trn76sunb658ri0hye	3		14	1
305	2024-10-11 11:57:06.57794+00	124	Cart 124 for session ak6nyqycht2ft562pn9w8k5hetbrg7ld	3		14	1
306	2024-10-11 11:57:06.577953+00	123	Cart 123 for Sanja	3		14	1
307	2024-10-11 11:57:06.577965+00	122	Cart 122 for session a2368aqfa948x4b578qhatso58moirj5	3		14	1
308	2024-10-11 11:57:06.577978+00	121	Cart 121 for session 02nfelm2nqblgmq6r5er3slovbxea3tl	3		14	1
309	2024-10-11 11:57:06.578004+00	120	Cart 120 for session 3wxy3la1d12u4h5nxjv4tjjovtbijjyf	3		14	1
310	2024-10-11 11:57:06.578017+00	119	Cart 119 for session r9tmch9dkuwmm1unpdf4ecisxtqq3kiw	3		14	1
311	2024-10-11 11:57:06.578029+00	118	Cart 118 for session lnitn9kh4kz6nskpcsq3jug3f76qgdme	3		14	1
312	2024-10-11 11:57:06.578041+00	117	Cart 117 for lozica	3		14	1
313	2024-10-11 11:57:06.578054+00	116	Cart 116 for session kziw3lmgli1pz68mkosua1fw4eyd5y3h	3		14	1
314	2024-10-11 11:57:06.578066+00	115	Cart 115 for session i344e4kxpkj0i1g7v5fsc14odyfslvm7	3		14	1
315	2024-10-11 11:57:06.578078+00	114	Cart 114 for session 9nod5r7g39mzx2s1k9ipsfdg8uh7yymc	3		14	1
316	2024-10-11 11:57:06.578091+00	113	Cart 113 for session pprz6pe96r2ox0ps9zi93cg5lo558uv8	3		14	1
317	2024-10-11 11:57:06.578106+00	112	Cart 112 for session 0l1a22s1a8egsssowcgjo8xtcyh3u4di	3		14	1
318	2024-10-11 11:57:06.578118+00	111	Cart 111 for session 9fevyusrffubc3n0mwn9ahp1wzb1fg27	3		14	1
319	2024-10-11 11:57:06.578131+00	110	Cart 110 for session lf5aabcenmp6bsh01i9ku08xu47hq1wj	3		14	1
320	2024-10-11 11:57:06.578143+00	109	Cart 109 for session cxfh8s2qufbtnkml0n7cfuvcq78wucr0	3		14	1
321	2024-10-11 11:57:06.578155+00	108	Cart 108 for session nx2jq93j0zoj9eaqtnj03ci56ajtttq8	3		14	1
322	2024-10-11 11:57:06.578167+00	107	Cart 107 for session b5gix01i5soazei5941paepkhrjpsskv	3		14	1
323	2024-10-11 11:57:06.578179+00	106	Cart 106 for session lw3ewnegg5qx630yox88mq3ozxm095zu	3		14	1
324	2024-10-11 11:57:06.578192+00	105	Cart 105 for session izo063i48dlepajllflv2dn2vwqmjmbb	3		14	1
325	2024-10-11 11:57:06.578204+00	104	Cart 104 for session 0h5ooq7dhhjnhsjlgd5hz0mgkhk4g490	3		14	1
326	2024-10-11 11:57:06.578216+00	103	Cart 103 for session hhnr1nvq32vf16uftkuhafczie4k67r2	3		14	1
327	2024-10-11 11:57:06.578228+00	102	Cart 102 for session panjj8ge23t9goo075dmjqmilbb1bwxw	3		14	1
328	2024-10-11 11:57:06.578241+00	101	Cart 101 for session tvbqnkfy1722uguyqwc64qaryf1xovi3	3		14	1
329	2024-10-11 11:57:06.578254+00	100	Cart 100 for session q5ucqcspvl6xenwivw09vm07ukirra3f	3		14	1
330	2024-10-11 11:57:06.578265+00	99	Cart 99 for session 6wlqbnrin0eaumia1u1xttjeuwiq12hs	3		14	1
331	2024-10-11 11:57:06.578278+00	98	Cart 98 for session abuhmowyeke2nmk241ywlx0l21x6bdij	3		14	1
332	2024-10-11 11:57:06.578289+00	97	Cart 97 for session ps9942r8e7yxr2xn3g7xw4li418jytn8	3		14	1
333	2024-10-11 11:57:06.578301+00	96	Cart 96 for session g75wr5e6x04tz7lruczptaceyhowkkib	3		14	1
334	2024-10-11 11:57:06.578313+00	95	Cart 95 for session 9yl2okr487xm6k326ctiokfblk22s5wv	3		14	1
335	2024-10-11 11:57:06.578325+00	94	Cart 94 for session a8z9uyv71vvd3ssexjjnhgejq6ov9ckz	3		14	1
336	2024-10-11 11:57:06.578338+00	93	Cart 93 for session zctfvefdi08e075tbiynvzndm0d3glgu	3		14	1
337	2024-10-11 11:57:06.57835+00	92	Cart 92 for session 1h3000aqgieyc72hi37hrkq6xecylr37	3		14	1
338	2024-10-11 11:57:06.578361+00	91	Cart 91 for session qc540kqgrq9mg2svc5k2ljyp4gm80w71	3		14	1
339	2024-10-11 11:57:06.578373+00	90	Cart 90 for session v4l8822il2hr6jz175xyc6nt76isum7q	3		14	1
340	2024-10-11 11:57:06.578385+00	89	Cart 89 for session qsfzkv654kp2xj94h5opzq5k49dz407b	3		14	1
341	2024-10-11 11:57:06.578396+00	88	Cart 88 for session tzpb96ad72qd2q0xd9djm0thrxcx45o0	3		14	1
342	2024-10-11 11:57:06.578408+00	87	Cart 87 for session tzs3f1d0j77vsto5z81mntlwivjkye82	3		14	1
343	2024-10-11 11:57:06.57842+00	86	Cart 86 for session lp3am1rxwhbfum8uc9b69l05cmm945kv	3		14	1
344	2024-10-11 11:57:06.578432+00	85	Cart 85 for session 3994fxeky99q3n8sxydgcendzb3xred4	3		14	1
345	2024-10-11 11:57:06.578443+00	84	Cart 84 for session a9tgv2yr1ehskk68h7p1fe1fnh8hcuhr	3		14	1
346	2024-10-11 11:57:06.578455+00	83	Cart 83 for session 0iz6q2qtxvxvndxzfqodrt24lwaw6dts	3		14	1
347	2024-10-11 11:57:06.578467+00	82	Cart 82 for session ewafjsamin5zcp0j6i8zarw1t5fuvgpi	3		14	1
348	2024-10-11 11:57:06.578478+00	81	Cart 81 for session ifc61imbumnrwri8ezzsffsedtwjiub0	3		14	1
349	2024-10-11 11:57:06.57849+00	80	Cart 80 for session yjuj62fjald6q5zamtp8cjccjv3m9nzu	3		14	1
350	2024-10-11 11:57:06.578502+00	79	Cart 79 for session ln42untxmhbyp0ac1mp7dost5t5dbv42	3		14	1
351	2024-10-11 11:57:06.578514+00	78	Cart 78 for session dmpiz0u0emwmy19d1fp565clun6rs8ir	3		14	1
352	2024-10-11 11:57:44.746382+00	77	Cart 77 for session us8780ghb05lkpznaoldxokjtifvlyl9	3		14	1
353	2024-10-11 11:57:44.746436+00	76	Cart 76 for session v3bx82mgn2vrt2ys5ozqtyqpritur5y3	3		14	1
354	2024-10-11 11:57:44.746461+00	75	Cart 75 for session f7lnfusa9hmse9kfr4qneo0a0f9spl2j	3		14	1
355	2024-10-11 11:57:44.746485+00	74	Cart 74 for session 3e3j7rf9mry84hfdqk5ljf2828y72f4q	3		14	1
356	2024-10-11 11:57:44.746508+00	73	Cart 73 for session 0fknxiua5yu0p77q87vmcga1wxvtnbct	3		14	1
357	2024-10-11 11:57:44.746531+00	72	Cart 72 for session 9tankwtppfhfqx4b3etnli0uhqxpuyk7	3		14	1
358	2024-10-11 11:57:44.746554+00	71	Cart 71 for session 2oud1i0fd8ou56t9py9wzbsykkkg2bb9	3		14	1
359	2024-10-11 11:57:44.746577+00	70	Cart 70 for marko	3		14	1
360	2024-10-11 11:57:44.746599+00	69	Cart 69 for session wdvuhdk0d4m6eaglz01mgamdyy7l9hdq	3		14	1
361	2024-10-11 11:57:44.746621+00	68	Cart 68 for session bvncwhsnevqm7zr8bol05k1stuwq4spz	3		14	1
362	2024-10-11 11:57:44.746643+00	67	Cart 67 for session z8w3u61s3j2gpt1r2snrj5pxf72fjbg8	3		14	1
363	2024-10-11 11:57:44.746664+00	66	Cart 66 for session 4yowqte6y8b69naoxstkum1n640ml2nc	3		14	1
364	2024-10-11 11:57:44.746685+00	65	Cart 65 for session aegp8to38yiat2go1b6mpxj21gikf8wl	3		14	1
365	2024-10-11 11:57:44.746707+00	64	Cart 64 for session qnt3pvksyq051mnnki66x9k5w7bb57m0	3		14	1
366	2024-10-11 11:57:44.746728+00	63	Cart 63 for session nc5nm1kbifmp26ijhtaqvihtt8ixxgax	3		14	1
367	2024-10-11 11:57:44.74675+00	62	Cart 62 for session vkg24h5i64qxlbvsbyrgbpvfo8qcbdgn	3		14	1
368	2024-10-11 11:57:44.746771+00	61	Cart 61 for session 0fqv7fdk4gzjzyuc5fhaf7exe668g7ba	3		14	1
369	2024-10-11 11:57:44.746794+00	60	Cart 60 for session nwbic20ewac4vm8dxbis7wfn0byp54qm	3		14	1
370	2024-10-11 11:57:44.746816+00	59	Cart 59 for session n6lii5wf1xoemg5r1w72ltp0tnd9on97	3		14	1
371	2024-10-11 11:57:44.746838+00	58	Cart 58 for session 34wsv5tjtnrbjbni0i5n9u5plx7k0qd6	3		14	1
372	2024-10-11 11:57:44.74686+00	57	Cart 57 for session mzawnihvmapmtf1pqhqofsnl90oxp504	3		14	1
373	2024-10-11 11:57:44.746881+00	56	Cart 56 for session 6n6wcl629rydcesuuf9gmlw6mfecgq06	3		14	1
374	2024-10-11 11:57:44.746903+00	55	Cart 55 for session 1bhy76skpdyjb78bcyg83tvagisdec2o	3		14	1
375	2024-10-11 11:57:44.746924+00	54	Cart 54 for session zsc1uwjmdj74e2se7yz5qhj4mo2fqq3a	3		14	1
376	2024-10-11 11:57:44.746946+00	53	Cart 53 for session jrd9uhijma4fvnsdl2v7n688lq4ahwaa	3		14	1
377	2024-10-11 11:57:44.746969+00	52	Cart 52 for session udirdxvsymt9xsmk4dd2nm5mti3cj3ba	3		14	1
378	2024-10-11 11:57:44.746991+00	51	Cart 51 for session tmj7wr001tvkl2m9srrgrp56z78nt1wh	3		14	1
379	2024-10-11 11:57:44.747013+00	50	Cart 50 for safeT	3		14	1
380	2024-10-11 11:57:44.747036+00	49	Cart 49 for session hofw2q6mv736pwpkxflse0wrl71ks4xz	3		14	1
381	2024-10-11 11:58:12.083762+00	188	Cart 188 for nikola	3		14	1
382	2024-10-22 14:20:27.472591+00	87	FB678C69E4834F31A3AB76A7E24B90F2	2	[{"changed": {"fields": ["User profile"]}}]	23	1
383	2024-10-22 14:30:10.024084+00	94	0E37E53337D94856949653DC020AA2E3	2	[{"changed": {"fields": ["User profile"]}}]	23	1
384	2024-10-22 15:35:57.197275+00	106	2D91B18B43134AF6880A4E49F0C85CB8	3		23	1
385	2024-10-22 15:35:57.197325+00	104	2819907E9AD14998B0F0FEDDE3827E53	3		23	1
386	2024-10-22 15:35:57.197343+00	102	35ED11C5E4A440EE93225E283FB11FCC	3		23	1
387	2024-10-22 15:35:57.197357+00	100	5D7CC6970ACB416585C4C6D66F576171	3		23	1
388	2024-10-23 14:05:03.317771+00	128	7E2E03CB1E2147CEB1B51C09FC7F7353	3		23	1
389	2024-10-23 14:05:03.317813+00	127	DAFBF770630D4B17A5FAAB89F90C450F	3		23	1
390	2024-10-23 14:05:03.317831+00	126	E254FD4DE91243BF9A6B0C5316F39662	3		23	1
391	2024-10-23 14:05:03.317844+00	125	B709E864C98F445084BCFC2BAFB853D1	3		23	1
392	2024-10-23 14:05:03.317858+00	124	097A7F8514944512B59BF33D7D6B8B5B	3		23	1
393	2024-10-23 14:05:03.31787+00	123	0F46D1D625B642B3A348115EB180DF2D	3		23	1
394	2024-10-23 14:05:03.317881+00	122	EE84D704AA514C9D8D5106EEF38DA35F	3		23	1
395	2024-10-23 14:05:03.317893+00	121	EEDF8B0FFAE54038A759C7B3DF1067DF	3		23	1
396	2024-10-23 14:05:03.317905+00	120	75EA12C6AAFA4FF29FE8ED4416AF5088	3		23	1
397	2024-10-23 14:05:03.317917+00	119	DDC7420619BD4FF5AE79E5B3D65C8BDE	3		23	1
398	2024-10-23 14:05:03.317929+00	118	9FF614F21234482A840E515CEF9EE97A	3		23	1
399	2024-10-23 14:05:03.317941+00	117	9BB9B604FEA34A26B73FBC93F09EBCB6	3		23	1
400	2024-10-23 14:05:03.317952+00	116	342C14DBDFB147F7AFD0352440506E7F	3		23	1
401	2024-10-23 14:05:03.317964+00	115	EE089E7A73EB4FC39DD194EB59D10EC8	3		23	1
402	2024-10-23 14:05:03.317976+00	114	A7ECAF1BC56147928D87DF8D2C140BC3	3		23	1
403	2024-10-23 14:05:03.317988+00	113	972374AF1AC7481C957D6F454C8EE2D2	3		23	1
404	2024-10-23 14:05:03.318+00	112	5C490C016C644D71AF4B740A4A716268	3		23	1
405	2024-10-23 14:05:03.318012+00	111	0B53DC548586488999F80AE8B0CB4BD8	3		23	1
406	2024-10-23 14:05:03.318024+00	110	195A94584180412B934E324EB96AD487	3		23	1
407	2024-10-23 14:05:03.318036+00	109	EBFF0B2DDBD0461BB9ED73DBC03FBE15	3		23	1
408	2024-10-23 14:05:03.31806+00	108	543DA96BA132413F9AED7B6FA78E14E7	3		23	1
409	2024-10-23 14:05:03.318073+00	107	446EC0AD399B4D6793DEA79F65E53EF6	3		23	1
410	2024-10-23 14:05:03.318085+00	105	3A6DDC89CD15445C878190122E51EF61	3		23	1
411	2024-10-23 14:05:03.318097+00	103	B6E0EC665FE74597851AD05D7E527E28	3		23	1
412	2024-10-23 14:05:03.318109+00	101	6D58AED29689422DA5ABBADE8853DF2E	3		23	1
413	2024-10-23 14:05:03.318121+00	99	AF27AA026A594DA38D6487FDD23E4707	3		23	1
414	2024-10-23 14:05:03.318134+00	98	BB9BA657840F414A971F239BC4CEE7F8	3		23	1
415	2024-10-23 14:05:03.318145+00	97	D39B1696CCAD492EB95349BF36F71B9A	3		23	1
416	2024-10-23 14:05:03.318157+00	96	D2BC6C6FF2B944A6889B947A3209CD0F	3		23	1
417	2024-10-23 14:05:03.318169+00	95	C9AB6D5BF8244AC296DC56DD889D6BAD	3		23	1
418	2024-10-23 14:05:03.31818+00	94	0E37E53337D94856949653DC020AA2E3	3		23	1
419	2024-10-23 14:05:03.318192+00	93	62DBE2981E5843C1A677F2073A8A1429	3		23	1
420	2024-10-23 14:05:03.318204+00	92	3B207413F2C64535B65E99EFEEB20856	3		23	1
421	2024-10-23 14:05:03.318216+00	91	7A7B49905DD241F281F1A34EC8AC932A	3		23	1
422	2024-10-23 14:05:03.318228+00	90	D491009D20784CCCBA420C0F7F68CC8D	3		23	1
423	2024-10-23 14:05:03.31824+00	89	B5A83758CC0444478E33EC43A0969175	3		23	1
424	2024-10-23 14:05:03.318252+00	88	0BA392DF1012410A838EB49ACE13D94C	3		23	1
425	2024-10-23 14:05:03.318265+00	87	FB678C69E4834F31A3AB76A7E24B90F2	3		23	1
426	2024-10-23 14:05:03.318276+00	86	4E0915CCD5DD4BED982AE851C06BC4AD	3		23	1
427	2024-10-23 14:05:03.318288+00	85	5CD9F34293EE44C0BB49B847707AD5C8	3		23	1
428	2024-10-23 14:05:03.3183+00	84	78702878BA6D4B21A9FE2F62B607A05C	3		23	1
429	2024-10-23 14:05:03.318312+00	83	460BB44CF1654410A3CB2E17D9E9FDED	3		23	1
430	2024-10-23 14:05:03.318323+00	82	1A8982D82E8247EE93FAE24C06BA0F44	3		23	1
431	2024-10-23 14:05:03.318335+00	81	DE4E07EC6E454DE88EEE1D4354A6577C	3		23	1
432	2024-10-23 14:05:03.318347+00	80	CE41C1A49C3B40ABBAFA55A10A393018	3		23	1
433	2024-10-23 14:05:03.318358+00	79	0CD4DDB5AD3B488FB968674658A0D1D2	3		23	1
434	2024-10-23 14:05:03.31837+00	78	8E33443F32B84052A021A72F468A98C3	3		23	1
435	2024-10-23 14:05:03.318382+00	77	1E39D98A3D134F47AB688F90D74F9011	3		23	1
436	2024-10-23 14:05:03.318394+00	76	6A8BF181860E4E0497E0A88E1FF4765E	3		23	1
437	2024-10-23 14:05:03.318405+00	75	50B36F3ADA1A4EC9A371FD8D202EBBD4	3		23	1
440	2024-10-23 14:05:03.318441+00	72	3B38EADDDFD3440EA7C0497AD585F34B	3		23	1
441	2024-10-23 14:05:03.318453+00	71	E8AB6E569AEB41FD8CFFD10D14EC6C97	3		23	1
442	2024-10-23 14:05:03.318465+00	70	BC41AE87A9D44C848F6301471961E2C6	3		23	1
443	2024-10-23 14:05:03.318477+00	69	F817DDD9B3CA459BB9DAFF6FF7A4705B	3		23	1
444	2024-10-23 14:05:03.318489+00	68	362013AF0C944A6A8C7C94D1342024EF	3		23	1
445	2024-10-23 14:05:03.318501+00	67	BA6BA0EDAFAE47EB94FB1FFCF388261D	3		23	1
446	2024-10-23 14:05:03.318512+00	66	C13722269F1B4065BC003323B3A23069	3		23	1
447	2024-10-23 14:05:03.318523+00	65	317B31DB909E466EB17BF1F43C64E317	3		23	1
448	2024-10-23 14:05:03.318535+00	64	88A79F1D818F4C22BB2658727353B9C5	3		23	1
449	2024-10-23 14:05:03.318546+00	63	11741310273E464AB175917D97C19365	3		23	1
450	2024-10-23 14:05:03.318557+00	62	AAAE4CA54827455CB0F4F2A6838946D4	3		23	1
451	2024-10-23 14:05:03.318569+00	61	CF8EADEA43894FF3BA772BAD9B714C6D	3		23	1
452	2024-10-23 14:05:03.31858+00	60	F494261C42D54F7B98968EB84F8F7B48	3		23	1
453	2024-10-23 14:05:03.318592+00	59	697BB9997AA74C7A96870FA426EEA006	3		23	1
454	2024-10-23 14:05:03.318603+00	58	35DB0434EC8941D6ADA36B241633C794	3		23	1
455	2024-10-23 14:05:03.318615+00	57	D9FB876A0C9546199F72656AD924B261	3		23	1
456	2024-10-23 14:05:03.318626+00	56	2782AC52E2E54D078FEECD09D8DB04C7	3		23	1
457	2024-10-23 14:05:03.318638+00	55	D0C3E878FA634E0589FA3861114EB1BC	3		23	1
458	2024-10-23 14:05:03.318649+00	54	E8C42822BF4F477699DF1E342E336118	3		23	1
459	2024-10-23 14:05:03.31866+00	53	FD85EE177C4C4ABBA0C4414053B3469E	3		23	1
460	2024-10-23 14:05:03.318672+00	52	24FD92810A3645C0A51AF3A836E42DA6	3		23	1
461	2024-10-23 14:05:03.318684+00	51	AC38ADAA3A0747328A0B63312C5090C8	3		23	1
462	2024-10-23 14:05:03.318706+00	50	F9EAA35B01C04E55A03D10870E7F77A3	3		23	1
463	2024-10-23 14:05:03.318731+00	49	AA635DC6A9864214B826D3D4197626B9	3		23	1
464	2024-10-23 14:05:03.318743+00	48	30E7C52519024636BFC4D03F044CF653	3		23	1
465	2024-10-23 14:05:03.318756+00	47	4244DDBB4EBF49B3833A11A59619A8AC	3		23	1
466	2024-10-23 14:05:03.318767+00	46	55969AB5083F4D9F88A476BA4F6FAA95	3		23	1
467	2024-10-23 14:05:03.318779+00	45	677147E79883479B80BE8D1BD974450A	3		23	1
468	2024-10-23 14:05:03.31879+00	44	8408058C08BF4A349BF7FF522A3E09DC	3		23	1
469	2024-10-23 14:05:03.318801+00	43	AD599F791D9E4DFA93FEBCE3D175445F	3		23	1
470	2024-10-23 14:05:03.318838+00	42	519BE6A8F9444C1EB4F43E53B0A5E94B	3		23	1
471	2024-10-23 14:05:03.31885+00	41	2C57A9EDB74940FC891F83B4929A0C1F	3		23	1
472	2024-10-23 14:05:03.318861+00	40	8D80E7A13D3E4EF18A3C4A1B99FE31AD	3		23	1
473	2024-10-23 14:05:03.318872+00	39	341919DAFD444FE09A8EE9B254B950D4	3		23	1
474	2024-10-23 14:05:03.318884+00	38	7F105ACC0ADB4F15A41704B0EA653FA8	3		23	1
475	2024-10-23 14:05:03.318895+00	37	FEFFDF050A8B485DAEEDD5D969D6A1FD	3		23	1
476	2024-10-23 14:05:03.318906+00	36	C71DB962C87F47CDBB35423168F3C857	3		23	1
477	2024-10-23 14:05:03.318917+00	35	416841CD82984430B2576E5DDC5B6AEE	3		23	1
478	2024-10-23 14:05:03.318929+00	34	0A9E96BF21E5465BA748B2DA91613DD9	3		23	1
479	2024-10-23 14:05:03.318941+00	33	C89E0CD975104840B5EF03141FCDFFA6	3		23	1
480	2024-10-23 14:05:03.318952+00	32	58D74F394140488ABDEB794E7FB3F8A6	3		23	1
481	2024-10-23 14:05:03.318964+00	31	92F907BDE68C4A51AC0C51988AA45DDB	3		23	1
482	2024-10-23 14:05:03.318975+00	30	E954C783EB0E44B4A90F378752A3B9DB	3		23	1
483	2024-10-23 14:05:03.318986+00	29	535482AEFE684E5D8F0F4A18BF3C1BA7	3		23	1
484	2024-10-23 14:05:03.318998+00	28	59B932B1AC764341AF4F12BCF85ABEE6	3		23	1
485	2024-10-23 14:05:03.319008+00	27	92A0257CB5064781B6A877B3FD4222C0	3		23	1
486	2024-10-23 14:05:03.319019+00	26	62DBF1E37C9B40588341458642302381	3		23	1
487	2024-10-23 14:05:03.31903+00	25	E739CB1BE93D4B6FAC1CFBF73B29E03E	3		23	1
488	2024-10-25 14:24:07.863592+00	3	nikola	2	[{"changed": {"fields": ["Receives newsletter"]}}]	21	1
489	2024-10-25 14:43:41.532074+00	3	nikola	2	[]	21	1
490	2024-10-25 14:52:29.847549+00	3	nikola	2	[{"changed": {"fields": ["Email"]}}]	21	1
491	2024-10-25 14:59:44.130417+00	1	nikola	2	[{"changed": {"fields": ["Email address"]}}]	4	1
492	2024-10-25 15:16:02.895733+00	15	safeT	2	[{"changed": {"fields": ["Email address"]}}]	4	1
493	2024-10-25 15:16:37.734632+00	12	safeT	2	[{"changed": {"fields": ["Receives newsletter"]}}]	21	1
494	2024-10-26 12:56:08.270408+00	37	nikola	3		21	1
495	2024-10-26 12:56:08.270457+00	35	Som	3		21	1
496	2024-10-27 10:34:34.296454+00	25	Sladjana	3		4	1
497	2024-10-27 13:11:58.970682+00	154	Message from nikola at 2024-10-27 13:11:58.842422+00:00	1	[{"added": {}}]	34	1
498	2024-10-27 13:18:19.532513+00	9	Conversation between Samko and nikola started at 2024-10-27 13:07:25.216024+00:00	3		33	1
499	2024-11-05 09:44:50.390307+00	26	nik	3		13	1
500	2024-11-05 09:44:50.390357+00	25	nikica	3		13	1
501	2024-11-05 09:44:50.390375+00	24	Ruza	3		13	1
502	2024-11-05 09:44:50.39039+00	23	nikica	3		13	1
503	2024-11-05 09:44:50.390403+00	22	nikica beli	3		13	1
504	2024-11-05 09:44:50.390416+00	21	Sanja Moja	3		13	1
505	2024-11-05 17:17:21.786899+00	164	Message from safeT at 2024-11-05 17:17:21.658516+00:00	1	[{"added": {}}]	34	1
506	2024-11-05 17:17:54.407368+00	165	Message from marko at 2024-11-05 17:17:54.275312+00:00	1	[{"added": {}}]	34	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	sites	site
8	account	emailaddress
9	account	emailconfirmation
10	socialaccount	socialaccount
11	socialaccount	socialapp
12	socialaccount	socialtoken
13	seeds	seed
14	cart	cart
15	cart	cartitem
16	social_django	association
17	social_django	code
18	social_django	nonce
19	social_django	usersocialauth
20	social_django	partial
21	custom_accounts	userprofile
22	checkout	orderlineitem
23	checkout	order
24	reviews	comment
25	reviews	review
26	chat	chatbotresponse
27	chat	adminactivity
28	chat	chatmessage
29	chat	supportticket
30	chat	chatsession
31	chat	conversation
32	chat	message
33	communications	chatconversation
34	communications	chatmessage
35	human	human
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-08-19 10:36:50.643255+00
2	auth	0001_initial	2024-08-19 10:36:54.671931+00
3	account	0001_initial	2024-08-19 10:36:56.155974+00
4	account	0002_email_max_length	2024-08-19 10:36:56.556752+00
5	account	0003_alter_emailaddress_create_unique_verified_email	2024-08-19 10:36:57.226839+00
6	account	0004_alter_emailaddress_drop_unique_email	2024-08-19 10:36:58.151583+00
7	account	0005_emailaddress_idx_upper_email	2024-08-19 10:36:58.686798+00
8	account	0006_emailaddress_lower	2024-08-19 10:36:59.346792+00
9	account	0007_emailaddress_idx_email	2024-08-19 10:37:00.148403+00
10	account	0008_emailaddress_unique_primary_email_fixup	2024-08-19 10:37:00.678962+00
11	account	0009_emailaddress_unique_primary_email	2024-08-19 10:37:01.210895+00
12	admin	0001_initial	2024-08-19 10:37:02.416748+00
13	admin	0002_logentry_remove_auto_add	2024-08-19 10:37:02.555762+00
14	admin	0003_logentry_add_action_flag_choices	2024-08-19 10:37:02.953729+00
15	contenttypes	0002_remove_content_type_name	2024-08-19 10:37:03.760945+00
16	auth	0002_alter_permission_name_max_length	2024-08-19 10:37:04.289861+00
17	auth	0003_alter_user_email_max_length	2024-08-19 10:37:04.818476+00
18	auth	0004_alter_user_username_opts	2024-08-19 10:37:05.087725+00
19	auth	0005_alter_user_last_login_null	2024-08-19 10:37:05.745808+00
20	auth	0006_require_contenttypes_0002	2024-08-19 10:37:06.008407+00
21	auth	0007_alter_validators_add_error_messages	2024-08-19 10:37:06.406526+00
22	auth	0008_alter_user_username_max_length	2024-08-19 10:37:07.074072+00
23	auth	0009_alter_user_last_name_max_length	2024-08-19 10:37:07.603835+00
24	auth	0010_alter_group_name_max_length	2024-08-19 10:37:08.135889+00
25	auth	0011_update_proxy_permissions	2024-08-19 10:37:08.404456+00
26	auth	0012_alter_user_first_name_max_length	2024-08-19 10:37:09.063003+00
27	seeds	0001_initial	2024-08-19 10:37:09.597548+00
28	seeds	0002_seed_height_from_seed_height_to	2024-08-19 10:37:10.515076+00
29	seeds	0003_seed_image	2024-08-19 10:37:11.039082+00
30	cart	0001_initial	2024-08-19 10:37:12.515769+00
31	seeds	0004_seed_created_at	2024-08-19 10:37:13.041554+00
32	sessions	0001_initial	2024-08-19 10:37:14.027295+00
33	sites	0001_initial	2024-08-19 10:37:14.442374+00
34	sites	0002_alter_domain_unique	2024-08-19 10:37:15.106228+00
35	socialaccount	0001_initial	2024-08-19 10:37:17.966378+00
36	socialaccount	0002_token_max_lengths	2024-08-19 10:37:18.643292+00
37	socialaccount	0003_extra_data_default_dict	2024-08-19 10:37:18.916074+00
38	socialaccount	0004_app_provider_id_settings	2024-08-19 10:37:20.107141+00
39	socialaccount	0005_socialtoken_nullable_app	2024-08-19 10:37:21.16756+00
40	socialaccount	0006_alter_socialaccount_extra_data	2024-08-19 10:37:21.716151+00
41	cart	0002_cart_session_id_alter_cart_user	2024-08-19 14:28:52.074138+00
42	default	0001_initial	2024-08-19 16:24:38.730521+00
43	social_auth	0001_initial	2024-08-19 16:24:38.861805+00
44	default	0002_add_related_name	2024-08-19 16:24:39.004015+00
45	social_auth	0002_add_related_name	2024-08-19 16:24:39.259325+00
46	default	0003_alter_email_max_length	2024-08-19 16:24:39.776231+00
47	social_auth	0003_alter_email_max_length	2024-08-19 16:24:39.904304+00
48	default	0004_auto_20160423_0400	2024-08-19 16:24:40.171179+00
49	social_auth	0004_auto_20160423_0400	2024-08-19 16:24:40.427525+00
50	social_auth	0005_auto_20160727_2333	2024-08-19 16:24:40.946228+00
51	social_django	0006_partial	2024-08-19 16:24:41.86561+00
52	social_django	0007_code_timestamp	2024-08-19 16:24:42.643226+00
53	social_django	0008_partial_timestamp	2024-08-19 16:24:43.420638+00
54	social_django	0009_auto_20191118_0520	2024-08-19 16:24:44.20514+00
55	social_django	0010_uid_db_index	2024-08-19 16:24:44.862242+00
56	social_django	0011_alter_id_fields	2024-08-19 16:24:47.279056+00
57	social_django	0012_usersocialauth_extra_data_new	2024-08-19 16:24:48.192704+00
58	social_django	0013_migrate_extra_data	2024-08-19 16:24:49.104371+00
59	social_django	0014_remove_usersocialauth_extra_data	2024-08-19 16:24:49.755499+00
60	social_django	0015_rename_extra_data_new_usersocialauth_extra_data	2024-08-19 16:24:50.410213+00
61	social_django	0016_alter_usersocialauth_extra_data	2024-08-19 16:24:50.676536+00
62	social_django	0001_initial	2024-08-19 16:24:51.191004+00
63	social_django	0003_alter_email_max_length	2024-08-19 16:24:51.321644+00
64	social_django	0004_auto_20160423_0400	2024-08-19 16:24:51.452895+00
65	social_django	0005_auto_20160727_2333	2024-08-19 16:24:51.583777+00
66	social_django	0002_add_related_name	2024-08-19 16:24:51.714615+00
67	custom_accounts	0001_initial	2024-08-20 16:27:56.349276+00
68	checkout	0001_initial	2024-08-20 16:27:57.821649+00
69	custom_accounts	0002_alter_userprofile_user	2024-08-21 08:14:41.13613+00
70	reviews	0001_initial	2024-08-25 08:10:05.560567+00
71	reviews	0002_comment_status_review_status	2024-08-26 14:02:09.892239+00
72	reviews	0003_alter_comment_status_alter_review_status	2024-08-26 14:37:18.297374+00
73	reviews	0004_remove_review_is_approved	2024-08-28 07:34:21.629912+00
79	chat	0001_initial	2024-08-29 09:57:48.316309+00
80	communications	0001_initial	2024-08-29 10:28:12.544737+00
81	communications	0002_alter_chatconversation_superuser_and_more	2024-08-29 11:04:50.674789+00
82	communications	0003_alter_chatconversation_superuser_and_more	2024-08-29 11:35:42.770214+00
83	communications	0004_chatconversation_is_active_and_more	2024-08-29 11:59:45.935667+00
84	communications	0005_alter_message_options_and_more	2024-08-29 20:28:30.351567+00
85	communications	0006_rename_message_chatmessage_and_more	2024-08-29 21:03:11.78359+00
86	human	0001_initial	2024-08-30 23:27:57.12645+00
87	human	0002_human_deleted_human_last_modified_and_more	2024-08-31 09:07:49.546349+00
88	cart	0003_cart_deleted_cart_last_modified_cartitem_deleted_and_more	2024-08-31 11:39:57.021547+00
89	communications	0007_chatconversation_deleted_and_more	2024-08-31 21:52:57.615497+00
90	reviews	0005_comment_deleted_comment_last_modified_review_deleted_and_more	2024-08-31 21:52:59.058971+00
91	seeds	0005_seed_deleted_seed_last_modified	2024-08-31 21:52:59.954264+00
92	seeds	0006_remove_seed_in_stock_seed_is_in_stock	2024-09-09 06:39:56.84161+00
93	reviews	0006_remove_review_seed	2024-09-11 09:23:20.447857+00
94	cart	0004_cart_items_delete_cartitem	2024-09-16 12:57:31.995473+00
95	cart	0005_remove_cart_items_cartitem	2024-09-16 13:55:01.870008+00
96	cart	0006_cart_total_price	2024-09-16 14:54:54.529278+00
97	cart	0007_rename_total_price_cart_cart_total_price	2024-09-16 15:17:02.318936+00
98	cart	0008_remove_cart_cart_total_price	2024-09-17 17:12:20.532623+00
99	custom_accounts	0003_userprofile_profile_image	2024-10-23 15:32:59.342851+00
100	custom_accounts	0004_userprofile_about_self	2024-10-23 16:31:58.687488+00
101	custom_accounts	0005_userprofile_receives_newsletter	2024-10-25 14:19:12.501791+00
102	custom_accounts	0006_userprofile_email	2024-10-25 14:27:51.876814+00
103	custom_accounts	0007_remove_userprofile_user_alter_userprofile_email	2024-10-26 12:01:55.799116+00
104	custom_accounts	0008_userprofile_user_alter_userprofile_email	2024-10-26 12:25:19.438489+00
105	custom_accounts	0007_alter_userprofile_profile_image	2024-11-06 20:21:13.667911+00
106	custom_accounts	0008_alter_userprofile_profile_image	2024-11-06 20:27:41.38808+00
107	custom_accounts	0009_alter_userprofile_profile_image	2024-11-07 12:40:55.821725+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
pf8goupy9xg9mfbr1htwzl0l4xk76bck	e30:1sjgET:aB8epFg3jeqHs109Yw7vB2_EIUYJhN8bLfILxiAbu_A	2024-09-12 14:34:41.74848+00
nmovq00xtlox87qg2bvlrwojq5ftdbq3	e30:1t4gMQ:AIZjzF_LkJhZSABRSnhavJtEBfxdu5n6jAyTJnCBENQ	2024-11-09 12:57:42.09929+00
0h5ooq7dhhjnhsjlgd5hz0mgkhk4g490	e30:1sutyL:rmM2aW1bkOUMeN-aWYgO8mqQv-gI1F1l7_SFtHiTl2g	2024-10-13 13:28:25.240849+00
03u7yzkn5ulvufg4t1knyr3nyx0lbqym	e30:1sgg1s:nntMw7bAln0xe3RsDTt9WyMPUSjIUQlVDCs3RLZMeaw	2024-09-04 07:45:16.011364+00
ko0kfqo77oxglk9b0s1pqy3fkoecw1qh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1sjk3j:WE_vmnht0Ks4ZoEe3WqGwKAwV3bn6Oh_zBAvMc7mdiU	2024-09-12 18:39:51.277274+00
lxf2ir7n5vnsrxssiljwstdgiql53hmu	e30:1tAQOl:XdfjE4EaDB0BLn6Yr5rCENcGrhRamugIvXFkMXmyz6E	2024-11-25 09:07:51.28349+00
szrlyalk2hxcobyvotpf9c2zy287jyyk	e30:1sggMa:5ywt4CkDCSqGA-mHQaQq8uupGyHNuA58vE_5NM7ih_I	2024-09-04 08:06:40.03034+00
wf7h5jqqzxq6241cat7usfohpynpxk2x	e30:1sgjLQ:4zbAscy_v_qus09x6rnUXh-5CZX3ajbGjs3SvhEf8ZI	2024-09-04 11:17:40.476248+00
lmbedjo9p1l23np1qcjwfvmwqsz5q0k6	e30:1sutWG:oXxQyWZvOmW0XBla5Enku8FcEYdnsVoHJxMcgqotwuY	2024-10-13 12:59:24.483888+00
i3l4jriwwfb2t1o7phgr0lr182qs5bsl	e30:1sutWG:oXxQyWZvOmW0XBla5Enku8FcEYdnsVoHJxMcgqotwuY	2024-10-13 12:59:24.840818+00
ak6nyqycht2ft562pn9w8k5hetbrg7ld	e30:1sx7kA:BvB83lulxwk42dkJIuslip_At2rVOYFRuejK_MDRmHM	2024-10-19 16:34:58.447275+00
2m1gu7pwpd7xp580a32oaen9zpx1iivu	e30:1sg3Mh:tfRdp5_LNvHKkIPguI1PxeZ4FfVBh-rEPcUlm8EcgHM	2024-09-02 14:28:11.549229+00
f3bn1n8ol653uwruvn8fzz8te5aevnc5	e30:1sjwuf:lgg3JvO_oLDHw4kWSXR3dFQWcgHhp3EPdJURHcoAVyw	2024-09-13 08:23:21.924304+00
mzhuu8i3jk5ro3qjfpjmeap9lsog9y72	e30:1sh1JB:Z4B5zMhIH0liEy7jKMb_H0q6DVeLV-7fn9P-jgaePdQ	2024-09-05 06:28:33.171344+00
fr87ndj61a27g94pvhhjjdcws5avj1hm	e30:1sjx2T:VKneAp4DGy9alfbkNUsA2vm33L-w2dpbm0bBFPUFc5k	2024-09-13 08:31:25.18241+00
fd0z8r54ynq4qy62c5vc7z99ytm8rfwo	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1sjaGV:wUX-ROD3EobOlPKumjPGq2Q5u5jX0wiAjzBq82Ssxv8	2024-09-12 08:12:23.920246+00
eht0yrdzbcxg0lewle7t0hdh39a33dny	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szENS:ogXV0cR0Ce57Ez5Ho8prvdhaRhhtVAZgfmWmpRzLs9c	2024-10-25 12:04:14.169979+00
d5kq5c4fs978mqj5etfgcdmvfijaso1c	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1sxO83:0ptp__R4ttJW5waPadciwkJ7V9qJRGCTFSVW9WVoOjs	2024-10-20 10:04:43.454652+00
r8cffxv5wcpq71wdffij26z2gfvf72zn	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t4gWI:NsuGhGPmaf4dDdkhGrDJv1iho1nXyg-oips71UjDcrg	2024-11-09 13:07:54.165586+00
har5bw7tgo9gsj4jx5k5jeyezb255ci1	e30:1sxkVO:feH04X4viv_tHstQTkY4Ea94QMS-E1-2tcQFt7AgSkc	2024-10-21 09:58:18.632885+00
e4hnzp3jaidpfp5dxiff2rref0fo3hb6	e30:1syQBQ:AEo04O1YSxdURyiSdHHWD7NHu11RkZQyfTsZejXm398	2024-10-23 06:28:28.550588+00
uaws332deitnfm2v9nw4ger19s1a7788	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t3vI9:1v_VIj7PxADej5T5wUCo8NTHHXalvDK6qkmF7Uvk6fU	2024-11-07 10:42:09.516301+00
c780jclskbinq8xzivzz362y8m5kswcq	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syQXK:14UKk9jQzh1dlGhmx-c4hH8v3BPgz9-NWxKfJbeuOAI	2024-10-23 06:51:06.635551+00
cq3izgzj82y9g49mzq8vuyk2k8fi4ykn	e30:1sutsq:r2HmDFpkP3hz7MpB78bSQnFfPMrZjQ-naR0lLmBidsc	2024-10-13 13:22:44.160043+00
yk9jhwgrpzpy1ecs5h2z8l9gu7eynzy4	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syr91:UA3Ksnvg05LUxr445r0gwweM-sprYK-xXh80RxcG3RM	2024-10-24 11:15:47.334541+00
y7115dcwm7tevr50jncgf6046opaspm2	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t50sT:H4H-Ud6Jq8eBR79JaJlhJkXmrWlJYd7JKC01JyybSfc	2024-11-10 10:52:09.239699+00
ii6erq67ozdpnpixmhh4d2oy1qp01vl8	e30:1t4gvl:6ye4GtuRfFK95rD1-kI6EEPspO411paX5EPBFr_n90o	2024-11-09 13:34:13.307573+00
3kdgznur1n06fj0u1k8f12mitc4m3mbz	e30:1t4h2j:_Rahv1149i5CYRnMuhiiJbWjy6eyiv4qaOEYzDxSV5w	2024-11-09 13:41:25.851605+00
3gx41e1n7pyq6hp0vudkp047u7xr7gaw	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t50wK:4Dim6NnNMErXr9FZvopviVnT1GhGtWql9ro4HtI3nbI	2024-11-10 10:56:08.217199+00
tuhw74aoe4xddkbdvpk40sbhqjmtkuuq	e30:1t4feY:v4Eq1fr2NUzLinUQx05IAwmqrVfj4bgzVtBCoxTnBGE	2024-11-09 12:12:22.192156+00
uow5cp33mont3t2hemi8yg8gr0dzb092	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syrjk:JFxxT3dmbZwkurt2RZjC6XvmbF5GxHEPgnIvRQJugCg	2024-10-24 11:53:44.343244+00
dimtg9p9uq86g5cdojkio31f8a9ua3dg	e30:1t4vIB:Gnw7zWXjccbS2OuWuGE-wNa00LVsYJFkcfbXqld7sEs	2024-11-10 04:54:19.29444+00
nycmpqj9rstievensxri30jepzx1ehi5	e30:1szFmO:MoYufGtJVQ5Q-hTqfDZ6eueQNlo_dPiu3E6rzqmcyoU	2024-10-25 13:34:04.468252+00
qab8xmgrahbmlbu8gto4v3fhr5in491z	e30:1t4fyC:165vojLETLhRB1M39uBSUg6rtgmySN9y11bq8slHm4I	2024-11-09 12:32:40.217365+00
zx9zouu8rovh9maqb0vbo9egql9c9viz	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syqVE:-uCNlO6_HtD4Tjerc7VtesAMGqd0h7tNpgwdQcTfhxg	2024-10-24 10:34:40.696408+00
3yidwe3opkbp64tpkxeup65b61zq0tgj	e30:1t51jV:JptD6m2OIonmCo0I-m6Tci-4eS_nsJExV2Wo4GWkijY	2024-11-10 11:46:57.354105+00
p4sngcr79h58qt7wozmzcisnv5dvw1f8	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syqVc:a4crPBSzr3loPzoB6AU58Hc0EYv76kPht2WsvGb0R7A	2024-10-24 10:35:04.663184+00
vo5bqy3qayn081umtftkkdzdnk7lmex1	e30:1syqbn:05COMvnqmFzJvXDe2uQSoIX-oozThGk3ci19UiLcu08	2024-10-24 10:41:27.032735+00
kzely9k3g5ydgd0pgplrapjuom0nsxi4	.eJxVkMtuwyAQRX-lYh2BccBgL7uvVPUHLGDApo6xwyMPRfn32lUW7XbuuWc080C9KnnsS7Kx94A6RNHh70wrM9mwB_CtwrBgs4QcvcY7gl9pwh8L2NP7i_0nGFUa93brtAHZ2NpUXDetpgJqLivplOMgZMMcOOokwFHbqqbSCi4cp1TXLWVHvkmNirn32c6oe6CgZrtpP32Y3r6WZLf8XFTIPt9R1-LqgNbozYZQhlt-QH5Ww14Yc147QqJN2JyWAj6oeN-OmgkMVUrWiEJ-WVLW06KAXKioGa-EZJSUW7iZeXI0XG6FxXgucMVXq9dt-_489nz-AP1Tbx8:1sm0w0:wvPz7OT_mT_p9COfJxQKdkpJiY3kZt3LJaU0DolFxCc	2024-09-19 01:05:16.908163+00
8vtycqc9dnoo7s5urmmi74h9mgas2rev	e30:1t51pl:lAyke2P8qnBpK6Vfxe44KKZXxgBCNEArNyCy9haU8xw	2024-11-10 11:53:25.862394+00
qnoo5dhb8x6rr0635y06zz7wuzv4f6pm	e30:1t51pm:Q4DiUOxnVe8cwrDQqioEDZzCy_XmQx6pEp79g7W0I58	2024-11-10 11:53:26.304267+00
8brouukvggbuxfpcpulvhz2svlhaiz2m	e30:1t8Mec:bEy5Qah1Bdoxbb-vQS36jxIwHNt3X5LhWw26Hiaruvs	2024-11-19 16:43:42.03938+00
x5w4skou48vgwi756tsjgdcayzbnsivq	e30:1sjgEU:3dbNsPTH1op8w2dQhbh1ENb2Py2ISLP2bjz26s7xROM	2024-09-12 14:34:42.353935+00
hwu3gkom7gh0yqj8sjvepg1c5pkycctp	e30:1sgU0n:3PvSCZMMcKAWaXpv_nZMMuUczqoFvRwzm60-J4qORns	2024-09-03 18:55:21.883163+00
izo063i48dlepajllflv2dn2vwqmjmbb	e30:1sutyL:rmM2aW1bkOUMeN-aWYgO8mqQv-gI1F1l7_SFtHiTl2g	2024-10-13 13:28:25.590898+00
5tha94skfrob1qfvdmspzd5k0xmi704z	e30:1siZOc:Q18tZPu18R8DyLOFDZ9Te3GQmfNWumUG8DH4aeV2GIc	2024-09-09 13:04:34.056339+00
zwo8pqonpykxqkgwqhhyt5l4f8s921ow	e30:1sggC7:Rx5uvzIlY8Y7n3yv6du2vrtgyXDXywNnOLV8PHoc-6Y	2024-09-04 07:55:51.730692+00
fk5znwvjevjjhluxeq8wpeoofoqzy2zh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szFJ3:pPn9N2819qu8HDHpWClPRSCw6NmH2rvLmpCT9FNR1AA	2024-10-25 13:03:45.906139+00
bqtloadfwidyqlduslgwgazorvwavpgt	e30:1sgjJp:P10C5s9GDjcA19woXvhYXXcU9FLwR-hwiSCE6IJSd0k	2024-09-04 11:16:01.686674+00
yetcporjsj0r6coskviy7ze8v2i2ffn5	.eJxVjMsOwiAQRf-FtSEMDwGX7v0GMsNDqgaS0q6M_26bdKHbe865bxZwXWpYR57DlNiFgWGn35EwPnPbSXpgu3cee1vmifiu8IMOfuspv66H-3dQcdSt1j5rbfAM0mWRBEFBF4t3CMJIWyT5RBQtKqucRjCGCha9QUFWKojs8wUF2jfu:1sjQJe:tF8dMUUalGfBbT5YbCJey-4KJIcsg1t-yhSXS27RMIk	2024-09-11 21:34:58.023784+00
2ro67w37h4fpbeqrcooj2tyr42qd65ai	.eJxVjLsOwjAQBP_lahTFzgObknRIFERQUEWX85kEiB1wACHEv0OAhmql3dl5QI_3jt1QtW74hIEZ9G2VrNSi3Je34MN6eyo7ERfNptwUMIGAV37j1sPM4jHwBCq8DE11CXz-_oWGv7JGOrAbF7NHt_MReTec2zoakei3hmjpDR_nP_ZP0GBoRq_JKEPKOLcZpSkLUigIba1Qp3GSIOdKS0RSGlUspiSktGmuSbOREgU8X2q_UEc:1syqIH:p35pQBvRtD78Jca56ijxt4SfDtYND2w59zgN40tnJGw	2024-10-24 10:21:17.419467+00
8i9x0vxzi1non17wzwryxdp8ltaarsb9	.eJxVjMsOwiAQRf-FtSEMDwGX7v0GMsNDqgaS0q6M_26bdKHbe865bxZwXWpYR57DlNiFgWGn35EwPnPbSXpgu3cee1vmifiu8IMOfuspv66H-3dQcdSt1j5rbfAM0mWRBEFBF4t3CMJIWyT5RBQtKqucRjCGCha9QUFWKojs8wUF2jfu:1syqIt:8tzOvadmaaLDoMv9Jwl9TWbapazrU0J915VDBLohbvc	2024-10-24 10:21:55.537753+00
slx1ndse6awbjcgizs1zliwvvppqv5ng	e30:1t7bTy:3pb7KYErM80aav1nvxyJNBQ-BaxUnAuikDEA_t3IXXs	2024-11-17 14:21:34.139424+00
0vwszvf4s1s0p4o3z3womaexfv3a0iwt	e30:1sgkTU:Y1rhWwtL8oaIl6zE37wUuak6tcYGgrxwdUByLXtUUMY	2024-09-04 12:30:04.119339+00
m8qdqmfjbp9xcx2n051kkj9fzgc4lqxa	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syqJp:yCxQlOSowfzKltyjGtCs4CTZIeZKG_4HyStFeP2K49c	2024-10-24 10:22:53.973959+00
yrqcikdfobv2gyx57cx0rq6aximud72f	e30:1sh1gA:jkPRd-WIczP_o-_RuLi4jtBPBFTSFiteuMrG9v_9id4	2024-09-05 06:52:18.958838+00
66vhket816l2dlqtpwv78cm4wsutau48	e30:1ss0ov:P6Ij6ZEJgOAE9tx4Vc4-aAhNlytXyOIcOFRdW6QkJi4	2024-10-05 14:10:45.081203+00
x9j6ntm753kvoflrbxhrazo5rekdr23w	e30:1sxO84:DqS4_CibDmOvXx1t_nBxaDpQA9SjE70sMIm_5RBHx4k	2024-10-20 10:04:44.844371+00
5k2fhjk04gyjhj1h9b5r58sathm5ldjg	e30:1sjwvy:LLb-mr2dFa21b1TdReUhz5PSr-_OGbme65zET66Bsv0	2024-09-13 08:24:42.271178+00
lfpi6js9l2sk3pd5clbd15gdicg97kah	e30:1sjx4G:UfQQkksKCkFqlnQt4GziZEh0iZsi_IlWFfwBwvq-CS0	2024-09-13 08:33:16.318184+00
0ovz2eo5mzj14z9cxk8rqhaqryrky4nl	e30:1syr8o:9WT7r4JqhmmgfegTr19nfP_-KV0fsiArTZRxnk85tso	2024-10-24 11:15:34.089198+00
ge4hddpk7253hl8x96l1y2fba89nyzw2	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syqUc:u2DVgfhfuOrzb_WHyQRDnmtporVYbXeWtn7LGMpocRg	2024-10-24 10:34:02.616261+00
dm0suuco5n02y5dnf6uag0rn61x77u6j	e30:1syqVF:i4hGYjAy3kIPyWawkSUw3NfWGUajQuqBs-AKcEqW5vY	2024-10-24 10:34:41.925743+00
63w0xugwt4k73iwtowzdkg65nc5h8zv7	e30:1szFal:0YuhDT9QDpek8AVeQvrbgCEwwNxu0Pgeoj2m3SIN9gQ	2024-10-25 13:22:03.437484+00
panjj8ge23t9goo075dmjqmilbb1bwxw	e30:1sutsp:rZbaZUWJK0m8H0PWFIUwYLem_qt8pcPOkEsEIEsY5HE	2024-10-13 13:22:43.320493+00
rahw7g3z2xc5unxoeqf92rqb8dczc9z6	.eJxVjLkOwjAQRP9laxTZ3jgQSigRBVEoqKK1vSHhsCEOIIT4d8LRUI305s084ET3I_u-an3_CQdTOLUVriaLdVncYojl5lwchaqL1YzmMIJIVx70OsC0pkPkEVR06ZvqErn77pWAP2jI7tm_G7cjvw2JDb7vWpO8leTXxmQZHB9mP_fvoKHYDOucpGA3SSXqTDmnrEWtMUOhtWasjZSZStkYoSk1qMcDZaLcSsmIpHJ4vgAiFU8w:1syrLt:Dt44qOVD2gKIZ5nzKpmiSl4zMB0YamjnHx64tUApP7k	2024-10-24 11:29:05.826076+00
kdk3jspgz1vvfaspxaccos5h6ejytxx8	e30:1szENS:70zA_5k15wn-DpVbwhGF4WyI2QQlj8Ejes8ahZZt6dc	2024-10-25 12:04:14.956435+00
63h1yq1016jpfug3bu8qys76s92yt6ao	.eJxVjEEOwiAQRe_C2hBgGBSX7j0DGZhRqoYmpV0Z726bdKHb997_b5VomWtaukxpYHVWzqjDL8xUntI2ww9q91GXsc3TkPWW6N12fR1ZXpe9_Tuo1Ou6jmSN8MlbwOCYXSmACAEMIgrcsrXBecnZIPkMeFypEMVirQCQi-rzBevUN4Q:1syrOL:BsCmqMpP9IxcFnKoNeQmFDKJqoY8aXyA6zQY70zm0KM	2024-10-24 11:31:37.048622+00
l98a5279hpgxicv9aeknge3rmr96di99	e30:1szFmN:ndCk4DljJNTO-x1iIMkF-Abtm06uKRTSZ0qQAnyTpbI	2024-10-25 13:34:03.626805+00
zs1n72gtbesf8duo1uf2ofpq3dfvpk7r	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syrPG:k1dt3GbRZjEdl9mw0rrfj5peCFMTgmnoHNZoNyTZhuw	2024-10-24 11:32:34.558508+00
cln2eua9o8t92tuy6bxps4o69zl574gu	e30:1t4gjx:MzG5JJHjFbX5pqvn207l-ABy9LaJHZpOPUwfKMPTgZo	2024-11-09 13:22:01.673459+00
25j8j9v3y5qcdalfr17qbbfyi5olotwg	.eJxVjEEOwiAQRe_C2hBgGBSX7j0DGZhRqoYmpV0Z726bdKHb997_b5VomWtaukxpYHVWzqjDL8xUntI2ww9q91GXsc3TkPWW6N12fR1ZXpe9_Tuo1Ou6jmSN8MlbwOCYXSmACAEMIgrcsrXBecnZIPkMeFypEMVirQCQi-rzBevUN4Q:1syrnu:wgDsV-sKD0lYVh9tFede12i-5cvjyOdL4Sy5tm3BBdg	2024-10-24 11:58:02.684587+00
svf6hq0j03lhpff38tij89n3servtlui	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szF6L:UVDO4hzO-gHyA6Wvj6fiBTMj7mEg0K9eRWZIncjff88	2024-10-25 12:50:37.971026+00
upni29tqaxeqqrp9s6112e1qlny7uh4f	e30:1t4eCQ:jMcB947N0d464ZK36027MLb5kg52WWQmpRHROZio9ac	2024-11-09 10:39:14.177099+00
9we9w8ccz4fadrx50timw9p8827b7zq1	e30:1t4hkx:tcuaUNJfQxXyjTZe23bDsHQYx_B--rzMFL0XeI1q778	2024-11-09 14:27:07.376673+00
o5wy9xxqu75ilo31eckod940a2asz4zc	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t51e7:iVpwXJ2VppaP-155K-FdHNuKrf7KSfpY5DDMxxUcrSw	2024-11-10 11:41:23.334115+00
t867zdrs3002kr92kuxvgvv1y2k3wlcf	e30:1t4fje:t7pjSmTKH-W9p2uPwrkKMZOrlBx2_0T9lHDMgthWRb4	2024-11-09 12:17:38.532278+00
303wrjgsaee1dw0no3n4avni77t58bfx	e30:1syQXL:oZQaeu8KSlHDveIwfinVrNpCEwICVDrxCH4EjVEc2XA	2024-10-23 06:51:07.945085+00
m1f5kweyt0bnm3m0pzqqqkk4vc1d3urk	e30:1t4fwc:ncMwyx57WOoJZFOUBZktfB4HZtEbLmxTJGvVvidNLcM	2024-11-09 12:31:02.075297+00
1zbrzht5elukgkqzilkzo63ws6lqtc06	e30:1t4fxj:hzE1UjbMbX2gcxbVc2A8xktVOugApgrOcNK4iUWHHfc	2024-11-09 12:32:11.386647+00
butnqmprmwzm25550g52m4j3rilsyaa3	e30:1t507C:Q0NsrrBZenBwpFYMXHo5ySLjqr34ngj2Mugpx1DYnCE	2024-11-10 10:03:18.546524+00
ict982r8ztdd6ue761fu8v34jwuj9rak	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t51ki:kFpysFroMByR6pOThySxbHddjMPV4LSwi79iSIZoDsY	2024-11-10 11:48:12.185552+00
8qoz1rk8rfi93f2boxd8mh66ftsvdvf5	e30:1t51pm:Q4DiUOxnVe8cwrDQqioEDZzCy_XmQx6pEp79g7W0I58	2024-11-10 11:53:26.74609+00
x3mgooh8sfiahj0fvje0sj9msl4yk9zx	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t50M4:4wXwHYX5A9bbSFUwUrBkCi3riMwjH_GboTieaTfiz0I	2024-11-10 10:18:40.34947+00
yexkxfjegx3o7e3zl2bftvc7v77emzwx	e30:1t9HXP:1Hs-N-3uCtmlCxmXvV9U7JF0SaM6hPzyj_VXYBw1p5U	2024-11-22 05:28:03.888066+00
smr5nx52vyfviglqlzigg58yxnoq9bec	e30:1sutyM:GA07tjRvdzu1EoJmHuB8yxGwTik5osIaYaFCKGb6ym4	2024-10-13 13:28:26.088839+00
ew5lqks5tnu8c1d7xuont8gvh2wi70yg	e30:1siE52:rf13EsE6m0IHDoQUeYo0gI-Sf-Bckwt1RqbB6thDfxE	2024-09-08 14:18:56.748379+00
2wchph6n4lwpozcnwv51lbxjie47rh17	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1syqEp:LDbLnDAFJfxZmxGBghgg8Y-t5UYtfcD1Eu8VT6NM35k	2024-10-24 10:17:43.443104+00
nc5nm1kbifmp26ijhtaqvihtt8ixxgax	e30:1st1XS:3sMCoPx_MVCbhMB80UPPAcgE0mGTTgaaad-cFd5c5kQ	2024-10-08 09:08:54.780478+00
5bldin11dq5jk63cxbyk6ef3ktbfkair	e30:1sutzU:gmpB1CX37_XIpZgQU3tQ-OyMhctGS1L4WePKEZkTAm4	2024-10-13 13:29:36.435663+00
y885ze03r6o9qubogjpzth5p52fr7xwz	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szFJ3:pPn9N2819qu8HDHpWClPRSCw6NmH2rvLmpCT9FNR1AA	2024-10-25 13:03:45.998098+00
1wbg98d3vlh0mevvlc1vvh23e5ywsv8o	e30:1sutWG:oXxQyWZvOmW0XBla5Enku8FcEYdnsVoHJxMcgqotwuY	2024-10-13 12:59:24.830002+00
alvmg233z6b1cfx5q60z01ylv2q0efpr	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1stmtu:z5i2V2x5JAjTM1Z0AvRoADoazHk_5HRc62fgf4h6ZO0	2024-10-10 11:43:14.572166+00
npxxuekhwvzugeemgcltyeu2o4mjft75	e30:1sgTyI:ia31JOw7SBHI7ypdACjXo5ZbW7RbMn9IwFh9hU2-wjg	2024-09-03 18:52:46.072025+00
b5gix01i5soazei5941paepkhrjpsskv	e30:1svBsX:OeONhL6_s_yOiu6glK5BdOjbjcoG-t5uqXuI6l1VE7Y	2024-10-14 08:35:37.592538+00
m3yxx8oyzfmdm7y7n24peynb0tbccrbb	e30:1syqII:vlswt47_Mi3Mj5x6_mpQ3KZlTYNmXlzwkRREqSmwY2g	2024-10-24 10:21:18.807701+00
8md0q4splh5wu11gyinsaagqyuqxl1cc	e30:1sgg8l:E734wNkzenSG09dcsJeLONl7Poij7zZOi1YylPatuwk	2024-09-04 07:52:23.390203+00
rbogrhd802dmmn1ejb4gv6xb4nbzi1ob	.eJxVjEEOwiAQRe_C2hBgGBSX7j0DGZhRqoYmpV0Z726bdKHb997_b5VomWtaukxpYHVWzqjDL8xUntI2ww9q91GXsc3TkPWW6N12fR1ZXpe9_Tuo1Ou6jmSN8MlbwOCYXSmACAEMIgrcsrXBecnZIPkMeFypEMVirQCQi-rzBevUN4Q:1ssJvy:kbpq2ZslnKtRzGKJZdHMjYpaglBltXR6yerlP-b2j1w	2024-10-06 10:35:18.931259+00
g5kcgkcph43ca7ngljaacezmk80o3dbr	e30:1sjwu5:TyKPrisDMHBA2WKN5YDKz6kcy9UPk3SKyW_UkJmD4kg	2024-09-13 08:22:45.631172+00
8e2gtd7zut660symcf21i2rlapo4zv1n	e30:1sjwwN:bIMG7VKlmVljpiufNHUL0nYcAOsuj9zuTOqvURmWLgo	2024-09-13 08:25:07.109685+00
uzmnvhajic09lebjmeq4e0qb0gbu3q2j	e30:1sjx6J:GYt4-LT-7OS0jGkZYTyR4qqML3u1cbCul528EOCr6kg	2024-09-13 08:35:23.361189+00
joj8hgrrp5fc6ut3j8g3dr047uueigxe	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1sx7we:VUHyqnH3OiHRqVXsReHEtRF6h1eOAIbZxZZjTVi-GCA	2024-10-19 16:47:52.832399+00
vyoxdbuo8ucsd742ozmoalenp0h374ro	.eJxVjMsOwiAUBf-FtSHIq-DSfb-B3AdK1UBS2pXx322TLnR7Zua8RYJ1KWnteU4Ti4s4D-L0OyLQM9ed8APqvUlqdZknlLsiD9rl2Di_rof7d1Cgl62OCIowa_boGQEtagURB0eUnWXLyqOJgW_GxeCMUpqVA88U9WZTEJ8vO-A5Eg:1sjg5w:fRW2P4OyBJDzKav6gW-KRUmN0mt0SggXoB5WQbFWtlY	2024-09-12 14:25:52.964653+00
cxfh8s2qufbtnkml0n7cfuvcq78wucr0	e30:1svBtf:ynbZLr-I2-Z4yaC_zC33LZraIKqKual4egq5QvD2vBg	2024-10-14 08:36:47.789578+00
f61ly69e4zdo5bdsq8aabsxaptx53yod	e30:1syqIu:D7-mGZzhqfNmGsjQ0Z86ZmS6FphmMj6Y6W1Sdtf9Gnk	2024-10-24 10:21:56.534804+00
46vkr0gue874xoxc4y11jiw16h8xybhp	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t3vIg:5Ik1Xa0Yjjc1ctoTFtsLkeRWkJj1OpWUewVgAAqEppI	2024-11-07 10:42:42.489937+00
6ye1cyey8xxxb5k9eurypx4yn8719k5v	e30:1sxe83:i5rkCnaBSKHhsPkq-_hEnL2roznosRgVYMX_wZDNtqE	2024-10-21 03:09:47.641755+00
ks08bxdfcv3l6nur168wpoqdho6urxg5	e30:1sh161:yiuH-N5pqRNuzJe1nVYameZ-uEBUt50zKdkvhnT1rzo	2024-09-05 06:14:57.814272+00
oad0te16bgthzrcad0n1ojhx50wg3yvy	e30:1t4gRC:JxdUaftco5Thq2V6AW-WvyNZWI-lUW-lMMDcKDfvNcY	2024-11-09 13:02:38.031765+00
z1qivkdppftmqesac5cnd4br6vxf2j68	e30:1shCMi:QioDAgxhtdFR3zsXVlRZcPyFIOLl7ajvX-RCV7b9_70	2024-09-05 18:16:56.080658+00
0s4djm1yt0k0df3gp2cpayva5v3zkd86	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1syQBO:cP4mMA8Ge5cggB9H46r0x-C66raDiDy3MxyjBO3c0xE	2024-10-23 06:28:26.934407+00
5am9cdcr2q0v9qjmsav00wk20x1ofqq6	e30:1sutsp:rZbaZUWJK0m8H0PWFIUwYLem_qt8pcPOkEsEIEsY5HE	2024-10-13 13:22:43.183809+00
aducenmoszbibthz967ktx4lr059y6bb	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1syqSo:pYQsYbCXTsHcUkXjrcOzEGENrNz2eNWMNivVoJM7Ee8	2024-10-24 10:32:10.051863+00
hdeivz3xqqsod9a42iqamwhsmh140qoe	e30:1syQUA:dHvYa6hb9hpnV-4oUY3Wc7-OJVr60CEn8QGQUnMZT4w	2024-10-23 06:47:50.174782+00
5llkq32owsglse36eopz6afv3dqofsuv	e30:1szFmN:ndCk4DljJNTO-x1iIMkF-Abtm06uKRTSZ0qQAnyTpbI	2024-10-25 13:34:03.819381+00
l69opi0u1kz8kt6vrilbegabl531w47s	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szCrB:uygqL5q5kXAZOET48CLDsA5zA3D6Lhf3zkbYLuLlZtw	2024-10-25 10:26:49.300404+00
dfp0nvd7jzaj95mknsms8i0z0vu8l1ta	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szFmX:HdKTsa6ooL45oKA0hnWau7SjAE5deWPaKnlVFnyif7c	2024-10-25 13:34:13.34772+00
a4m41gcid42cimet8te7n2ajsj03bczh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szFn1:9EoIMTxr8e5pf4TfXTxjT22LiFDWV2llyzay9mXWAaI	2024-10-25 13:34:43.018479+00
vcla7zuaar5ic9w03u03vws3w67zz0hb	e30:1t4gb9:EpIfvJp9H2U8_dDrdM6mhwB9FOmxKNZY0ul9gkkzBFM	2024-11-09 13:12:55.510182+00
k04zabo35q9bldjitidy63uxaa5ut1p5	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1szFnS:zR9KTHj2Py68QTRTU87Y-VKokZIhO6_S6VqELvg6lO4	2024-10-25 13:35:10.848633+00
44yxa2h76zxk4fsh6jr5jw6e96ixrnqn	e30:1syrLv:wvcZSP6e4p_AVK8ls5v14TCAhzeXRKa9VRjryCN6MNE	2024-10-24 11:29:07.023532+00
0lzr7b4noetxc0a8990sanc2k97b4gu3	e30:1syrON:mVKca6IEXZcK01Zf-GwWrn3DTnxz3TfqqV6VmvIrYPg	2024-10-24 11:31:39.059019+00
9xo03wik8envitoh6vsntchst9zcmc6f	e30:1t4eCQ:jMcB947N0d464ZK36027MLb5kg52WWQmpRHROZio9ac	2024-11-09 10:39:14.473489+00
g9j63o6i0fiqyks3vs3xmpty0m48xfmf	e30:1t4ffx:F6Rd2iU-_FmdGIV6zu3P5lTSjxo7EvF9iHU6TYUIRMA	2024-11-09 12:13:49.30725+00
zxba1z5xwnuuektcav7cdt2u6zs5u45n	e30:1t4gvl:6ye4GtuRfFK95rD1-kI6EEPspO411paX5EPBFr_n90o	2024-11-09 13:34:13.701445+00
72c09jzmj9z7rcvewpj9powryyw6d6jj	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1szF5S:zpaRtMGRZtAzuBTknZsNcUltsoDftFaTA7GGPiZHTAU	2024-10-25 12:49:42.183006+00
94kqqvr9g78v3thpxhr9wnm950c9ox1z	e30:1t4fwc:ncMwyx57WOoJZFOUBZktfB4HZtEbLmxTJGvVvidNLcM	2024-11-09 12:31:02.874866+00
f5wkjmywvfoi21t899tanon2cpq3770w	e30:1t4hkx:tcuaUNJfQxXyjTZe23bDsHQYx_B--rzMFL0XeI1q778	2024-11-09 14:27:07.039691+00
wi95se1rr1uezux009jzkrmf224dv6aj	e30:1t8Med:_dHO__FDa9zpzIg950QzuKVR7RgHddpPdHiaikIk68k	2024-11-19 16:43:43.935098+00
a18889zobirw119zsx2w8kbwsonttzxr	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gAu:wcygDOgZZqw_tVdds8ICGr2y1spTvR9RtQiTKKXjTIE	2024-11-20 13:34:20.705934+00
2uwyjd09zdta8l8b8wf8w77guxanvtp7	e30:1t7bTx:u6POwJIf0K4ziDqZYttkA_rPyxMtCx9wCEYB34P2UL8	2024-11-17 14:21:33.999266+00
iczyojjf7ze5c0el6m0om0o4wih8u16d	e30:1t8e7P:SMaxBz-Sn0urM3j7e3WFnongFYq7S3xaR5YMbuWi2kw	2024-11-20 11:22:35.515721+00
jc3d59wn8ampzx6yq9261b7z3jxhsteg	e30:1t8gBf:MrpS1dr69pJBYfnavw9-oT_zs61AH9YgtIFYstlcfGk	2024-11-20 13:35:07.600074+00
6pc3whmokwckgcjr8zqtyslogwweccqa	e30:1tARNH:y6hPqoHXdokxR3ubPUo7tM_o_aAVEObCOX_C4AsmAqI	2024-11-25 10:10:23.568327+00
d9wyg51z91y4ju8pg2imx013tw3sz4wb	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gCc:2vBzuyhT8PARuVHRAl3_0JPbBc2NUlJJ0EkIJA2w-w4	2024-11-20 13:36:06.749366+00
looodu2zdar9hb430vvfvjq8ul576hvm	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8eIS:DJ9TIG-4VlzTXLuCfZi4iDCOpMix2g-lbiNIicvdDc8	2024-11-20 11:34:00.478559+00
tnw7m3fuo10h57qgbbv2itot2tfutk6z	e30:1t8gfZ:-rsYW4rhaEjNh7qSPGalJRX05iYWuHP7x36XkKywuuw	2024-11-20 14:06:01.656213+00
bte0ixf4wh2zemcxvq3o1j4rgbij7bgi	e30:1t8eqq:bDKcvBS1_LsxNrH7rPUIm2gO6Hh9Q-7_AJTWkZdoksI	2024-11-20 12:09:32.916378+00
0ay35jknycs6s9fkl03mz8w16as0c2ti	e30:1t8gDE:3xVhkNBom0xUuzHVPJaSqcu-3CzBiONDSbFavLC8QPk	2024-11-20 13:36:44.819521+00
6ie16ltn3oat5u6gpbnno5ol26ea4kho	e30:1tAQOq:cbZcticCng7w-PymxBeA8vJ-bxW3X-Xcfer6jbkD_VE	2024-11-25 09:07:56.043734+00
5hfmw71e060wsav0gl5dndxzce0cwwb9	e30:1t8KgM:TZLAMeFyIPpH0EpHTudridUKf9HM4ZQXApYZ2nT1PMo	2024-11-19 14:37:22.548665+00
dk4hec2tl84zkoe64febyigefoxu4ghq	e30:1t8Kko:ffZU2Knmdr9g2odDWX7wAfUo1k0tcffDR9saPQCfQ74	2024-11-19 14:41:58.510059+00
t6vfiy3uno0agsviw51wolqpvwuql55h	e30:1t8fTS:Muv3rP06rtmVLsUSQ0nESfe19CteBz1RAzIRgQ3D_g8	2024-11-20 12:49:26.998895+00
x3mova6th2bykbqfgr2ufbxtt1mjnuwu	e30:1tAQZ7:goawYGLB2KhbC_meSH9yRXYU3pL2qH4IfWs5tMuHK0M	2024-11-25 09:18:33.396546+00
dn825iggwt8rji68l8uxzqhaudzof0au	e30:1t8flv:z9CK4sSyMA_lGVVzxYLasxgpz8r0O_C_O-BnoADyjaE	2024-11-20 13:08:31.860046+00
xtyl9gtz9814ib4oxmw38xglnyf4xna9	e30:1tAQbI:y3UqQCQfPJbl1w6YTqHxhubMpJ50fvf8OlDZdx9-Q0A	2024-11-25 09:20:48.4349+00
ny6mx5bqykvppwet9w8kj1xat0gj20ip	e30:1t8Kzl:WkSa82IGPYR1iUjE7VpyWVwH77XFDH3KtKoq9cH7k2c	2024-11-19 14:57:25.769845+00
we75gm4kxh6pqq8vdcx224u1vokj7615	e30:1t8gFX:DQXEfub7W9uiHsEs0-q-DyAIMDwDycFStA0P9B_s9C4	2024-11-20 13:39:07.939585+00
ufr8qtkmz429lioruokwbxsjeqmt1mhc	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8fuN:946a1ThOvP7t1JLeHOyqGG1lxyPzezVq0nQ1S5k8k1I	2024-11-20 13:17:15.720089+00
e9cicxlag3rgsis0hjafgxkq7uw7lst9	e30:1t8L2K:35OQgE-NSaCUhcHbebcZJzd26OV5ztjTEvr7sx2TOTA	2024-11-19 15:00:04.492117+00
70hkoi56iv1pnuviidr0t9zrxml0ypo2	e30:1t8fvE:fxuMMhKpZ5T7WsK2O84buaU0o8ZhRELV_mTmaEExR7o	2024-11-20 13:18:08.573494+00
edw6x68jg5xnkeg5g66ci6m625t19hk8	e30:1t8gGN:6Y-Eu-pRuJgm1B-lPYbg1Whfi1pMIzW32keY-z1gJq8	2024-11-20 13:39:59.402282+00
wggx0kozb3q3ckjijkhova7zzhsundtk	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8fxA:blr7gMOqrPQZlFKbvDQ8R4lhghc7X049xEsGUEeBkNc	2024-11-20 13:20:08.249903+00
p9h5y7du2lbg72aghgqyx9zhs0oal14d	e30:1t8lcL:T6CvCFNsLDPUM31yZMe5bLxHvirLXhir393YlQE2eVE	2024-11-20 19:23:01.754377+00
f3mj7in6o3rvqqs4n1pkfq3tdfx9jyj2	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8kGg:peQedTSBvNV-YDDSul_VNKKePMzxCRc7MY7zSoz2qPo	2024-11-20 17:56:34.589917+00
bamwvaju3x9r47gbxdq1z0snjecx1lk3	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gKt:vpaqbuFh0dOo3lyhwNuo4FPUUs-o19dyFCZgFvPoUJI	2024-11-20 13:44:39.887736+00
1u2w18qz9yuzihaujzhi2kka5g3hga1g	e30:1t8gMW:DOYkPinGxCpw9EEM1ndu8kiO8q_wUvk8Lkt_zoUp3qU	2024-11-20 13:46:20.911525+00
9hn1h4d71vj17rna1gn9y4u4vcs91779	e30:1t8kNl:lVgsC1LwaBu5ZThSYaUznp7cVoTIpJ4PnF0Bt84nVUs	2024-11-20 18:03:53.723839+00
nrcxzxpmfmuwobphiwymfxkls3jpx86y	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gRQ:637Eg3rf8izXTL8S_HshdjwPL9ofVIplC6wIyO7L1xA	2024-11-20 13:51:24.137603+00
qb6il93xe0q9da4j9gz0t03njntsn95i	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1t5vjh:tMyK4IbLrXaKswLU-WyGxm5cjKe0aLXWiUUCMtriWQc	2024-11-12 23:34:53.266804+00
nlsfx6t32dtpht79l06xhm4l7hk7qhfq	e30:1t5vlv:8uJTtLbkH5F5sq1c7iIHTyVfNNJi5aDrOBUKttjNX6A	2024-11-12 23:37:11.490011+00
8b6jlgi3xlvium4gotet12zir5occ9r9	e30:1t8gXU:GptWN5JB30h7MBXDJj1QlkCMI63fSRRr4bHQ1K3vYdM	2024-11-20 13:57:40.024503+00
9141gg9szbsdszv0gs7o91843xhcxeco	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8kR2:fIDA0DO-zaJnP1BYushdG86xuaAO9RpK3HXHph3peN4	2024-11-20 18:07:16.723854+00
3oirz1di8z5ohdwu0ao3gd6iwzed7731	.eJxVjMEOwiAQRP-Fs2kQpAVv-iNkWXYDsaGJwMn471LTg54mM29mXsJDb8n3Sk-fo7gKo8XpNwyADyo7gXXd4wkQt17a9O0cuE634ai0jNDyVu7H6u8qQU3jR0uJaIxjJKl4dpG0ltYSuLA4c6EzSWCMOrjIbEHBUDXKNFu2vFjx_gABUz3u:1t5vsv:DaSsVmTsvjAL-ttmLSQcM8cdoy6uck-hzeGtpSP_mLI	2024-11-12 23:44:25.481459+00
dhero3lhmp384cbt7z08tjz0kc667rm3	e30:1t8gaR:qDH0whqsRy_7KCMlC5tciQ9VcUkRKQuorbXBITqOoEI	2024-11-20 14:00:43.05673+00
00wtxz59worf84s3fhle4fy0he7c89vp	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t6Aj4:VjHOZLyzZJ2RDKAlLD1urd3ZM6p6JaxliPpEC43xiIg	2024-11-13 15:35:14.333559+00
ghacccy5567y9mw1yu60lrn013guj0t0	e30:1t8gbJ:1Io1PKWibEUssR2bwJbSoLAnQM6W_3SfFBQfCQ_mfO0	2024-11-20 14:01:37.789705+00
avirh35n4miu5xs48d13oyi7fjerlzon	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8kgZ:NNkgHcp5vf667Ib4ii9CDEYp_D91XUaJtLOc6VmAd2Q	2024-11-20 18:23:19.274494+00
g7su20wt7iuhi6un3wtf5bwf7v4kwzs3	e30:1t8mZ1:jiTGzZvcmh0-1jqrvJJVLMt10oSZRo5P19MTmPw_fKk	2024-11-20 20:23:39.591736+00
v0nixewyyi78euxi2ed1a54tadc3ukgp	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8kh6:nE-OoMyjJduvhpm4ULmhBZ6Ya98CmFc900z99MB1MGk	2024-11-20 18:23:52.368742+00
pb808l232vnvvsc4njtqijw9dispnr71	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8klm:zapZKEe_nyYD7nUJvQKs6jS4IevfN9B0AlFDLJ8yio4	2024-11-20 18:28:42.895051+00
75mudlhbuw5qk91gmknbqq0du0ooq7yw	e30:1tLH0B:LmY1H5bcfBiFw4VgiX_x6m-VODglihYRa3-Y_S1SXhA	2024-12-25 07:19:19.147572+00
t8k3pkpttdkkk1ghrn88iqc8eh62p008	e30:1t8dzg:jl_talRm1Ws-tJ3a487BeWsS6HQp68E_6ABRO6q0RrA	2024-11-20 11:14:36.581102+00
hybpzjcisgmxiggqoo28k0swq94dou3p	e30:1t7ac6:LZhWggHnQdXXPH6xkJ-9e6JfTgXoayNqRyAwwUlaWZ4	2024-11-17 13:25:54.131324+00
h02q21qh6wp2i2x2pn5zqh4pil5x518o	e30:1t5veV:iuyI84lbQRYDTTJZbh7wF--d93tq944c0bIhldrLN-0	2024-11-12 23:29:31.001428+00
d6lfiugj7tz661zstzkppf7tmv5u7ref	e30:1t9JP9:QvD5u-qjc2IChE4fATEKTviry_UPP4co_ciZG9ZJjrc	2024-11-22 07:27:39.454809+00
n5yzqmxd997zfgioea2w4eqz7dx0rn9c	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t5vhh:97f7zQfqZNQv9QPRxLyQElML4efGYICyVZVD9VGYuhw	2024-11-12 23:32:49.72329+00
oxm74eofs60irew0vkvwf4tjyn31wll9	e30:1t7bU0:KHUfKD196RG-Mf31Z6wNQF1iewet-odWQiWWsSoRLfI	2024-11-17 14:21:36.689374+00
bmt2i39rcme0oxqu9kka7c229xaq3npx	e30:1t5vji:roJ4gQEnC0qEJ7KCPPUMHCPVHIWZWE7o1JuhaHs4Xb4	2024-11-12 23:34:54.195728+00
4t7shy0q7zvlqv151zct1suerjuauy7v	e30:1tAQRB:gAlT-TcetlUt7nKe6Ajb8KQSSD-zMN12cs43hyEOQVk	2024-11-25 09:10:21.121986+00
4vaje5kqsuiudwdj67n2av5zgm4bndn2	e30:1t9Mae:cB2mGN5eJJj249jqoY-mi5NkIUPxvwQ7bbqrAowx8o0	2024-11-22 10:51:44.501502+00
ppy0dh2bem64fs75vb8eb6k05xg2tahk	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t538h:RXZ_3xwd51lKcSUvGrUL_NWyZ0D4RxjoUdBcZ6GJIQM	2024-11-10 13:17:03.224007+00
r9jdg583in1kdkdq5tufauhvm88umpe8	e30:1t7xWJ:muS8JqFDGArRXg5J8NyJmFfUkd-k5ysDxs1EvnNsWK4	2024-11-18 13:53:27.634806+00
s9hkw4qdzm4v53cp7s5d9jpg6hkzvctb	e30:1t54oq:dmvfX40nefvLyRbhKGdSIw0vpoFU6dc4P2HZdd9ns-0	2024-11-10 15:04:40.150129+00
s1kbzv04hbxvodlzclhrn2or57skpbv9	e30:1t6Aj6:gAZA2yMqwinc-Jzdcq3nZo5EGFGWhAURkxRU4MnCvPo	2024-11-13 15:35:16.191422+00
ty5xf0auxkn33faa5kx1zvcy689gh9mh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gC2:uXSqG3-P2zK0Mwb-mBC_uns6cs0WBi2hlYSQdRXmo3Q	2024-11-20 13:35:30.347243+00
i1tai6u3zk2w3ruesnnt4ypzqcnc1t1j	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8e9G:SPb797hLU64nny_WYmZyz5BmXTvRe6TPAONaeTUVUwU	2024-11-20 11:24:30.092855+00
kjc7azdtpj46o6i5jfmkznr42ljnytz4	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8lMS:3RTdH2fRayBFOz8amCHjItvluDNHTn3Y9b6QB6PxSrM	2024-11-20 19:06:36.460777+00
lo253jg7rufxzqqmwbp3ecpe0djf3sba	e30:1t8KgM:TZLAMeFyIPpH0EpHTudridUKf9HM4ZQXApYZ2nT1PMo	2024-11-19 14:37:22.450593+00
iouqvvcz4i9i9yr2msr912gmoxyjm24k	e30:1t8eIT:rzAnbd7cWOrw5RT5v3K6SFcUjrW430NUzl4LHc5EzSE	2024-11-20 11:34:01.439734+00
wdctft3mrte7u22tce0owf69ju36xfwr	e30:1t8Kko:ffZU2Knmdr9g2odDWX7wAfUo1k0tcffDR9saPQCfQ74	2024-11-19 14:41:58.636328+00
2w3ucrlgvu25hvzfu2b4x2mezifm8746	e30:1t8gCe:l8HhB63jjnJxrVfNclTEMnwPz5PHbPUF8_0fOy_rq18	2024-11-20 13:36:08.431776+00
h5dtlj62kjxyv8x3ctydltlsd7aoaxt6	e30:1t8KoD:SFXPzgzjpwO3dint-jhpnFJ57vhU_-Y2ybrV0o_gHhw	2024-11-19 14:45:29.033298+00
6t40a56lu9jyt89900jljfgra2isx281	e30:1t8Kyq:PkoTvJvL4ZiMie73e0hxZe2KEnhzXYXLDJtV7LLENZA	2024-11-19 14:56:28.225586+00
mz2k4tseg0ndpeibvyru3e9wgptotw1a	e30:1tAQZQ:Cz4rMdsn27lxtLkQ3-wQeEEWIM-KVxaOUcZvSfdIYyU	2024-11-25 09:18:52.665041+00
bk5o199jowwvxnj494zdahi2j86tahhp	e30:1t8Kzl:WkSa82IGPYR1iUjE7VpyWVwH77XFDH3KtKoq9cH7k2c	2024-11-19 14:57:25.151379+00
ro9145hiul92ww2w7mmjz3o29xv6dxij	e30:1t8fPN:Cqx0U4Ly5q24_d7IY5AOsXrlJ1UL7uCa2h0VXToxXs8	2024-11-20 12:45:13.621768+00
2ydv8ah1ki9fh0de8fz3a66sndhft0dv	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8fTp:iOLGCQv30xtY5ktMNR35S3EQxwECSeDQwYOcmbplVFs	2024-11-20 12:49:49.805625+00
l587e0ksdiimdopp9eg4ajb9555jht2g	e30:1t8gE6:UdpNu9CZNj2Tc3F2-7Cq5i_34ATlWe_heO4_zjdLr6c	2024-11-20 13:37:38.182118+00
rt7hcfr2r2rw6apwta16vocu4cr1j677	e30:1tAQfS:gJy4eimEcmZWilz6om_GY6awMQip36o2Q0_-mbOyyAU	2024-11-25 09:25:06.46068+00
r9ngt8450nk6r4ctoq5qzbrkoewgoodx	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1t8gFQ:czryjkuxIqmWkjNq6VdHKmeOhmJ-1WpdzMQ2bHYH34U	2024-11-20 13:39:00.87936+00
9vkl6eu3x2t1uqusxavc1puctmwui4fk	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8lah:Tjmer1n85edwWSSZT4lRI8coMZT7EBTe15PzTb17yPo	2024-11-20 19:21:19.29919+00
vhsymdavybq8ugvig8tob0jc6hllw3y7	e30:1t8lca:h6u89zBeJPWlO6VXlKDBeGXlfkaVEjF1Xnb57PayAP8	2024-11-20 19:23:16.978539+00
t6je2roc1975zfeerai39ilrbgtnjrs0	e30:1t8fuP:UUyeI-a7Ty1l23XYurs3kUjcnW_Yvgnc_0JRSHEBjKo	2024-11-20 13:17:17.58107+00
9vp8stxbjijpatke0sffdgaj67pv5y4u	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gGy:cSO6Bp_3e4GvpiGfpyB0DupA8ekxxr8zkh8otfb9L-I	2024-11-20 13:40:36.894709+00
30uotpu5g2lvkmwhszihwis2z8ng9jmb	e30:1tAQtc:eH4C6OZp9-ffEKl4VcmikHlqbYfZmVNHTP-1fVFKIl8	2024-11-25 09:39:44.764286+00
z6tn4i0oo7cru8w49qpxwyj2n359f3eo	e30:1tAR41:61KNt5asV6GQtvfZodAFE7CdN5NRAqCq5NOsqm-Vzzk	2024-11-25 09:50:29.994806+00
njqtl69ipv2e0qpjv35mwzipf6a4a8vn	e30:1t8lh6:NRixWTcr0KxLowl_QYC1OkZn8iuYAR-sjlFoVyQo9GE	2024-11-20 19:27:56.009903+00
vuz9bdkqa512onnr8po9069ui3hxvv6q	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8g8t:0ouUDuokQoLPiOWNAHjOvxv34NrlQpVUCy1YLi6FwjM	2024-11-20 13:32:15.470562+00
hku3ll1le9cksxr7nfn0foaijhqn17iw	e30:1t8kL7:xIfAQYEQ9cwUPYfxasnb8NRb-4A7RZ6jo5sHoH_tQ9s	2024-11-20 18:01:09.788034+00
1jyp689xdinw35qo3kyb5wzcvrzfyfou	e30:1t8gKv:dqF1KNrg0Nc__3cgJZTeOZ0xOMqwjQNX9c1QiDAlgvE	2024-11-20 13:44:41.791604+00
elrtpdlakgss7uphw6h52t3xos0jz3ff	e30:1tARGO:X7aTBsAJ6Q-PkOEL7WHwq3uAdpXimDNfoDL_ZCD2OCI	2024-11-25 10:03:16.267982+00
oj6xfv8cfzb7d327absqrqqdg7ibjoni	e30:1t8gLu:9ChLn-hgvFSY6S3lu8u79EEuAc9mfXVNf3JyWJP4o_w	2024-11-20 13:45:42.79858+00
pct9sn7s53cp5b025e2yod3r1b9qxvzr	e30:1t8gR1:aa7KhNkN7xTWgWKMOjb6QhaWaPmkdeereRtBUoTJ_vk	2024-11-20 13:50:59.052048+00
lrjvnfwytjduov2szslge7jtav65u2zb	e30:1t9m2X:B6lg0OvnBjOFvcrhzWj3dFVnvBmd1qlrI3IlVWzbwoM	2024-11-23 14:02:13.83972+00
woo9osm58jok93v6fhch6aw1rarhpr2q	e30:1t9oT6:JwdwMqcIxaZrLV8SPmz3nnUAGNy2MxSgsIihkgKiKww	2024-11-23 16:37:48.134197+00
xqji7jnnejtv3gynn53cc2142o5dv0qv	e30:1t8kga:6PpGJIyJifWBmYUc3VCCshHiq0Iow0xbCfoMvVWLo6o	2024-11-20 18:23:20.354423+00
zg7jq5df8736uztx4xba0jt32labslxi	e30:1t9qQ7:mw5DQ8CebvvCsBdjSjTh0b7xGsbpOyl3_GPK4uDHg5E	2024-11-23 18:42:51.970897+00
e34vcbbkt6ncsz7nhp7znoa44dr7sar0	e30:1t93vF:-pI4PWFXJEhgO3eUdxug73claE5uq_DV6uZJ9QkS82k	2024-11-21 14:55:45.691282+00
fh7y6h56ri06te4f2ltpnqd3b9ppy5oc	e30:1t94Ka:78fEM4wufYrQGQlYWbSHt38u0-EIU7PVqngxgorTV4M	2024-11-21 15:21:56.83829+00
u0f9rth176ewlaqb67oo2l95br1clp05	e30:1tA7zj:69Iv3RYXsjSoLN2ArPjDo0mX9qBPvTfxFU5TBONQYzE	2024-11-24 13:28:47.902613+00
4br7dxkvja8urogek5c31fe3stxvw1fz	e30:1t8gfa:_Qec0G-fVQVeG4atvK9Ql_YcSPDVZ-Lr0d6aojT3dn4	2024-11-20 14:06:02.149172+00
qw3zi5p12qc07b3p12k85siirv668jic	e30:1t6p68:fTws0UCZfKdTcKUrF34uNvwNksic4ctD0flr5pJCJIU	2024-11-15 10:41:44.782417+00
9mpyt0koa0p0l734oq18nx50eh4zwxil	e30:1t8dzs:WhbIF7pIqsdUumpbJ6lxWuu4hiqQdjSkX4ORtudioG0	2024-11-20 11:14:48.283518+00
kmmdjpq09sggp314arfd9tcjxrzwlysh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t5vfX:n0WXWBDWYmPghV9Ax8-3fzNV891nR7QK2qe6Z9W-Zc8	2024-11-12 23:30:35.489595+00
kjda4thblc0nwmlp7pxp57yfb6kxm7ie	e30:1tARNI:KP5Woksd7PKZQpALM6O1N7jCmxacQxL52Q-D7CR380k	2024-11-25 10:10:24.132788+00
4t92ly3e7zlqinw9hn4uycyc39kxwbj8	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8e8Y:mu5m13O91M60oHPK4uoZBtrpsA_DiSi1GChNdzofIdI	2024-11-20 11:23:46.774394+00
5cg28eruvari06vvarqeclrcj8lt0lcw	e30:1t7bU0:KHUfKD196RG-Mf31Z6wNQF1iewet-odWQiWWsSoRLfI	2024-11-17 14:21:36.684485+00
2oxfzrlfnax1tudk6kcw9by1cngwt9j0	e30:1t8l5W:-hLS4GxqtDMwA9ZIkj1-cz3sLJfmHrCU3Aa18Z2zbDc	2024-11-20 18:49:06.955749+00
c1xpjq642b1m4o692d8slnbitfq6i7lm	e30:1t7xWL:QhBYxK1LvSx3a0xLuFOFPfKNynFxHE6kncQSB4Xh2VA	2024-11-18 13:53:29.637366+00
kbv2dqrncw0l3e10dyqqunsexe8pudcv	e30:1t69cS:lVOPLLSCOJtncN6qUbidQmhwW1WmiipwouSbUpUWXzI	2024-11-13 14:24:20.956118+00
28ejff5an8n4bon4ljn924zsy647wc5q	e30:1t8e9I:zAP46NLqp4KewQyKugjxeAFrOM4MTrRUgS6sZ8xafYY	2024-11-20 11:24:32.305425+00
vmyxg4l85jemidjlx63avd6j3bghrzml	e30:1t8gC3:Yd78GUhn0vowzwha7c7n8PfPPgkipANF3RFZyPSc7oQ	2024-11-20 13:35:31.15488+00
801risk9z253gu0ua0ic5a3y3988pgtp	e30:1tAQTH:VNRANNRya2U1lUF0_HixMmLFzTD-xPZUD_axE4t6jEs	2024-11-25 09:12:31.914008+00
lj43f1ah03hvwg80049jrkdmusjxp8ks	e30:1t9Jyw:ZWAbOSa5BWDKCg8wL0Z4rCpoie_LNwyxYFvxuMs0jxk	2024-11-22 08:04:38.329082+00
f7hpaz4rslvbt7nrh5chfqxldcbjrrfw	e30:1t8iyk:i8LdiHil04t4AMh9HeHFE8Y9x9RqifTjvs-BlhOhh7M	2024-11-20 16:33:58.338002+00
cmv09e3235zrogh0a1rcnmtz0duteu3n	e30:1t8lP9:7gSL-SQxwQzalobEg0YBIN1u5S2RtI_8cXGgbwK9eA0	2024-11-20 19:09:23.56568+00
ccqa0jzzxkp7m8kf3340prcyw1il9jux	e30:1tAQab:4WQGMbDFD_Y39TEgt3efFrV8r_cFRSq-n01TvGzyTpQ	2024-11-25 09:20:05.756077+00
dy0edienxi2g7ohpqgzstumh90jofrhf	e30:1t8lW6:6MOL_ZFS1E2c9ZcacJHx7R77LaEy5TfGWUzSR60hCDM	2024-11-20 19:16:34.072109+00
ztexum279uzfkeut5rpjcavtr7dxr11c	e30:1t8gFT:rfh4yIXOZKhQNz1xCX2jvj18ad4XBXKTRQINITWXUk4	2024-11-20 13:39:03.75497+00
hmlgixajsv8a4ch2f5ns0v6lx6unv775	e30:1t9N4q:eK9PjMVV_I_jx0GnyFsfOo8a7W07Z33Rdepxhx7aso4	2024-11-22 11:22:56.072352+00
l8cj4u88r68hty72gcu4yxc6js5cre85	e30:1t8fTr:UxwheUFIH2FN7X1G0zdUk2FHYtJFhQGCFkm_kDn9YFA	2024-11-20 12:49:51.7536+00
w8ww6ksfzowgd1dbcebdt8f9qwzil48t	e30:1tLH0C:eNRgoZc0wWQPPYxHOANwmpFEkCw7t_413y9FDXRRAso	2024-12-25 07:19:20.054416+00
ytpmf4ctv9m95osyiqwre6ue8gp56mg5	e30:1t8flw:m2zKu5MxJaXB-ZbDtZzzJE71BM2XgftiKjN4d69RQzM	2024-11-20 13:08:32.675933+00
f3s0nmy6j7flzaxnq4uzbu1f1oh3d4y0	e30:1tAQgp:tFXeCj29m2bBo4hWPhp8NAjXm0o4GBfDpE2axHbEjYg	2024-11-25 09:26:31.334153+00
kl5wi4517jwcy3xt6qmw82h2luju2y9r	e30:1t8gGz:aKJAenx29jhjvhE3jM13u4m3h5-nKRxx9IglzAqkBSc	2024-11-20 13:40:37.971648+00
klec56lnqh9p2add9ffkyc0sn1ybrrr0	e30:1tAQy2:MFVF2WGLoMu1m9vCnabpYe_OgvsEplAuOA6F-irCuIo	2024-11-25 09:44:18.287422+00
5cpniv646isofg13flc3kn3jome51mon	e30:1t8lgG:PrdEkSja5za2BZGM82H_6XY4oaMzZ6kQfkgshVaCbDI	2024-11-20 19:27:04.710518+00
fymuqziqrrvz53tigw8rs4jjyv8gptd4	e30:1t8gKX:lhX9TdNAX0Hg-1FV4qJ_8TQzPKt5TrDR_RvbruaXsWA	2024-11-20 13:44:17.067526+00
vdzpr981ovt5gn5g86g9u2q2msjtjjpl	e30:1tLH2U:60N2ghfCEx01QrJoSS9bF1NW5HgW2-xAv416rB5WCy0	2024-12-25 07:21:42.284432+00
60ovdyvjxlzmflvxjugpk3xw76rxulrn	e30:1tAR5X:aZNoX5xLOhShB7oG-E15a8yCyyXdU7sqbKK3PL1JvwU	2024-11-25 09:52:03.268569+00
72ucd66eb7lcczv6w5qrf2sno76m5rf2	e30:1t8g8u:Zqur2fKxDSHn6HuGH4cCzG1uA-weZDspTcSBtDXeosM	2024-11-20 13:32:16.889234+00
lc18skrbs0uxrhre9vu1slv2o4w7d19r	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gMU:HouEHurBxaOVZRM4clLZMg8otZNhV2-ekS9Jd4zJaQ8	2024-11-20 13:46:18.670067+00
72a5rls5q39l318da67ab5dtkvewbelv	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gAI:nb8hrEE0s0v102cQgoi4EaRmQtI-NuC8J7VpdDsTisg	2024-11-20 13:33:42.683544+00
6eysm55qveq2x488lk1bke09e1etes8t	.eJxVjMsOwiAQRf-FtSEMDwGX7v0GMsNDqgaS0q6M_26bdKHbe865bxZwXWpYR57DlNiFgWGn35EwPnPbSXpgu3cee1vmifiu8IMOfuspv66H-3dQcdSt1j5rbfAM0mWRBEFBF4t3CMJIWyT5RBQtKqucRjCGCha9QUFWKojs8wUF2jfu:1t8ltE:ZtC4-0PnsdsAyhklZNrdNyaaV3g75_hAycjGQutwdpg	2024-11-20 19:40:28.067435+00
bgte9hxd42s7613k04ijjsdr92wzdplh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8kgd:dC76Ng-3gFYoLcsRUs6088iaJVJmFKljBA2WvbMylqU	2024-11-20 18:23:23.485905+00
1fwz4trdokfbwv1rqs9goqry62vh0141	e30:1t8gaR:qDH0whqsRy_7KCMlC5tciQ9VcUkRKQuorbXBITqOoEI	2024-11-20 14:00:43.492771+00
zh1d53zvkg1juuq2ykyr9gxeirz2cpt6	e30:1t8kkA:Z2pvQm1D6pjYXMpk1SU37hTvjBcxO0Tfc2IAHeuX4uM	2024-11-20 18:27:02.422183+00
z730sogjwprj4dv0ywnkd1rwe2ft8kji	e30:1t8gbJ:1Io1PKWibEUssR2bwJbSoLAnQM6W_3SfFBQfCQ_mfO0	2024-11-20 14:01:37.210536+00
kpkx7fbocdf5to0jd9o4fqvyiw9yvayl	e30:1t91jt:DSaO3VctuDnfG2c_8bHXM3SrrMNe7F6-E_2R3v-36C0	2024-11-21 12:35:53.569158+00
zvdzkxa8cflf7sgtuxlvo0gx2f8ph371	e30:1t9oT7:4mtgb4IdHIvX-kUMU3kbrSjOHMl2pYsI0JW2oztiFLQ	2024-11-23 16:37:49.86719+00
d0h3os07nfsmdydkc220wkwc117n7typ	e30:1t940T:ETixlqtxW332A-7jgF1iC8LxEq6JGqLDhXexJ7ERVeg	2024-11-21 15:01:09.865808+00
gwn2a2qg91nfd5vl7k13qwzgwrgtzn9j	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t94KW:Jt2nCVwGWqc_235asmRLF2cNctBpzPGbCApN88QlNK4	2024-11-21 15:21:52.101952+00
w76kdicl6d66ca7kalzbuuaiz5o2i1oc	e30:1t94Kf:YrGIXuW9py1ewoTAi6hwxAuWysy7vvjUtR5BMy7prXQ	2024-11-21 15:22:01.324409+00
0mn9vpelzeevntsnt1aabuldtzi0xfe2	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1t94LK:lBU5Q5K1antMRNKWD2EMD5HhATdFWL1p1Uig7mdTUYM	2024-11-21 15:22:42.345631+00
xwucck433xch1w9x31jo84wdzqu661ch	e30:1t9r77:S2n-fpbjQa0N4HdUz7x1-ElnO040afmaqa7-7s2YC58	2024-11-23 19:27:17.410559+00
df6i0wa421sj2d8yiy1wlka2ttqr6ml5	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1tA86i:ieHEyZaO-toKlB7ncgj8Ub7GV5Qqi9C0uD7P6j9SjK8	2024-11-24 13:36:00.767564+00
fycw4uchl4gv2nrxl1ostivwddiu9jbw	e30:1tA9fe:lcGHoid125zO-gEef5H-yTbgbuSOH1tfNUnF5W_IPPk	2024-11-24 15:16:10.181728+00
srzxw9i9uq3v4o9dtsvdt3oxv3ohptm6	e30:1tA9gy:6frIJlxm_7l1P4o-W6HY4LZMa32J7SzE7wGnC7yLmho	2024-11-24 15:17:32.186456+00
8y896s6crqnvub1pcozqlp6pub1x3bky	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1tAEZS:b2YbWrFU6FJObVofyE3uYPt07Ucv_8gI7nMWEgG6VAM	2024-11-24 20:30:06.95428+00
dp8to38skbmwklu7p4pqgkeel89qcs8d	e30:1t5hTk:4xTgpGhu9wFS-YAsX6nXIfcFlazAyVE_1Ah_58yIiJU	2024-11-12 08:21:28.093952+00
8859cmc1hwao8qclx5frkvboiwqlmumj	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1t8l5o:UycmXU51KpfbeW5bQE4pvXbFlUReGAmscorFR85Ynxo	2024-11-20 18:49:24.50135+00
kqvgkmcqek98jdy6irxcse5sm4w8os6m	e30:1t5vfY:Jh2P-eRX-uIJAApy1sEwh_RkTjrpSmCKVgHqGSA3grk	2024-11-12 23:30:36.748279+00
lkvso1p8bwgqij9o7erb3i13emdzxful	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t51x2:3aTY7b_PX5lWRd2L6nPCDUQz2iBrTUKXhhJlmNF_Jos	2024-11-10 12:00:56.139148+00
a1lhjpebhe3d5h7gpe2l8qt8usddgsnz	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8e7N:fhq8cBn77CJTkedyqco07_I02c_YZDAFwF7fQ_9QTaQ	2024-11-20 11:22:33.502232+00
6qya88rgiooylo7suo8e9lxw6cthzjne	e30:1t52qf:JWxClzk-6VJ2yGA2MU0bF-dusB8Ee634zMFT15NEX-Q	2024-11-10 12:58:25.126956+00
q3oy407l93eryl3j5df2f1amcfxw126m	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t5viU:gmdOg6FSiNp7gwY6kj9JVzAjr4COPbCXjDmTca7C7_k	2024-11-12 23:33:38.510596+00
hx6llg7rxuozpg7vi0ionuumu5ffxqwy	e30:1t532Q:P_bvCWMWyC96qO3N3DnRkijEf7-aSHbMH8tbRb_bmOs	2024-11-10 13:10:34.895125+00
e64b0j1qslwwv0j6mxe62kssz31j2a1j	e30:1t94Mg:DurGwCYlZvqabrPN5sd2ndnwoKt6Es2-0ElZytB0tcM	2024-11-21 15:24:06.548657+00
x1a1260ipycrldixuwahsuqe362p39dc	e30:1t8e8a:b817dMq4tmHE6Bf2Lck-hFXZOLPpDzMMttx5aScdLsI	2024-11-20 11:23:48.175101+00
a06dbgnp8yold5z9cdng6qbnfi4zhrxe	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8lMv:sg8QKLgFhvaEH8O2MZ9h6KVp69mxx5G_LZSzZ6P3Z2g	2024-11-20 19:07:05.0046+00
ykrv16i03li353gso942pg9macasn9un	e30:1t69cS:lVOPLLSCOJtncN6qUbidQmhwW1WmiipwouSbUpUWXzI	2024-11-13 14:24:20.997559+00
966hbl5yriseamb7s1gjlh3f0mwllu96	e30:1tAQZ1:YwDPgKuMEkPJys8_b-V8lZ3t5o-s4hmTvsic5iWC0PM	2024-11-25 09:18:27.678759+00
gcwrskcschhzuofy6glxf2fgus54lvd1	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8gDD:c3Mpa6kodKO_JHvW2aQKUcf7Q30SAnBP9MI7ftHoAAg	2024-11-20 13:36:43.491916+00
ytb3d71ch1iw29z0wd8nqvimdx5s2w9f	e30:1t9LuG:FZdhcZVwM0YTxL9B3V07u8l4nb3ZKYNr1MUNSXLsw2I	2024-11-22 10:07:56.198474+00
ttgr55q18zw3s3bvjxp07v5khnrkqvk6	e30:1t8fPM:M_lD-8ELz4iAhRiRsEkSjVEAeJTbpW0y74MKvrn8FVc	2024-11-20 12:45:12.896237+00
eyafdtirrz6265jo2no8g0qlxv7uutx2	e30:1t9cQa:jSNdLCzwRCD7hvDGW8b-NcVMOOH5wEPZDsjU_ekRSL4	2024-11-23 03:46:24.683216+00
q12h6jax1kn2mk7jvt9nhxpbu23jppi3	e30:1t8gEt:ZbXqZuuwFmG3PusqSd2tjnsJwFcw_lkpc1772DDyR3E	2024-11-20 13:38:27.247056+00
qjyho3pe6j79jza8snbukh7lozpr28gl	e30:1tAQb3:v1BrqZAozj7mk9iReFM3D71zW00GuXDsv0K5vpf77lQ	2024-11-25 09:20:33.353385+00
21k93ks37g14ethk4qhsrxfugfdvlshj	e30:1t8gFV:ltrTIdQG5iUzqf6WY5Qfa7jq6mu5mxuLwm4Uhl_oN4E	2024-11-20 13:39:05.138373+00
o522gwyqz9otmzkpmirmn3elu98y3ynf	e30:1t8kF2:w8BOvYZL7Uf8GUOwarhWDhzqXJMxssEQ3_on59-Vcw8	2024-11-20 17:54:52.20669+00
skrad5w9azdv8r7epxncleg2gtxa0mrq	e30:1tAQhy:T9Ek3mOpPI_lT0gXOMjjoU6xgWahDbLFlUFNDEaIOrE	2024-11-25 09:27:42.906095+00
grno2cx0c8qwqlnkmr2nf8o1m5dmmquz	e30:1tAQyu:P2bAqGrLb4lPCcKVI_lTK91dcB1X-Z41yoe--ewtNMY	2024-11-25 09:45:12.251355+00
sf4fztibr2esjnlqoez4awojpos46lzh	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t8fvD:UPeJkqKl_VUxVJhVlDef0H5LGNsAb6ztqsg81eLxNU4	2024-11-20 13:18:07.041422+00
x9fs1wxu3aag4oiu43dfxfjrw6eil06p	e30:1t8L2K:35OQgE-NSaCUhcHbebcZJzd26OV5ztjTEvr7sx2TOTA	2024-11-19 15:00:04.852812+00
v4jz258ycuq4uekby0jqo6b34esncwpv	e30:1t8gI1:k5xGUArjcgnH0EXH-st7HYBovFEU4xJI6eBfK-o6qSs	2024-11-20 13:41:41.951463+00
jfz02akzd7lisiyzatxkafq2mwfvbx9a	e30:1t9lbj:UG3RwmmU4t62B7JqK31J7_Ke8irN3JXu-VoUUWjERag	2024-11-23 13:34:31.576768+00
gucc0d5v8us8ug5i85xpskexd28c17tp	e30:1t8gKY:wRaeptIvUIKTNE5C8qYkADMNEK454SCc4h7VhLKVweE	2024-11-20 13:44:18.674007+00
nhob30ss7589wc4omoqrxpfjqzhg0sor	e30:1t8g4y:HFx6D-DxaImmTRq5zmkiYAPzcTCuoRrejGzQLWNRwVQ	2024-11-20 13:28:12.288923+00
nwchkvm41npkityy4bj0v48swsqba2f4	e30:1tAR5j:2RGZ-8TUAzeRPfAw23AiP_E5KKwoCaefP_nfVo41E00	2024-11-25 09:52:15.222914+00
zt8lja460flddqz2c7d0urqvd95j8cit	e30:1t8gAK:HkNCYItyeu4qLUxkPpUZAe8h41W_RjT_bAa5-ZrjA34	2024-11-20 13:33:44.011063+00
2uhij4kr1wy4gqtn7jhj3im5655svdis	e30:1tARGQ:cj-9FMhD504XkUHaL-ba3doiLe3LZvcLatrPKotBftA	2024-11-25 10:03:18.577824+00
lyc81sajf8noesdyu7gud0kb11hqm49j	e30:1t8gR1:aa7KhNkN7xTWgWKMOjb6QhaWaPmkdeereRtBUoTJ_vk	2024-11-20 13:50:59.817526+00
k1bbus4qh0gzsf7l2vnwzxr4krr7w0bo	e30:1t9oT5:PXQSziDIx6tLHNjgQf7aXAtGmHP8HYV6LmHfxnCcp80	2024-11-23 16:37:47.78023+00
dk8j1287pg82lt6tkju7e9etqpb4xmhe	e30:1tARGS:EyfFsf1anGBPGF9zBe_mE9ROZJd-a-_i4s50hULsRFw	2024-11-25 10:03:20.799655+00
wpd05i02o72v93uypdn1236d68nwei1r	e30:1t9oT9:sfBLUqdjTAtgYTsWscH-llxyiFTu6heQTWNII7vG0oQ	2024-11-23 16:37:51.426573+00
czbe3pv1mprknmn2rciy1d7qvw7zzj41	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1t91k4:4vra-dvmDH9PHUZiyJhKL-wLo83DzgUqd5MIhchkh1w	2024-11-21 12:36:04.72226+00
l8axitmp0w7ma4esko76eux9cmmekeub	e30:1t9qQP:QN4HlvdePQgW2orgmDH4pc3h8aW6Sq_zHRQ4Ww_A-AU	2024-11-23 18:43:09.884297+00
u9mdsqck5vh1a22o5pclfefrrp57kpg8	e30:1tARGU:0I_O_ZWNg4ekAjqfSZ3MBjj32ZYxziB4rToUgkLlCzE	2024-11-25 10:03:22.300976+00
gr8l6708oil91z6jscl3h4fld5vttk66	e30:1t940Z:RkF2Ez2X8w_WcxlG70kkGgfabJnOUoK_mMU2fo4esz0	2024-11-21 15:01:15.455824+00
fha39jm4ghz5d44ov37y8jwaz8jd9tjw	e30:1tARGU:0I_O_ZWNg4ekAjqfSZ3MBjj32ZYxziB4rToUgkLlCzE	2024-11-25 10:03:22.576793+00
890bglextv9w3fk8pmk7ca4gw99tj0u4	e30:1tARGU:0I_O_ZWNg4ekAjqfSZ3MBjj32ZYxziB4rToUgkLlCzE	2024-11-25 10:03:22.608289+00
378fg09t114fljfxpqk6ny8bel8ik909	e30:1t9r7O:BYU3LIVNthycOL_qbHV68PQhY6l9fyGaFB1Mk7Hf2FY	2024-11-23 19:27:34.460155+00
oml5uwwdf884esz6rl3nh5hz31017nc0	e30:1tARGU:0I_O_ZWNg4ekAjqfSZ3MBjj32ZYxziB4rToUgkLlCzE	2024-11-25 10:03:22.947485+00
j0a0svv0ecmr9ugyj5qdbo89wowmibhr	e30:1tARGW:zJoX-GQcDf6JHGneY6VDMB7x-lB__qD4qpzvZdjkMmk	2024-11-25 10:03:24.639771+00
gtwtc4cs6c8nlzsbgmr4rmku5yuov5s5	e30:1tARGX:yAr-TBzQf0InJA0H4c7TpfR6zzpYp1C2Wcus-Bo9tSg	2024-11-25 10:03:25.372353+00
bjnp9vwd9sgmv6v0cakjh9q7yqbwtbf3	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1tA9fZ:QlivK7JgHYyuz5MluwMizzhuHgkhRrHw2vSZd6II8JA	2024-11-24 15:16:05.404547+00
sixez68db9560vp8k21gwkn048vmunrx	.eJxVjEEOwiAUBe_C2pB-Cggu3XuG5vXzsVUDSWlXxrubJl3odmYybzVgW6dha7IMc1IXRVGdfuEIfkrZTXqg3KvmWtZlHvWe6MM2fatJXtej_RtMaNP-TY4d2InPjq0V4gBi5DEg2q7vIT5EA3CICB2dmYzJ1keOkowBqc8XKoo4jw:1tA9hN:Ib453dil-35tFd3XBFfCD6DX9d1ZFyEILH21zha5jR0	2024-11-24 15:17:57.989648+00
dgzwtj5u2j7aeb6sdpdzh6w7pleicll9	e30:1tAEXw:zWGr4mZFtJejXPWVYSDSGq63ngldVGajW1qn1Zw_e4A	2024-11-24 20:28:32.000277+00
q5ezev4g6a0ofvwgk1ce50xxerz71ofm	e30:1tARNJ:vYR4ZS5nF9Rns3_tXp6L4UBaCIs3oHFADWNij96ejK8	2024-11-25 10:10:25.643492+00
6ziy6f7f28jg01gb5j20jcwlhq75renv	e30:1tARGW:zJoX-GQcDf6JHGneY6VDMB7x-lB__qD4qpzvZdjkMmk	2024-11-25 10:03:24.932362+00
xecwgbh4x0zjt5kbu9n8g144qer1px85	e30:1tARGX:yAr-TBzQf0InJA0H4c7TpfR6zzpYp1C2Wcus-Bo9tSg	2024-11-25 10:03:25.124142+00
ttrrfilmv9fvis7imte4a3asldxordg7	e30:1tARGX:yAr-TBzQf0InJA0H4c7TpfR6zzpYp1C2Wcus-Bo9tSg	2024-11-25 10:03:25.807514+00
7w3uwtupqkftqzdmyj1yflhkfrz0v6q1	e30:1tARGY:pFWjcHkaFcKxULk8vMq57OH0xZp1eQaPOAvLKmnW8nU	2024-11-25 10:03:26.926801+00
rt7srvkb7fbcdycj84r19m4s4s40zr24	e30:1tARGZ:WrXvu1INZb1CetPEVf_TbeZsS5uSDmz1-bXxW2QUU1c	2024-11-25 10:03:27.252921+00
ot967t1hh22eqhoa26sa3ijldtvj4zg9	e30:1tARGZ:WrXvu1INZb1CetPEVf_TbeZsS5uSDmz1-bXxW2QUU1c	2024-11-25 10:03:27.266462+00
5p7pm1u0k9zrzdwd5r9jor2r046y546a	e30:1tARGZ:WrXvu1INZb1CetPEVf_TbeZsS5uSDmz1-bXxW2QUU1c	2024-11-25 10:03:27.469044+00
e6vd0k9d824342pxdpne204c10mz0s5j	e30:1tARGZ:WrXvu1INZb1CetPEVf_TbeZsS5uSDmz1-bXxW2QUU1c	2024-11-25 10:03:27.487903+00
7ebmkw6cotbqjv2sm09s3y6d9fr6z2kz	e30:1tARGb:z9ZL-7F00U2c3HT6iCdQ8a_KFvVw5jzXtdsw2KvZwxQ	2024-11-25 10:03:29.248663+00
wuqjf2zewkmicjneqq3jerq474l3wivg	e30:1tARGb:z9ZL-7F00U2c3HT6iCdQ8a_KFvVw5jzXtdsw2KvZwxQ	2024-11-25 10:03:29.621025+00
ohq7p7vox1jozy3k34cf86iqodhg7ilw	e30:1tARGb:z9ZL-7F00U2c3HT6iCdQ8a_KFvVw5jzXtdsw2KvZwxQ	2024-11-25 10:03:29.881963+00
6x49qbkppqhnxatuu7z51irrn2namzec	e30:1tARGc:RnNTsXqnDOCJpmwIlTzabQ7TcQc3s7wLNH_jSuM4WLY	2024-11-25 10:03:30.003675+00
26zk85w97eaxkfs9oo2k69o66dpjd5ws	e30:1tARGd:Riqd6ASUiBMFq0ZAcNhe7QT6h271Rzp09buyLHSAwW8	2024-11-25 10:03:31.849842+00
gm4jwz0gqt4j1lzvc39hym6wl02gw5sr	e30:1tARGe:MR-JhzFUXltsaHSrxPCvUVlNzd3XSPS2RIqByS36DUo	2024-11-25 10:03:32.122102+00
rc036pvahra8jqrf2eks5nvucvfgbdgc	e30:1tARGe:MR-JhzFUXltsaHSrxPCvUVlNzd3XSPS2RIqByS36DUo	2024-11-25 10:03:32.187312+00
el439jac1fq5f1sdk24kz8tutq0p7ktg	e30:1tARGe:MR-JhzFUXltsaHSrxPCvUVlNzd3XSPS2RIqByS36DUo	2024-11-25 10:03:32.453751+00
4thkm6n0gn92yjemaxswiledejswm9lc	e30:1tARGg:LiAGb5Si6ak2iZW8RNJgFK2KlhkaR-MmJTVwAc87q1c	2024-11-25 10:03:34.003771+00
lbkd54fikkl7oa6q33425xtgxm9lkouh	e30:1tARGg:LiAGb5Si6ak2iZW8RNJgFK2KlhkaR-MmJTVwAc87q1c	2024-11-25 10:03:34.447244+00
i4wre7lfgho1oav2bug9mc11xutmtt2v	e30:1tARGg:LiAGb5Si6ak2iZW8RNJgFK2KlhkaR-MmJTVwAc87q1c	2024-11-25 10:03:34.593502+00
hc3v5i5vmoaowcr04h5xo0eiz9vm7dqh	e30:1tARGg:LiAGb5Si6ak2iZW8RNJgFK2KlhkaR-MmJTVwAc87q1c	2024-11-25 10:03:34.697505+00
01u2cj50g7rq5ryqpo7doa4u3m6try1w	e30:1tARGi:PaGZiQZWj6-L2YYelg3zfgzuwevdltArdMZw4y90p3E	2024-11-25 10:03:36.689087+00
eph7tbtrpu3etoe17ire1lakph686ie6	e30:1tARGi:PaGZiQZWj6-L2YYelg3zfgzuwevdltArdMZw4y90p3E	2024-11-25 10:03:36.894352+00
lb8krs1lhjz6t0opw4fqlcblw9aw4c9f	e30:1tARGj:lY9ORlalbJ0BcFa2PYHl3jToDUuI8N3leqByy8eplTU	2024-11-25 10:03:37.544503+00
x4btkf946cm0wo3vtgqtk0tnsy0v1ztg	e30:1tARGm:EdGDGCj0dihetoT_YY4XfCbeAJvQwHyXdgqxe1S0t24	2024-11-25 10:03:40.317064+00
t7b0pr2fjoescp7rzfy9eehmbpgkenw5	e30:1tARGp:bREVyNcL3eDcmKW1enmbHhJ2mSlyF_0Eqd5xi8kUd70	2024-11-25 10:03:43.150238+00
qfwlv6olovjdtrxlko3pilbf6vq2hyzt	e30:1tARGr:HzAFhfLYJASF7HhkZsabSv4U1myWbBBgTXI4DWOjnvM	2024-11-25 10:03:45.98615+00
8oexsj1qi8sikdb5dz2krf8ngx6ehjci	e30:1tARGu:ohAPhfIDfqxsyV1LDUmwEx-DkAfNN6mKAEkTiA1NZQU	2024-11-25 10:03:48.790007+00
uqnmg2x3mvpuslhejpj6j7bodcchjnn7	e30:1tARGv:yRg0xyfvn9G1wMCAtVqVCHgiUCGukoXTNO3AHh1vNio	2024-11-25 10:03:49.424188+00
qd51snke10lklfayq3fly1irhsjr06aj	e30:1tARGw:14NK2nkfrPQITZ5Kr_UFdVxyRzGGyuoK9mK4BkdJyoE	2024-11-25 10:03:50.640277+00
pskexuh1xrg0lpgkwxtuez8l3oowzgz0	e30:1tARGx:ur_pc8NYZagWTRwKS82zrSCkq_Mczg5GojYSn08Hcs0	2024-11-25 10:03:51.536262+00
oxliu6ewp61f542qpb6aqu5krmmgn9ar	e30:1tARGy:dmY7ql-WJAy-OYLCscPbUdA8sB_ZRgmyMEu6Gx0n4ME	2024-11-25 10:03:52.810874+00
fonatxkeq5lgl8fr7fqmm6ue5hwgcqi4	e30:1tARH0:2MUkmE4BZebAUCp4Lo-X6CYBIB4fd_K7Ph7SEqq8Jy4	2024-11-25 10:03:54.310954+00
8ljtm21i21h6uecz1bk0e7u9w81nmp03	e30:1tARH0:2MUkmE4BZebAUCp4Lo-X6CYBIB4fd_K7Ph7SEqq8Jy4	2024-11-25 10:03:54.956064+00
a8blqnxelfv5cdpnajtnjoshzlhm1cuu	e30:1tARH1:Bos15uXadQkSgN_oVPb_cd4I2Bcad69i0-zokxcVgeU	2024-11-25 10:03:55.53333+00
yk9cqn4pxffii5nqbvz8mrdlsaih3jso	e30:1tARH3:66WC8PF8t58RSufaPdMzJzPJXcu7Vv0DR7M96Y_-BHM	2024-11-25 10:03:57.074848+00
dc41fuwjilik33b3e17k6jg3bl3ync1u	e30:1tARH3:66WC8PF8t58RSufaPdMzJzPJXcu7Vv0DR7M96Y_-BHM	2024-11-25 10:03:57.709113+00
rs08oyczl39t3bb1gmh8ry0iboz0masv	e30:1tARH5:3L-PEF7aCbJzrimfo7oCuhgQplfav1sI-FLqwzdFPMo	2024-11-25 10:03:59.202189+00
cgyvrmaes9dzoll3tl3cg8o3qmjfhcyv	e30:1tARH5:3L-PEF7aCbJzrimfo7oCuhgQplfav1sI-FLqwzdFPMo	2024-11-25 10:03:59.799819+00
habfzwi6f1zoklvq0an7lku4l2lb7g6o	e30:1tARH7:4gKoy-1zFGklrs6JoibR9CrlemkDepeq1Aen4TwWM3o	2024-11-25 10:04:01.324333+00
ucjehar71fjzz4049rfpzhec1l08uy1c	e30:1tARH7:4gKoy-1zFGklrs6JoibR9CrlemkDepeq1Aen4TwWM3o	2024-11-25 10:04:01.914932+00
eu6cbomn5nlhqggcz2h23cy1jdx2x26f	e30:1tARH9:A56YowQh6zctOF4nsJ9yW2T3xWWOwiZqIH92gfKNAn0	2024-11-25 10:04:03.466242+00
8fl0jcst5gz20gedzbrnuyr00r78o81y	e30:1tARHA:fUMvUgTPFOpKWqf3pfmbvxQMzKzootYdBi81w3CcfVA	2024-11-25 10:04:04.039702+00
hngrj8ny6t1utlpvrwtw6ym66m24izo1	e30:1tARHB:VduAJmZNSj4LEhn0XTOJqQ3cJzPkxuDwFrudeMW5so4	2024-11-25 10:04:05.583427+00
0ve378x9fu0qyt7fipq8gvp32v2zcm8h	e30:1tARHC:d9CZ2G03B2B4XG-iG6jCHMEE3C-HYxTGaJs9-1ndPKs	2024-11-25 10:04:06.14913+00
drfsjnwkha69bkocdgvd302dopw4dur0	e30:1tARHE:9B4s8K16GThz5tkym1bGj-0nIUEelJvEqX8WXY1OUK4	2024-11-25 10:04:08.977371+00
kkkh5kevm61vw5w9rjecvri5mkfymc1k	e30:1tARHG:W8hoJAG44a_-D1aIBY-cJkkF9I8p2YF2JCWKTzM26Lc	2024-11-25 10:04:10.852645+00
c4t3fuc8todm5ao9wr3qk9n5rienej8z	e30:1tARHH:gVh9DtYAph2pwj1fwPPL5mHFiuKH2zJBBa35hU9Pra0	2024-11-25 10:04:11.33799+00
t999ai78wpqxx0kq7vyut288jfjg40ya	e30:1tARHI:7C-xpCEDTVOYpqsRslozx0U_xLdXx00kLb7XZtD0szM	2024-11-25 10:04:12.974315+00
73y0k9fl7sdl150xx98lggs0qi8juahg	e30:1tARHJ:07riDu1FOI2i6roU2aTVcfCUZauY3jMJuRZuih-91HQ	2024-11-25 10:04:13.42599+00
x9vpcnhfcy0a3hnkzps6mi8e5ojqhw4b	e30:1tARHL:Wolo4s_fYc21sSCTfHMw7CMhnXRiFEx2Fri6ZlXwzlg	2024-11-25 10:04:15.063591+00
ew00e73p8r1vf8eswino59z6hy46d3ps	e30:1tARHL:Wolo4s_fYc21sSCTfHMw7CMhnXRiFEx2Fri6ZlXwzlg	2024-11-25 10:04:15.498092+00
hupbv7lmj60cxw75zffu84cs60sw0sgz	e30:1tARHN:PSLkUlmdYEpYh1I9vCYLEQZOSwhUwK_PQ8hhp-aDQaM	2024-11-25 10:04:17.18989+00
x5m2ytgufhznbc7xb33th0050css4bgj	e30:1tARHN:PSLkUlmdYEpYh1I9vCYLEQZOSwhUwK_PQ8hhp-aDQaM	2024-11-25 10:04:17.614612+00
ue8l3l5jme7qwlp8cywnq1olgzmyxu96	e30:1tARHP:AMQxiY1dUaM3I8igmtPiIrQFDZBt4wuUHYglveWHTE8	2024-11-25 10:04:19.317487+00
5z7rrpy7w1399qrku5opq2vdvi5p4y67	e30:1tARHP:AMQxiY1dUaM3I8igmtPiIrQFDZBt4wuUHYglveWHTE8	2024-11-25 10:04:19.734629+00
0n704he3iv404i5rq8znlgs5z81rgsmk	e30:1tARHR:inke66PerzfjCUFEpKbHyDX0-vR0uD_DsJ_hXm8oQeI	2024-11-25 10:04:21.422995+00
h2h1q028ckapknwws9yge275dh9zc3ar	e30:1tARHR:inke66PerzfjCUFEpKbHyDX0-vR0uD_DsJ_hXm8oQeI	2024-11-25 10:04:21.818974+00
4ok3yuorgpaenlh2fa9fkul74fi3xgcz	e30:1tARHT:ObEbTImfO_3RIRm775nORnjFXvGVXTvj2H-yk_TICak	2024-11-25 10:04:23.516019+00
e3azwkfkrreutbo4vtderuz092qg83pk	e30:1tARHT:ObEbTImfO_3RIRm775nORnjFXvGVXTvj2H-yk_TICak	2024-11-25 10:04:23.916387+00
idh84qskrjefqoueoc80ge8e6xbnrgv1	e30:1tARHV:X9eyZ_YyHIj_6qPN6l21mmUKzCP2l0fgesdzNtBRPZE	2024-11-25 10:04:25.61442+00
66wdz6ryo90l02htq56lalofsbc254kf	e30:1tARHW:UVQllnh_magO3NWxVqov5ug64zr0Bk5NBs3zrpcZZxw	2024-11-25 10:04:26.015043+00
feqjh077916v7ukff650ftbnan0c5fwv	e30:1tARHX:ZN5wOAAj0A57d8ei30T9hF4ndp0BsehYS9aO3w6wrZc	2024-11-25 10:04:27.776379+00
0d03xdcv8f6mduuzce9pauw7mpfk9m9s	e30:1tARHY:DX-NTXzU9g0MzvGXcneiwEAHh-ov0m8F1TakbykRaiw	2024-11-25 10:04:28.139747+00
4778nt4oe7vfa6owmvmzka284fpzylyc	e30:1tARNK:Xrxn5oyrdrUIhSLQ4kEdHGkVRpHno-Za3xO6OceNNc4	2024-11-25 10:10:26.239901+00
uvvc4e5iufcl8lbk7v1z58eu4sjaxkht	e30:1tARHZ:9jwZ0KpWaLzkW44eXuV1dQx5k9T4mW5JKEt1DLWIvRs	2024-11-25 10:04:29.908591+00
cdmum7j9snj5hemhlkiibx7s0p0y5ols	e30:1tARHi:QG7824R5_1ZFTciWiy66yvxa-uRjI1fIuRMcklap8YE	2024-11-25 10:04:38.941597+00
l0lff9392lpstmvt8zfhyvqcspkzrlcb	e30:1tARNM:6IzEqolhm_EEQ65wTbL69M-s5juAg5tsEUy1Mjr1HlQ	2024-11-25 10:10:28.399213+00
b0p6tga5aby4u8quwgaxwk727mp1eno4	e30:1tARHk:4VzxCJucOfpgRNVSQGEmeyQHjm0hIj2U6gKgmK3CUeA	2024-11-25 10:04:40.398054+00
0z2au20eb82b9j3gqizskjl0ife29oy5	e30:1tARHl:VMEtlyTX-tPsoSlO-6tPuej_GAN3vhnXgO9m22wmyV8	2024-11-25 10:04:41.013041+00
b0ivvg6jo0b3gke1epv52hx76yvyq540	e30:1tARNO:vkMyfsOR9W3EJGNB9XRiKjMVCBuBuuDm_FY46dfkbzk	2024-11-25 10:10:30.534703+00
38s54vtrkmnfuyj5hn9hqbt5h204t2f9	e30:1tARHm:DDVx9aMXw_ocAyWQQE073STD2IC31GbpCSW4a2tbngQ	2024-11-25 10:04:42.53028+00
22cqogqj21i11lz7akr3jy4ebmqij0y9	e30:1tARHn:CjsVBlRL97urrHT8fRJirJK1YRxg1t2GgRJuqENgmD4	2024-11-25 10:04:43.116046+00
rownlr1ude2t0ip1ztihzrlo1pkg8iia	e30:1tARNQ:7bCa8UELO4g5NtZ3UV4iGe2EeOJyx6STRObZ0U2IaC8	2024-11-25 10:10:32.781877+00
y3bouvmcp0g4rji9sekfxm2gz7rsheez	e30:1tARHo:qmxSx872rV1wtp-6B3fKgH61NcI0zkOFN2VJEQ50yKk	2024-11-25 10:04:44.627014+00
4balf7za21rxmwwulo3r3e22r8sw9rbz	e30:1tARHp:N9UkMeoGgG61AG810IR-8yxMJzoZ_DDcBxj58geruxI	2024-11-25 10:04:45.207071+00
uj4t4fvp4dqycjg3mrtr3gbepcfk2jce	e30:1tARNW:k-qbGKV5R7qsGpijUbOh2f4a1ctNQIXeBt8Z-mpuP5c	2024-11-25 10:10:38.792818+00
e9qchfzjw5ogcgbcm4gkn4v0uqv6fene	e30:1tARHr:9siR2-djSKPRcudqszDJ-noh2iZoh6Ur-SZEcSKuhN8	2024-11-25 10:04:47.296469+00
4yjlmc8b7w2d9n7x5htpn36m1z0ser3u	e30:1tARHr:9siR2-djSKPRcudqszDJ-noh2iZoh6Ur-SZEcSKuhN8	2024-11-25 10:04:47.300398+00
h1adss65riddzq9x9x3gb98rucikih5a	e30:1tARNW:k-qbGKV5R7qsGpijUbOh2f4a1ctNQIXeBt8Z-mpuP5c	2024-11-25 10:10:38.79464+00
kll0qizpq5bpywhtq8k6ogw9tuueoehp	e30:1tARNY:KJLpc-86NmWF2VTGFgri_FEWpd7EnSjJN5GS-mLN_DU	2024-11-25 10:10:40.868069+00
1o7xoc9cj5bsk0ia5u7k9p4xli61j0vm	e30:1tARNY:KJLpc-86NmWF2VTGFgri_FEWpd7EnSjJN5GS-mLN_DU	2024-11-25 10:10:40.899379+00
ivqnjf67iv2fovq6x0mu4ls88gx33e4b	e30:1tARHs:7ZckNGkLjJjaK1eA9QL-VmmRe8hAMH9By3zXpCluo_Y	2024-11-25 10:04:48.623525+00
a2p7saojp4t6r5vf0cmyh78yi4iip7f6	e30:1tARHs:7ZckNGkLjJjaK1eA9QL-VmmRe8hAMH9By3zXpCluo_Y	2024-11-25 10:04:48.653469+00
tq2g8gkbfqg9vad54h7gw0nm0ah15g45	e30:1tARHt:3_78OHecbB8qsh7AVIfMLiJ4OnEJoaj1-MUJXS1nvrA	2024-11-25 10:04:49.023108+00
1rgbspd5wql5b8olmngi40l2e4yrtzq7	e30:1tARHt:3_78OHecbB8qsh7AVIfMLiJ4OnEJoaj1-MUJXS1nvrA	2024-11-25 10:04:49.039913+00
8l0gkz4ohn2m6mnhj0swszva257mauak	e30:1tARHt:3_78OHecbB8qsh7AVIfMLiJ4OnEJoaj1-MUJXS1nvrA	2024-11-25 10:04:49.254951+00
kp9b2ginr71c045tj0wl3wwk22fntoyo	e30:1tARI2:qOIVHlcJ0m5ugJCW_tu6K857hGcZSmW9SrhfKoDzd80	2024-11-25 10:04:58.639174+00
z9mr58anb1o9g7ppm5rs1dy6ounb8zzo	e30:1tARI4:aqh1czrOKAwBvJqnqOwdHSQOktsX2Cx6kslA_X0d4a4	2024-11-25 10:05:00.785676+00
lrzpnhaxtk1uf2cfkwbtybtl3jxov809	e30:1tARNa:wLj3sLTM_82I1xLV8BEiLRe2yNKd2fjhEyg8KOibZNM	2024-11-25 10:10:42.92902+00
iirpskbye9y2cmgepdov039cznsazusj	e30:1tARI6:izhi0iqIwaAjCiVV5a8YmqfFBGUGIoDScdBys5LcmRw	2024-11-25 10:05:02.956456+00
wwo4uzs94baheaw5tuvw7amclovl663h	e30:1tARNb:eWjJ6e5Q5T3Dnbj23EkyfPkKSl7GxKJrfLvVZBV2Izs	2024-11-25 10:10:43.010903+00
iqg94dcqtjjrnopwlks4zgpik7ly4awk	e30:1tARI9:8vHxsU4_6s5DQunl0wKX3vVx0BSgSNNJ6OmGCLoMkIU	2024-11-25 10:05:05.209368+00
u45szpvqerea2axmumt23qxkkb07e630	e30:1tARJp:8Etfvk9Cx5IKJpdrEhmL_UojReDEbOGeOBkJ5Hp1zkY	2024-11-25 10:06:49.128986+00
qeofb3clnkeh926qybhjy7bcc6q3ry45	e30:1tARJr:NM4uTNGDF_89kydGpDdbKDhjrKIPx9LfnolKcr5FSfQ	2024-11-25 10:06:51.353533+00
cygcrv5hawua76to9voc56t8bxbn7vvw	e30:1tARNd:3QHtpfaggi1TJ_JLasgoScUFjFbH029rxOsxnZvecDk	2024-11-25 10:10:45.028275+00
gzq5ceqwkwtngee8l75p8nbxnkbk7ogz	e30:1tARJt:D9SpD6YKxuJzppjNwIvR29pTqT6r_nHGrtVjGeaTG9k	2024-11-25 10:06:53.504395+00
w7p3eomv98mxrp6tc7eyi2usdx5tzcgt	e30:1tARNd:3QHtpfaggi1TJ_JLasgoScUFjFbH029rxOsxnZvecDk	2024-11-25 10:10:45.107387+00
sl1qbljx8f0bmvr4r6l6u6wfphv3f727	e30:1tARJv:UJny_DyQAFdvX-rWTPyP4ywUStHcosyZoCgz6VYX9xs	2024-11-25 10:06:55.22214+00
8u9k0tmt2eijec0w8tff0ltyvbkc0yid	e30:1tARJv:UJny_DyQAFdvX-rWTPyP4ywUStHcosyZoCgz6VYX9xs	2024-11-25 10:06:55.647632+00
vmqtmc4jvk10r1spuu18genm64z7gb6p	e30:1tARJx:6qpSkWmMDplcoQHmjN9S4XONfAzT-YCf4q42XO9b_hI	2024-11-25 10:06:57.442107+00
hoq8prrd531gqjc3y2hdcfa78jh9vtcc	e30:1tARNf:9flQzsIa5e1aLKsgDieLELkLuRBpfZ0mR9m-cywpA9c	2024-11-25 10:10:47.107054+00
bui8xm624dp6eppscmtn9qmrqh7r4r07	e30:1tARJz:I5NrKYnfdsS2hG-pD6FrDW6ot9tZ1BkwWskXHaurZjs	2024-11-25 10:06:59.586631+00
oxr2e8pjdjqirs3yx4o8lusd5buysuea	e30:1tARNf:9flQzsIa5e1aLKsgDieLELkLuRBpfZ0mR9m-cywpA9c	2024-11-25 10:10:47.228545+00
xyr6dddr8s2vyvtrcrobbkbpx3m8dgkw	e30:1tARK1:ywi1CvQ4eTm1l8qCqvEP_TPdfEXvq3rnKKgB7rCwYUo	2024-11-25 10:07:01.772599+00
9j5biq9fhohbi6f709hbgum9e37s3c0v	e30:1tARKR:TFv02MHb_Mz-Phqi3wB_8L-jdSFN0T6_A42Th8DWhKk	2024-11-25 10:07:27.746291+00
xw81olf6wp2grbrhg4id6t9lphwi9iyg	e30:1tARKT:jggGv_AuzfF0aDVSQtq5C3rAAP5_0772hresSqL8pVE	2024-11-25 10:07:29.931486+00
evfgfed7len56e1ogffdhy53ie9k71s8	e30:1tARNh:XcUF2hTM3STTGfXw-3c3Y7JK6SgOL0O6OAQkQ5q2v-U	2024-11-25 10:10:49.158334+00
im2yelc9zrp3hoc95dljw0b7cp7l8tji	e30:1tARKW:GWAtnE1F751Fy3e0j9UJ6ojQ4o1Hd1G-2UyxQtAboZM	2024-11-25 10:07:32.200732+00
jsrti0p3h881696o9de3rcv2qhkuyawi	e30:1tARNh:XcUF2hTM3STTGfXw-3c3Y7JK6SgOL0O6OAQkQ5q2v-U	2024-11-25 10:10:49.357646+00
8ycx6j0dff6dp046m8cjmoafr726x8oz	e30:1tARKY:K1-okV5UEkRwnEnxQu4Ko4r3cXkVrMs27XlOoNkLlWI	2024-11-25 10:07:34.421861+00
2yz4bvic38a64kqacp7bxkk443i8u7p1	e30:1tARN2:ySDbhVG9xbn1ZUg72GvZ8r22BO2hbjuTezm0R8Pjm0M	2024-11-25 10:10:08.56809+00
hdbm0lnjg2hbsfk676m0lkucufb7hm6o	e30:1tARN4:nIlzMD7CSzCBqnJELCkZj5r9Fy8mx8vmGhaVsGpQ_KU	2024-11-25 10:10:10.811818+00
o7qah7buvu65xc5iyo9f9kdp19wvdgvu	e30:1tARNj:cKddB2HM9KPg2lGpj-ZkpttwfveCuDeu2Rl4RaUlBRo	2024-11-25 10:10:51.222208+00
zjdi8yaw4enbi856m466olnr6hpxmfcd	e30:1tARN6:qpomVWmbHGfcJ00GSGDS8qSRUv9PwyPoWxdFKGNmM60	2024-11-25 10:10:12.973877+00
1cn2z4dzswd8wphjr15o4wetdey1gajn	e30:1tARNj:cKddB2HM9KPg2lGpj-ZkpttwfveCuDeu2Rl4RaUlBRo	2024-11-25 10:10:51.467219+00
k9sgpo14dll17im5og811rbqe8walg6w	e30:1tARN7:KMqKstP02CHJAoGYkWNr1fPKHxEjYC53lpJwbQzXOQI	2024-11-25 10:10:13.649402+00
4ccxu2caqho5k6hbmvb4g4i2pag8jlf9	e30:1tARN9:cjxXiqYq-3b0l9AbgSQL4_6Q6L3Wm_ixm0fqT5H-Xyk	2024-11-25 10:10:15.084673+00
57fko9jlt0xfguwmtunbfdg0zltwd2rv	e30:1tARN9:cjxXiqYq-3b0l9AbgSQL4_6Q6L3Wm_ixm0fqT5H-Xyk	2024-11-25 10:10:15.716298+00
xhdfskguwr71g50dkalw0fb7dqcrgafh	e30:1tARNl:-EY6LWFEnzqPBcJz4DwbHZGyzTk8uSlFLDC7QTrTZMs	2024-11-25 10:10:53.351223+00
mk63ej71p4kq9tv72kebvld93tgt0x5u	e30:1tARNB:GzqgO8o_iM4dqJixAlIGuOQNaSfE4DRw2Az4YyDkdX0	2024-11-25 10:10:17.223302+00
813uozzkdp3i5dxw6nqdde0i3qe65xp9	e30:1tARNl:-EY6LWFEnzqPBcJz4DwbHZGyzTk8uSlFLDC7QTrTZMs	2024-11-25 10:10:53.617405+00
w4owjb8d2d4ofy5zjjv9j5ydr6pazx7f	e30:1tARNB:GzqgO8o_iM4dqJixAlIGuOQNaSfE4DRw2Az4YyDkdX0	2024-11-25 10:10:17.803915+00
e62x2v3mqou6p7f8wdin150ji6e4vqjo	e30:1tARND:aT6tqB0ojicy1nqZiJYVJ-HI-Mc6ZEMMZCm62qUckoM	2024-11-25 10:10:19.346967+00
80u7rxooogr34fe6kmaqgo3abyrdz9tv	e30:1tARND:aT6tqB0ojicy1nqZiJYVJ-HI-Mc6ZEMMZCm62qUckoM	2024-11-25 10:10:19.902437+00
ak5ga5hjd538g32mbin7cgu1qvkfnqd6	e30:1tARNF:REMhdr8CBPr4-bog58Fjn8AXfRT3ZOnPfIkq6dWJHeU	2024-11-25 10:10:21.470493+00
qk57any51o5n9i3y237qrupje0u0p5t5	e30:1tARNG:MvdQ22GlfTG7ZxX7B_vHXRsDA62n84EdmRxhaAngO4A	2024-11-25 10:10:22.010561+00
1d7jbvypftzt667qohsqhl0chefxwnb7	e30:1tARNn:H3KHOczsq5Ca5jqierrCQ_jQPpd5HveQcZb4uSQcgkA	2024-11-25 10:10:55.447655+00
qd2tfz6mceqm8kryrju8fpgm2fzxb7af	e30:1tARNn:H3KHOczsq5Ca5jqierrCQ_jQPpd5HveQcZb4uSQcgkA	2024-11-25 10:10:55.734558+00
98999gxvancnnphrsjry2g1w9n6agae3	eyJwYXltZW50X2ludGVudF9pZCI6InBpXzNRVW5sdFJ3c29zVFlxUm0wMllxS0hZaCJ9:1tLKZV:5wnUEXE7F2SrFbnrMFzSmmuRaOxxmLW48FSSlp_OZPo	2024-12-25 11:08:01.860775+00
se16b7qcpkjyxt28ejg1ixdi9y8soqyb	e30:1tARNp:kMgwRMQ1VNK_A-tr-LK0YsrfpAMmZkK2V5eeFfl8vbo	2024-11-25 10:10:57.580108+00
rxi5wblm21p8zdyvdda2arrdb2wrdknp	e30:1tARNp:kMgwRMQ1VNK_A-tr-LK0YsrfpAMmZkK2V5eeFfl8vbo	2024-11-25 10:10:57.85813+00
rv1htbmwsq9npwj61xi1m8b1qj9fzl38	e30:1tARNr:Cm2rpw7d330qyY3XpB50czNBO2TRFvCRUX5G4W4yOGM	2024-11-25 10:10:59.668981+00
bnxnmzek1rhz6c2uhms8f64ldqfsj7wx	e30:1tARNr:Cm2rpw7d330qyY3XpB50czNBO2TRFvCRUX5G4W4yOGM	2024-11-25 10:10:59.937575+00
0mc33ctuq50srrcv7ceakv1spnga8uo0	e30:1tARNt:oBiVplDqa2YRf_EeOnD-n1sHgDH-gYJB_tViDavX680	2024-11-25 10:11:01.78513+00
dn4s6nrylxo98oeyd37ydty16x8j18xm	e30:1tARNu:9xzt_DRW2O9kplvVBcdN7DsD5_a4HJ-pyQkDRo3LExQ	2024-11-25 10:11:02.037623+00
bm4iggj545dinkr2i3imiduskpopf4dn	e30:1tARNv:TMcg3-gFOg03W-bYuZnKyucIwi9QaPrdZQW-lCeKwIM	2024-11-25 10:11:03.916297+00
rkjwlcv1lns054ozr72vu0i4r36agbbm	e30:1tARNw:PQTtjSiApmNuQcAfnSiFlVWm0klkvXMk09ZxkhLSegQ	2024-11-25 10:11:04.133257+00
5njien8sntzlmwzs1l08sqbkcgxyp7u1	e30:1tARNy:2zY7fUQOqnROX-zG6qZkvkMRuUFs_eqyj2fM2d1kXmc	2024-11-25 10:11:06.049507+00
4bwtl8rqjg8kgjccop4dpxv3ce5jzo0z	e30:1tARNy:2zY7fUQOqnROX-zG6qZkvkMRuUFs_eqyj2fM2d1kXmc	2024-11-25 10:11:06.218548+00
f1dzbssas4st38b99s8laogj3lga2jtl	e30:1tARO0:0F6k09VOnj691jrtHnPeydU1rqzTGu4g2VW3JtDuHLA	2024-11-25 10:11:08.192283+00
lkmxtw5sem3sjhrhi48ibvloujqp4sj7	e30:1tARO0:0F6k09VOnj691jrtHnPeydU1rqzTGu4g2VW3JtDuHLA	2024-11-25 10:11:08.328676+00
kjokwjqhlujr21weri8yav9f01g13x7n	e30:1tARO2:cLDZp--_TgpwzudZumMJK645B2hoI7wQTchBFfW9fYk	2024-11-25 10:11:10.281568+00
hmi76u1vo3hnfi4epxw0olambo626fon	e30:1tARO2:cLDZp--_TgpwzudZumMJK645B2hoI7wQTchBFfW9fYk	2024-11-25 10:11:10.41258+00
4infp0bzlhsl94q3xvyzv79cs65b272d	e30:1tARO3:NyKUMqVCjQTRmr71nI_l0ADYvzvmXeX3f8O84FnnWYQ	2024-11-25 10:11:11.451752+00
1qd9ut5369c10uwinsn3g5wgkml4jh14	e30:1tARO4:LWiBbwt4G5XD-HXaermTU3KF0HDoUUskUCR2yvwJxj8	2024-11-25 10:11:12.166467+00
om36skylslk7ciy8atvjpg5u5pswy3vm	e30:1tARO4:LWiBbwt4G5XD-HXaermTU3KF0HDoUUskUCR2yvwJxj8	2024-11-25 10:11:12.374632+00
4j8v86pgdmdbgq5ihqaunj06zkb6oetx	e30:1tARO4:LWiBbwt4G5XD-HXaermTU3KF0HDoUUskUCR2yvwJxj8	2024-11-25 10:11:12.484947+00
hx2iwrpg1j2e44ct3j91oqtfj6xtj3j8	e30:1tARO4:LWiBbwt4G5XD-HXaermTU3KF0HDoUUskUCR2yvwJxj8	2024-11-25 10:11:12.643288+00
zuurrkh4kkv0qhxs92lbfuwzcetjkhg6	e30:1tARO4:LWiBbwt4G5XD-HXaermTU3KF0HDoUUskUCR2yvwJxj8	2024-11-25 10:11:12.979491+00
63a0y0abc8gwv2em6d1mwgep1thjir4c	e30:1tARO6:cHw5v_eyXwztxoUBYvg80imGCG_PAuuDpwTwSq6cDrk	2024-11-25 10:11:14.512395+00
smtkx6rwhvdysc1yjaftuue16q496mhx	e30:1tARO6:cHw5v_eyXwztxoUBYvg80imGCG_PAuuDpwTwSq6cDrk	2024-11-25 10:11:14.596827+00
153oc321c312bn2nn59teafeoqadu5cx	e30:1tARO7:BbdsAAcbQAGo5-JXlahrjDEm90CHi__48C6cuVclIIs	2024-11-25 10:11:15.721175+00
i1f4lro4c1m572c33jgho92qkizh8kgw	e30:1tARO8:FJ6B3G97noJzponEQYpdnMU4SXEfF3pOAFsSnz4C36I	2024-11-25 10:11:16.62396+00
wd9tijxjdcu8ktg3x6u4qeh2jro4t2bh	e30:1tARO8:FJ6B3G97noJzponEQYpdnMU4SXEfF3pOAFsSnz4C36I	2024-11-25 10:11:16.702386+00
3crdsn43bwftxyipgc7q0l1vllqnwxsj	e30:1tARO9:751EqxhJifaAXV27kKYAH-9CuWuL7Z_gThyLIokiC6A	2024-11-25 10:11:17.962296+00
hlahxp9gc50cnzwga8e4qorx6nbpvkrf	e30:1tAROA:hGapit1Ksdzh8YQH5AVnNrpsI7VsDZw3RzDNGy8Vo4w	2024-11-25 10:11:18.563207+00
l4qai8l4tift90qoutzjgjaxcncbdnnb	e30:1tAROA:hGapit1Ksdzh8YQH5AVnNrpsI7VsDZw3RzDNGy8Vo4w	2024-11-25 10:11:18.749141+00
ym80x0ejlrvd8udgokgvedx88k2fnaw5	e30:1tAROA:hGapit1Ksdzh8YQH5AVnNrpsI7VsDZw3RzDNGy8Vo4w	2024-11-25 10:11:18.803991+00
5tgeubia6f0igwwhnwecyz33sy0n4w82	e30:1tAROB:gQBqaYVU71sZQljj5q38qGtxLXhatHFPvjrjrRz1jK0	2024-11-25 10:11:19.030835+00
77hxmuywzhd3m749qbsfmqxshfp1teyg	e30:1tAROC:eLDczY0ovetc9VrQFVVAWodqAGonOGyi9kP4TFVKe6M	2024-11-25 10:11:20.226256+00
a3hb9x19kda1wc05pajrz47m0aiarnpl	e30:1tAROC:eLDczY0ovetc9VrQFVVAWodqAGonOGyi9kP4TFVKe6M	2024-11-25 10:11:20.823831+00
0p9qurr3qnvkfddxsnspjhh0ucw4uumv	e30:1tAROC:eLDczY0ovetc9VrQFVVAWodqAGonOGyi9kP4TFVKe6M	2024-11-25 10:11:20.833809+00
foddbga6uh0odn31m88f42fgpko4l2dc	e30:1tAROC:eLDczY0ovetc9VrQFVVAWodqAGonOGyi9kP4TFVKe6M	2024-11-25 10:11:20.919965+00
aekvjaw7pi27k5ywwalgjs596bf1lgwx	e30:1tAROD:Z4WxiF4bmuTDy6pN_e1Vj8iCux6e_b_fiKxMiQorYsg	2024-11-25 10:11:21.790933+00
ovgi3kp7d7oj6an04ron96zm4mzht6u7	e30:1tAROE:Ws61P0qlrGe1cxZj1mfHkOq6l0MG5byyueryDeZ_ifQ	2024-11-25 10:11:22.955344+00
cw8mtskina4rqkeu94tq03kuqisrl35a	e30:1tAROF:0QsfP53K3_Gi6c6pqLbUY5GxnHM10XWjepQIOoqGlu0	2024-11-25 10:11:23.027315+00
vz8ufkr83gcg333nfayhtbnku7fivgu6	e30:1tAROF:0QsfP53K3_Gi6c6pqLbUY5GxnHM10XWjepQIOoqGlu0	2024-11-25 10:11:23.154304+00
y17d6pc6jyso6lj9vy1r982l4x8l192u	e30:1tAROG:e3Vi4XTkOXuAcfXVcmsEQPi4VKzMJni6-7aAPW03RKY	2024-11-25 10:11:24.570953+00
tfybdxyc4huskn55vhsehxwx2p9n3u3f	e30:1tAROH:ooAyLxeeq31r5Q-gRY73q69ZP3ecgKDDzBQz_rXRLT4	2024-11-25 10:11:25.094184+00
inkw0574nw6ifonxlywambz57dc2irw7	e30:1tAROH:ooAyLxeeq31r5Q-gRY73q69ZP3ecgKDDzBQz_rXRLT4	2024-11-25 10:11:25.146642+00
qkznyhjk2octsiefrda0jzlqf5fr11l8	e30:1tAROJ:9uzidgWL8_NsRGJZTQgnNpgFBGM0U9hpJB_l-5uOFJI	2024-11-25 10:11:27.194352+00
sa8db6zpy8qrg4loaifyul9euf8hps68	e30:1tAROJ:9uzidgWL8_NsRGJZTQgnNpgFBGM0U9hpJB_l-5uOFJI	2024-11-25 10:11:27.268417+00
4uy0miqg4xdr0tlqgvq9lwjnfymf5q7m	e30:1tAROL:I8nuitMF7oRz6rmdJaJA1FvPFRKzy5grlFqiweYu4iU	2024-11-25 10:11:29.272285+00
hpnotsgzui17vp0illa0816tqdfpa1lp	e30:1tAROL:I8nuitMF7oRz6rmdJaJA1FvPFRKzy5grlFqiweYu4iU	2024-11-25 10:11:29.398971+00
zuo9goekocnb7cggb7xspdejochijezo	e30:1tARON:U9Xu0ARriBFsjKaK9O_W_G8uaIQgI8xDEjB7B98UExQ	2024-11-25 10:11:31.344529+00
xynbm7ss9mg905ssjdxuqa6cv5alg5dm	e30:1tARON:U9Xu0ARriBFsjKaK9O_W_G8uaIQgI8xDEjB7B98UExQ	2024-11-25 10:11:31.490221+00
1n3zk7st4wb7so76h4d9myqja5omig2s	e30:1tAROP:wXsw1sDpmI43hTzkJWZ2rwrDWa4WhqAyhMRX9Stq8Lc	2024-11-25 10:11:33.439964+00
1zubf1j7238p4xhnrw8fukwly8fvic7m	e30:1tAROP:wXsw1sDpmI43hTzkJWZ2rwrDWa4WhqAyhMRX9Stq8Lc	2024-11-25 10:11:33.607895+00
2e4hc7e6unlpvutytulio56meh41jcfk	e30:1tAROR:EX4dktI83OeGwIuyZzfZIcvpaTmhMuwUHdWUNTbSZyw	2024-11-25 10:11:35.5222+00
0sujnhthm351dlktrc061ntkgj9eyj9y	e30:1tAROR:EX4dktI83OeGwIuyZzfZIcvpaTmhMuwUHdWUNTbSZyw	2024-11-25 10:11:35.714773+00
lqd8y3lii8ekfvra27qbgtl60f2aj22n	e30:1tAROT:NK7HsLouv-mvSRiD0CLYlz8qDRk_1tSEGPJJLJMcDZU	2024-11-25 10:11:37.612212+00
58mw8htl16tbledoo5piw42jzdc16io4	e30:1tAROT:NK7HsLouv-mvSRiD0CLYlz8qDRk_1tSEGPJJLJMcDZU	2024-11-25 10:11:37.800168+00
ux68kit9v4oebmakjdt9o6yfyxasrjv8	e30:1tAROh:NpPAl1GoS6tay7NgN7f15b3wlVysUEsIxK8-35ZhZxY	2024-11-25 10:11:51.742284+00
l6mb0vonx3axd62sy3nrcdo8zxycdhxs	e30:1tAROj:8JJVF12KYUOI9uVWBdFgxVsHRnUyd-vzzqWvFMZJW0c	2024-11-25 10:11:53.43469+00
svda95fij1u8kjsuwdera2cthdy4adcx	e30:1tAROj:8JJVF12KYUOI9uVWBdFgxVsHRnUyd-vzzqWvFMZJW0c	2024-11-25 10:11:53.483054+00
13l8u047rdm000o59w4dl7xkc6ad5bpf	e30:1tAROl:Z7d_mc417RrXZ0zmoAvUzndfUmP-Avtfxwi-4r75Z48	2024-11-25 10:11:55.638921+00
xqnapkbfmyark37s0i1k5j5j240kh4wp	e30:1tAROm:nQUl9EjAY-R3ZJpAlRNh-LaDhaQnOjedBgXD3pZorqM	2024-11-25 10:11:56.153647+00
cspb900nxbaabe3h4ax85sqts40vkkt5	e30:1tAROm:nQUl9EjAY-R3ZJpAlRNh-LaDhaQnOjedBgXD3pZorqM	2024-11-25 10:11:56.338324+00
0zo8osoap2vu65lhgnu7idjuw9i8vvlf	e30:1tAROm:nQUl9EjAY-R3ZJpAlRNh-LaDhaQnOjedBgXD3pZorqM	2024-11-25 10:11:56.348046+00
ecukp3anzxyjzp6gmam7td6oawjy4aks	e30:1tAROn:dpAb1bQ1Lh4z-cuHREkKNLS5pcIWg0u5q5d1CYrPjx0	2024-11-25 10:11:57.893457+00
wqm0liw4ae9by4ell846kqs7qt82ffbu	e30:1tXfof:eChA-lksYpFHDjIhoegI85ng3d0hG_Lhl1mYal12oZg	2025-01-28 12:14:41.138825+00
ny28d9yss1asqcpnsshcnla19qjzck1t	e30:1tAROo:XdwjRv62gyeRZHH5fXZPNpAAsVNJNRpGTI4_qGErcrc	2024-11-25 10:11:58.487625+00
op1pney5m2ct0hhwqvubmziiy3bt5l15	e30:1tAROo:XdwjRv62gyeRZHH5fXZPNpAAsVNJNRpGTI4_qGErcrc	2024-11-25 10:11:58.672967+00
fasxw5d3js6gnlbcgk8gm1r44m3hbi0v	e30:1tAROp:3X-qD2-umsM1P56zmYHNBcjwjgfUZmjLjHNrWhcZbpY	2024-11-25 10:11:59.222554+00
ues40c6rl0hr9vei8ljvsmjvhvgwbirw	e30:1tAROq:pKNnV-sR2FEySKXnOAYr2NA1DT2JVC-mXU5ZZn7oIko	2024-11-25 10:12:00.09761+00
v5v989tk5orc1u3f4asp9f3a9d6wh3bx	e30:1tAROq:pKNnV-sR2FEySKXnOAYr2NA1DT2JVC-mXU5ZZn7oIko	2024-11-25 10:12:00.821925+00
obx91l2lu9hgn7s89dab05yy8l07v0ah	e30:1tAROq:pKNnV-sR2FEySKXnOAYr2NA1DT2JVC-mXU5ZZn7oIko	2024-11-25 10:12:00.946232+00
f3ly0bhzdf5umo0x0l3px084oxndws4q	e30:1tAROs:3VT_Rl8YLVCWs17SExF-vP6m-WrYr_7SltwZAlroeVc	2024-11-25 10:12:02.091782+00
k8d53aboyfm6tomfai968pt6hbqqsh5e	e30:1tAROt:FtnmueCwfWW6bN00DU3eppEKQc989iq99xWGeXxFmQk	2024-11-25 10:12:03.184677+00
gblkkmqpt9cagkm7yhowsyxku5m132at	e30:1tAROt:FtnmueCwfWW6bN00DU3eppEKQc989iq99xWGeXxFmQk	2024-11-25 10:12:03.21747+00
wfm5xi1g9p22ktn2pg38bblmmb4ygu9p	e30:1tAROu:qFWBlElteFB0khVlgPwgWlLwxv-BMoMdZr6b3r-b-hc	2024-11-25 10:12:04.940259+00
1d4isciln7offgs0an3u8rjm3u8poj8c	e30:1tAROx:y-P2fjJ2b0iVZXqJEYEiUWWYKzKXAs7dRhIg-Kl-ZdY	2024-11-25 10:12:07.865491+00
s04weyo2qlvh102mu2er1k105ogb45v0	e30:1tARP0:jPxINjgLrAnyXaPNxN31zYgzzHQoTCep2T__pkIuBag	2024-11-25 10:12:10.681781+00
zouomik9bm22k4mo0qvi0nvnmx8tjpjp	e30:1tARP3:HCur15-SrwpLpUb8IpiiCZl2hrHQx7VEWK53qVPwY0g	2024-11-25 10:12:13.613397+00
6bl8tt2a9ul48sf9iu8brit8npiyvf33	e30:1tARP6:f8-wb2lIhIiYbfgwauRTdcwbnsJ3o2DqGogRGJThfWk	2024-11-25 10:12:16.391998+00
i5w6cm4kydx3iz5s1nosbdkxdhhpek72	e30:1tAqQb:lIolPpo9a1bdXsD10ecmBiRhSdqXTwAMwt5DJS9cg04	2024-11-26 12:55:29.690491+00
0dmqp972pbd8firezne66twr61un2qho	e30:1tAtw1:52be7g6myYvCrsGWEVNfn_wDS9GaM3EFc5EvVTIGu_8	2024-11-26 16:40:09.605896+00
7sijjdj0mprlta644t44moiof0h1yja8	e30:1tAx5u:ktBZj9-bwp5n6GchWdgQtjKoodk6KB26D-Nt1vCdZ6Q	2024-11-26 20:02:34.80376+00
9vlba1jm3zry8pcfn8vigqmqjxih4wa2	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1tE9eY:kgr6hRSAMXi2rjXWWXeM3ZIgJIVMI_8XVx_xBCP8Au4	2024-12-05 16:03:34.64097+00
u8gj6mwcp36qddfniv0u04n4gvgbt3if	e30:1tE9ea:pJ7GzVdIrV0fKcw6ZUkLnUqrY7YlPJS59zxhYWN75Y8	2024-12-05 16:03:36.224398+00
wh26qlaaeypxpry3216t08x06ectnzui	e30:1tE9fV:Qs5uX8vuC6k4jENnOW96wxUNIGRoKVB_HJafASFEMnc	2024-12-05 16:04:33.624242+00
8j007kulnmo1d72n8cwt24dgb7pevtja	e30:1tE9fX:kohRv-VBTKbbRawc3GhyfUB5man33Kc1yr2LWIov93g	2024-12-05 16:04:35.870168+00
m25bu7rgn4aabfcohujqez9vc95bq525	e30:1tE9g0:SL_b-pL0FZL5asySPUC-BK4-XAnmln6vj16A7WWDx_c	2024-12-05 16:05:04.240709+00
f1az9uodktrgiqq4kldianpdb30xcinr	e30:1tE9g2:a3yZoC2YVWJkukHJ2RkQq5_vpyQhzYXocvm1Aas1v84	2024-12-05 16:05:06.464396+00
lsfdpgv2wokbac2unzgwmj3n6rq8pyjs	e30:1tJBxU:ayX0zjhjHE0XFmrO_EO2aoB4hxhW44giI0Skpq5cSLE	2024-12-19 13:31:56.024718+00
l1rcdokb8u340gifdl9gua4k2u3y59b4	.eJxVjEEOwiAQRe_C2pAO7QB16b5nIAzDSNWUpLQr491Nky50-997_61C3LcS9pbXMLO6KlCX341ieublAPyIy73qVJdtnUkfij5p01Pl_Lqd7t9Bia0c9SiU2NtsUodkRwLHBn3nJQqy83YQFhDP3FPuDPjs0AkCkBlh6FF9vgQmOBY:1tJXvJ:-yCp8MzlYePfrOPvw5Vyj2xdC31V9gihnAWox12KLFk	2024-12-20 12:59:09.033995+00
5aq6ptf3o4oa32gqsgkcwbod9q771g37	e30:1tKEHG:b5exx6I-zfltG5NqXSIKD4h_u1Arca2wxppsYJzzw64	2024-12-22 10:12:38.055873+00
kz1pa0zucb2kxpp7w203mzqw0b32gk0z	e30:1tKJKn:G2xPz-9HY6l_ygXrn4StZLQ2ajCTj5KGpxgieSste9o	2024-12-22 15:36:37.015211+00
8xt1oup8d5yif3y4q8sdk1hakkc3pu25	e30:1tKMlD:annAQz_DQfF6Y9aypbxLoNTQw2jlwuozMom5uq-7CyA	2024-12-22 19:16:07.272972+00
sr8w5fcr68ce8s2p9utc5gapr018h1t4	e30:1tKRFr:nqqgWPViiQhsyDcv8A1MSx-SP-lydA_NUgwKDuBiWoo	2024-12-23 00:04:03.10905+00
yzbtcq2yggvxiln7ik6fsl9mmnmxvmyo	eyJwYXltZW50X2ludGVudF9pZCI6InBpXzNRVVJpc1J3c29zVFlxUm0wTW5qdFdEOSJ9:1tKyWV:JEh66Fh1BI8JfNdSH67V-I4_8mckt8nJIPVNLGkk67U	2024-12-24 11:35:27.31302+00
ln0n8ch31h4rw5x2z2mgqhzkau3nagqk	e30:1tLGsH:DN8Oi-TmN--F_KrM1ZwPG--dZdHyVM9f4G9I7QLmMok	2024-12-25 07:11:09.998875+00
q150z8xmrd8smyu22b0ye91dsa911y2z	e30:1tLGxJ:tWBqPSIWHS2ODMqZ9mjXF8-FTsjq3pm247jL5WIvQhM	2024-12-25 07:16:21.010935+00
g8ff8oxfnu726mgwr3y7x17z8k0tdeim	e30:1tLGyM:wQRBJC3uQmLbmcz99eaEQ2p426SROa1Wd82oDLaaqEs	2024-12-25 07:17:26.808418+00
cgivyy0iwdy4u3jfzicei4skwbzbz68d	.eJxVjDsOwjAQBe_iGln-sP5Q0nMGa3dtcADZUpxUiLtDpBTQvpl5L5FwXWpaR5nTlMVJOC0OvyMhP0rbSL5ju3XJvS3zRHJT5E6HvPRcnufd_TuoOOq3hpIRrhyBPB2tIwR2ygLrQqi8yiZoFyhQNKDJxhDIkS_Bg2fSHo14fwAX9DgL:1tLGyv:tpO6qaVzoQCItu0WSiT1WsLrPN_1Tbii8gLAyUCdvpg	2024-12-25 07:18:01.852332+00
du3at7w2kpx5kdap7x58ammt76qg84c6	.eJxVjMsOgjAURP-la0MotQ9cujNRE4mGuCL3tlUQKUghxBj_XVE2rCaZc2ZepIFnZV2XFa77hSEr0hQZO5zKdZ8MvvbH8yOp6H5It326IQuSQd_lWe9t-7cFnZcIurRuJOYG7loHunZdW2AwKsFEfbCrjb2vJ3d2kIPPv2tuDfCLjjlKXDKBwLUIGdfUIoQyNJGiQqHCOOIUWawUCpRWSS41UgkReX8A_jNJ8A:1tLH03:bwr2z-i33LJk1ZvIk8Uhwe1gAdkfndRatCNckKhKN6c	2024-12-25 07:19:11.297585+00
69m0rlenmj3eavx23bv0mpxxhsindrg7	e30:1tLH04:gHMXtgDmVCDsm7kuwuznWlxMBA8cFn6dtJWpJZZWabc	2024-12-25 07:19:12.424348+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: human_human; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.human_human (id, first_name, last_name, age, email, deleted, last_modified) FROM stdin;
4	brko	brkati	20	bra@mail.com	f	2024-08-31 09:12:57.829301+00
2	CAsh	Antoinou	36	sidasa@gmail.com	f	2024-08-31 09:24:24.629941+00
3	spike	Antoinou	33	sida@gmail.com	f	2024-08-31 09:43:43.475447+00
5	Sila	LAsi	30	sida@gmail.com	f	2024-08-31 11:00:55.153435+00
1	Asham	Misic	24	bra@mail.com	f	2024-08-31 11:15:43.677355+00
\.


--
-- Data for Name: reviews_comment; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.reviews_comment (id, text, created_at, updated_at, user_id, review_id, status, deleted, last_modified) FROM stdin;
42	asdasdsadasdasdasdasd	2024-10-02 10:22:34.377441+00	2024-10-02 13:12:20.513732+00	1	48	approved	f	2024-10-02 13:12:20.513737+00
39	fdsadfsdfsdfsf	2024-10-02 10:20:15.647835+00	2024-10-04 14:35:43.059877+00	1	48	approved	f	2024-10-04 14:35:43.059882+00
43	MAIJA	2024-10-02 10:23:07.846639+00	2024-10-04 19:43:28.695992+00	1	48	approved	f	2024-10-04 19:43:28.695996+00
44	MAIJA	2024-10-02 10:23:08.531767+00	2024-10-04 19:50:04.732055+00	1	48	approved	f	2024-10-04 19:50:04.732061+00
41	alo bre	2024-10-02 10:22:34.352485+00	2024-11-04 15:45:41.566996+00	1	48	approved	f	2024-11-04 15:45:41.567002+00
46	Mara je legenda.	2024-10-02 10:35:25.19439+00	2024-11-04 15:45:50.515282+00	1	48	approved	f	2024-11-04 15:45:50.515287+00
40	asdasdsadasdasdasdasd	2024-10-02 10:22:34.34346+00	2024-11-04 18:07:22.959843+00	1	48	approved	f	2024-11-04 18:07:22.959848+00
49	bANANA	2024-10-02 10:36:52.633071+00	2024-11-04 18:11:44.181524+00	1	48	approved	f	2024-11-04 18:11:44.181529+00
55	ub	2024-11-09 19:04:28.975297+00	2024-11-10 11:51:40.638279+00	1	51	approved	f	2024-11-10 11:51:40.638285+00
56	vxcvxcvxvxcv	2024-11-10 12:12:19.780788+00	2024-11-10 12:12:19.780803+00	1	48	pending	f	2024-11-10 12:12:19.780809+00
\.


--
-- Data for Name: reviews_review; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.reviews_review (id, rating, comment, created_at, updated_at, user_id, status, deleted, last_modified) FROM stdin;
48	3	ALokilokiok	2024-09-28 12:07:58.094959+00	2024-09-28 12:07:58.094972+00	19	approved	f	2024-09-28 12:07:58.094978+00
49	4	Abla balda	2024-09-30 14:53:29.398424+00	2024-09-30 21:41:35.66209+00	1	rejected	f	2024-09-30 21:41:35.662095+00
52	3	Amazing rate.	2024-10-04 12:56:56.585922+00	2024-10-04 14:28:25.25353+00	21	rejected	f	2024-10-04 14:28:25.253536+00
53	5	Good seeed bro.	2024-10-04 19:42:47.045024+00	2024-10-04 19:43:19.242205+00	1	approved	f	2024-10-04 19:43:19.242211+00
54	1	Main cool	2024-10-04 19:48:58.742472+00	2024-10-04 19:50:00.123548+00	15	approved	f	2024-10-04 19:50:00.123554+00
56	3	dvdfvdfvd	2024-11-04 18:13:02.719771+00	2024-11-04 18:14:16.48617+00	1	approved	f	2024-11-04 18:14:16.486176+00
55	3	dvdfvdfvd	2024-11-04 18:13:01.151722+00	2024-11-04 18:32:01.816337+00	1	approved	f	2024-11-04 18:32:01.816342+00
57	3	iujimuijmm	2024-11-09 19:04:02.953596+00	2024-11-09 20:40:41.240387+00	1	approved	f	2024-11-09 20:40:41.240392+00
59	5	Lovely shop!!	2024-11-10 13:35:26.058412+00	2024-11-10 13:35:26.058424+00	59	pending	f	2024-11-10 13:35:26.058431+00
58	3	zxczxczxc	2024-11-10 12:12:04.401306+00	2024-11-10 20:08:44.289102+00	1	rejected	f	2024-11-10 20:08:44.289108+00
51	4	Briliant	2024-10-02 08:52:06.824937+00	2024-11-10 20:08:55.689875+00	1	approved	f	2024-11-10 20:08:55.689881+00
60	5	Great seeds.	2024-12-06 13:03:46.220758+00	2024-12-08 11:08:56.704323+00	1	approved	f	2024-12-08 11:08:56.70433+00
\.


--
-- Data for Name: seeds_seed; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.seeds_seed (id, name, scientific_name, description, planting_months_from, planting_months_to, flowering_months_from, flowering_months_to, category, sun_preference, price, discount, height_from, height_to, image, created_at, deleted, last_modified, is_in_stock) FROM stdin;
6	Lavender	Lavandula angustifolia	A fragrant herb with beautiful purple flowers, ideal for gardens and aromatic uses.	3	5	6	8	flower	full_sun	7.95	0.00	0.60	0.90	image/upload/v1724507774/hlka9qtx6phhtlgtsjx2.webp	2024-08-16 14:00:00+00	f	2024-09-06 09:41:20.264108+00	t
1	Red  Rose	Rosa Santana	The red rose is a classic symbol of beauty and love. Belonging to the Rosaceae family, the genus Rosa encompasses a wide variety of species and cultivars, many of which produce the vibrant red flowers that are so highly prized.	10	5	5	7	rose	partly	10.95	5.00	2.50	3.50	image/upload/v1724508444/ybdxx06vltvlmfwdeowv.webp	2024-08-15 11:08:38+00	f	2024-08-31 21:52:59.700783+00	t
10	Cherry Tree	Prunus avium	A beautiful tree that produces sweet cherries, ideal for orchards and gardens.	3	5	4	5	tree	partly	200.00	20.00	8.00	15.00	image/upload/v1724507594/qfxm75lyqkq3ifunlhz3.webp	2024-08-17 16:00:00+00	f	2024-09-08 06:34:04.815985+00	t
3	Yellow Rose	Rosa xanthina	Bright and cheerful, this rose variety is known for its sunny yellow blooms.	8	4	6	9	rose	full_sun	15.00	10.00	1.80	2.50	image/upload/v1724507858/m6p2tpvo0x7oy3shw174.webp	2024-08-17 10:00:00+00	f	2024-09-08 08:44:56.694859+00	t
9	Maple Tree	Acer saccharum	Known for its beautiful fall foliage and strong wood, the Maple Tree is a garden favorite.	4	7	5	6	tree	partly	175.00	15.00	12.00	25.00	image/upload/v1724507621/lr1ab34194vnzjfm9seq.webp	2024-08-16 15:00:00+00	f	2024-09-05 01:02:20.629696+00	t
7	Marigold	Tagetes erecta	Bright and hardy flowers known for their vibrant colors and pest-repellent properties.	5	7	7	10	flower	full_sun	4.95	0.00	0.30	0.60	image/upload/v1724510665/r81w8gxuaqwijvberox6.webp	2024-08-17 13:00:00+00	f	2024-09-03 14:24:43.152502+00	t
4	Pink Rose	Rosa damascena	A beautiful rose with delicate pink flowers, ideal for gardens and bouquets.	7	5	5	8	rose	full_sun	14.95	0.00	1.50	2.00	image/upload/v1724507841/uxnxcmkf1nvxu4rrqudw.webp	2024-08-18 12:00:00+00	f	2024-09-06 10:44:51.325256+00	t
15	Black Currant Bush	Ribes rubrum	Produces clusters of red or black currants, perfect for making jellies and sauces.	4	6	5	7	bush	full_sun	20.00	0.00	1.00	1.80	image/upload/v1724138023/vrkbdzwk3tw4bque3jsg.webp	2024-08-18 14:00:00+00	f	2024-09-09 06:50:18.773058+00	f
13	Raspberry Bush	Rubus idaeus	A bush that produces delicious raspberries, great for gardens and culinary uses.	4	6	6	8	bush	full_shade	22.00	5.00	1.00	1.80	image/upload/v1724137564/jnf0kfrsoi00nxpizjem.webp	2024-08-16 12:00:00+00	f	2024-09-06 09:48:15.20859+00	t
5	Sunflower	Helianthus annuus	Bright and cheerful, sunflowers are a staple in summer gardens.	4	7	7	9	flower	full_sun	5.95	0.00	1.50	3.00	image/upload/v1724507793/mjwm1hwexr80ilylk0yo.webp	2024-08-15 12:00:00+00	f	2024-09-03 15:01:01.284244+00	t
14	Gooseberry Bush	Ribes uva-crispa	A hardy bush that produces tart gooseberries, ideal for jams and desserts.	3	5	5	7	bush	full_sun	18.00	0.00	0.80	1.50	image/upload/v1725882855/qznukuyqkdvypa2dqxwv.webp	2024-08-17 13:00:00+00	f	2024-09-09 11:54:15.421598+00	t
8	Oak Tree	Quercus robur	A majestic tree known for its strength and longevity.	3	6	5	6	tree	partly	15.00	5.00	10.00	20.00	image/upload/v1724507719/tuv943oaday7kqsooptg.webp	2024-08-15 14:00:00+00	f	2024-08-31 21:52:59.700783+00	t
12	Blueberry Bush	Vaccinium corymbosum	A fruitful bush that provides delicious blueberries in summer.	3	5	4	6	bush	partly	25.00	0.00	1.00	2.00	image/upload/v1725883033/d1puspac2e7d8tkgk9kk.webp	2024-08-15 15:00:00+00	f	2024-09-09 11:57:12.923795+00	f
2	White Rose	Rosa Alba	White roses, part of the Rosa genus in the Rosaceae family, are cherished for their timeless elegance and purity. They come in a variety of shades, from pure white to creamy ivory, and are prized for their classic beauty and delicate fragrance. White roses can enhance any garden with their graceful appearance and versatility.	9	4	6	8	rose	full_sun	12.95	0.00	2.00	3.00	image/upload/v1724508348/tthtvhvrspdit6gpx78h.webp	2024-08-16 11:08:38+00	f	2024-09-05 10:52:52.118759+00	t
11	Lemon Tree	Citrus limon	A tropical tree known for its tangy lemons, great for home gardens and indoor growing.	5	7	6	8	tree	full_sun	60.00	5.00	1.50	2.50	image/upload/v1725883166/jtax2qs8aprc7wptf43s.webp	2024-08-18 11:00:00+00	f	2024-09-09 11:59:26.134974+00	f
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.social_auth_partial (id, token, next_step, backend, "timestamp", data) FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.social_auth_usersocialauth (id, provider, uid, user_id, created, modified, extra_data) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key, provider_id, settings) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: dpawoazs
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 1, false);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 144, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 61, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: cart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.cart_cart_id_seq', 635, true);


--
-- Name: cart_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.cart_cartitem_id_seq', 345, true);


--
-- Name: chat_adminactivity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_adminactivity_id_seq', 1, false);


--
-- Name: chat_chatbotresponse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_chatbotresponse_id_seq', 1, false);


--
-- Name: chat_chatmessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_chatmessage_id_seq', 1, false);


--
-- Name: chat_chatsession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_chatsession_id_seq', 1, false);


--
-- Name: chat_conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_conversation_id_seq', 1, false);


--
-- Name: chat_conversation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_conversation_participants_id_seq', 1, false);


--
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 1, false);


--
-- Name: chat_supportticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.chat_supportticket_id_seq', 1, false);


--
-- Name: checkout_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.checkout_order_id_seq', 163, true);


--
-- Name: checkout_orderlineitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.checkout_orderlineitem_id_seq', 420, true);


--
-- Name: communications_chatconversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.communications_chatconversation_id_seq', 18, true);


--
-- Name: communications_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.communications_message_id_seq', 174, true);


--
-- Name: custom_accounts_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.custom_accounts_userprofile_id_seq', 76, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 506, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 35, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 107, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: human_human_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.human_human_id_seq', 5, true);


--
-- Name: reviews_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.reviews_comment_id_seq', 56, true);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 60, true);


--
-- Name: seeds_seed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.seeds_seed_id_seq', 26, true);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, false);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, false);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dpawoazs
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, false);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress account_emailaddress_user_id_email_987c8728_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_email_987c8728_uniq UNIQUE (user_id, email);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: cart_cart cart_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_pkey PRIMARY KEY (id);


--
-- Name: cart_cart cart_cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_user_id_key UNIQUE (user_id);


--
-- Name: cart_cartitem cart_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_pkey PRIMARY KEY (id);


--
-- Name: chat_adminactivity chat_adminactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_adminactivity
    ADD CONSTRAINT chat_adminactivity_pkey PRIMARY KEY (id);


--
-- Name: chat_chatbotresponse chat_chatbotresponse_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatbotresponse
    ADD CONSTRAINT chat_chatbotresponse_pkey PRIMARY KEY (id);


--
-- Name: chat_chatbotresponse chat_chatbotresponse_query_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatbotresponse
    ADD CONSTRAINT chat_chatbotresponse_query_key UNIQUE (query);


--
-- Name: chat_chatmessage chat_chatmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatmessage
    ADD CONSTRAINT chat_chatmessage_pkey PRIMARY KEY (id);


--
-- Name: chat_chatsession chat_chatsession_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatsession
    ADD CONSTRAINT chat_chatsession_pkey PRIMARY KEY (id);


--
-- Name: chat_conversation_participants chat_conversation_partic_conversation_id_user_id_d4d01dfe_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_conversation_participants
    ADD CONSTRAINT chat_conversation_partic_conversation_id_user_id_d4d01dfe_uniq UNIQUE (conversation_id, user_id);


--
-- Name: chat_conversation_participants chat_conversation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_conversation_participants
    ADD CONSTRAINT chat_conversation_participants_pkey PRIMARY KEY (id);


--
-- Name: conversation chat_conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT chat_conversation_pkey PRIMARY KEY (id);


--
-- Name: chat_message chat_message_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_pkey PRIMARY KEY (id);


--
-- Name: chat_supportticket chat_supportticket_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_supportticket
    ADD CONSTRAINT chat_supportticket_pkey PRIMARY KEY (id);


--
-- Name: checkout_order checkout_order_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.checkout_order
    ADD CONSTRAINT checkout_order_pkey PRIMARY KEY (id);


--
-- Name: checkout_orderlineitem checkout_orderlineitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.checkout_orderlineitem
    ADD CONSTRAINT checkout_orderlineitem_pkey PRIMARY KEY (id);


--
-- Name: communications_chatconversation communications_chatconversation_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatconversation
    ADD CONSTRAINT communications_chatconversation_pkey PRIMARY KEY (id);


--
-- Name: communications_chatmessage communications_message_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatmessage
    ADD CONSTRAINT communications_message_pkey PRIMARY KEY (id);


--
-- Name: custom_accounts_userprofile custom_accounts_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.custom_accounts_userprofile
    ADD CONSTRAINT custom_accounts_userprofile_pkey PRIMARY KEY (id);


--
-- Name: custom_accounts_userprofile custom_accounts_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.custom_accounts_userprofile
    ADD CONSTRAINT custom_accounts_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: human_human human_human_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.human_human
    ADD CONSTRAINT human_human_pkey PRIMARY KEY (id);


--
-- Name: reviews_comment reviews_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.reviews_comment
    ADD CONSTRAINT reviews_comment_pkey PRIMARY KEY (id);


--
-- Name: reviews_review reviews_review_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_pkey PRIMARY KEY (id);


--
-- Name: seeds_seed seeds_seed_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.seeds_seed
    ADD CONSTRAINT seeds_seed_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress_email_03be32b2; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX account_emailaddress_email_03be32b2 ON public.account_emailaddress USING btree (email);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: cart_cartitem_cart_id_370ad265; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX cart_cartitem_cart_id_370ad265 ON public.cart_cartitem USING btree (cart_id);


--
-- Name: cart_cartitem_seed_id_8342c57c; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX cart_cartitem_seed_id_8342c57c ON public.cart_cartitem USING btree (seed_id);


--
-- Name: chat_adminactivity_admin_id_154a26f3; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_adminactivity_admin_id_154a26f3 ON public.chat_adminactivity USING btree (admin_id);


--
-- Name: chat_adminactivity_chat_session_id_e72602b6; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_adminactivity_chat_session_id_e72602b6 ON public.chat_adminactivity USING btree (chat_session_id);


--
-- Name: chat_chatbotresponse_query_e2d8e7a8_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_chatbotresponse_query_e2d8e7a8_like ON public.chat_chatbotresponse USING btree (query varchar_pattern_ops);


--
-- Name: chat_chatmessage_session_id_4dacb902; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_chatmessage_session_id_4dacb902 ON public.chat_chatmessage USING btree (session_id);


--
-- Name: chat_chatsession_admin_id_23081aec; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_chatsession_admin_id_23081aec ON public.chat_chatsession USING btree (admin_id);


--
-- Name: chat_chatsession_user_id_5e1fb0de; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_chatsession_user_id_5e1fb0de ON public.chat_chatsession USING btree (user_id);


--
-- Name: chat_conversation_participants_conversation_id_f3ae152d; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_conversation_participants_conversation_id_f3ae152d ON public.chat_conversation_participants USING btree (conversation_id);


--
-- Name: chat_conversation_participants_user_id_01493ead; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_conversation_participants_user_id_01493ead ON public.chat_conversation_participants USING btree (user_id);


--
-- Name: chat_message_conversation_id_a1207bf4; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_message_conversation_id_a1207bf4 ON public.chat_message USING btree (conversation_id);


--
-- Name: chat_message_receiver_id_0eceddde; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_message_receiver_id_0eceddde ON public.chat_message USING btree (receiver_id);


--
-- Name: chat_message_sender_id_991c686c; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_message_sender_id_991c686c ON public.chat_message USING btree (sender_id);


--
-- Name: chat_supportticket_user_id_bec6e0d9; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX chat_supportticket_user_id_bec6e0d9 ON public.chat_supportticket USING btree (user_id);


--
-- Name: checkout_order_user_profile_id_949184a7; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX checkout_order_user_profile_id_949184a7 ON public.checkout_order USING btree (user_profile_id);


--
-- Name: checkout_orderlineitem_order_id_b4cfbe6b; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX checkout_orderlineitem_order_id_b4cfbe6b ON public.checkout_orderlineitem USING btree (order_id);


--
-- Name: checkout_orderlineitem_seed_id_a1bfbf8c; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX checkout_orderlineitem_seed_id_a1bfbf8c ON public.checkout_orderlineitem USING btree (seed_id);


--
-- Name: communicati_convers_d606fd_idx; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communicati_convers_d606fd_idx ON public.communications_chatmessage USING btree (conversation_id);


--
-- Name: communicati_sender__e80e75_idx; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communicati_sender__e80e75_idx ON public.communications_chatmessage USING btree (sender_id);


--
-- Name: communicati_started_71f694_idx; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communicati_started_71f694_idx ON public.communications_chatconversation USING btree (started_at);


--
-- Name: communicati_user_id_7a9800_idx; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communicati_user_id_7a9800_idx ON public.communications_chatconversation USING btree (user_id, superuser_id);


--
-- Name: communications_chatconversation_superuser_id_2c3b05f4; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communications_chatconversation_superuser_id_2c3b05f4 ON public.communications_chatconversation USING btree (superuser_id);


--
-- Name: communications_chatconversation_user_id_fa194506; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communications_chatconversation_user_id_fa194506 ON public.communications_chatconversation USING btree (user_id);


--
-- Name: communications_message_conversation_id_4929d245; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communications_message_conversation_id_4929d245 ON public.communications_chatmessage USING btree (conversation_id);


--
-- Name: communications_message_sender_id_559db3f5; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX communications_message_sender_id_559db3f5 ON public.communications_chatmessage USING btree (sender_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: reviews_comment_review_id_43f1c708; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX reviews_comment_review_id_43f1c708 ON public.reviews_comment USING btree (review_id);


--
-- Name: reviews_comment_user_id_1d319c7d; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX reviews_comment_user_id_1d319c7d ON public.reviews_comment USING btree (user_id);


--
-- Name: reviews_review_user_id_875caff2; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX reviews_review_user_id_875caff2 ON public.reviews_review USING btree (user_id);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_code_code_a2393167 ON public.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_code_code_a2393167_like ON public.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_code_timestamp_176b341f ON public.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON public.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_partial_token_3017fea3 ON public.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON public.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_uid_796e51dc; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc ON public.social_auth_usersocialauth USING btree (uid);


--
-- Name: social_auth_usersocialauth_uid_796e51dc_like; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_usersocialauth_uid_796e51dc_like ON public.social_auth_usersocialauth USING btree (uid varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON public.social_auth_usersocialauth USING btree (user_id);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: unique_primary_email; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE UNIQUE INDEX unique_primary_email ON public.account_emailaddress USING btree (user_id, "primary") WHERE "primary";


--
-- Name: unique_verified_email; Type: INDEX; Schema: public; Owner: dpawoazs
--

CREATE UNIQUE INDEX unique_verified_email ON public.account_emailaddress USING btree (email) WHERE verified;


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cart cart_cart_user_id_9b4220b9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cart
    ADD CONSTRAINT cart_cart_user_id_9b4220b9_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_cart_id_370ad265_fk_cart_cart_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_cart_id_370ad265_fk_cart_cart_id FOREIGN KEY (cart_id) REFERENCES public.cart_cart(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cart_cartitem cart_cartitem_seed_id_8342c57c_fk_seeds_seed_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.cart_cartitem
    ADD CONSTRAINT cart_cartitem_seed_id_8342c57c_fk_seeds_seed_id FOREIGN KEY (seed_id) REFERENCES public.seeds_seed(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_adminactivity chat_adminactivity_admin_id_154a26f3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_adminactivity
    ADD CONSTRAINT chat_adminactivity_admin_id_154a26f3_fk_auth_user_id FOREIGN KEY (admin_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_adminactivity chat_adminactivity_chat_session_id_e72602b6_fk_chat_chat; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_adminactivity
    ADD CONSTRAINT chat_adminactivity_chat_session_id_e72602b6_fk_chat_chat FOREIGN KEY (chat_session_id) REFERENCES public.chat_chatsession(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_chatmessage chat_chatmessage_session_id_4dacb902_fk_chat_chatsession_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatmessage
    ADD CONSTRAINT chat_chatmessage_session_id_4dacb902_fk_chat_chatsession_id FOREIGN KEY (session_id) REFERENCES public.chat_chatsession(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_chatsession chat_chatsession_admin_id_23081aec_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatsession
    ADD CONSTRAINT chat_chatsession_admin_id_23081aec_fk_auth_user_id FOREIGN KEY (admin_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_chatsession chat_chatsession_user_id_5e1fb0de_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_chatsession
    ADD CONSTRAINT chat_chatsession_user_id_5e1fb0de_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_conversation_participants chat_conversation_pa_conversation_id_f3ae152d_fk_chat_conv; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_conversation_participants
    ADD CONSTRAINT chat_conversation_pa_conversation_id_f3ae152d_fk_chat_conv FOREIGN KEY (conversation_id) REFERENCES public.conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_conversation_participants chat_conversation_participants_user_id_01493ead_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_conversation_participants
    ADD CONSTRAINT chat_conversation_participants_user_id_01493ead_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_message chat_message_conversation_id_a1207bf4_fk_chat_conversation_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_conversation_id_a1207bf4_fk_chat_conversation_id FOREIGN KEY (conversation_id) REFERENCES public.conversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_message chat_message_receiver_id_0eceddde_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_receiver_id_0eceddde_fk_auth_user_id FOREIGN KEY (receiver_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_message chat_message_sender_id_991c686c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_sender_id_991c686c_fk_auth_user_id FOREIGN KEY (sender_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: chat_supportticket chat_supportticket_user_id_bec6e0d9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.chat_supportticket
    ADD CONSTRAINT chat_supportticket_user_id_bec6e0d9_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: checkout_order checkout_order_user_profile_id_949184a7_fk_custom_ac; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.checkout_order
    ADD CONSTRAINT checkout_order_user_profile_id_949184a7_fk_custom_ac FOREIGN KEY (user_profile_id) REFERENCES public.custom_accounts_userprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: checkout_orderlineitem checkout_orderlineitem_order_id_b4cfbe6b_fk_checkout_order_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.checkout_orderlineitem
    ADD CONSTRAINT checkout_orderlineitem_order_id_b4cfbe6b_fk_checkout_order_id FOREIGN KEY (order_id) REFERENCES public.checkout_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: checkout_orderlineitem checkout_orderlineitem_seed_id_a1bfbf8c_fk_seeds_seed_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.checkout_orderlineitem
    ADD CONSTRAINT checkout_orderlineitem_seed_id_a1bfbf8c_fk_seeds_seed_id FOREIGN KEY (seed_id) REFERENCES public.seeds_seed(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: communications_chatconversation communications_chatc_superuser_id_2c3b05f4_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatconversation
    ADD CONSTRAINT communications_chatc_superuser_id_2c3b05f4_fk_auth_user FOREIGN KEY (superuser_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: communications_chatconversation communications_chatc_user_id_fa194506_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatconversation
    ADD CONSTRAINT communications_chatc_user_id_fa194506_fk_auth_user FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: communications_chatmessage communications_messa_conversation_id_4929d245_fk_communica; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatmessage
    ADD CONSTRAINT communications_messa_conversation_id_4929d245_fk_communica FOREIGN KEY (conversation_id) REFERENCES public.communications_chatconversation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: communications_chatmessage communications_message_sender_id_559db3f5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.communications_chatmessage
    ADD CONSTRAINT communications_message_sender_id_559db3f5_fk_auth_user_id FOREIGN KEY (sender_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custom_accounts_userprofile custom_accounts_userprofile_user_id_eca9f42b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.custom_accounts_userprofile
    ADD CONSTRAINT custom_accounts_userprofile_user_id_eca9f42b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_comment reviews_comment_review_id_43f1c708_fk_reviews_review_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.reviews_comment
    ADD CONSTRAINT reviews_comment_review_id_43f1c708_fk_reviews_review_id FOREIGN KEY (review_id) REFERENCES public.reviews_review(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_comment reviews_comment_user_id_1d319c7d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.reviews_comment
    ADD CONSTRAINT reviews_comment_user_id_1d319c7d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_review reviews_review_user_id_875caff2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.reviews_review
    ADD CONSTRAINT reviews_review_user_id_875caff2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dpawoazs
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

