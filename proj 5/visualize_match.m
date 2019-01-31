function visualize_match(xy1,xy2,I1,I2)

cimg=cat(1,I1,I2);
figure;
imshow(cimg); pause(0.5); hold on;
plot(xy1(1,:),xy1(2,:),'r*');
plot(xy2(1,:),xy2(2,:)+size(I2,1),'r*');
l=line([xy1(1,:);xy2(1,:)],[xy1(2,:);xy2(2,:)+size(I2,1)]);
set(l,'color','r');
