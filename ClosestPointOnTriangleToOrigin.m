function [an,type]=ClosestPointOnTriangleToOrigin(tri)
A=tri(:,1); B=tri(:,2); C=tri(:,3);
tri(:,4)=tri(:,1); tri(:,5)=tri(:,2);

for i=1:3
    cond1 = (-tri(:,i))'*(tri(:,i+1)-tri(:,i));
    cond2 = (-tri(:,i))'*(tri(:,i+2)-tri(:,i));
    if cond1 <= 0 && cond2 <= 0
        p= tri(:,i);
        type=[1 i];
        break
    end
    
    tri3d(:,i)=[tri(:,i);0];
    tri3d(:,i+2)=[tri(:,i+2);0];
    tri3d(:,i+1)=[tri(:,i+1);0];
    cr= cross(tri3d(:,i+2)-tri3d(:,i+1),tri3d(:,i)-tri3d(:,i+1));
    cond3 = cross(cr,tri3d(:,i)-tri3d(:,i+1))'*(-tri3d(:,i+1));
    cond4 = (-tri(:,i))'*(tri(:,i+1)-tri(:,i));
    cond5 = (-tri(:,i+1))'*(tri(:,i)-tri(:,i+1));
    if cond3 >= 0 && cond4 >= 0 && cond5 >= 0
        lamda= (tri(:,i+1)-tri(:,i))\(-tri(:,i));
        p= tri(:,i)+ lamda*(tri(:,i+1)-tri(:,i));
        type=[2 i];
        break
    end
    
end

an=p;

end