# Strategies

!!! note "Note:" 
    This is a work in progress. It's a software configuration guide. This Is Not Financial Advice.

## Use cases - which strategy is best for you?

- DCA_Strict: 
    - You're a believer in crypto and you're playing very long... 
    - Only buys.
    - Why use Elena and not your exchange "auto invest"? At least in Binance, Elena is cheaper. You can also automate in one place several exchanges.
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
        cron_expression: "0,30 * * * *" # At 0 and 30 minutes of every hour
        budget_limit: 600.0 # Buy up to 600 UDST
        pct_reinvest_profit: 100.0 # reinvest all profits
````

Parameters:

- strategy_class: this chooses what strategy to use.
- pair: uppercase string literal of a pair of currencies (as [CCXT](https://github.com/ccxt/ccxt/wiki) express it)
- exchange: exchange name [as represented in Elena](https://github.com/Pasta-fantasia/elena/blob/main/elena/domain/model/exchange.py#L5).
- time_frame: default timeframe for the candles retrival from exchange [as represented in Elena](https://github.com/Pasta-fantasia/elena/blob/main/elena/domain/model/time_frame.py#L4) 
- cron_expression: [cron expression](https://crontab.guru/) that defines when the bot is going to be executed. The default installation in this guid makes Elena to execute every minute but a weekly DCA can uses something like "0 0 12 ? * SUN"
- budget_limit: sets how much can spend. 0 means no limit. On any buy the strategies check if there is budget on the bot and balance on the exchange. You can assign 100 USDT on the bot while you keep 300 USDT on the exchange.
- pct_reinvest_profit: sets, after a profitable trade, how much of that profit will become part of the budget.

## DCA_Strict

Just a DCA, a cron to create a buy order. No more logic.

````yaml
Strategies:
  - id: DCA_Strict
    strategy_class: elena_basic.strategies.dca_strict.DCA_Strict
    bots:
      - id: DCA_BTC_USDT_1
        config:
          spend_on_order: 10.0 # spend 100 USDT on every cycle
````

Parameters:

- spend_on_order:


## DCA_Conditional_Buy_LR

A cron expression evaluates a linear regression, if the angle is positive creates the buy order, to avoid buying during a fall.

```yaml
Strategies:
  - id: DCA_LR
    strategy_class: elena_basic.strategies.dca_conditional_lr.DCA_Conditional_Buy_LR
    bots:
      - id: DCA_LR_BTC_USDT_1
        config:
          spend_on_order: 100.0 # spend 100 USDT on every cycle
          lr_buy_longitude: 5 # data points for linear regression

```

Parameters:

- spend_on_order: how much can spend on every single order, budget and balance are checked.
- lr_buy_longitude: number of timeframe point to calculate the linear regression. In a 1d time fame is the number of days.


## DCA_Conditional_Buy_LR_with_TrailingStop

Buys as DCA_Conditional_Buy_LR but adds a trailing stop.

[Experiments](DCA_Conditional_Buy_LR_with_TrailingStop).

````yaml
Strategies:
  - id: DCA_LR_SL...
    strategy_class: elena_basic.strategies.dca_conditional_lr_trailing_stop.DCA_Conditional_Buy_LR_with_TrailingStop

    bots:
      - id: DCA_LR_SL_BTC_USDT_1
        config:
          spend_on_order: 100.0 # spend 100 USDT on every cycle
          lr_buy_longitude: 5 # data points for linear regression
          band_length: 7
          band_mult: 1
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%

````

Parameters:

- spend_on_order: how much can spend on every single order, budget and balance are checked.
- lr_buy_longitude: number of timeframe point to calculate the linear regression. In a 1d time fame is the number of days.
- band_length:
- band_mult:
- minimal_benefit_to_start_trailing:


## TrailingStopLoss

````yaml
  - id: TrailingStopLoss
    name: TrailingStopLoss
    enabled: true
    strategy_class: elena_basic.strategies.trailing_stop.TrailingStopLoss

    bots:
      - id: BTC_USDT_1
        name: TrailingStopLoss BTC/USDT
        config:
          band_length: 7
          band_mult: 1
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%
          asset_to_manage: 100%


````
Parameters:

- band_length:
- band_mult:
- minimal_benefit_to_start_trailing:
- asset_to_manage: