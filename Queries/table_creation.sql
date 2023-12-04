create schema etl_bankatm_data;

create table
    etl_bankatm_data.DIM_LOCATION(
        location_id int not null distkey sortkey,
        location varchar(50),
        streetname varchar(255),
        street_number int,
        zipcode int,
        lat DECIMAL(10, 3),
        lon DECIMAL(10, 3),
        PRIMARY KEY(location_id)
    );

create table
    etl_bankatm_data.DIM_ATM(
        atm_id int not null DISTKEY SORTKEY,
        atm_number varchar(20),
        atm_manufacturer varchar(50),
        atm_location_id int,
        PRIMARY KEY(atm_id),
        FOREIGN KEY(atm_location_id) references etl_bankatm_data.DIM_LOCATION(location_id)
    );

create table
    etl_bankatm_data.DIM_DATE(
        date_id int not null DISTKEY SORTKEY,
        full_date_time timestamp,
        year int,
        month varchar(20),
        day int,
        hour int,
        weekday varchar(20),
        PRIMARY KEY(date_id)
    );

create table
    etl_bankatm_data.DIM_CARD_TYPE(
        card_type_id int not null DISTKEY SORTKEY,
        card_type varchar(30),
        PRIMARY KEY(card_type_id)
    );

create table
    etl_bankatm_data.FACT_ATM_TRANS(
        trans_id bigint not null DISTKEY SORTKEY,
        atm_id int,
        weather_loc_id int,
        date_id int,
        card_type_id int,
        atm_status varchar(20),
        currency varchar(10),
        service varchar(20),
        transaction_amount int,
        message_code varchar(225),
        message_text varchar(225),
        rain_3h decimal(10, 3),
        clouds_all int,
        weather_id int,
        weather_main varchar(50),
        weather_description varchar(255),
        PRIMARY KEY(trans_id),
        FOREIGN KEY(weather_loc_id) references etl_bankatm_data.DIM_LOCATION(location_id),
        FOREIGN KEY(atm_id) references etl_bankatm_data.DIM_ATM(atm_id),
        FOREIGN KEY(date_id) references etl_bankatm_data.DIM_DATE(date_id),
        FOREIGN KEY(card_type_id) references etl_bankatm_data.DIM_CARD_TYPE(card_type_id)
    );