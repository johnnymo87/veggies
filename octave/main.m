warning ("off", "Octave:broadcast");
%% Machine Learning Online Class
%  Exercise 7 | Principle Component Analysis and K-Means Clustering
%
%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     pca.m
%     projectData.m
%     recoverData.m
%     computeCentroids.m
%     findClosestCentroids.m
%     kMeansInitCentroids.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc

%% ================= Part 1: Find Closest Centroids ====================
%  To help you implement K-Means, we have divided the learning algorithm 
%  into two functions -- findClosestCentroids and computeCentroids. In this
%  part, you shoudl complete the code in the findClosestCentroids function. 
%
fprintf('Finding closest centroids.\n\n');

% Load an example dataset that we will be using
fprintf('Loading dataset.\n\n');
X = load('data.txt');
% Normalize the features
%fprintf('Normalizing features.\n\n');
%[X, mu, sigma] = featureNormalize(X);

% iterate through different K-means
%for K = 2:16
	K = 16; % NUmber of centroids
	fprintf('Using %d centroids.\n\n', K);
	initial_centroids = kMeansInitCentroids(X, K);
	 % sort by hue, lowest to highest, so resultant cluster ordering tends to stay consistent across iterations
	[_, order] = sort(initial_centroids(:,1));
	initial_centroids = initial_centroids(order,:);

	max_iters = 16;

	% For consistency, here we set centroids to specific values
	% but in practice you want to generate them automatically, such as by
	% settings them to be random examples (as can be seen in
	% kMeansInitCentroids).
	%initial_centroids = [3 3; 6 2; 8 5];

	% Run K-Means algorithm. The 'true' at the end tells our function to plot
	% the progress of K-Means
	[centroids, idx] = runkMeans(X, initial_centroids, max_iters, false);
	fprintf('\nK-Means Done.\n\n');
%endfor

% undo feature normalization
%X = X .* sigma;
%X = X .+ mu;

% append HSV values to cluster info
idx = [idx X];

%write idx out to a tab-delimited text file
name = ['idx_' num2str(K) '.txt'];
dlmwrite(name, idx, '\t');
