from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

# === Load data ===
#Ebt   = rdmds('Ebt', range(43200,46081,60))
Ebc   = rdmds('Ebc', range(43200,46081,60))
Conv  = rdmds('Conv', range(43200,46081,60))
#KLeps = rdmds('KLeps', np.nan)
#Div   = rdmds('Div', range(43200,46081,60))

#uPbt  = rdmds('uPbt', range(43200,46081,60))
#vPbt  = rdmds('vPbt', range(43200,46081,60))

uPbc  = rdmds('uPbc', range(43200,46081,60))
vPbc  = rdmds('vPbc', range(43200,46081,60))

#uEbt  = rdmds('uEbt', range(43200,46081,60))
#vEbt  = rdmds('vEbt', range(43200,46081,60))

uEbc  = rdmds('uEbc', range(43200,46081,60))
vEbc  = rdmds('vEbc', range(43200,46081,60))

# === Save in 5 groups ===
#savemat('Energy_BT_BC.mat', {'Ebt': Ebt, 'Ebc': Ebc})
#savemat('ConKLeps.mat', { 'Conv': Conv,'KLeps':KLeps})
#savemat('Flux_Pbt.mat', {'uPbt': uPbt, 'vPbt': vPbt})
savemat('ConEbc.mat', { 'Conv': Conv,'Ebc':Ebc})
savemat('Flux_Pbc.mat', {'uPbc': uPbc, 'vPbc': vPbc})
#savemat('Flux_Ebt.mat', {'uEbt': uEbt, 'vEbt': vEbt})
savemat('Flux_Ebc.mat', {'uEbc': uEbc, 'vEbc': vEbc})
