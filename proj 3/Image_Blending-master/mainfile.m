clear all
close all
clc

%% Read the images
A=imread('1.jpg');
B=imread('4.jpg');
% rotate the second image since it's printing upside-down
C=imrotate(B , 180);
% setting height and width
height=size(A,1);
width=size(A,2);

%% Convert images to grayscale
firstImg=rgb2gray(A);
secondImg=rgb2gray(C);

%% Create mask
partitionedImg=floor(width/2);
maskedImg=ones(height,width);
maskedImg(:,1:partitionedImg)=0*maskedImg(:,1:partitionedImg);

%% Create gaussian pyramids for both the images and the mask
levels=floor(log2(min([width, height])));
sigma=2;
hsize=3*sigma+1;
sigmaMask=10;
hsizeMask=3*sigmaMask+1;
% using gausian pyramid
firstImg_Gauss_Pyr=Gaus_Pyr(firstImg,levels,sigma,hsize);
second_Gauss_Pyr=Gaus_Pyr(secondImg,levels,sigma,hsize);
masked_gauss_Pyr=Gaus_Pyr(maskedImg,levels,sigmaMask,hsizeMask);

%% Create Laplacian pyramids from both the images 
firstImgLaplacePyr=Lap_Pyr(firstImg_Gauss_Pyr);
secondImgLaplacePyr=Lap_Pyr(second_Gauss_Pyr);

%% Blend laplacian pyramid
blendedPyr=blend_Pyr(firstImgLaplacePyr,secondImgLaplacePyr,masked_gauss_Pyr);

%% Reconstruct image from blended pyramid
blendedImg=collapse_Pyr(blendedPyr);
imshow(blendedImg);
imgClubbed=[firstImg(:,1:partitionedImg), secondImg(:,partitionedImg+1:end)];
figure, imshow(imgClubbed);
