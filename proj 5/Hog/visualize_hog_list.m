% samuel.cheng@ou.edu

function hog=visualize_hog_list(hog,list,I,scaling_factor)

if ~exist('hog','var')
    error('Format: visualize_hog(hog). hog should be 3 dimensional data')
end
if length(size(hog))~=2
    error('Expect input to be two dimensional');
end

if size(hog,3)>20
    error('The third dimension have length > 20. It appears that there are too many bins for orientation of gradients.')
end

if ~exist('scaling_factor','var')
    scaling_factor=0.002;
end

%w=1;
figure; 
if exist('I','var')
    imshow(I);
%    w=size(I,1)/size(hog,1);
end
%     % normalize input
%     %hog=hog./repmat(sum(hog,3),[1,1,size(hog,3)]);
    
%[x,y]=meshgrid(w*((1:size(hog,1))-0.5),w*((1:size(hog,2))-0.5));
x=list(:,1);
y=list(:,2);
for angleid=1:size(hog,2)
    angle=(angleid-1)*2*pi/size(hog,2);
    nx=x+hog(:,angleid)*scaling_factor*sin(angle);
    ny=y+hog(:,angleid)*scaling_factor*cos(angle);
    h=line([y(:)';ny(:)'],[x(:)';nx(:)']);
    set(h,'color',[0 0 0]);
end

if exist('I','var')
    truesize(gcf,[512 512/size(I,1)*size(I,2)]);
end