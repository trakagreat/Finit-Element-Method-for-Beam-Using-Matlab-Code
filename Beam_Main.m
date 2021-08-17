clear
clear all
%%Reading input file
input_file_beam_prob_b

%%Formation of global stiffness matrix and global load vector
[K,F] = stiff_load(nele,ngauss,coord,connect,xivec,wvec,E,Ie,q_load);

%%Update global load vector after incorporating point load/moment
F = point_ld_mom(F,P_load,P_moment);
K_glob = K;
F_glob = F;

%%updating the global stiffness matrix and load vector using B.C
[K,F] = impose_bc(nele,K,F,BC_data);

%%finding solution
ureduce = inv(K)*F;

%%update solution vector with prescribed DOF
un = bc_update(ureduce,BC_data);
Freac = K_glob*un;
xi = [-1:0.1:1]';        
[xnume, unume] = postprocessing(nele,coord,connect,un,xi);


% % ==============================================
% %% Printing Intermediate Result to The Output File
% % ------------------------------------------------


%%Writing output results in a file
fid=fopen('Problem 2 with 2 elements.txt','w');   %%fid=fopen('Problem name.txt','w');

fprintf(fid,'\n\nThe Final Solution\n');
fprintf(fid,'=========================\n\n');
fprintf(fid,'wn\n');
fprintf(fid,'--\n');
for i = 1:2*(nele+1)
   fprintf(fid,'%12.4e\n\n',un(i));
end

fprintf(fid,'\n\nThe Reaction Forces can be found from\n');
fprintf(fid,'=========================================\n\n');
fprintf(fid,'F = K*wn\n');
fprintf(fid,'---------\n');
for i = 1:2*(nele+1)
   fprintf(fid,'%12.4e\n\n',Freac(i));
end
save('filename111','fid')

%%_________________________________________________________________________
%%%Reading input file for different number of elements
%%_________________________________________________________________________

clear
input_file_beam_prob_b6

%%Formation of global stiffness matrix and global load vector
[K,F] = stiff_load(nele,ngauss,coord,connect,xivec,wvec,E,Ie,q_load);

%Update global load vector after incorporating point load/moment
F = point_ld_mom(F,P_load,P_moment);
K_glob = K;
F_glob = F;

%%updating the global stiffness matrix and load vector using B.C
[K,F] = impose_bc(nele,K,F,BC_data);

%5finding solutionh
ureduce = inv(K)*F;

%%updating solution vector with prescriobed DOF
un = bc_update(ureduce,BC_data);
Freac = K_glob*un;
xi = [-1:0.05:1]';        
[xnume, unume] = postprocessing(nele,coord,connect,un,xi);




% % ==============================================
% %% Printing Intermediate Result to The Output File
% % ------------------------------------------------

%%writing output results in a file

fid=fopen('Problem 2 with 6 elements.txt','w'); %% %%fid=fopen('Problem name.txt','w');

fprintf(fid,'\n\nThe Final Solution\n');
fprintf(fid,'=========================\n\n');
fprintf(fid,'wn\n');
fprintf(fid,'--\n');
for i = 1:2*(nele+1)
   fprintf(fid,'%12.4e\n\n',un(i));
end

fprintf(fid,'\n\nThe Reaction Forces can be found from\n');
fprintf(fid,'=========================================\n\n');
fprintf(fid,'F = K*wn\n');
fprintf(fid,'---------\n');
for i = 1:2*(nele+1)
   fprintf(fid,'%12.4e\n\n',Freac(i));
end
save('filename111','fid')







