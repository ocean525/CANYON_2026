#!/bin/bash

#SBATCH
#SBATCH --job-name=python
#SBATCH --partition=compute
#SBATCH --mem=32G
#SBATCH --time=7-00:00:00
#SBATCH --nodes=1
##SBATCH --exclusive

##==== modify ntasks as what you need===

# Load modules
module load python/anaconda/2024.10/3.12.7

#python3 read_energy_bc.py
#python3 read_oneT.py
python3 read_energy_all.py
python3 read_grid.py
#python3 read_KLeps.py
