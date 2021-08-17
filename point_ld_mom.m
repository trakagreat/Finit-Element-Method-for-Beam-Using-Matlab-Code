function [F] = point_ld_mom(F,P_load,P_moment);
%adding boundary forces and moments
Rforce=size(P_load,1);          %no of rows in force input vector
Rmoment=size(P_moment,1);        %no of rows in moment input vector
for ii=1:Rforce
    F(2*P_load(ii,1)-1)=F(2*P_load(ii,1)-1)+P_load(ii,2);
end
for ii=1:Rmoment
    F(2*P_moment(ii,1))=F(2*P_moment(ii,1))+P_moment(ii,2);
end