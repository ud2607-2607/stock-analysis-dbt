with source as (
    select * from {{ source('raw', 'STOCK_PRICES') }}
),

renamed as (
    select
        date::date         as price_date,
        ticker             as ticker_symbol,
        sector,
        open::float        as open_price,
        high::float        as high_price,
        low::float         as low_price,
        close::float       as close_price,
        volume::bigint     as volume

    from source
    where close is not null
      and volume > 0
)

select * from renamed