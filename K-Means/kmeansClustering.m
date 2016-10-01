clc;
clear;
close all;

%% Get Data:
rng default; % For reproducibility
X = [randn(100,2)*0.75+ones(100,2);
    randn(100,2)*0.5-ones(100,2)];


%% Perform Kmeans clustering with two groups
[idx,C] =kmeans(X,2); 

%% Plot The clusters
x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

% NOTE: This will throw warning because we are calling again the
% kmeans algorithm but we are only doing one iteration to get the actual
% fistances from the mesh XGrid to the calculated centroids C. 
idx2Region = kmeans(XGrid,2,'MaxIter',1,'Start',C);

figure;
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [0,0.75,0.75;
     0.75,0,0.75],'..');
hold on;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
title 'Kmeans Clustering';
xlabel 'X1';
ylabel 'X2';
legend('Region 1','Region 2','Data','Centroids','Location','SouthEast');
hold off;   
    