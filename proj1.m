% Before trying to construct hybrid images, it is suggested that you
% implement my_imfilter.m and then debug it using proj1_test_filtering.m

% Debugging tip: You can split your MATLAB code into cells using "%%"
% comments. The cell containing the cursor has a light yellow background,
% and you can press Ctrl+Enter to run just the code in that cell. This is
% useful when projects get more complex and slow to rerun from scratch

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = im2single(imread('C:\Users\jenny\Downloads\CV\homework1-master\homework1-master\data\dog.bmp'));
image2 = im2single(imread('C:\Users\jenny\Downloads\CV\homework1-master\homework1-master\data\cat.bmp'));

% Several additional test cases are provided for you, but feel free to make
% your own (you'll need to align the images in a photo editor such as
% Photoshop). The hybrid images will differ depending on which image you
% assign as image1 (which will provide the low frequencies) and which image
% you asign as image2 (which will provide the high frequencies)

%% Filtering and Hybrid Image construction
cutoff_frequency = 7; %This is the standard deviation, in pixels, of the 
% Gaussian blur that will remove the high frequencies from one image and 
% remove the low frequencies from another image (by subtracting a blurred
% version from the original version). You will want to tune this for every
% image pair to get the best results.
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);
filter1=[1 1 1;1 1 1;1 1 1]/9;
filter2=zeros(29,29);
filter2(15,15)=2;
filter3=filter2-filter;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE BELOW. Use my_imfilter create 'low_frequencies' and
% 'high_frequencies' and then combine them to create 'hybrid_image'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output  image  =   myfilter (    raw image ,   filter  ) 
output  =   my_imfilter ( image1, filter  ) ;
%{
[M,N]=size(filter1)
[M1,N1,c]=size(image1)
S=M*N;
i1=image1(:,:,1);
i2=image1(:,:,2);
i3=image1(:,:,3);
Y=zeros((M1-2),(N1-2));
Y1=zeros((M1-2),(N1-2));
Y2=zeros((M1-2),(N1-2));
Y3=zeros((M1-2),(N1-2),3);    
        for j=1:1:N1-N+1
            for i=1:1:M1-M+1
        I=i1((i):(i+2), (j):(j+2) ).*filter1;
        Y(i,j)=sum(I(:))/S;
            
            end
        end
    
        for j=1:1:N1-N+1
            for i=1:1:M1-M+1
        I=i2((i):(i+2), (j):(j+2) ).*filter1;
        Y1(i,j)=sum(I(:))/S;
            
            end
        end


        for j=1:1:N1-N+1
            for i=1:1:M1-M+1
        I=i3((i):(i+2), (j):(j+2) ).*filter1;
        Y2(i,j)=sum(I(:))/S;
            
            end
        end

Y3(:,:,1)=Y;
Y3(:,:,2)=Y1;
Y3(:,:,3)=Y2;
%}

low_frequencies =  output;
 
   %{
    disp('低通濾波處理中...');
    new_image=conv2(image2, filter, 'same');
    new_image=round(new_image);
    image(new_image);
    title('低通濾波影像');
    disp('完成！'); 
    %}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output2  =   my_imfilter ( image2, filter3  ) ;
high_frequencies = output2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hybrid_image = 0.5*(high_frequencies+low_frequencies);

%% Visualize and save outputs
figure(1); imshow(low_frequencies)
figure(2); imshow(high_frequencies + 0.5);
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis);
imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);