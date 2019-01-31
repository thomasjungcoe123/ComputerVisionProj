%samuel.cheng@ou.edu

function h=myhog_list(I,list,r,nbins)

if length(size(I))~=2
    error('Image should be 2-dim')
end

if ~exist('nbins','var')
    nbins=4;
end

if ~exist('r','var')
    r=4;
end
    
nI=zeros(ceil(size(I)/r)*r);

nI(1:size(I,1),1:size(I,2))=I;
%nI=I; % skip padding

xI=filter2([-1 0 1],nI);
yI=filter2([-1; 0; 1],nI);

[theta,rho]=cart2pol(xI,yI);

theta=mod(theta,2*pi);
binsize=2*pi/nbins;
th=mod(theta+binsize/2,2*pi);
tbin=ceil(th/binsize+1e-10);
%bincenters=2*pi*(0:nbins)/nbins;

%vbin=tbin(:); vrho=rho(:);
rhos=zeros([size(tbin) nbins]);
[I,J]=ndgrid(1:size(tbin,1), 1:size(tbin,2));
K=sub2ind(size(tbin),I(:),J(:));
rhos(sub2ind(size(rhos),I(:),J(:),tbin(K)))=rho(sub2ind(size(rho),I(:),J(:)));


%rhos=zeros(8,8,2); rhos(1:4,1:4,:)=1; rhos(5:8,5:8,:)=2; %debug
[x,y]=ndgrid(-r:r,-r:r);
xi=reshape(kron(list(:,1),ones(numel(x),1)),[size(x),size(list,1)]);
yi=reshape(kron(list(:,2),ones(numel(y),1)),[size(y),size(list,1)]);
xi=xi+repmat(x,[1,1,size(list,1)]);
yi=yi+repmat(y,[1,1,size(list,1)]);
xi=reshape(xi,[numel(x),size(list,1)]);
yi=reshape(yi,[numel(x),size(list,1)]);

hii=reshape(kron(1:nbins,ones(numel(xi),1)),[size(xi),nbins]);
xii=repmat(xi,[1,1,nbins]);
yii=repmat(yi,[1,1,nbins]);

rhoss=rhos(sub2ind(size(rhos),xii,yii,hii));
h=sum(rhoss);
h=reshape(h,[size(list,1),nbins]);

