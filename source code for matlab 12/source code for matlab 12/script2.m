[fname pname] = uigetfile('*.*','Choose source image');
ims = imread(strcat(pname,fname));
im_original=ims;
%figure(1);imshow(ims);
tic
[m n k] = size(ims);
a = uint8(zeros(m,n,3));
m
n
for i = 1:m
    for j = 1:n
        %a(i,j,1) = ims(i,j,1) + ims(i,j,2) + ims(i,j,3);
        %a(i,j,2) = -2*ims(i,j,1) + ims(i,j,2) + ims(i,j,3);
        %a(i,j,3) = ims(i,j,2) + ims(i,j,3);
        a(i,j,1)=uint8(ims(i,j,1));
        a(i,j,2)=uint8(ims(i,j,2));
        a(i,j,3)=uint8(ims(i,j,3));
    end
end
%a=ims;
%a
%a=rgb2ycbcr(a);
%a=rgb2ntsc(a);
vec_space = divide_window_size(a,1,1,1); % This function divides the image 
%into windows of given size, here 1 X 2. 
avg_code=[];
i=1;
sum=uint32(0);
[row col]=size(vec_space);

cb=fcg(vec_space,9);
%cb=kpe(vec_space,512);
%cb
%cb = lbg2(vec_space,512,15); % This function applies LBG algo on 'vec_space' 
%returned by above function, of given size, here 128. 
%cb
length(cb)
%length(vec_space)
toc
% Accept the target image and colorize it.
[fname1 pname1] = uigetfile('*.*','Choose grayscale image');
imt = imread(strcat(pname1,fname1));
%imt= divide_window_size(imt,2,2,0);
tic
colorized=colorize2(imt,cb,1,1);
figure(4);imshow(colorized);

%Applying smoothing filter
H = fspecial('gaussian', [3 3]);
I = imfilter(colorized, H);
%figure(5);imshow(I);
toc

%[fname pname] = uigetfile('*.*','Choose image to find MSE');
%im_original = imread(strcat(pname,fname));

MSE = reshape(mean(mean((double(colorized) - double(im_original)).^2,2),1),[1,3]);
MSE
mean(MSE)