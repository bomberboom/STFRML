function feature_swt2=extraction_swt2_1_OATH(I)
    layer=1;
    [ca,chd,cvd,cdd] = swt2(I,layer,'db3');
    swt2all=[chd,cvd,cdd];
    feature_swt2=reshape(swt2all,[256*256,layer*3]);

return