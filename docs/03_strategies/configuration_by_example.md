# Configuration by example

!!! note "Note:" 
    This is a work in progress. It's a software configuration guide. This Is Not Financial Advice.

This page guides you to an example of parametrization using DCA_Conditional_Buy_LR_with_TrailingStop and
TrailingStopLoss.

Lets supuse you have 1000 USDT and some old BTC and some HNT from your hotspot.

You believe in two possible [scenarios](../03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/index.md) for the next
year: _Up and Down_ or _Range_.

- TrailingStopLoss to protect or trade some already hodl crypto, BTC and HNT.
- DCA_Conditional_Buy_LR_with_TrailingStop to invest the 1000 USDT.

All config bellow are in [strategies_example.yaml](../assets/configs_2.2.2/strategies_example.yaml)

## TrailingStopLoss for BTC and HNT

For long term BTC configuration for the trailing is 1d timeframe and:

- band_length=34
- band_mult=2

For HNT
the [same configuration can be used](../03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/HNT/KuCoin_HNT-USDT_1d_2023-06-16_2023-06-16_2024-01-21_1731/bt_interactive_plot.html).
You can see in the graph that the sell is not triggered.

The bots will run every hour to check the status.

In both cases all the balance in the exchange will be managed by the strategy. Every time new coins arrive the bots will
take them as "under protection".

If you want to combine this strategy with another trading one in the same exchange you must use absolute number on
_asset_to_manage_. The example will use Kucoin for TrailingStopLoss and Binance for
DCA_Conditional_Buy_LR_with_TrailingStop.

The configuration file for this looks like:

````yaml
Strategies:
  - id: TrailingStopLoss
    name: TrailingStopLoss
    enabled: true
    strategy_class: elena_basic.strategies.trailing_stop.TrailingStopLoss

    bots:
       - id: BTC_USDT_1
        name: TrailingStopLoss BTC/USDT
        enabled: true
        pair: BTC/USDT
        exchange: kucoin
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 * * * *" # At every minute
        budget_limit: 0.0 # don't control budget
        pct_reinvest_profit: 100.0 # reinvest all profits
        tags:
          - TrailingStopLoss
          - bear
        config: # https://elena.fransimo.info/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/LongTerm/Binance_BTC-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1526/
          band_length: 34
          band_mult: 2
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%
          asset_to_manage: 100%

      - id: HNT_USDT_1
        name: TrailingStopLoss HNT/USDT
        enabled: true
        pair: HNT/USDT
        exchange: kucoin
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 * * * *" # At every minute
        budget_limit: 0.0 # don't control budget
        pct_reinvest_profit: 100.0 # reinvest all profits
        tags:
          - TrailingStopLoss
          - bear
        config: # https://elena.fransimo.info/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/HNT/KuCoin_HNT-USDT_1d_2023-06-16_2023-06-16_2024-01-21_1731/
          band_length: 34
          band_mult: 2
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%
          asset_to_manage: 100%
````

## DCA_Conditional_Buy_LR_with_TrailingStop to invest the 1000 USDT

With the 1000 USDT on Binance, 500 will trade with BTC and 500 on ETH.

All configration will spend 100 USDT each time.

For BTC:

- lr_buy_longitude: 7 
- band_length: 34
- band_mult: 2

From the [experiment](../03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Up_and_down/Binance_BTC-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1523/index.md).

You split the 500 on ETH in two parametrization: 

- Range (from the [experiment](DCA_Conditional_Buy_LR_with_TrailingStop/Range/Binance_ETH-USDT_1d/index.md))
    - lr_buy_longitude: 6 
    - band_length: 11 
    - band_mult: 1
- Up_and_down (from the [experiment](../03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Up_and_down/Binance_ETH-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1609/index.md))
    - lr_buy_longitude: 2 
    - band_length: 55
    - band_mult: 2

Optimization are only a guide and are based on history. The [ETH Range optimization](DCA_Conditional_Buy_LR_with_TrailingStop/Range/Binance_ETH-USDT_1d/index.md) is band_length: 11, band_mult: 1, but it also says dca_budget=1600, buy_all_days=0. That means use all your budget once a week. The example bellow uses only 100 USDT per day.

Before using any bot with any configuration is better your check at least the simulation by your self, and then, if the parameters are compatible run it in the exchange test environment.

````yaml
Strategies:
  - id: DCA_LR_SL
    name: DCA_LR_SL
    enabled: true
    strategy_class: elena_basic.strategies.dca_conditional_lr_trailing_stop.DCA_Conditional_Buy_LR_with_TrailingStop

    bots:
      - id: DCA_LR_SL_BTC_USDT_1
        name: DCA Conditional LR with Trailing Stop Loss BTC/USDT
        enabled: false
        pair: BTC/USDT
        exchange: binance
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 5 * * *" # At 5am each day
        budget_limit: 500.0 # Buy up to 500 UDST
        pct_reinvest_profit: 100.0 # reinvest all profits
        tags:
          - DCA
          - bull
        config: # https://elena.fransimo.info/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Up_and_down/Binance_BTC-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1523/
          spend_on_order: 100.0 # spend 100 USDT on every cycle
          lr_buy_longitude: 7 # data points for linear regression
          band_length: 34
          band_mult: 2
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%

      - id: DCA_LR_SL_ETH_USDT_1
        name: DCA Conditional LR with Trailing Stop Loss BTC/USDT
        enabled: false
        pair: ETH/USDT
        exchange: binance
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 5 * * *" # At 5am each day
        budget_limit: 250.0 # Buy up to 250 UDST
        pct_reinvest_profit: 100.0 # reinvest all profits
        tags:
          - DCA
          - ranging
        config: # https://elena.fransimo.info/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Range/Binance_ETH-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1612/
          spend_on_order: 100.0 # spend 100 USDT on every cycle
          lr_buy_longitude: 6 # data points for linear regression
          band_length: 11
          band_mult: 1
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%

      - id: DCA_LR_SL_ETH_USDT_2
        name: DCA Conditional LR with Trailing Stop Loss BTC/USDT 2
        enabled: false
        pair: ETH/USDT
        exchange: binance
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 5 * * *" # At 5am each day
        budget_limit: 250.0 # Buy up to 250 UDST
        pct_reinvest_profit: 100.0 # reinvest all profits
        tags:
          - DCA
          - bull
        config: # https://elena.fransimo.info/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Up_and_down/Binance_ETH-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1609/
          spend_on_order: 100.0 # spend 100 USDT on every cycle
          lr_buy_longitude: 2 # data points for linear regression
          band_length: 55
          band_mult: 2
          minimal_benefit_to_start_trailing: 0.3 # % minimal benefit, expressed as 5%, but minimal could be 0.3%

````


## General conservative configuration

The only real way to configure your strategies is to try the parameters your self using the [experiments' repo notebooks](https://github.com/Pasta-fantasia/backtesting_notebooks).

The results [here](../03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/index.md) always come with a heat map, an ordered by return set of results that show all posible combination of parameters.

As mentioned above, optimization are only a guide based on history.

All that said, over a lot of simulations one repeats very ofter:

````yaml
        time_frame: 1d # Valid values: 1m, 1h, 1d, 1M, 1y
        cron_expression: "0 5 * * *" # At 5am each day
        config: 
          spend_on_order: 100.0 # spend 50 on bear, 100 on range, more only if you're absolute sure.
          lr_buy_longitude: 7 # or 6
          band_length: 34 # for long term and trusted assets
          band_mult: 2
          # band_length: 13 # for short term or risk reduction
          # band_mult: 1
````
