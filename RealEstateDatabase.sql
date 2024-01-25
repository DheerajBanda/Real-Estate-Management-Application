drop table Agency CASCADE;
drop table Agent CASCADE;
drop table Apartment;
drop table Area;
drop table AreaHospitals;
drop table AreaSchools;
drop table Booking;
drop table Card;
drop table CommBuild;
drop table HoldsCard;
drop table Hospital;
drop table House;
drop table Land;
drop table Located;
drop table Manages;
drop table Owner;
drop table Owns;
drop table Property CASCADE;
drop table Renter;
drop table School;
drop table WorksFor;

/*STRONG ENTITIES-------------------------------------------------------------------------------------------------------*/
-- Agency (agency_id, agency_name, contact_info, street, city, state, zip_code)
-- Agent (agent_email, first_name, last_name, contact info, job_title, street, city, state, zip_code)
-- Property (property_id, price, description, availability, city, state, zip_code)
-- House (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft)
-- Apartment (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft,  build_type)
-- CommBuild (property_id, price, description, availability, city, state, zip_code, business_type, amt_rooms, sq_ft)
-- Land (property_id, price, description, availability, city, state, zip_code, acres)
-- VacationHome (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft)
-- Area (location_id, location_name, crime_rate)
-- School (school_name)
-- Hospital (hospital_name)
-- Renter (renter_email, budget, enroll_rewards, pref_num_beds, pref_location, preferred_num_baths, contact_info, first_name, last_name, street, city, state, zip_code)
-- Card (card_number, card_name, security_code, exp_date, renter_email)
-- Owner (owner_id, owner_email, fist_name, last_name, contact_info, street, city, state, zip_code)

/*RELATIONSHIPS--------------------------------------------------------------------------------------------------------------*/
-- Owns (property_id, owner_email)
-- Booking (booking_id, property_id, renter_email, card_number, start_date, end_date)
-- AreaSchools (location_id, school_name)
-- AreaHospitals (location_id, hospital_name)
-- Located (property_id, location_id)
-- HoldsCard (card_number, renter_email)
-- Manages  (property_id, agent_id)
-- WorksFor (agent_id, agency_id)


/*STRONG ENTITIES-------------------------------------------------------------------------------------------------------*/

/*Agency (agency_id, agency_name, contact_info, street, city, state, zip_code)*/
create table Agency (
	agency_id		VARCHAR(8),
	agency_name		VARCHAR(10),
	contact_info	VARCHAR(50),
	street			VARCHAR(10),
	city			VARCHAR(10),
	state			CHAR(2),
	zip_code		CHAR(5),
	primary key (agency_id));

/*Agent (agent_email, first_name, last_name, contact info, job_title, street, city, state, zip_code)*/
create table Agent (
	agent_email		VARCHAR(25),
	first_name		VARCHAR(8),
	last_name		VARCHAR(10),
	contact_info	VARCHAR(50),
	job_title		VARCHAR(10),
	street			VARCHAR(10),
	city			VARCHAR(10),
	state			CHAR(2),
	zip_code		CHAR(5),
	agency_id		VARCHAR(8),
	primary key (agent_email),
	foreign key (agency_id) references Agency);

/*Property (property_id, price, description, availability, city, state, zip_code)*/
create table Property (
	property_id		VARCHAR(8),
	agent_email		VARCHAR(8),		
	price			NUMERIC(9,2),
	description		VARCHAR(255),
	availability	BOOLEAN default true,
	city			VARCHAR(10),
	state			CHAR(2),
	zip_code		CHAR(5),
	rental_sale		varchar(5),
	available_date	Date,
	primary key (property_id),
	foreign key (agent_email) references Agent);


/*House (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft)*/
create table House (
	amt_rooms		INTEGER,
	sq_ft			INTEGER
	) INHERITS (Property);

/*Apartment (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft,  build_type)*/
create table Apartment (
	amt_rooms		INTEGER,
	sq_ft			INTEGER,
	build_type		VARCHAR(10)
	) inherits (Property);
	
/*CommBuild (property_id, price, description, availability, city, state, zip_code, business_type, amt_rooms, sq_ft)*/
create table CommBuild (
	business_type	VARCHAR(10),
	amt_rooms		INTEGER,
	sq_ft			INTEGER
	) inherits (Property);

/*Land (property_id, price, description, availability, city, state, zip_code, acres)*/	
create table Land (
	acres			INTEGER
	) inherits (Property);

/*VacationHome (property_id, price, description, availability, city, state, zip_code, amt_rooms, sq_ft)*/
create table VacationHome (
	amt_rooms		INTEGER,
	sq_ft			INTEGER
	) inherits (Property);
	
/*Area (location_id, location_name, crime_rate)*/
create table Area (
	location_id		VARCHAR(8),
	location_name	VARCHAR(10),
	crime_rate		INTEGER,
	primary key (location_id));
	
/*School (school_name)*/
create table School (
	school_name		VARCHAR(30),
	primary key (school_name));

/*Hospital (hospital_name)*/
create table Hospital (
	hospital_name	VARCHAR(30),
	primary key (hospital_name));

/*Renter (renter_email, budget, enroll_rewards, pref_num_beds, pref_location, preferred_num_baths, contact_info, first_name, last_name, street, city, state, zip_code)*/
create table Renter (
	renter_email	VARCHAR(25),
	budget			INTEGER,
	enroll_rewards	BOOLEAN default false,
	pref_num_beds	INTEGER,
	pref_location	VARCHAR(10),
	pref_num_baths	INTEGER,
	contact_info	VARCHAR(50),
	first_name		VARCHAR(8),
	last_name		VARCHAR(10),
	street			VARCHAR(10),
	city			VARCHAR(10),
	state			CHAR(2),
	zip_code		CHAR(5),
	primary key (renter_email));
	
/*Card (card_number, card_name, security_code, exp_date, renter_email)*/
create table Card (
	card_number	CHAR(16),
	card_name		VARCHAR(18),
	security_code	CHAR(3),
	exp_date		DATE,
	renter_email	VARCHAR(25),
	primary key (card_number),
	foreign key (renter_email) references Renter);

/*Owner (owner_id, owner_email, fist_name, last_name, contact_info, street, city, state, zip_code)*/
create table Owner (
	owner_id		VARCHAR(8),
	owner_email		VARCHAR(25),
	first_name		VARCHAR(8),
	last_name		VARCHAR(10),
	contact_info	VARCHAR(50),
	street			VARCHAR(10),
	city			VARCHAR(10),
	state			CHAR(2),
	zip_code		CHAR(5),
	primary key (owner_id));


/*Code used to generate RewardsProgram if enroll_rewards is true*/
/*
insert into RewardsProgram (renter_email)
select renter_email from Renters
where enroll_rewards = true;
*/


/*RELATIONSHIPS-------------------------------------------------------------------------------------------------------*/

/*Owns (property_id, owner_email)*/
create table Owns (
	property_id		VARCHAR(8),
	owner_email		VARCHAR(25),
	primary key (property_id));


/*Booking (booking_id, property_id, renter_email, card_number, start_date, end_date)*/
create table Booking (
	booking_id		VARCHAR(8),
	property_id		VARCHAR(8),
	renter_email	VARCHAR(25),
	card_number		CHAR(16),
	start_date		DATE,
	end_date		DATE,
	primary key (booking_id),
	foreign key (property_id) references Property,
	foreign key (renter_email) references Renter,
	foreign key (card_number) references Card);
	
/*AreaSchools (location_id, school_name)*/
create table AreaSchools (
	location_id		VARCHAR(8),
	school_name		VARCHAR(30),
	primary key (school_name));

/*AreaHospitals (location_id, hospital_name)*/	
create table AreaHospitals (
	location_id		VARCHAR(8),
	hospital_name	VARCHAR(30),
	primary key (hospital_name));
	
/*Located (property_id, location_id)*/
create table Located (
	property_id		VARCHAR(8),
	location_id		VARCHAR(8),
	primary key (property_id));
	
/*HoldsCard (card_number, renter_email)*/
create table HoldsCard (
	card_number		CHAR(16),
	renter_email	VARCHAR(25),
	primary key (card_number));

/*Manages  (property_id, agent_id)*/
create table Manages (
	property_id		VARCHAR(8),
	agent_id		VARCHAR(8),
	primary key (property_id));
	
/*WorksFor (agent_id, agency_id)*/
create table WorksFor (
	agent_id		VARCHAR(8),
	agency_id		VARCHAR(8),
	primary key (agent_id));
