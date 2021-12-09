%Code segment for automatic face detection and face cropping 
clc; 
img = imread('try.png'); 
figure(1);
imshow(img); 
FaceDetect = vision.CascadeObjectDetector; %already trained cascade object detector
FaceDetect.MergeThreshold = 7 ;
BB = step(FaceDetect, img); 
figure(2);
imshow(img); 
for i = 1 : size(BB,1)     
  rectangle('Position', BB(i,:), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'r'); 
end 
for i = 1 : size(BB, 1) 
  J = imcrop(img, BB(i, :)); 
  figure(3);
  subplot(1, 1, i);
  imshow(J); 
end
%code for face cropping ends
J=rgb2gray(J);% To convert identified and cropped face from rgb to greyscale
%code segment for converting a grayscale face to an lbp image
clc;
grayImage = J;
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, [])
% Enlarge figure to full screen.96
set(gcf,'name','Image Analysis Demo','numbertitle','off')
 
% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(grayImage);
subplot(2, 2, 2);
bar(pixelCount, 'BarWidth', 1, 'EdgeColor', 'none');
grid on;
xlim([0 grayLevels(end)]); % Scale x axis manually.
 
% Preallocate/instantiate array for the local binary pattern.
localBinaryPatternImage1 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage2 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage3 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage4 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage5 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage6 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage7 = zeros(size(grayImage), 'uint8');
localBinaryPatternImage8 = zeros(size(grayImage), 'uint8');
tic;
for row = 2 : rows - 1
    for col = 2 : columns - 1
        centerPixel = grayImage(row, col);
        pixel7=grayImage(row-1, col-1) > centerPixel;
        pixel6=grayImage(row-1, col) > centerPixel;
        pixel5=grayImage(row-1, col+1) > centerPixel;
        pixel4=grayImage(row, col+1) > centerPixel;
        pixel3=grayImage(row+1, col+1) > centerPixel;
        pixel2=grayImage(row+1, col) > centerPixel;
        pixel1=grayImage(row+1, col-1) > centerPixel;
        pixel0=grayImage(row, col-1) > centerPixel;
        
        % Create LBP image with the starting, LSB pixel in the upper left.
        eightBitNumber = uint8(...
            pixel7 * 2^7 + pixel6 * 2^6 + ...
            pixel5 * 2^5 + pixel4 * 2^4 + ...
            pixel3 * 2^3 + pixel2 * 2^2 + ...
            pixel1 * 2 + pixel0);
        
        localBinaryPatternImage1(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the upper middle.
        eightBitNumber = uint8(...
            pixel6 * 2^7 + pixel5 * 2^6 + ...
            pixel5 * 2^4 + pixel3 * 2^4 + ...
            pixel3 * 2^2 + pixel1 * 2^2 + ...
            pixel0 * 2 + pixel7);
        localBinaryPatternImage2(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the upper right.
        eightBitNumber = uint8(...
            pixel5 * 2^7 + pixel4 * 2^6 + ...
            pixel3 * 2^5 + pixel2 * 2^4 + ...
            pixel1 * 2^3 + pixel0 * 2^2 + ...
            pixel7 * 2 + pixel6);
        localBinaryPatternImage3(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the center right.
        eightBitNumber = uint8(...
            pixel4 * 2^7 + pixel3 * 2^6 + ...
            pixel2 * 2^5 + pixel1 * 2^4 + ...
            pixel0 * 2^3 + pixel7 * 2^2 + ...
            pixel6 * 2 + pixel5);
        localBinaryPatternImage4(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower right.
        eightBitNumber = uint8(...
            pixel3 * 2^7 + pixel2 * 2^6 + ...
            pixel1 * 2^5 + pixel0 * 2^4 + ...
            pixel7 * 2^3 + pixel6 * 2^2 + ...
            pixel5 * 2 + pixel0);
      
        localBinaryPatternImage5(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower center.
        eightBitNumber = uint8(...
            pixel2 * 2^7 + pixel1 * 2^6 + ...
            pixel0 * 2^5 + pixel7 * 2^4 + ...
            pixel6 * 2^3 + pixel5 * 2^2 + ...
            pixel4 * 2 + pixel3);
        localBinaryPatternImage6(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the lower left.
        eightBitNumber = uint8(...
            pixel1 * 2^7 + pixel0 * 2^6 + ...
            pixel7 * 2^5 + pixel6 * 2^4 + ...
            pixel5 * 2^3 + pixel4 * 2^2 + ...
            pixel3 * 2 + pixel2);
        localBinaryPatternImage7(row, col) = eightBitNumber;
        
        % Create LBP image with the starting, LSB pixel in the center left.
        eightBitNumber = uint8(...
            pixel0 * 2^7 + pixel7 * 2^6 + ...
            pixel6 * 2^5 + pixel5 * 2^4 + ...
            pixel4 * 2^3 + pixel3 * 2^2 + ...
            pixel2 * 2 + pixel1);
        localBinaryPatternImage8(row, col) = eightBitNumber;
        
    end
end
toc;
% Outer layer of pixels will be zero because they didn't have 8 neighbors.
% So, to avoid a huge spike in the histogram at zero, replace the outer layer of pixels with the next closest layer.
localBinaryPatternImage1(1, :) = localBinaryPatternImage1(2, :);
localBinaryPatternImage1(end, :) = localBinaryPatternImage1(end-1, :);
localBinaryPatternImage1(:, 1) = localBinaryPatternImage1(:, 2);
localBinaryPatternImage1(:, end) = localBinaryPatternImage1(:, end-1);
 
subplot(2,2,3);
imshow(localBinaryPatternImage1, []);
hp = impixelinfo();
hp.Units = 'normalized';
hp.Position = [0.2, 0.5, .5, .03];
 
subplot(2,2,4);
[pixelCounts, GLs] = imhist(uint8(localBinaryPatternImage1(2:end-1, 2:end-1)));
bar(GLs, pixelCounts, 'BarWidth', 1, 'EdgeColor', 'none');
grid on;
 
% Bring up another figure with all 8 LBP images on it, plus the average of them all.
LBPAverageImage = (double(localBinaryPatternImage1) + double(localBinaryPatternImage2) + double(localBinaryPatternImage3) + double(localBinaryPatternImage4) + double(localBinaryPatternImage5) + double(localBinaryPatternImage6) + double(localBinaryPatternImage7) + double(localBinaryPatternImage8)) / 8;
 
subplot(3, 3, 5);
imshow(LBPAverageImage, []);


%Code for extracting LBP facial images ends here


saveas(gcf,'lbp.png') % Saving the LBPAverageImage figure window image as an image

K=imread('lbp.png'); % Saving the image into a variable for further processing

K=imcrop(K);% {a window will show which requires us to crop the image manually before moving on to the next code segment}%

K=de2bi(K); % converting image data into binary matrix
K=K(:); % converting the binary matrix into a column to run it in verilog
K % To display K

%After displaying K, the values have to be copied from matlab into a .dat file in the Verilog directory 
