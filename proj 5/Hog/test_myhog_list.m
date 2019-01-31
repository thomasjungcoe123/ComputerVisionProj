oimg=imread('gantrycrane.png');
oimg=rgb2gray(oimg);
imgheight=128;
img=imresize(oimg,[imgheight,imgheight/size(oimg,1)*size(oimg,2)]);
[x,y]=ndgrid(10:10:100,10:10:100); % locations to compute HOGs
list=[x(:) y(:)];
tic; h=myhog_list(img,list,4,16); toc; % compute hog at the locations in the list
visualize_hog_list(h,list,img);
