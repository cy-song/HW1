# HW1
function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);




%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
%image1 = im2single(imread('../data/dog.bmp'));
[M,N]=size(filter)
[M1,N1,c]=size(image)
image1=zeros(M1+(M-1),N1+(N-1),c);
image1( (1+(M-1)/2:M1+(M-1)/2) ,(1+(N-1)/2  :N1+(N-1)/2),:)=image((1:M1),(1:N1),:);
S=M*N;
i1=image1(:,:,1);
i2=image1(:,:,2);
i3=image1(:,:,3);
Y=zeros((M1),(N1));
Y1=zeros((M1),(N1));
Y2=zeros((M1),(N1));
Y3=zeros((M1),(N1),3);    
k=0;
k1=0;
        for j=1:1:(N1+(N-1)-N+1)
                  k1=k1+1;
                for i=1:1:(M1+(M-1)-M+1)
                   k=k+1;
        I=i1((i):(i+M-1), (j):(j+N-1) ).*filter;
        Y(i,j)=sum(I(:));
                   
                end
          
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       for j=1:1:(N1+(N-1)-N+1)
                  k1=k1+1;
                for i=1:1:(M1+(M-1)-M+1)
                   k=k+1;
        I=i2((i):(i+M-1), (j):(j+N-1) ).*filter;
        Y1(i,j)=sum(I(:));
                   
                end
          
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

         for j=1:1:(N1+(N-1)-N+1)
                  k1=k1+1;
                for i=1:1:(M1+(M-1)-M+1)
                   k=k+1;
        I=i3((i):(i+M-1), (j):(j+N-1) ).*filter;
        Y2(i,j)=sum(I(:));
                   
                end
          
        end

Y3(:,:,1)=Y;
Y3(:,:,2)=Y1;
Y3(:,:,3)=Y2;
     output = Y3;
    

    
    
    





































