function [un] = bc_update(ureduce,BC_data)
for ii=1:size(BC_data,1)  
    nd=BC_data(ii,1);
    dof=BC_data(ii,2);
    Agdof(ii)=2*(nd-1)+dof;        %global DOF stored in array
end
a=Agdof;
nodes= size(ureduce,1)+size(BC_data,1);
for ii=1:nodes
    b(ii)=ii;
end
c=setdiff(b,a);

for ii=1:size(BC_data,1)  
    nd=BC_data(ii,1);
    dof=BC_data(ii,2);
    gdof=2*(nd-1)+dof;
    val(ii)=BC_data(ii,3);
end


for ii=1:size(c,2)
un(c(ii))=ureduce(ii);
end
for ii=1:size(a,2)
   un(a(ii))=val(ii); 
end
un=un'