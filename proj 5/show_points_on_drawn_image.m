function show_points_on_drawn_image(offsets,xx,xy1,xy2)

    nxy1=xx*xy1; nxy1=nxy1./repmat(nxy1(3,:),[3,1]);

    nxy1=nxy1+repmat([offsets';0],[1,size(nxy1,2)]);
    nxy2=xy2+repmat([offsets';0],[1,size(xy2,2)]);

    plot(nxy1(1,:),nxy1(2,:),'bo');
    plot(nxy2(1,:),nxy2(2,:),'rx');
