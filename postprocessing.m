function [xnume, unume] = postprocessing(nele,coord,connect,un,xi)
 
un=un';
nodes=nele+1;
for i=1:nodes
   xn(i)=coord(i,2);
end
xnume= []; unume = []; unume1 =[];
for el = 1:nele
    x_n = xn(el:el+1);
    u_n = un((el-1)*2+1:2*(el+1));
    le = x_n(2) - x_n(1);
    Nx = [(1-xi)/2, (1+xi)/2];
    
    %%N matrix for deflection
    N1 = (2-3*xi+xi.^3)/4;
    N2 = (1-xi -xi.^2 +xi.^3)/4;
    N3 = (2 + 3*xi -xi.^3)/4;
    N4 = (-1 -xi + xi.^2 + xi.^3)/4;
    Nu = [N1 le*N2/2 N3 le*N4/2];
    
    %%N matrix for slope
    N11 = (-3+3*xi.^2)/4;
    N22 = (-1 -2*xi +3*xi.^2)/4;
    N33 = (3 -3*xi.^2)/4;
    N44 = (-1 + 2*xi + 3*xi.^2)/4;
    Nu1 = (2/le)*[N11 le*N22/2 N33 le*N44/2];
    
    
    xnume = [xnume;Nx*x_n'];
    unume = [unume;Nu*u_n']; %delfection
    
    unume1= [unume1;Nu1*u_n'];  %slope
end


% Ploting:
h = figure(1);


if(nele==2|nele==3)
plot(xnume,unume,'b-','linewidth',1,'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);
end
if(nele==6)
  plot(xnume,unume,'-.r*','linewidth',1,'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);      
end


grid on;
set(gcf, 'Position', get(0,'Screensize'));
set(gca,'FontSize',12,'Fontweight','demi');
set(gcf, 'defaultTextInterpreter', 'latex');

% Labelling Axes
xlabel('x (m)','fontsize',18);
ylabel('u (m)','fontsize',18);

title('FEM Comparison of deflections')
legend({'2 Elements sol','6 Elements sol'},'Location','northwest')


saveas(h,'Deflection comparison que2','png')
hold on

h=figure(2)
if(nele==2|nele==3)
plot(xnume,unume1,'b-','linewidth',1,'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);
end
if(nele==6)
  plot(xnume,unume1,'-.r*','linewidth',1,'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',8);      
end


grid on;
set(gcf, 'Position', get(0,'Screensize'));
set(gca,'FontSize',12,'Fontweight','demi');
set(gcf, 'defaultTextInterpreter', 'latex');

% Labelling Axes
xlabel('x (m)','fontsize',18);
ylabel('u (rad)','fontsize',18);

title('FEM Comparison of slopes')
legend({'2 Elements sol','6 Elements sol'},'Location','northwest')



% Saving the figure
saveas(h,'Slope comparison que2','png')
hold on