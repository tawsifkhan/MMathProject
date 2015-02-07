# MMathProject
This repository contains the MATLAB functions for a software I developed for my MMath Thesis at University of Waterloo.

The software can be used to compute the optimal sensor location for a Kalman Filter used to estimate a wave dispersive equation. 

Using the FEM Files:

The FEM files can be used to numerically solve any equation you want. You will have to change the final discrete equation. The mass and stiffness matrices are constructed independently. And also the reconstruction and project of functions are indepent. The only changes need to be made in order to solve a different equation is in the femShallow___.m files. 

Using the State Estimation Files:

myKalman.m is the most important file for the state estimation. The optimal sensor location need to be calculated beforehand.
