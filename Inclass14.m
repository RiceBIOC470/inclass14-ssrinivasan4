%Inclass 14
%GB comments
1 100 
2: Question asks to generate two separate sets of masks:1) using erosion and 2) using distance transform. Can only give credit for the Distance transform. Additionally, no comments were provided that describes which method was more useful. 
2a 0 
2b 100
overall: 75

%Work with the image stemcells_dapi.tif in this folder

% (1) Make a binary mask by thresholding as best you can
reader14=bfGetReader('stemcells_dapi.tif');
iplane=reader14.getIndex(1-1,1-1,1-1)+1;
reader14_im=bfGetPlane(reader14, iplane); 
reader14_thres=reader14_im > 300;
imshow(reader14_thres, []);

% (2) Try to separate touching objects using watershed. Use two different
% ways to define the basins. (A) With erosion of the mask (B) with a
% distance transform. Which works better in this case?

img14 = bwconncomp(reader14_thres);
stats_14 = regionprops(img14,'Area');
area_14 = [stats_14.Area];

img14_sqrt = round(1.2*sqrt(mean(area_14))/pi);
img14_erode = imerode(reader14_thres,strel('disk',img14_sqrt));
img14_outside = ~imdilate(reader14_thres,strel('disk',1));
img14_basin = imcomplement(bwdist(img14_outside));
img14_basin = imimposemin(img14_basin,img14_erode|img14_outside);
img14_watershed = watershed(img14_basin);
imshow(img14_watershed, []);
