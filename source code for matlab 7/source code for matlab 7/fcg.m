function codebook = fcg( vec,no_of_iterations )
% The function fcg() applies fast codebook generation algorithm
% on 'vec', and returns the codebook.
    
%initialization of main data structures.
    [row col]=size(vec);
    pointer=[1 row];
    col
    temp=1;
%algorithm
    for curr_col=1:1:no_of_iterations
        [p_row p_col]=size(pointer);
        for i=1:1:p_row
            low=pointer(i,1);
            high=pointer(i,2);
            sub_matrix=vec(low:high,1:col);
            temp=[uint16(mod(curr_col,col))];
            if temp==0
                temp=col;
            end
            sub_matrix=sortrows(sub_matrix,temp);
            vec(low:high,1:col)= sub_matrix;
           
        end
        temp=[];
        for j=1:1:p_row
            if pointer(j,1)==pointer(j,2) || abs(int32(pointer(j,1))-int32(pointer(j,2)))==1
                temp=[temp;pointer(j,1) pointer(j,2)];%;pointer(j,1) pointer(j,2)];
            else
                mid=pointer(j,1)+pointer(j,2);
                mid=uint32(mid/2);
                temp=[temp;pointer(j,1) mid;mid+1 pointer(j,2)];
            end
        end
        pointer=temp;
        
    end
%calculating the codebook
    cb=[];
    %pointer
    [p_row p_col]=size(pointer);
    for i=1:1:p_row
        index=pointer(i,1)+pointer(i,2);
        index=uint32(index/2);
        cb=[cb;vec(index,:)];
    end
    codebook=cb;
end

