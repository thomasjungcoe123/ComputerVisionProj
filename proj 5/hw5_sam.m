% run this script

imnames={'i1.jpg','i2.jpg'};

% resize image to reduce complexity
% pad image to avoid boundary problem
I1=preprocess_image(imread(imnames{1}));
I2=preprocess_image(imread(imnames{2}));


%% Todo
% find match coordinates from I1 to I2
% You should comment the following line and create xy1 and xy2 leveraging
% the HOG features created in HW4
% xy1 contains list of positions in I1 that match with positions in I2
% (stored in xy2)
% xy1 and xy2 are homogenous coordinate, each column is one point
% first coordinate of a point is the horizontal coordinate of the image
% second coordinate of the point is the vertical coordinate

load hw5.mat % you should comment this line, this load my pre-matched pair list and transform
% check out xy1,xy2 and xx_sam
%% Don't need to change here
% visualize your points
visualize_match(xy1,xy2,I1,I2);

xx=affine_fit(xy1,xy2); % note that xy1 and xy2 are in homogenous coordinates, each column is one point
% check out the predefined example in hw5.mat

[wholeImg,NewImage,offsets]=draw_align_image(xx,I1,I2);
pause(0.5); % workaround for matlab bug with imshow and hold
hold on;
show_points_on_drawn_image(offsets,xx,xy1,xy2); % this line is for debugging, you can comment it if you want
title('Affine transform without ransac');
xlabel('Red cross are points in the second image; blue circle are transformed points on the first image');

%% extra credit, try to implement ransac to get a better fitting (50%)

%% extra credit, try to implement projective transform fitting to get nicer transform (50%)

%% If you implement both extra credit, your transform should be pretty nice as below

xx=xx_sam
[wholeImg,NewImage,offsets]=draw_align_image(xx,I1,I2);
pause(0.5);
hold on;
show_points_on_drawn_image(offsets,xx,xy1,xy2); % this line is for debugging, you can comment it if you want
title('Projective transform fitting + ransac');
xlabel('Red cross are points in the second image; blue circle are transformed points on the first image');
