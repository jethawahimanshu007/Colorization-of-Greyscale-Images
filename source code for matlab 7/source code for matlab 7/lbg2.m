function codebook = lbg( vec,num,no_of_iterations )
    %This function will apply LBG algo on 'vec' and codebook of length 'num' 
    %will be returned.
    %step 1: Define initial codebook.
    cb = [];
    sum1 = [];
    count1 = [];
    previous=[];
    [row col]=size(vec);
    step=uint32(row/num);
    for i = 1 : step : row
        t=[];
        %for j=1:col
        %    t=[t vec(i,j)];
        %end
        t=vec(i,:);
        cb = [cb;t];
        sum1 = [sum1;uint32(zeros(col))];
        count1 = [count1;uint32(0)];
    end
    
    for i = length(cb) : num
        t=[];
        for j=1:col
            t=[t 0];
        end
        cb = [cb;t];
        sum1 = [sum1;uint32(zeros(col))];
        count1 = [count1;uint32(0)];
    end
    
    for i=1: row
        previous=[previous;0];
    end
    
    %step 2: Make changes in initial codebook.
    changed = 1;
    iteration = 1;
    while changed==1
        changed = 0;
        changes=0;
        iteration=iteration+1;
        for i = 1:row
            t=[];
            %for j=1:col
            %    t=[t vec(i,j)];
            %end
            t=vec(i,:);
            %pos = findMin(t,cb);
            distances(:,1)=abs(double(cb(:,1))-double(t(1)));
            distances(:,2)=abs(double(cb(:,2))-double(t(2)));
            distances(:,3)=abs(double(cb(:,3))-double(t(3)));
            [y,ind] = min(distances);
            pos=ind(1);
            if pos ~= previous(i)
                changed = 1;
                changes=changes+1;
            end
            previous(i) = pos;
            for j=1:col
                sum1(pos,j) = sum1(pos,j) + uint32(vec(i,j));
            end
            count1(pos)=count1(pos)+1;
        end
        changes
        str=input('Do you want to stop the algorithm?(y/n)');
        if str=='y'
            break;
        end
        
        if changes<10
            break;
        end
        
        if iteration>=no_of_iterations
            break;
        end
        
        for j=1:num
            for k=1:col
                cb(j,k)=uint8(sum1(j,k)/count1(j));
                sum1(j,k)=0;
            end
            count1(j)=0;
        end
    end
    iteration
    changed
    codebook=cb;
end

function position = findMin(vector, c)
   minPos=1;
   [row,col]=size(c);
   dist=[];
   for i=1:row
       t=int32(0);
       t=sum(abs(int32(vector)-int32(c(i,:))));
       dist = [dist uint32(t)];
   end
   %size(dist)
   [y,ind] = min(dist);
   %ind
   %return
   position=ind;
end