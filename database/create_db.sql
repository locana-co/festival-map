-- bootstrap script

--DROP DATABASE IF EXISTS festival_map;
--CREATE DATABASE festival_map;
DROP SCHEMA IF NOT EXISTS public CASCADE;
CREATE SCHEMA IF NOT EXISTS public;
CREATE EXTENSION IF NOT EXISTS postgis;

DROP TABLE IF EXISTS customer CASCADE;
CREATE TABLE IF NOT EXISTS customer (
    id serial primary key,
    name text,
    website text,
    location geometry,
    phone_number text,
    email text,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS festival CASCADE;
CREATE TABLE IF NOT EXISTS festival (
    id serial primary key,
    customer_id serial references customer(id),
    name text,
    description text,
    website text,
    start_date timestamp,
    end_date timestamp,
    centroid geometry,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS vendor_type CASCADE;
CREATE TABLE IF NOT EXISTS vendor_type (
    id serial primary key,
    festival_id serial references festival(id),
    name text,
    description text,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS vendor CASCADE;
CREATE TABLE IF NOT EXISTS vendor (
    id serial primary key,
    vendor_type_id serial references vendor_type(id),
    festival_id serial references festival(id),
    map_location_id serial references map_location(id),
    name text,
    description text,
    website text,
    size text,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TYPE IF EXISTS map_type_enum CASCADE;
CREATE TYPE map_type_enum AS ENUM ('festival', 'admin', 'registration');
DROP TABLE IF EXISTS map_type CASCADE;
CREATE TABLE IF NOT EXISTS map_type (
    id serial primary key,
    name text,
    type map_type_enum,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS map CASCADE;
CREATE TABLE IF NOT EXISTS map (
    id serial primary key,
    map_type_id serial references map_type(id),
    festival_id serial references festival(id),
    name text,
    style_json json,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS map_location CASCADE;
CREATE TABLE IF NOT EXISTS map_location (
    id serial primary key,
    map_id serial references map(id),
    name text,
    geom geometry,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS admin_permissions CASCADE;
CREATE TABLE IF NOT EXISTS admin_permissions (
    id serial primary key,
    read boolean,
    write boolean,
    delete boolean,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);

DROP TABLE IF EXISTS admin CASCADE;
CREATE TABLE IF NOT EXISTS admin (
    id serial primary key,
    permission_id serial references admin_permissions(id),
    customer_id serial references customer(id),
    username text,
    first_name text,
    last_name text,
    date_created timestamp,
    date_modified timestamp,
    active boolean
);
