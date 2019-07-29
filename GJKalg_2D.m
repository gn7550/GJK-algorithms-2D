function distance=GJKalg_2D(A,B)

%A=[3 4 4 3;3 3 4 4], B=[0 -1 1;2 0 0];
%here B has to be counterclockwise when mutilpied by -1
C=Minkowski_Sum(A,B); %B has to be counterclockwise starting
                      %with largest y value
n=size(C,2);
Vn=randperm(n,3);


Q1=C(:,Vn(1)); Q2=C(:,Vn(2)); Q3=C(:,Vn(3));
V=[ Q1 Q2 Q3 ];
k=1;
[p,type]=ClosestPointOnTriangleToOrigin(V);
   [in,on] = inpolygon(0,0,C(1,:),C(2,:));
if in==1 || on==1
    disp('collision')
    return 
end

for i=1:size(C,2)
    q(:,i) = C(:,i);
    supp(:,i) = q(:,i)'*(-p) ;
end

[q_new, ind] = max(supp);
q_new=C(:,ind);


while k<500
if type(1)==1
    if isequal(q_new,V(:,1)) || isequal(q_new,V(:,2)) || isequal(q_new,V(:,3))...
        while 1   
        jj=randi(n,1);
        jjj=randi(n,1);
        if ~isequal(C(:,jj),q_new) && ~isequal(C(:,jjj),q_new)...
               && ~isequal(C(:,jj),C(:,jjj))
        V = [q_new C(:,jj) C(:,jjj)];
        break
        end
        end
        
    else
        while 1
        j=randi(n,1);
         if ~isequal(C(:,j),q_new) && ~isequal(C(:,j),p)
         V = [q_new p C(:,j)];
         break
         end
        end
    end
end


if type(1)==2 
    if isequal(q_new,V(:,1))||isequal(q_new,V(:,2))||isequal(q_new,V(:,3))
        [p,type]=ClosestPointOnTriangleToOrigin(V);
        distance=norm(p);
        break
    elseif type(2)==3 && ~isequal(V(:,1),q_new) && ~isequal(V(:,2),q_new)&& ~isequal(V(:,3),q_new)
        V(:,2)= q_new ;
    elseif type(2)==2 && ~isequal(V(:,1),q_new) && ~isequal(V(:,2),q_new) && ~isequal(V(:,3),q_new)
        V(:,1)= q_new ;
    elseif type(2)==1 && ~isequal(V(:,1),q_new) && ~isequal(V(:,2),q_new)&& ~isequal(V(:,3),q_new)
        V(:,3)= q_new;
    end
end

[p,type]=ClosestPointOnTriangleToOrigin(V);
for i=1:size(C,2)
    supp(:,i) = q(:,i)'*(-p) ;
end
[q_new, ind] = max(supp);
q_new=C(:,ind);

k=k+1;
end

distance = norm(p);


end
