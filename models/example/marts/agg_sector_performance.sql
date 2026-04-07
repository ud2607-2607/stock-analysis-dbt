with base as (
    select * from {{ ref('fct_stock_prices') }}
),

final as (
    select
        date_trunc('month', price_date)   as month,
        sector,

        -- average return across all stocks in sector that month
        round(avg(daily_return_pct), 4)   as avg_monthly_return_pct,

        -- total dollar volume traded in sector that month
        round(sum(dollar_volume), 2)      as total_dollar_volume,

        -- best single day return in sector that month
        round(max(daily_return_pct), 4)   as best_day_return_pct,

        -- worst single day return in sector that month
        round(min(daily_return_pct), 4)   as worst_day_return_pct,

        -- number of trading days
        count(distinct price_date)        as trading_days

    from base
    group by 1, 2
)

select * from final
order by month desc, avg_monthly_return_pct desc