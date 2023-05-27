function feature_swt2=extraction_swt2(I)
    layer=2;
    [ca,chd,cvd,cdd] = swt2(I,layer,'db3');
    chdall=[chd(:,:,1,1:layer),chd(:,:,2,1:layer),chd(:,:,3,1:layer)];
    cvdall=[cvd(:,:,1,1:layer),chd(:,:,2,1:layer),chd(:,:,3,1:layer)];
    cddall=[cdd(:,:,1,1:layer),cdd(:,:,2,1:layer),cdd(:,:,3,1:layer)];
    swt2all=[chdall,cvdall,cddall];
    feature_swt2=reshape(swt2all,[128*128,9*layer]);

return