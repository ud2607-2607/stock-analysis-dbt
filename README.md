# Stock Market Analytics Pipeline

## Overview
An end-to-end analytics engineering pipeline that ingests real-time S&P 500 stock data 
and transforms it into business-ready models for performance and volatility analysis.

25 S&P 500 stocks across 5 sectors, 1 year of daily price history (~6,275 rows)

## Tech Stack
- **Databricks** — data ingestion and reshaping via Python/pandas
- **Snowflake** — cloud data warehouse (RAW, STAGING, MARTS layers)
- **dbt Cloud** — SQL transformation, testing, and documentation
- **Yahoo Finance API (yfinance)** — real-time stock price data source

## Architecture
Yahoo Finance API (raw data) -> Databricks (ingest) -> Snowflake -> dbt staging and marts 

## Staging 
- 'stg_stock_prices.sql' -> Cleaned version for the raw data of 25 S&P 500 stocks 

## Marts 
- fct_stock_prices.sql -> core fact table with derived metrics 
- agg_sector_performance.sql -> monthly performance aggregation by market sector
- agg_stock_volatility.sql -> volatility and return metrics metrics per stock over the full period 

## Key Metrics Engineered 
- Daily return % per stock 
- Monthly sector performance ranking 
- Dollar Value 
- Return Volatility (stdev of daily returns)

## Dbt Test 
- schema.yml that ensures 7 dbt test are not_null, uniqueness 