# Strategies

!!! note "Note:" 
    This is a work in progress. It's a software configuration guide. This Is Not Financial Advice.

## Use cases - which strategy is best for you?

- DCA_Strict:
    - You're a believer in crypto and you're playing very long...
    - Only buys.
    - Why use Elena and not your exchange "auto invest"? At least in Binance, Elena is cheaper. You can also automate in
      one place several exchanges.
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
    - You bought crypto on the previous bull run and you want to sell it with a profit, setting a minimal price. (pending to implement)
    - You want to buy by your self, but after that you want to protect that asset from strong falls.

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

- **strategy_class**: this chooses what strategy to use.
- **bots.id**: bot id, that's used as filename like DCA_BTC_USDT_1.json
- **pair**: uppercase string literal of a pair of currencies (as [CCXT](https://github.com/ccxt/ccxt/wiki) express it)
- **exchange**: exchange
  name [as represented in Elena](https://github.com/Pasta-fantasia/elena/blob/main/elena/domain/model/exchange.py#L5).
- **time_frame**: default timeframe for the candles retrival from
  exchange [as represented in Elena](https://github.com/Pasta-fantasia/elena/blob/main/elena/domain/model/time_frame.py#L4)
- **cron_expression**: [cron expression](https://crontab.guru/) that defines when the bot is going to be executed. The
  default installation in this guid makes Elena to execute every minute but a weekly DCA can uses something like "0 0
  12 ? * SUN"
- **budget_limit**: sets how much can spend. 0 means no limit. On any buy the strategies check if there is budget on the
  bot and balance on the exchange. You can assign 100 USDT on the bot while you keep 300 USDT on the exchange.
- **pct_reinvest_profit**: sets, after a profitable trade, how much of that profit will become part of the budget.

## DCA_Strict

On every cron execution it places a buy market order. The amount of the order is set by _spend_on_order_ parameter and
it's limited by budget.

````yaml
Strategies:
  - id: DCA_Strict
    strategy_class: elena_basic.strategies.dca_strict.DCA_Strict
    bots:
      - id: DCA_BTC_USDT_1
        config:
          spend_on_order: 10.0 
````

Parameters:

- **spend_on_order**: how much can spend on every single order, budget and balance are checked.

## DCA_Conditional_Buy_LR

As _DCA_Strict_ but it evaluates a linear regression, if the angle is positive creates the buy order, to avoid buying
during a fall. _lr_buy_longitude_ determines how many time intervals are used to calculate the angle.

In 1d time frame, _lr_buy_longitude_ is the number of _days_ with price going up.

```yaml
Strategies:
  - id: DCA_LR
    strategy_class: elena_basic.strategies.dca_conditional_lr.DCA_Conditional_Buy_LR
    bots:
      - id: DCA_LR_BTC_USDT_1
        config:
          spend_on_order: 100.0 
          lr_buy_longitude: 5 

```

Parameters:

- **spend_on_order**: how much can spend on every single order, budget and balance are checked.
- **lr_buy_longitude**: number of timeframe point to calculate the linear regression. In a 1d time fame is the number of
  days.

## TrailingStopLoss

A [trailing stop](https://www.investopedia.com/terms/t/trailingstop.asp#:~:text=Key%20Takeaways,back%20in%20the%20other%20direction.)
moves up a [stop order](https://www.investopedia.com/terms/s/stoporder.asp),
an order that is executed when the prices fall from a "stop loss" point and has a minimal selling price at "stop price".

Stop loss limit is shown as _lb_close_ the blue line on the graphs. Stop price as _lb_low_ the orange line on the
graphs.

It's a conservative strategy to protect the investment.

On every run the bots will:

- Check if new coins has arrived they will start a new _trade_ with an entry price as the current price.
- Once a _trade_ begins the bots will check if the _entry price_ is higher than then current _"stop price"
  +minimal_benefit_to_start_trailing_, if so, a stop order will be sent with stop loss (lb_close) and stop price(
  lb_low).
- For every trade already started they will check if the current calculated stop price is higher than the previous
  order, if so, they will cancel the old order and create a new one. The bots groups all trades in one stop order deu to
  some exchanges limitations.

Uses [Double Exponential Moving Average (DEMA)](https://www.investopedia.com/terms/d/double-exponential-moving-average.asp)
on the Closes to calculate the stop loss. Stop price is the stop loss minus a percentage.

Why DEMA? Because it performed better on the simulations.

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
          band_low_pct: 3.8906
          min_price_to_start_trailing: 0.0
          minimal_benefit_to_start_trailing: 0.3 
          asset_to_manage: 100%


````

Parameters:

- **band_length**: DEMA length. Number of data point in the time_frame defined at bot level.
- **band_mult**: standard deviation multiplier over band.
- **band_low_pct**: percentage bellow stop loss to set the stop price.
- **min_price_to_start_trailing**: price of the asset to start trailing
- **minimal_benefit_to_start_trailing**: % minimal benefit, expressed as 5%, but minimal could be 0.3%
- **asset_to_manage**: expressed a % or absolute is how much asset to manage.


stop_loss = dema(ohlc.close,band_length) - ( std(ohlc.close,band_length) * band_mult )

stop_price = stop_loss - band_low_pct%

_band_low_pct_ in the examples coms from the down variance (open - low) of the price for the optimization period.

## DCA_Conditional_Buy_LR_with_TrailingStop

Buys as DCA_Conditional_Buy_LR but adds a trailing stop. The trailing is the same as _TrailingStopLoss_ but it works
only with the trades that the DCA started (only DCA buys are managed)

[Experiments](DCA_Conditional_Buy_LR_with_TrailingStop).

````yaml
Strategies:
  - id: DCA_LR_SL...
    strategy_class: elena_basic.strategies.dca_conditional_lr_trailing_stop.DCA_Conditional_Buy_LR_with_TrailingStop

    bots:
      - id: DCA_LR_SL_BTC_USDT_1
        config:
          spend_on_order: 200.0
          daily_budget: 200.0
          # weekly_budget: 0.0
          spent_times_shift: "-5 hours"
          lr_buy_longitude: 7
          band_length: 34
          band_mult: 2
          band_low_pct: 3.8906
          min_price_to_start_trailing: 0.0
          minimal_benefit_to_start_trailing: 0.3 

````

Parameters:

- **spend_on_order**: how much can spend on every single order, budget and balance are checked.
- **daily_budget**: how much to spend by day. _spend_on_order_ = to 10, with a cron by hour will by 24 times and spend 240... unless _daily_budget_ is set to, for example, 100 then it will buy only 100 per day. Spend by day is calculated based on the buy orders.
- **weekly_budget**: same as _daily_budget_ but for week.
- **spent_times_shift**: -[timedelta](https://pandas.pydata.org/docs/reference/api/pandas.Timedelta.html) to shit the week or daily spend. Useful to start the day at 5am with _"-5 hours"_.
- **lr_buy_longitude**: number of timeframe point to calculate the linear regression. In a 1d time fame is the number of
  days.
- **band_length**: DEMA length. Number of data point in the time_frame defined at bot level.
- **band_mult**: standard deviation multiplier over band.
- **band_low_pct**: percentage bellow stop loss to set the stop price.
- **min_price_to_start_trailing**: price of the asset to start trailing
- **minimal_benefit_to_start_trailing**: % minimal benefit, expressed as 5%, but minimal could be 0.3%
- **asset_to_manage**: expressed a % or absolute is how much asset to manage.