# DCA_Conditional_Buy_LR_with_TrailingStop

!!! note "Note:" 
    This is a work in progress. It's a software configuration guide. This Is Not Financial Advice.

Experiment's source code can be found [here](https://github.com/Pasta-fantasia/backtesting_notebooks).

## Scenarios and best results for BTC

DCA_Conditional_Buy_LR_with_TrailingStop works better on _1 day_ timeframe in any scenario. It took thousands of test sampling ranging dates to discard minute and hourly trading for this strategy.

Sampling moving and overlapping dates helped to reduce the parameters space.  

### Range

From: 2022-06-16 to 2023-03-10.

#### Optimized parameters

- band_lenght=9
- band_mult=1
- minimal_benefit_to_start_trailing=1.003
- reinvest=2
- dca_budget=1600
- buy_all_days=0
- lr_buy_longitude=7

#### Results

- Return: **43.3217598368181%** over **-1.2284505259711431%** on buy and hold.
- Initial investment: 1600.0
- Final result: 2293.1481573890896

[![Range_BTC_1d.png](scenarios/Range_BTC_1d.png)](/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Range/Binance_BTC-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1515/bt_interactive_plot.html)


### Up and Down

From 2019-11-01 to 2022-01-23.

#### Optimized parameters

- band_lenght=34
- band_mult=2
- minimal_benefit_to_start_trailing=1.003
- reinvest=2
- dca_budget=200
- buy_all_days=1
- lr_buy_longitude=7

#### Results

- Return: **942.0295578414548%** over **292.6135311175407%** on buy and hold.
- Initial investment: 1600.0
- Final result: 16672.472925463277

[![Up_and_Down_BTC_1d.png](scenarios/Up_and_Down_BTC_1d.png)](/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Up_and_down/Binance_BTC-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1523/bt_interactive_plot.html)

### Bear

From 2021-11-12 to 2022-11-12.

#### Optimized parameters

- band_lenght=3
- band_mult=1
- minimal_benefit_to_start_trailing=1.003
- reinvest=2
- dca_budget=50
- buy_all_days=0
- lr_buy_longitude=11

#### Results

- Return: **-4.829400051103121%** over **-73.78119881357838%** on buy and hold.
- Initial investment: 1600.0
- Final result: 1522.72959918235

[![Bear_BTC_1d.png](scenarios/Bear_BTC_1d.png)](/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/Bear/Binance_BTC-USDT_1d_2021-11-12_2021-11-12_2024-01-20_1525/bt_interactive_plot.html)


### Long Term

From 2017-01-01 to 2024-01-20.

#### Optimized parameters

- band_lenght=34
- band_mult=2
- minimal_benefit_to_start_trailing=1.003
- reinvest=2
- dca_budget=100
- buy_all_days=1
- lr_buy_longitude=2

#### Results

- Return: **1426.2876041527215%** over **868.7791126420045%** on buy and hold.
- Initial investment: 1600.0
- Final result: 24420.601666443545

[![Longterm_BTC_1d.png](scenarios/Longterm_BTC_1d.png)](/03_strategies/DCA_Conditional_Buy_LR_with_TrailingStop/LongTerm/Binance_BTC-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1526/bt_interactive_plot.html)



## BTC

### Bear

[Binance_BTC-USDT_1d_2021-11-12_2021-11-12_2024-01-20_1525](Bear/Binance_BTC-USDT_1d/index.md)

[Binance_BTC-USDT_1h_2021-11-12_2021-11-12_2024-01-20_1541](Bear/Binance_BTC-USDT_1h_2021-11-12_2021-11-12_2024-01-20_1541/index.md)

[Binance_BTC-USDT_1w_2021-11-12_2021-11-12_2024-01-20_1542](Bear/Binance_BTC-USDT_1w_2021-11-12_2021-11-12_2024-01-20_1542/index.md)

### Range

[Binance_BTC-USDT_1h_2022-06-16_2022-06-16_2024-01-20_1538](Range/Binance_BTC-USDT_1h_2022-06-16_2022-06-16_2024-01-20_1538/index.md)

[Binance_BTC-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1515](Range/Binance_BTC-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1515/index.md)

[Binance_BTC-USDT_1w_2022-06-16_2022-06-16_2024-01-20_1537](Range/Binance_BTC-USDT_1w_2022-06-16_2022-06-16_2024-01-20_1537/index.md)

### Up and down

[Binance_BTC-USDT_1w_2019-11-01_2019-11-01_2024-01-20_1555](Up_and_down/Binance_BTC-USDT_1w_2019-11-01_2019-11-01_2024-01-20_1555/index.md)

[Binance_BTC-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1523](Up_and_down/Binance_BTC-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1523/index.md)

[Binance_BTC-USDT_1h_2019-11-01_2019-11-01_2024-01-20_1556](Up_and_down/Binance_BTC-USDT_1h_2019-11-01_2019-11-01_2024-01-20_1556/index.md)

### Long Term

[Binance_BTC-USDT_1w_2017-01-01_2017-01-01_2024-01-20_1543](LongTerm/Binance_BTC-USDT_1w_2017-01-01_2017-01-01_2024-01-20_1543/index.md)

[Binance_BTC-USDT_1h_2017-01-01_2017-01-01_2024-01-20_1633](LongTerm/Binance_BTC-USDT_1h_2017-01-01_2017-01-01_2024-01-20_1633/index.md)

[Binance_BTC-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1526](LongTerm/Binance_BTC-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1526/index.md)


## ETH

### Bear

[Binance_ETH-USDT_1d_2021-11-12_2021-11-12_2024-01-20_1611](Bear/Binance_ETH-USDT_1d_2021-11-12_2021-11-12_2024-01-20_1611/index.md)

### Range

[Binance_ETH-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1612](Range/Binance_ETH-USDT_1d_2022-06-16_2022-06-16_2024-01-20_1612/index.md)

### Up_and_down

[Binance_ETH-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1609](Up_and_down/Binance_ETH-USDT_1d_2019-11-01_2019-11-01_2024-01-20_1609/index.md)

### Long Term
[Binance_ETH-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1610](LongTerm/Binance_ETH-USDT_1d_2017-01-01_2017-01-01_2024-01-20_1610/index.md)

## HNT

Scenario for HNT can't be the sames for other due to data lack in exchanges.

[KuCoin_HNT-USDT_1d_2023-06-16_2023-06-16_2024-01-21_1731](HNT/KuCoin_HNT-USDT_1d_2023-06-16_2023-06-16_2024-01-21_1731/index.md)
