from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

# === Load data ===
#Ebt   = rdmds('Ebt', np.nan)
Ebc   = rdmds('Ebc', np.nan)
Conv  = rdmds('Conv', np.nan)

uPbc  = rdmds('uPbc', np.nan)
vPbc  = rdmds('vPbc', np.nan)
uEbc  = rdmds('uEbc', np.nan)
vEbc  = rdmds('vEbc', np.nan)

#uPbt  = rdmds('uPbt', np.nan)
#vPbt  = rdmds('vPbt', np.nan)
#uEbt  = rdmds('uEbt', np.nan)
#vEbt  = rdmds('vEbt', np.nan)

# === Save in 5 groups ===
#savemat('energy_density.mat', {'Ebt': Ebt, 'Ebc': Ebc})
savemat('conEbc.mat', { 'Conv': Conv, 'Ebc': Ebc})
#savemat('flux_pbt.mat', {'uPbt': uPbt, 'vPbt': vPbt})
savemat('flux_pbc.mat', {'uPbc': uPbc, 'vPbc': vPbc})
#savemat('flux_ebt.mat', {'uEbt': uEbt, 'vEbt': vEbt})
savemat('flux_ebc.mat', {'uEbc': uEbc, 'vEbc': vEbc})
