python ./sem_seg/train_multi_gpu_deep.py \
    	--data_dir=./data/block_pickle \
    	--log_dir=./data/model1 \
    	--model=GADH_Net_EA \
	--extra-dims 3 4 \
	--gpu_num=2
