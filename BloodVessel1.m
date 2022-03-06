function [final] = BloodVessel1(originalImage1)
% RGB to grayscale
%imshow([originalImage1(:,:,1),originalImage1(:,:,2),originalImage1(:,:,3)]);
%close all
%clear all
%originalImage1=imread ('u:\teamblood\DRIVE\test\images\03_test.tif');
% I = originalImage1(:,:,2);
% c=adapthisteq(I);
%figure,imshow(c);
%cn=colornorm(originalImage1);
greyImage1 = rgb2gray(originalImage1);
%figure,imshow(greyImage1);%2
greyImage1 = double(greyImage1);
%figure,imshow(greyImage1);%3
%h=Hu_Moments(greyImage1)
%h=adapthisteq(greyImage1); 
% Use a mask to remove the background
mask1 = find_mask(greyImage1);
figure,imshow(mask1);%4
mask1 = 1-mask1;
%options=struct('FrangiScaleRange', [1 5], 'FrangiScaleRatio', 1, 'FrangiBetaOne', 1,...'FrangiBetaTwo', 7.5, 'verbose',true,'BlackWhite',true);
%[outIm,whatScale,Direction] = FrangiFilter2D(double(dgrayeye1), options);
frangi1=FrangiFilter2D(greyImage1);
%figure,imshow(frangi1);%5
maskedFrangi1 = frangi1.*mask1;
figure,imshow(maskedFrangi1);title('Frangi Filtered Image');
% M=imsubtract(maskedFrangi1,0.25);
% R=imreconstruct(M,maskedFrangi1);
% figure,imshow(R);
%figure; imshow(maskedFrangi1);
% level = multithresh(maskedFrangi1,2);
% thresholded1 = imquantize(maskedFrangi1,level);
newprI = adapthisteq(maskedFrangi1);
thresh = isodata(newprI);
vessels = imbinarize(newprI,thresh);
% adj=imadjust(maskedFrangi1);
% thresholded1 = imbinarize(adj,0.0001);
figure,imshow(vessels);%7
%figure; imshow(i); title('thresh')
% x=bwmorph(i,'spur');
% y=bwmorph(x,'majority');
% z=bwmorph(y,'bridge');
%figure,imshow(y);
x=bwareaopen(vessels,250);%%150
final=bwareafilt(x,25);
% CC = bwconncomp(y, 8);
% S = regionprops(CC, 'Area');
% L = labelmatrix(CC);
% BW2 = ismember(L, find([S.Area] >= 25));
%     %figure; imshow(BW2); title('1st selection >');
% BW3 = ismember(L, find([S.Area] < 25)); 
%      %figure; imshow(BW3); title('1st selection <');
% se4=strel('disk',1);
% po=imdilate(BW2, se4);
%     %figure; imshow(po); title('1st selection > + dilate')
% %bw4 = imerode(po,se4);
% %Iskel = bwmorph(po,'skel',Inf);
% %Iendp = bwmorph(Iskel,'endpoints');
% % Iconn = bwlabel(Iskel,8);
% % Idiff = Iskel - Iendp;
% %Iendplab = Iconn - Idiff; %endpoints like connected components
% %[n m] = size(bw4);
% 
% CC2 = bwconncomp(po, 8);
% S2 = regionprops(CC2, 'Perimeter');
% L2 = labelmatrix(CC2);
% po1 = ismember(L2, find([S2.Perimeter] < 80));
%     %figure; imshow(po1); title('2nd selection <');
% po2 = ismember(L2, find([S2.Perimeter] >= 80));
%     %figure; imshow(po2); title('2nd selection >');
% 
% CC3 = bwconncomp(po1, 8);
% S3 = regionprops(CC3, 'Eccentricity');
% L3 = labelmatrix(CC3);
% %po2 = ismember(L3, find([S3.Area] >=10));
% poCen = ismember(L3, find([S3.Eccentricity] >= 0.95));
%     %figure; imshow(poCen); title('3rd selection Eccentricity')
% final = imadd(po2,poCen);
%     %figure; imshow(final); title('final before dilate')
%      final = imerode(final,se4);
%    %final=bwmorph(final,'bridge');
  final=bwmorph(final,'majority');
  %figure,imshow(final);
end