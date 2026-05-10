from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

# === Load data ===
Ebt   = rdmds('Ebt', range(28860,31741,60))
Ebc   = rdmds('Ebc', range(28860,31741,60))
Conv  = rdmds('Conv', range(28860,31741,60))
KLeps = rdmds('KLeps', np.nan)
#Div   = rdmds('Div', range(28860,31741,60))

uPbt  = rdmds('uPbt', range(28860,31741,60))
vPbt  = rdmds('vPbt', range(28860,31741,60))

uPbc  = rdmds('uPbc', range(28860,31741,60))
vPbc  = rdmds('vPbc', range(28860,31741,60))

uEbt  = rdmds('uEbt', range(28860,31741,60))
vEbt  = rdmds('vEbt', range(28860,31741,60))

uEbc  = rdmds('uEbc', range(28860,31741,60))
vEbc  = rdmds('vEbc', range(28860,31741,60))

# === Save in 5 groups ===
savemat('Energy_BT_BC.mat', {'Ebt': Ebt, 'Ebc': Ebc})
savemat('ConKLeps.mat', { 'Conv': Conv,'KLeps':KLeps})
savemat('Flux_Pbt.mat', {'uPbt': uPbt, 'vPbt': vPbt})
savemat('Flux_Pbc.mat', {'uPbc': uPbc, 'vPbc': vPbc})
savemat('Flux_Ebt.mat', {'uEbt': uEbt, 'vEbt': vEbt})
savemat('Flux_Ebc.mat', {'uEbc': uEbc, 'vEbc': vEbc})
