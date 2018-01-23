#!/bin/bash

# Select GPU
if [ $# -ne 2 ]; then
  echo "Error: set GPU number & config path." 1>&2
  echo "Usage: ./run_ctc_temp.sh gpu_index" 1>&2
  exit 1
fi

# local
# export PATH=$PATH:/usr/local/cuda-8.0/bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64:/usr/local/cuda-8.0/extras/CUPTI/lib64
# PYTHON=/home/lab5/inaguma/.pyenv/versions/anaconda3-4.1.1/bin/python

# CCC
export PATH=$PATH:/opt/share/cuda-8.0/x86_64/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/x86_64/lib64:/usr/local/cuda-8.0/x86_64/extras/CUPTI/lib64:/opt/share/cuDNN-v5.1-8.0/cuda/lib64
PYTHON=/u/jp573469/.pyenv/shims/python

model_path=$1
gpu_index=$2

epoch=-1
beam_width=100
eval_batch_size=20
temperature_inference=4

CUDA_VISIBLE_DEVICES=$gpu_index $PYTHON eval_ctc_temp.py \
  --model_path $model_path \
  --epoch $epoch \
  --beam_width $beam_width \
  --eval_batch_size $eval_batch_size \
  --temperature $temperature_inference
