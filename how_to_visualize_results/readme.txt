All the data and figure are provided in the zenodo repository. Here we try to explain how to analysis them.


Take Control as an example:

(1) model output Ebt.***.data and uEbc.***.data … , all the process from temperature and pressure to energy terms are completed in model diagnostic codes.(energy_diagnostics_fill.F)

Then we use read_energy_all.py to get .mat files:
Energy_density_W10.mat, Flux_ebc_W10.mat … (in the zenodo repository, only W10 data at this level) 


(2) based on these data, we can get its time tendency, divergence, conversion, dissipation terms in the canyon and in the box:
get_results_of_length.m, Energy_process_length.m. (in "other_codes")  Then we can get all the results we need, listed in L.xlsx, W.xlsx, S.xlsx.  we can plot figures and calculate percentages.


(3) for each figure, we offer their code and data as well.
