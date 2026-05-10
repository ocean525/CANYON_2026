https://github.com/ocean525/CANYON_2026/
%% make input files first;


All the input files is provided in the zenodo repository as well.  (https://doi.org/10.5281/zenodo.20100764)



(1) bathy files (eg. Bathy_L30_W10 is the Control case)
(2) initial temperature file for the whole area
(T.init for all cases except T.init_Y300 for Y300, they are too big to upload here, it is in the zenodo.)

(3) grid space files (delXvar, delYvar)
(4) initial temperature 2-d profile (tRef)

Only when you need new topography, you could use Make_input_part1.m and Make_input_part2.m
This means you may need to modify the SIZE.h in code as well, if it have a different grid size.


%% run the model;


Here we assume you already have a basic understanding of how MITgcm works, so we only 
give the "code" and "input" for most cases and code_Y300, input_Y300 for case Y300.

You could download the whole model from https://mitgcm.org/
The manual : https://mitgcm.readthedocs.io/en/latest/
I also write a manual in Chinese: https://ocean525.github.io/


After compiling MITgcm based on my "code", get the executable file.
Enter the Input, then:

run auto_checknan.sh to get .mat result data for each case directly! 

It will get the restart files of cycle 13, without any output (cause we don't need them), under "data_13cycle" and "data.pkg_13cycle".


Then it will run the model again from cycle 13 and output files we need, under "data_900" and "data.pkg_900".
Finally, it will run the python code to get all the result and move them to ../mat/ with their name after case name. (read_energy_all.py)


So before run it, need to rename it, for example:


(1) in auto_checknan.sh:

#SBATCH -J auto_run_W1  (just the name of mission for clear)
and
for f in *.mat; do mv "$f" "${f%.mat}_W1.mat"; done


(2) in data_13cyle and data_900:

 bathyFile='Bathy_L30_W1',-


this is for case W1, when run other cases, change those name as well, for example:

#SBATCH -J auto_run_L23
for f in *.mat; do mv "$f" "${f%.mat}_L23.mat"; done
bathyFile='Bathy_L30_L23',


Other input files such as T.init, delY, delX, tRef are all the same.

For case Y300, it has different SIZE.h in code(in code_Y300), which needs recompile. And it have different input files (in Input_Y300).
Note that T.init for Y300 is named T.init_Y300, but when used in data, you need to rename it!



%% Finally, all the code and result data are in the zenodo repository
They are not the original model output, as they'are too much and too big, but we try to provide
the code to analysis them. For example, read_energy_all.py in the input is used to get .mat files.

Anything that is not clear here, please send an email to Shiqiang.Hu@uea.ac.uk
I'll try to help.


