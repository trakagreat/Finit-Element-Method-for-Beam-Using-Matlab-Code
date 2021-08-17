function [K,F] = impose_bc(nele,K,F,BC_data);
for ii=1:size(BC_data,1)  
    nd=BC_data(ii,1);
    dof=BC_data(ii,2);
    Agdof(ii)=2*(nd-1)+dof;        %global DOF stored in array
end
a=Agdof;
nodes=nele+1;
for ii=1:2*nodes
    b(ii)=ii;
end
c=setdiff(b,a);
Kreduce=K(c,c);
for ii=1:size(BC_data,1)  
    nd=BC_data(ii,1);
    dof=BC_data(ii,2);
    gdof=2*(nd-1)+dof;
    val(ii)=BC_data(ii,3);
    if(val(ii)~=0)
        for jj=1:2*nodes
            F(jj)=F(jj)-K(jj,gdof)*val(ii);
        end
    end
end
Freduce=F(c);
K=Kreduce
F=Freduce
