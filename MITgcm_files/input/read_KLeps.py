from MITgcmutils import rdmds
import numpy as np
from scipy.io import savemat

# === 设置周期号 ===
start_cycle = 12
end_cycle   = 12

# === 基本参数 ===
steps_per_cycle = 2160
interval = 2160  # 输出间隔

# === 自动生成时间步 ===
itrs = range(start_cycle * steps_per_cycle, end_cycle * steps_per_cycle + 1, interval)

# === Load data ===
KLeps   = rdmds('KLeps', itrs)

savemat('KLeps.mat', { 'KLeps':KLeps})
