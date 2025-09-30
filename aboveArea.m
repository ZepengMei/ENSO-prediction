function a = aboveArea(land,areaGrid,th)

a = [];
n_month = size(land,3);
for k = 1:12    
    kc = 1;    
    for ii = k:12:n_month
        temp = land(:,:,ii);
        a(kc,k) = sum(areaGrid(temp>=th));
        kc = kc+1;
    end
end