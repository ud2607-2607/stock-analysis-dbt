with staging as (
    select * from {{ ref('stg_stock_prices') }}
),

final as (
    select
        price_date,
        ticker_symbol,
        sector,
        open_price,
        high_price,
        low_price,
        close_price,
        volume,

        -- daily price change
        close_price - open_price                          as price_change,

        -- daily % return
        round((close_price - open_price) / open_price * 100, 2) as daily_return_pct,

        -- daily price range (how volatile was this day?)
        high_price - low_price                            as daily_range,

        -- dollar volume (how much money moved?)
        round(close_price * volume, 2)                    as dollar_volume

    from staging
)

select * from final