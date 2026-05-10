#!/bin/bash
#SBATCH -J run_W1
#SBATCH -p compute
#SBATCH --time=2-00:00:00
##SBATCH -N 4
#SBATCH -n 198
##SBATCH --exclusive

module purge  
module load gcc/11.1.0
module load mpi/openmpi/4.1.6/gcc/ib

mpirun -np 198 ./mitgcmuv
