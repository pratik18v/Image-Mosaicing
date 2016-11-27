clc; clear all; close all;

im1 = imread('sbu1.jpg');
im2 = imread('sbu2.jpg');

%Save common points between the given two images as points.mat
%cpselect(im1,im2)

%Already saved points for demo, comment this line when selecting your own
%points using cpselect command above
load('points.mat');


figure(1)
imshow('points_used.jpg');

H = computeH(points1,points2);

[Iwarp,Imerge] = warpImage(im1,im2, H);

figure(2)
imshow(Iwarp);
figure(3)
imshow(Imerge);