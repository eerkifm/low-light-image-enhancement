clc
clear all
close all
 
X = imread('i01_16_5.bmp');

[N, M, P] = size (X);
ori_R = X(:,:,1);
ori_G = X(:,:,2);
ori_B = X(:,:,3);

R = double(ori_R); 
G = double(ori_G); 
B = double(ori_B); 

tic

vImage=max(max(R,G),B);

out = colorspace('hsi<-rgb', X);

H = out(:,:,1);
S = out(:,:,2);
I = out(:,:,3);

%% Calculate New Intensity

for i = 1:1:N; 
	for j = 1:1:M;
		alpha(i,j) = 1-(vImage(i,j)/255); 
    end 
end 

for i = 1:1:N; 
	for j = 1:1:M;
		if I(i,j) < 0.5;    
			I2(i,j) = I(i,j)*(1+alpha(i,j));
		else    
			I2(i,j) = I(i,j)*(1+(alpha(i,j)/2));
		end 
    end
end 

%% Calculate New Saturation

for i = 1:1:N; 
    for j = 1:1:M; 
        S2(i,j) = (S(i,j)*I(i,j))/I2(i,j);
    end 
end

%HSI
HSI=zeros(size(X));
HSI(:,:,1) = H;
HSI(:,:,2) = S2;
HSI(:,:,3) = I2;

%%
in = colorspace('rgb<-hsi' , HSI);
toc

imwrite(in,'i01_enhanced.bmp');
