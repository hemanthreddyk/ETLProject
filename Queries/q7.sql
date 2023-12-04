-- Number of transactions happening on an ATM on weekdays and on weekends throughout the year. Order
-- this by the ATM_number, ATM_manufacturer, location, weekend_flag and then total_transaction_count

select
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    case
        when d.weekday in ('Saturday', 'Sunday') then 1
        else 0
    end as weekend_flag,
    count(trans_id) as total_transaction_count
from
    etl_bankatm_data.fact_atm_trans f,
    etl_bankatm_data.dim_atm a,
    etl_bankatm_data.dim_location l,
    etl_bankatm_data.dim_date d
where
    f.atm_id = a.atm_id
    and a.atm_location_id = l.location_id
    and f.date_id = d.date_id
group by
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    weekend_flag
order by
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    weekend_flag,
    total_transaction_count
limit 10;