from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

Ebt   = rdmds('Ebt', np.nan)
uPbt  = rdmds('uPbt', np.nan)
vPbt  = rdmds('vPbt', np.nan)
uEbt  = rdmds('uEbt', np.nan)
vEbt  = rdmds('vEbt',np.nan)
Ebc   = rdmds('Ebc', np.nan)
uPbc  = rdmds('uPbc', np.nan)
vPbc  = rdmds('vPbc', np.nan)
uEbc  = rdmds('uEbc', np.nan)
vEbc  = rdmds('vEbc', np.nan)
Conv  = rdmds('Conv', np.nan)

savemat('energy_vars.mat', {
    'Ebt': Ebt,
    'uPbt': uPbt,
    'vPbt': vPbt,
    'uEbt': uEbt,
    'vEbt': vEbt,
    'Ebc': Ebc,
    'uPbc': uPbc,
    'vPbc': vPbc,
    'uEbc': uEbc,
    'vEbc': vEbc,
    'Conv': Conv,
})
