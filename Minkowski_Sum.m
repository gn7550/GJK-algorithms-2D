function Q=Minkowski_Sum(A,B)
i=1;j=1;
n=size(A,2);
m=size(B,2);
a=A; %this has to be counterclockwise

b=-B; %this has to be counterclockwise
a(:,n+1)=a(:,1);
a(:,n+2)=a(:,2);
b(:,m+1)=b(:,1);
b(:,m+2)=b(:,2);
Q=[];
while size(Q,2)<n+m
    Q=[Q, a(:,i)+b(:,j)];
    
    qa = atan2(a(2,i+1)-a(2,i),a(1,i+1)-a(1,i));
    qb = atan2(b(2,j+1)-b(2,j),b(1,j+1)-b(1,j));
   
   
    if qa<0
        qa=qa+2*pi;
    end
    if qb<0
        qb=qb+2*pi;
    end

    
    if qa<qb 
        i=i+1;
    else               
        if qa>qb
        j=j+1;
        else
        i=i+1;
        j=j+1;
        end
    end
    
    if i>n+1 || j>m+1
        disp(Q)
        break
    end
end
end