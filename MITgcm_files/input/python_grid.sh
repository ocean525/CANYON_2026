#!/bin/bash

#SBATCH
#SBATCH --job-name=python
#SBATCH --partition=xahcnormal
#SBATCH --time=7-00:00:00
#SBATCH --nodes=1
#SBATCH --exclusive

##==== modify ntasks as what you need===

# Load modules
module load compiler/intel/2021.3.0
module load python/3.8.10

python3 read_grid.py
