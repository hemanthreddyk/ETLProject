-- Top 10 ATMs where most transactions are in the ’inactive’ state

select
    a.atm_number,
    a.atm_manufacturer,
    l.location,
    count(trans_id) as total_transaction_count,
    sum(
        case
            when atm_status = 'Inactive' then 1
            else 0
        end
    ) as inactive_transaction_count
from
    etl_bankatm_data.fact_atm_trans f,
    etl_bankatm_data.dim_atm a,
    etl_bankatm_data.dim_location l
where
    f.atm_id = a.atm_id
    and a.atm_location_id = l.location_id
group by
    a.atm_number,
    a.atm_manufacturer,
    l.location
order by
    inactive_transaction_count desc
limit 10;