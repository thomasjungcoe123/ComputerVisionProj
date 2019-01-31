function [NewImage,offsets]=real_warp_image(I1c,xx)


maxoffsets=[1000 1000];

ImSize = size(I1c);
h = ImSize(1);
w = ImSize(2);
ImX = [1:ImSize(2)];
ImY = [1:ImSize(1)];
[ImX, ImY] = meshgrid(ImX,ImY);
ImTmp = ones(1,prod(size(ImX)));
ImX = ImX';
ImY = ImY';
ImX = ImX(:)';
ImY = ImY(:)';

rx=xx*[ImX;ImY;ImTmp];
rx=rx./repmat(rx(3,:),[3,1]);

dummy=min(rx');
offsets=ceil(-dummy(1:2));
offsets(offsets<0)=0;
offsets=min([offsets;maxoffsets]);

dummy=max(rx');
dummy=max([dummy(1:2); w h]);
dummy=min([dummy; maxoffsets*2]);

nh=ceil(dummy(2)+offsets(2)); nw=ceil(dummy(1)+offsets(1));

NewImage = zeros(ceil(nh),ceil(nw),3);

[ImX, ImY] = meshgrid((1:nw)-offsets(1),(1:nh)-offsets(2));
ImTmp = ones(1,prod(size(ImX)));
FinalXY = [ImX(:)';ImY(:)';ImTmp];
FinalXY1 = inv(xx)*FinalXY;
FinalXY1 = ceil(FinalXY1 ./repmat(FinalXY1(3,:),[3,1]));
FinalXY(3,:) = [];
FinalXY1(3,:) = [];

% 
% NewImage(:,:,1) = zeros(ceil(nh),ceil(nw));
% NewImage(:,:,2) = NewImage(:,:,1);
% NewImage(:,:,3) = NewImage(:,:,1);
FinalXY(:, FinalXY1(1,:) <=0) = [];
FinalXY1(:, FinalXY1(1,:) <=0) = [];

FinalXY(:, FinalXY1(1,:) >w ) = [];
FinalXY1(:, FinalXY1(1,:) >w ) = [];

FinalXY(:, FinalXY1(2,:) <=0) = [];
FinalXY1(:, FinalXY1(2,:) <=0) = [];

FinalXY(:, FinalXY1(2,:) >h ) = [];
FinalXY1(:, FinalXY1(2,:) >h ) = [];


NewImage((FinalXY(1,:)-1+offsets(1))*nh+FinalXY(2,:)+offsets(2)) = I1c((FinalXY1(1,:)-1)*h+FinalXY1(2,:));
NewImage((FinalXY(1,:)-1+offsets(1))*nh+FinalXY(2,:)+offsets(2)+nw*nh) = I1c((FinalXY1(1,:)-1)*h+FinalXY1(2,:)+w*h);
NewImage((FinalXY(1,:)-1+offsets(1))*nh+FinalXY(2,:)+offsets(2)+nw*nh*2) = I1c((FinalXY1(1,:)-1)*h+FinalXY1(2,:)+w*h*2);
%offsets=[0,0];