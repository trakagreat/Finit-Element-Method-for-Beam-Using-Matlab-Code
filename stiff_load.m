function [K,F] = stiff_load(nele,ngauss,coord,connect,xivec,wvec,E,Ie,q_load)

nodes=size(coord,1);                      %no of nodes in beam
kglobal=zeros(2*nodes,2*nodes);
qmat=zeros(nele,4);
rq_load=size(q_load,1);           %no of rows in input q_load matrix
for ii=1:rq_load
    for jj=1:4
        qmat(ii,jj)=qmat(ii,jj)+q_load(ii,jj);
    end
end
fglobal=zeros(2*nodes,1);




for i=1:nele                          %loop for elements
    
    
    
    
ndele=connect(i,:);
sz=length(ndele);
for j=2:sz                            %loop for coordinate at different nodes 
    xele(j-1)=coord(ndele(j),2);
end
for k=2:sz                            %loop for determining node no in particluar element
   nd(k-1)=connect(i,k); 
end
vec=[2*nd(1)-1,2*nd(1),2*nd(2)-1,2*nd(2)]  %determing global DOF for element

gauss=ngauss;        %no of gauss points
le = xele(2) - xele(1);
qele=qmat(i,:)

K1=0;F1=0;
Kindividual=cell(1,nele);
Findividual=cell(1,nele);


for z=1:gauss
B1 = 3*xivec(z)/2;
B2 = le*(3*xivec(z)-1)/4;
B3 = -3*xivec(z)/2;
B4 = le*(3*xivec(z)+1)/4;

B = (4/le^2)*[B1, B2, B3, B4];



K1=K1+(E(i)*Ie(i)*le/2)*(B'*B)*wvec(z);

N1 = (2 - 3*xivec(z) + xivec(z)^3)/4;
N2 = (1 - xivec(z) - xivec(z)^2 + xivec(z)^3)/4;
N3 = (2 + 3*xivec(z) - xivec(z)^3)/4;
N4 = (-1 - xivec(z) + xivec(z)^2 + xivec(z)^3)/4;

N = [N1, le*N2/2, N3, le*N4/2];

N1x = (1 - xivec(z))/2;
N2x = (1 + xivec(z))/2;
xe = [N1x  N2x]*xele';

q = qele(2)+qele(3)*xe+qele(4)*xe^2;
F1=F1+(N'*q*le/2)*wvec(z);
end

kele = K1;
fele = F1;

Kindividual{i}=kele;
Findividual{i}=fele;



for ii=1:4
    for jj=1:4
        kglobal(vec(ii),vec(jj))=kglobal(vec(ii),vec(jj))+kele(ii,jj);
    end
end

    for ii=1:4
        fglobal(vec(ii))=fglobal(vec(ii))+fele(ii);
    end
end

K=kglobal;
F=fglobal;
end

