python ./sem_seg/inference_deep.py \
    --model=GADH_Net_EA --extra-dims 3 4 \
    --model_path=data/model1/model_394020.ckpt \
    --input_path=data/Inference \
    --output_path=data/Inference/Eval_can_out
