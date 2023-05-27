function feature_swt2=extraction_swt2(I)
    [ca,chd,cvd,cdd] = swt2(I,4,'db3');
    chdall=[chd(:,:,1,1),chd(:,:,2,1),chd(:,:,3,1),chd(:,:,1,2),chd(:,:,2,2),chd(:,:,3,2)];
    cvdall=[cvd(:,:,1,1),chd(:,:,2,1),chd(:,:,3,1),cvd(:,:,1,2),cvd(:,:,2,2),cvd(:,:,3,2)];
    cddall=[cdd(:,:,1,1),cdd(:,:,2,1),cdd(:,:,3,1),cdd(:,:,1,2),cdd(:,:,2,2),cdd(:,:,3,2)];
    swt2all=[chdall,cvdall,cddall];
    feature_swt2=reshape(swt2all,[128*128,18]);

return