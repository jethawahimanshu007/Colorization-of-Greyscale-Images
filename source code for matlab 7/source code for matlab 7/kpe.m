function codebook = kpe( vec, req_size )
    
    [row col]=size(vec);
    pointer=[1 row];
    means=[mean(vec)];
    
    row
    curr_size=1;
    while curr_size < req_size
        [p_row p_col]=size(pointer);
        temp_pointer=[];
        temp_means=[];
        for i=1:1:p_row
            temp_mean=means(i,:);
            temp_error=ones(1,col);
            temp_min=min(temp_mean);
            temp_error=temp_mean/temp_min;
            temp_v1=temp_mean+temp_error;
            temp_v2=temp_mean-temp_error;
            
            sub_low=pointer(i,1);
            sub_high=pointer(i,2);
            
            sub_matrix=vec(sub_low:sub_high,1:col);
            down=uint32(1);
            up=uint32(sub_high-sub_low+1);
            len_of_sub=up;
            for j=sub_low:1:sub_high
                x=double(vec(j,:));
                d1=abs(temp_v1-x);
                d2=abs(temp_v2-x);
                d1=sum(d1);
                d2=sum(d2);
                %d1
                %d2
                if d1-d2<5
                    sub_matrix(down,:)=x;
                    down=down+1;
                else
                    %up
                    sub_matrix(up,:)=x;
                    up=up-1;
                    
                    if up<=0
                        up=1;
                    end
                end
            end
            %if sub_low+down>=row
            %    sub_low=row-down;
            %end
            vec(sub_low:sub_high,1:col)=sub_matrix;
            if down>=len_of_sub-1
                down=len_of_sub-1;
                temp_pointer=[temp_pointer;sub_low sub_low+len_of_sub-1;sub_low+len_of_sub-1 sub_high];  
            else
                temp_pointer=[temp_pointer;sub_low sub_low+down;sub_low+down+1 sub_high];
            end
            %%vec(sub_low:down+1,1:col)
            %if sub_low+down>row
                %first_mean=double(vec(sub_low,:));
                %second_mean=double(vec(sub_high,:));
            %else
            %sub_low
            %sub_low+down
            if down==0
                first_mean=double(vec(sub_low,:));
            else
                first_mean=mean(vec(sub_low:sub_low+down,1:col));
            end
            if sub_low+down-1>=sub_high
                second_mean=double(vec(sub_low+down-1,:)); 
            else
                second_mean=mean(vec(sub_low+down-1:sub_high,1:col));
            end
            
            %first_mean
            %second_mean
            temp_means=[temp_means;first_mean;second_mean];
            
        end
        pointer=temp_pointer;
        %pointer
        means=temp_means;
        curr_size=size(means);
    end
    codebook=uint32(means);
end

