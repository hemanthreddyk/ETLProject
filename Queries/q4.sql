-- Number of overall ATM transactions going inactive per month for each month

select
    c.year,
    c.month,
    c.transaction_count,
    d.inactive_count,
    CAST(
        trunc(
            100.0 * d.inactive_count / c.transaction_count,
            2
        ) AS NUMERIC(10, 4)
    ) as inactive_count_percent
from (
        select
            a.year,
            a.month,
            count(b.trans_id) as transaction_count
        from
            etl_bankatm_data.dim_date a,
            etl_bankatm_data.FACT_ATM_TRANS b
        where a.date_id = b.date_id
        group by a.month, a.year
    ) c
    left join (
        select
            a.year,
            a.month,
            count(b.atm_status) as inactive_count
        from
            etl_bankatm_data.dim_date a,
            etl_bankatm_data.FACT_ATM_TRANS b
        where
            a.date_id = b.date_id
            and b.atm_status = 'Inactive'
        group by
            a.month,
            a.year
    ) d on c.year = d.year
    and c.month = d.month
order by c.year, c.month;