with base as (
    select * from {{ ref('fct_stock_prices') }}
),

final as (
    select
        ticker_symbol,
        sector,

        -- average daily price range (higher = more volatile)
        round(avg(daily_range), 4)                as avg_daily_range,

        -- standard deviation of daily returns (classic volatility measure)
        round(stddev(daily_return_pct), 4)        as return_volatility,

        -- average daily return
        round(avg(daily_return_pct), 4)           as avg_daily_return_pct,

        -- total return over the whole period
        round(
            (max(close_price) - min(close_price))
            / min(close_price) * 100
        , 2)                                      as total_period_return_pct,

        -- average dollar volume (how liquid is this stock?)
        round(avg(dollar_volume), 2)              as avg_dollar_volume,

        count(distinct price_date)                as trading_days

    from base
    group by 1, 2
)

select * from final
order by return_volatility desc