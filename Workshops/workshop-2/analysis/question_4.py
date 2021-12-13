import pandas as pd
import yfinance as yf
import matplotlib.pyplot as plt

tickets = list()
profit_amzn_o = list()
profit_eqix_o = list()
profit_amzn_c = list()
profit_eqix_c = list()
if __name__ == "__main__":
    DATAFRAME = pd.read_csv('gross_information.csv')
    DATAFRAME_GRAPH = pd.read_csv('report_information.csv')
    for index, row in DATAFRAME.iterrows():
        if row["SYMBOL"] == 'EQIX':
            profit_eqix_o.append(row["OPEN_STOCK"])
            profit_eqix_c.append(row["CLOSE_STOCK"])
        elif row["SYMBOL"] == 'AMZN':
            profit_amzn_o.append(row["OPEN_STOCK"])
            profit_amzn_c.append(row["CLOSE_STOCK"])

    for index, row in DATAFRAME_GRAPH.iterrows():
        if index < 11:
            tickets.append(row["SYMBOL"])

    profit_open_stock_value_amzn = ((profit_amzn_o[-1] - profit_amzn_o[0]) / profit_amzn_o[-1]) * 100
    profit_open_stock_value_eqix = ((profit_eqix_o[-1] - profit_eqix_o[0]) / profit_eqix_o[-1]) * 100
    profit_close_stock_value_amzn = ((profit_amzn_c[-1] - profit_amzn_c[0]) / profit_amzn_c[-1]) * 100
    profit_close_stock_value_eqix = ((profit_eqix_c[-1] - profit_eqix_c[0]) / profit_eqix_c[-1]) * 100

    print("AMZN (Open price profit): ", profit_open_stock_value_amzn)
    print("EQIX (Open price profit): ", profit_open_stock_value_eqix)
    print("AMZN (Close price profit): ", profit_close_stock_value_amzn)
    print("EQIX (Close price profit): ", profit_close_stock_value_eqix)

    data = yf.download(tickets, start="2014-01-02", end="2017-12-29")['Adj Close']
    # Plot all the close prices
    ((data.pct_change()+1).cumprod()).plot(figsize=(10, 7))

    # Show the legend
    plt.legend()

    # Define the label for the title of the figure
    plt.title("Returns", fontsize=16)

    # Define the labels for x-axis and y-axis
    plt.ylabel('Cumulative Returns', fontsize=14)
    plt.xlabel('Year', fontsize=14)

    # Plot the grid lines
    plt.grid(which="major", color='k', linestyle='-.', linewidth=0.5)
    plt.show()
    

