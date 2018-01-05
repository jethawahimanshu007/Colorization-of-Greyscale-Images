function vec_space = divide_window_size( input,m,n,flag )
%UNTITLED2 this function takes as input the image, and widow size m X n. In
%the output it returns array of the size l X (m*n*3).
%   Detailed explanation goes here

if flag==0
    vec = [];
    [x y] = size(input);
    for i=1:m:x
        for j=1:n:y
            temp=[];
            for l=i:i+m-1
                for k=j:j+n-1
                    if l<=x && k<=y
                        temp=[temp input(l,k)];
                    else
                        temp=[temp 0];
                    end
                end
            end
            vec=[vec;temp];
        end
    end
    vec_space=vec;

else
    vec = [];
    [x y z] = size(input);

    for i = 1:m:x
        for j = 1:n:y

            temp = [];
            for l=i:i+m-1
                for k = j:j+n-1
                    if l<=x && k<=y
                        temp=[temp input(l,k,1) input(l,k,2) input(l,k,3)];
                    else
                        temp=[temp 0 0 0];
                    end
                end
            end
            vec=[vec;temp];

        end
    end

    vec_space=vec;

end

