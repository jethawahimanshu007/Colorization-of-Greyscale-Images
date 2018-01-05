function ans1 = colorize2( im,cb,m,n)
    %This function takes as input the target image and codebook. And it 
    % produces colorized version of the target image.
    %Detailed explanation goes here
    im_d=divide_window_size(im,m,n,0);
    [row col]=size(im);
    c=uint8(zeros(row,col,3));
    %figure(2);imshow(im);
    d_pointer=1;
    grays=[];
    [cbrow cbcol]=size(cb);
    %cb=double(cb);
    avg_cb=[];
    for i=1:cbrow
        temp=[];
        for j=1:3:m*n*3
            temp_double=0.2989*double(cb(i,j)) + 0.587*double(cb(i,j+1)) + 0.114*double(cb(i,j+2));
            avg1=temp_double;
            %avg=uint8(cb(i,j)/3 + cb(i,j+1)/3 + cb(i,j+2)/3);
            temp=[temp avg1];
        end
        grays=[grays;temp];
        avg_cb=[avg_cb;mean(temp) cb(i,:)];
    end
    
    avg_cb=sortrows(avg_cb,1);
    jump=10;
    len_index=uint32(cbrow/jump)+1;
    index=double(zeros(len_index,1));
    
    %buillding index
    j=1;
    for i=1:jump:cbrow
        index(j)=avg_cb(i,1);
        j=j+1;
    end
    
    %searching using index
    for i=1:m:row
        for j=1:n:col
            key=im_d(d_pointer,:);
            d_pointer=d_pointer+1;
            key=mean(key);
            %key=uint8(key);
            ll=1;
            ul=jump;
            l1=1;
            
            %search in the first level index
            while l1<len_index
                if key<index(l1)
                    break
                elseif key>index(l1)
                    ll=ul;
                    ul=ul+jump;
                else
                    ll=ul;
                end
                l1=l1+1;
            end
            
            if ul>cbrow
                ul=cbrow;
            end
            
            if ll>cbrow
                ll=cbrow;
            end
            
            %ll=ll-jump;
            
            %if ll<1
            %    ll=1;
            %end
            %search in the second level index
            minPos=ll;
            minDiff=1000;
            for k=ll:1:ul
                tempDiff=abs(int32(key) - int32(avg_cb(k,1)));
                %tempDiff=abs(key - avg_cb(k,1));
                if tempDiff<minDiff
                    minDiff=tempDiff;
                    minPos=k;
                end
                if tempDiff==0
                    break;
                end
            end
            
            %transfer the color
            p=2;
            k=minPos;
            %cb(k,:)
            for l=i:i+m-1
                for o=j:j+n-1
                    c(l,o,1)=uint8(avg_cb(k,p));p=p+1;
                    c(l,o,2)=uint8(avg_cb(k,p));p=p+1;
                    c(l,o,3)=uint8(avg_cb(k,p));p=p+1;
                    %c(l,o,1)=avg_cb(k,p);p=p+1;
                    %c(l,o,2)=avg_cb(k,p);p=p+1;
                    %c(l,o,3)=avg_cb(k,p);p=p+1;
                end
            end
        end
    end
    ans1=c;
end