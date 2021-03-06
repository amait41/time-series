import numpy as np
from scipy.stats import norm
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import seaborn as sns
from seaborn.utils import ci; sns.set()
from statsmodels.graphics.gofplots import qqplot
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

def checkup_res(res):  
      
    res = res.dropna()
    
    fig = plt.figure(figsize=(15, 8))
    gs = gridspec.GridSpec(3, 3)
    ax1 = fig.add_subplot(gs[0, :])
    ax2 = fig.add_subplot(gs[1, 0])
    ax3 = fig.add_subplot(gs[1, 1])
    ax4 = fig.add_subplot(gs[1, 2])
    ax5 = fig.add_subplot(gs[2, 0])
    ax6 = fig.add_subplot(gs[2, 1])
    ax7 = fig.add_subplot(gs[2, 2])

    # Residuals' plot
    sns.lineplot(data=res, ax=ax1).set(xlabel="", ylabel="", title='')
    # ACF
    plot_acf(res, ax=ax2)
    # PACF
    plot_pacf(res, ax=ax3)
    # Lag
    sns.scatterplot(x=res.values[:-1], y=res.values[1:], ax=ax4).set(xlabel=r'$\epsilon_{t-1}$', ylabel=r'$\epsilon_t$', title='Lag 1')
    # Histogramme
    sns.histplot(res / res.std(), stat="density", ax=ax5).set(title='Standardized residuals histplot', xlabel="")
    x = np.linspace(norm.ppf(0.01),norm.ppf(0.99), 100)
    ax5.plot(x, norm.pdf(x),'r--', label='N(0,1)')
    # QQ plot
    qqplot(res / res.std(), line='45', ax=ax6)
    ax6.title.set_text('QQ Plot')
    # Série normalisée
    res_norm = (res.values - res.mean()) / res.std()
    sns.lineplot(data=res_norm, ax=ax7).set(title="Normalised residuals", xlabel='Time')
    sns.lineplot(x=range(len(res_norm)), y=1.96, color="r", linestyle='--', ax=ax7)
    sns.lineplot(x=range(len(res_norm)), y=-1.96, color="r", linestyle='--', ax=ax7)

    plt.suptitle("Residuals' checkup")
    plt.tight_layout()
    plt.show()
