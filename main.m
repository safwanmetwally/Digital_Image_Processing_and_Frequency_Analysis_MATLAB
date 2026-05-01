% 2D FFT --low and high frequency filter
clc;
close all;
clear;
%********
img = imread('kid.png');
img =rgb2gray(img);
figure, imshow(img)
ft2 =fft2(img);
ft = fftshift(ft2);       % shift low frequency into the centre
Fmag = log(1+abs(ft2));
fftshiftmag=fftshift(Fmag);
figure('Name','Magnitude Fourier'); imshow(Fmag, []);
figure('Name','Fourier frequency shift'); imshow(fftshiftmag, []);
%******
[row,col]=size(ft);
radius=40;
 rm=row/2;
    clm=col/2;
    [x,y] = meshgrid(-rm:rm-1,-clm:clm-1);
    z = sqrt(x.^2+y.^2);  % the distance between all points and the center of grid
    cL = z < radius ;   % Low filter putting cL =1 in the inner circle and zero otherwise
       cH = ~cL;    %  High filter cH=1 outside the circle and 0 inside it.
  %*****
l_ft = ft .* cL;
h_ft = ft .* cH;
%**********
low_filtered_image = ifft2(ifftshift(l_ft));
high_filtered_image = ifft2(ifftshift(h_ft));
low_f = uint8((low_filtered_image));
high_f = uint8((high_filtered_image));
figure, imshow(low_f)
subplot(2, 2, 1); imshow(cL, []); title('Low-frequency filter'); axis on;
subplot(2, 2, 2); imshow(cH, []); title('High-frequency filter'); axis on;
subplot(2, 2, 3); imshow(low_f , []); title('Low-frequency-image'); axis on;
subplot(2, 2, 4); imshow(high_f, []); title('High-frequency-image'); axis on;