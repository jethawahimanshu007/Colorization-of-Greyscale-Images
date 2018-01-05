[fname pname]=uigetfile('*.*','Choose an image');
im=imread(strcat(pname,fname));
im=rgb2gray(im);
name=input('Enter the file name:');
imwrite(im,strcat(name,'.jpg'),'jpg');