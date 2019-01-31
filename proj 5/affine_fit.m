function xx=affine_fit(xy1,xy2)

xy1=xy1./repmat(xy1(3,:),[3,1]); % make sure inputs are normalized
xy2=xy2./repmat(xy2(3,:),[3,1]); 

i = 1;
A = [xy1(:,i)' 0 0 0 ; 0 0 0 xy1(:,i)' ];
B = [xy2(1:2,i)];
for i = 2:length(xy1(1,:))
    AA = [xy1(:,i)' 0 0 0 ; 0 0 0 xy1(:,i)' ];
    A = [A;AA];
    B = [B;xy2(1:2,i)];
end
xx = [reshape(inv(A'*A)*A'*B,3,2)';0 0 1];