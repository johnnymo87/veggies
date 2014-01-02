function [centroids avg_position] = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);
k_counts = zeros(K, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

for i = 1:m
	% count how many points are assigned to a given centroid
	k_counts(idx(i)) += 1;
	centroids(idx(i), :) += X(i,:);
endfor
for i = 1:K
	if k_counts(i) == 0
		% re-init centroids that have no points
		%keyboard();
		fprintf('Reinitializing centroid %d\n', k_counts(i));
		centroids(i, :) = kMeansInitCentroids(X, 1);
	else
		centroids(i, :) = centroids(i, :) / k_counts(i);
	endif
endfor

avg_position = sum(centroids) / K;
fprintf('Average centroid position: %f %f %f \n\n', avg_position);







% =============================================================


end

