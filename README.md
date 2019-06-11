# Photogrammetry
This repository holds my my experiments about fundamental tasks in photogrammetry

## Basic Homography Math
This code consists of basic transformations on the homography representations of line and point

## Panorama
![image](./assets/demo.jpg)
In this experiment, I stitched 3 pictures of a subject into a single panorama picture.The experiment includes the following steps
 - 3 input pictures are taken by turning camera around a common projection center so that three images do not have disparity
 - Correspondence analysis is performed by selecting feature points in 3 images in a way that they are both on common planar surface. These feature points will be used to estimate homography transformations from one image to another image. The homography is estimated using SVD.
 - Finally, image one is rectified to the plane of the image 2, and then the rectified image 2-3 is one more time rectified to the plane of the image 3.

## Camera Calibration
![image](./assets/calibration.jpg)

This experiment is about camera calibration using  direct linear transformation (DLT), which estimate the intrinsic and extrinsic camera parameters using correspondences between 3D-2D control points. The experiment include the following stages.
- Correspondence analysis: the 2D control points on image are selected manually using a Matlab tool. The corresponding 3D control points are generated in code based on the pattern that we draw on the calibration object. At least 6 point correspondences are required for the DLT algorithm.
- The projective transformation is then estimated from the correspondence points using SVD decomposition.
- In the final stage, the estimated projection is decomposed using RQ decomposition. The result of RQ decomposition include two matrices: a 3x3 matrix that represents the intrinsic parameters and a 3x4 matrix that represents the extrinsic camera parameters (rotation and translation)
