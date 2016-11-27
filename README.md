# **Image Mosacing using Homography**

## **Introduction**
The code takes as input, two images with some overlapping region. Both the images have been taken from a different viewing
angle. The code goes on to compute the homography matrix than bring one image (moving image) in the plane of the other (fixed
image). Using this transformation, the code then goes on to stitch the two images at the overlapping region to create the
mosiac.

Files included:
1. main.m : Shows an example of how to use the given functions to generate the mosaiced image. Require a file called points.mat
  that includes the co-ordinates of points common to both the images. One such file is included for demo.
2. computeH.m : Takes as input a set of points common to the two images and returns the homogparhy matrix that relates both of 
  them.
3. m_visualizeH.m : Helper function that turns on an interactive session to check whether the computed H is correct or not.
  Takes as input im1, im2 and H. To check the validity of H, clicking on a specific point on im1 should appear at the corres-
  ponding point at im2.
4. warpImage.m : Takes as input Iin, Iref and H, trasforms Iin to the plane of Iref using H and then stitches both of them
  along the overlapping region.

## **Results**

**The two input images**
<img src="https://github.com/pratik18v/Image-Mosaicing/blob/master/points_used.jpg" height="128" width="128"> <img src="https://github.com/pratik18v/Image-Mosaicing/blob/master/points_used.jpg" height="128" width="128">

**Points used**
![Alt text](/points_used.jpg?raw=true "Points used")

**Warped Image**
![Alt text](/sbu1_warped.jpg?raw=true "Iin warped in the plane of Iref")

**Merged Image**
![Alt text](/sbu_merged.jpg?raw=true "Merged Image")
