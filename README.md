## GADH_Net_EA: *A Geometry-Attentional Network for ALS Point Cloud Classification*
![GA-Conv](https://github.com/WuzhaoLee/GADH_Net_EA/blob/master/doc/GA-Conv.png)
## Introduction
Airborne Laser Scanning (ALS) point cloud classification is a critical task in remote sensing and
photogrammetry communities. In particular, the characteristics of ALS point clouds are distinctive
in three aspects, (1) numerous geometric instances (e.g. tracts of roofs); (2) drastic scale variations
between different categories (e.g. car v.s. roof); (3) discrepancy distribution along the elevation,
which should be specifically focused on for ALS point cloud classification. In this paper, we propose
a geometry-attentional network consisting of geometry-aware convolution, dense hierarchical architecture
and elevation-attention module to embed the three characteristics effectively, which can be
trained in an end-to-end manner. Evaluated on the ISPRS Vaihingen 3D Semantic Labeling benchmark,
our method achieves the state-of-the-art performance in terms of average F1 score and overall
accuracy (OA). Additionally, without retraining, our model trained on the above Vaihingen 3D dataset
can also achieve a better result on the dataset of 2019 IEEE GRSS Data Fusion Contest 3D point cloud
classification challenge (DFC 3D) than the baseline (i.e. PointSIFT), which verifies the stronger generalization
ability of our model.
In this repository, we release code and data for training and inferencing our geometry-attentional network.
## Installation
CUDA9.X, CUDNN and anaconda should be installed in advance.
### install tensorflow 1.12.0
``` 
$ conda install tensorflow-gpu=1.12.0
```
### Install pdal as a conda environment ([https://anaconda.org/conda-forge/pdal](https://anaconda.org/conda-forge/pdal))
```
$ conda install -c conda-forge/label/cf202003 pdal=1.7
```
### Install laspy
```
$ pip install laspy==1.7
```
### Compile and install pointnet2 & PointSIFT tensorflow utilities
```
$ cd /path/to/GADH_Net_EA/tf_ops/3d_interpolation
@ sh ./tf_interpolate_compile_py3.sh
$ cd /path/to/GADH_Net_EA/tf_ops/grouping
$ sh ./tf_grouping_compile_py3.sh
$ cd /path/to/GADH_Net_EA/tf_ops/sampling
$ sh ./tf_sampling_compile_py3.sh
$ cd /path/to/GADH_Net_EA/tf_ops/pointSIFT_op
$ sh ./tf_pointSIFT_compile_py3.sh
```
## Create ISPRS dataset
You can download our processed data：block.pickle, or run the following to generate these data.
```
$ sh ./create_dataset.sh
```
## Training the model
To train our geometry-attentional network with deep supervision, run:
```
$ sh ./train.sh
```
## Running Inference
To classify point clouds, first run the following to generate intermediate classification results ```Eval_can_out/Eval_can.txt```, and then use knnVote.m to perform Knn voting to get point-wise semantic labels of the original point cloud ```myout1/EVAL_CLS.txt```:
```
$ sh ./inference.sh
```
## Evaluate and generate the confusion matrix
run the following:
```
###### need to change
docker run -it --rm \
    -v /path/to/GADH_Net_EA/data/Inference:/data \
    -v /path/to/GADH_Net_EA/sem_seg:/metrics \
    ga_net -c \
   "python /metrics/evaluate.py -g /data/gt_test -d /data/myout1 | tee /data/myout1/metrics_myout1.txt"
```

## Citation
If you find our work useful in your research, please consider citing:
```
@article{li2020geometry,
  title={A geometry-attentional network for ALS point cloud classification},
  author={Li, Wuzhao and Wang, Fu-Dong and Xia, Gui-Song},
  journal={ISPRS Journal of Photogrammetry and Remote Sensing},
  volume={164},
  pages={26--40},
  year={2020},
  publisher={Elsevier}
}
```
