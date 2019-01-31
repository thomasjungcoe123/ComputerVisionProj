function I1=preprocess_image(I1,pad)

if ~exist('pad','var')
    pad=15;
end

    I1=imresize(I1,[512,512/size(I1,1)*size(I1,2)]);
    I1=pad_image(I1,pad);
