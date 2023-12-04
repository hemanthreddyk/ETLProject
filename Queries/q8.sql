-- Most active day in each ATMs from location "Vejgaard"

select
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    d.weekday,
    count(trans_id) as total_transaction_count
from
    etl_bankatm_data.fact_atm_trans f
    inner join etl_bankatm_data.dim_atm a on f.atm_id = a.atm_id
    inner join etl_bankatm_data.dim_location l on a.atm_location_id = l.location_id
    inner join etl_bankatm_data.dim_date d on f.date_id = d.date_id
where
    l.location = 'Vejgaard'
    and d.weekday in (
        select d.weekday
        from
            etl_bankatm_data.fact_atm_trans f
            inner join etl_bankatm_data.dim_date d on f.date_id = d.date_id
            inner join etl_bankatm_data.dim_location l on f.weather_loc_id = l.location_id
        where l.location = 'Vejgaard'
        group by d.weekday
        order by
            count(f.trans_id) desc
        limit 1
    )
group by
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    d.weekday
order by
    total_transaction_count;