%% 读取数据
clear all
clc
% info = ncinfo('cru_ts4.07.1901.2022.tmp.dat.nc');
land = ncread('HadISST_sst.nc','sst');%读取数据
land = rot90(land);
time = ncread('HadISST_sst.nc','time');%读取时间
time = timeCov(double(time),[1870 1 1]);
lat = flipud(ncread('HadISST_sst.nc','latitude')); %读取经纬度
lon = (ncread('HadISST_sst.nc','longitude'));
% 60-150, 0-50N   
land = land(lat>=-15&lat<=15,lon>=-20&lon<=20,:);%选择经纬度范围
lat = double(lat(lat>=-15&lat<=15));
lon = double(lon(lon>=-20&lon<=20));
[Lon,Lat]=meshgrid(lon,lat);
wgs84km = wgs84Ellipsoid("kilometer");%计算格点面积
areaGrid = arrayfun(@(x) areaquad(x-0.25,0,x+0.25,0.5,wgs84km),lat);
areaGrid = repmat(areaGrid,1,length(lon));

land = land(:,:,time(:,1)>=1950);
th_list = 24:0.5:30;
for ii = 1:length(th_list)  
    a(:,:,ii) = aboveArea(land,areaGrid,th_list(ii));
     writematrix(a(:,:,ii),'大西洋(-20-20).xlsx','sheet',num2str(th_list(ii)));
    %writematrix(zscore(a(:,:,ii)),'data_norm.xlsx','sheet',num2str(th_list(ii)));
end 


