clear all;
clear all;
clc;

I = imread("Image.jpg");
img = rgb2gray(I);

eq_img = histeq(img);

% Display Output Images of Histogram Equalization
figure(1);
subplot(221),imshow(img), title("Digital  Image");
subplot(222), imshow(eq_img), title("Equalized Image");
subplot(223),imhist(img), title("Image Histogram");
subplot(224),imhist(eq_img), title("Equalized Histogram");



%%%%  Histogram Modeling

resize_Img = imresize(img, 0.20); 
K = resize_Img;

[M N]=size(K);
K = double(K);

Z = sqrt(K);
Zmax = max(Z(:));
Zmin = min(Z(:));

for i= 1:M
    for j = 1:N
        Y(i,j)= 255*(Z(i,j)-Zmin/(Zmax-Zmin));
    end
end


% Display Output Images of Histogram Modeling
figure(2);
subplot(121), imshow(resize_Img), title("Resized Image");
subplot(122), imshow(Y, []), title("Modeling Image");


%%%%% Histogram Specification/Mapping

Img = img; %Original image

r = imread('Ref_Image.jpeg');
Ref = rgb2gray(r);

M = zeros(256,1,'uint8');              
cdf1 = cumsum(imhist(Img))/numel(Img);  % cdf of original image
cdf2 = cumsum(imhist(Ref))/numel(Ref);  % cdf of reference image

for r=1:256
    [~,s] = min(abs(cdf1(r)-cdf2));
    M(r) = s-1;   
end

out = M(double(Img)+1);

% Display Output Images of Histogram Specification/Mapping
figure(3);
subplot(231),imshow(Img),title('Original Image');
subplot(232),imshow(Ref),title('Reference Image');
subplot(233),imshow(out),title('Final Image');

subplot(234),imhist(Img),title('Histogram :Original Image');
subplot(235),imhist(Ref),title('Histogram :Reference Image');
subplot(236),imhist(out),title('Histogram :Final Image');

