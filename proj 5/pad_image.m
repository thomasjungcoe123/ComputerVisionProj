function Io=pad_image(I,pad)

nsize=size(I);
nsize(1:2)=nsize(1:2)+2*[pad pad];

Io=uint8(zeros(nsize));

if numel(size(I))==3
    Io(pad+1:end-pad,pad+1:end-pad,:)=I;
elseif numel(size(I))==2
    Io(pad+1:end-pad,pad+1:end-pad)=I;
else
    error('Dimension of I is invalid. Either 2d or 3d.');
end
