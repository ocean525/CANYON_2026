#!/bin/bash
#SBATCH -J auto_run_W1
#SBATCH -p compute
#SBATCH --time=2-00:00:00
##SBATCH -N 4
#SBATCH -n 1
##SBATCH --exclusive

# Configure no-diagnostic run: from the beginning to the end of 12 cycles
cp data_13cycle data
cp data.pkg_13cycle data.pkg

# Submit the first MITgcm job
jobid=$(sbatch exp.slurm | awk '{print $4}')

# Monitor job status and check for NaN in STDOUT.0000
while squeue -j "$jobid" > /dev/null 2>&1 && squeue -j "$jobid" | grep -q "$jobid"; do
  echo "$(date): Job $jobid still running..."
  # Count occurrences of "NaN" (ignore errors if file not yet created)
  nan_count=$(grep -E -i -c '\bNaN\b' STDOUT.0000 2>/dev/null || echo 0)
  nan_count=${nan_count:-0}
  if [ "$nan_count" -gt 10 ]; then
    echo "$(date): Detected $nan_count NaNs! Cancelling all jobs of $USER..."
    scancel -u "$USER"
    exit 1
  fi
  sleep 900  # Check every 30 minutes
done

echo "$(date): Job $jobid finished."

# Configure diagnostic run: from 12 to 13 cycles (output every 900s)
cp data_900 data
cp data.pkg_900 data.pkg

# Submit the second MITgcm job
jobid=$(sbatch exp.slurm | awk '{print $4}')

# Monitor job status and check for NaN in STDOUT.0000
while squeue -j "$jobid" > /dev/null 2>&1 && squeue -j "$jobid" | grep -q "$jobid"; do
  echo "$(date): Job $jobid still running..."
  nan_count=$(grep -E -i -c '\bNaN\b' STDOUT.0000 2>/dev/null || echo 0)
  nan_count=${nan_count:-0}
  if [ "$nan_count" -gt 10 ]; then
    echo "$(date): Detected $nan_count NaNs! Cancelling all jobs of $USER..."
    scancel -u "$USER"
    exit 1
  fi
  sleep 900  # Check every 15 minutes
done
#
echo "$(date): Job $jobid finished."

# After 12 13 cycles, run the Python post-processing script (no NaN check)
jobid=$(sbatch python.sh | awk '{print $4}')

# Monitor only job completion (no NaN detection)
while squeue -j "$jobid" > /dev/null 2>&1 && squeue -j "$jobid" | grep -q "$jobid"; do
  echo "$(date): Python job $jobid still running..."
  sleep 180  # Check every 3 minutes
done

echo "$(date): Python job $jobid finished."

# rename and move
for f in *.mat; do mv "$f" "${f%.mat}_W1.mat"; done
mv *.mat ../mat

