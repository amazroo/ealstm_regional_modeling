# The env is a pain to set up, dont use the conda requirements_gpu.yaml
# see here: https://github.com/kratzert/ealstm_regional_modeling/issues/1
# But I had to specifically use numba 0.53 and numpy 1.20
# when numba 0.55 is available, more recent versions of numpy should work.
# /glade/work/jamesmcc/conda-envs/ealstmc

# The data loader workers are apparently cpus
qsub -I -X  -q casper@casper-pbs -A NRAL0017 -l walltime=24:00:00 -l select=1:ncpus=36:ngpus=1:mem=220G

module load conda
conda activate /glade/work/mazrooei/miniconda3/envs/ealstm
python main.py train --camels_root data/ --cache_data=True --num_workers=36
# This will create a run dir like: runs/run_1402_1035_seed339400

# Evaluate model
python main.py evaluate --camels_root data/ --run_dir runs/run_2903_2008_seed588170/
