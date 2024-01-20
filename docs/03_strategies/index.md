# Strategies

!!! note "Note:" 
    This is a work in progress.

## Use cases - which strategy is best for you?

- DCA_Strict: 
    - You're a believer in crypto and you're playing very long... 
    - Only buys.
- DCA_Conditional_Buy_LR: 
    - A believer that wants to avoid buying during a fall.
    - Only buys.
- DCA_Conditional_Buy_LR_with_TrailingStop: 
    - DCA + Trailing Stop Loss.
    - Buys and passive sells with stop loss.
    - Check TrailingStopLoss.
- TrailingStopLoss: you want to protect your crypto holdings or incomes selling it in a fall ensuring a profit
    - Passive sells with stop loss.
    - You have crypto, you're holding, but you can trade a part to get a profit in the bull run.
    - You have incomes in crypto, like a validator, miner, hotspot.
    - You bought crypto on the previous bull run and you want to sell it with a profit, setting a minimal price.

## General parameters

````yaml
Strategies:
  - id: DCA_Strict
    name: DCA_Strict
    enabled: true
    strategy_class: elena_basic.strategies.dca_strict.DCA_Strict

    bots:
      - id: DCA_BTC_USDT_1
        name: DCA Strict BTC/USDT
        enabled: false
        pair: BTC/USDT
        exchange: binance
        time_frame: 1h # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0,30 * * * *" # At every 5th minute
        budget_limit: 600.0 # Buy up to 600 UDST
        pct_reinvest_profit: 100.0 # reinvest all profits
````

Parameters:

- strategy_class:
- pair:
- exchange:
- time_frame:
- cron_expression:
- budget_limit:
- pct_reinvest_profit:

## DCA_Strict

Just a DCA, a cron to create a buy order. No more logic.

## DCA_Conditional_Buy_LR

A cron expression evaluates a linear regression, if the angle is positive creates the buy order, to avoid buying during a fall.

## DCA_Conditional_Buy_LR_with_TrailingStop

Buys as DCA_Conditional_Buy_LR but adds a trailing stop.

[Experiments](DCA_Conditional_Buy_LR_with_TrailingStop).

## TrailingStopLoss
