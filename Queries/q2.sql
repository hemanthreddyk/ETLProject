-- Q2 Number of ATM failures corresponding to the different
-- weather conditions recorded at the time of the transactions

select
    f.weather_main,
    count(trans_id) as total_transaction_count,
    sum(
        case
            when atm_status = 'Inactive' then 1
            else 0
        end
    ) as inactive_count,
    case
        when coalesce(inactive_count, 0) = 0 then 0.0000
        else trunc( (
                cast(
                    inactive_count as numeric(10, 4)
                ) / total_transaction_count
            ) * 100,
            2
        )
    end as inactive_count_percent
from
    etl_bankatm_data.fact_atm_trans f
where f.weather_main != ''
group by f.weather_main
order by
    inactive_count_percent desc
limit 10;
