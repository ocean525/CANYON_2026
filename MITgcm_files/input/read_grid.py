from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

XC = rdmds('XC')
YC = rdmds('YC')
XG = rdmds('XG')
YG = rdmds('YG')
RC = rdmds('RC')
RF = rdmds('RF')
Depth = rdmds('Depth')
DXG=rdmds('DXG')
DYG=rdmds('DYG')
DXC=rdmds('DXC')
DYC=rdmds('DYC')
RAC=rdmds('RAC')
#hFacC=rdmds('hFacC')


savemat('grid.mat', {
    'XC': XC,
    'YC': YC,
    'XG': XG,
    'YG': YG,
    'RC': RC,
    'RF': RF,
    'Depth': Depth,
    'DXG':DXG,
    'DYG':DYG,
    'DXC':DXC,
    'DYC':DYC,
    'RAC':RAC,
#    'hFacC':hFacC,
})
