# Class: DCA_Conditional_Buy_LR_with_TrailingStop - HNT - HNT/USDT - KuCoin

- Experiment nickname: HNT 
- Symbol: HNT/USDT
- Exchange: KuCoin
- Start date: 2023-06-16
- End date: 2024-01-21
- Timeframe: 1d

## Optimized parameters

- band_lenght=34
- band_mult=2
- minimal_benefit_to_start_trailing=1.003
- reinvest=2
- dca_budget=200
- buy_all_days=1
- lr_buy_longitude=11

## Results

- Return: **278.090686541276%** over **436.87543869018555%** on buy and hold.
- Initial investment: 1600.0
- Final result: 6049.450984660416

Interactive simulation graph: [bt_interactive_plot.html](bt_interactive_plot.html)

## Details 
### Backtesting stats:

```
Start                     2023-06-16 00:00:00
End                       2024-01-21 00:00:00
Duration                    219 days 00:00:00
Exposure Time [%]                   84.090909
Equity Final [$]                  6049.450985
Equity Peak [$]                    7994.78103
Return [%]                         278.090687
Buy & Hold Return [%]              436.875439
Return (Ann.) [%]                  808.414879
Volatility (Ann.) [%]               1903.6141
Sharpe Ratio                         0.424674
Sortino Ratio                       15.924387
Calmar Ratio                        20.195716
Max. Drawdown [%]                  -40.029028
Avg. Drawdown [%]                  -11.374621
Max. Drawdown Duration       95 days 00:00:00
Avg. Drawdown Duration       16 days 00:00:00
# Trades                                    8
Win Rate [%]                            100.0
Best Trade [%]                     338.398466
Worst Trade [%]                    227.267557
Avg. Trade [%]                     278.671936
Max. Trade Duration         184 days 00:00:00
Avg. Trade Duration         174 days 00:00:00
Profit Factor                             NaN
Expectancy [%]                     280.552125
SQN                                 19.635564
_strategy                 DCA_Conditional_...
_equity_curve                             ...
_trades                        Size  Entry...
dtype: object
```

### Top 10 configurations



### Files

- full: [heatmap.md](heatmap_df.md), [heatmap.xlsx](heatmap_df.xlsx) 
- trades: [trades.md](trades.md) [trades.xlsx](trades.xlsx)
- equity: [equity_curve.md](equity_curve.md) [equity_curve.xlsx](equity_curve.xlsx)