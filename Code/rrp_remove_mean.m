%
% RRP_REMOVE_MEAN Removes the column means of a matrix
%
% [Y, M] = RRP_REMOVE_MEAN(X)
%
% Inputs
%    X:     Data matrix arranged in columns
%    M:     Mean to be removed (optional).
%
% Outputs:
%    Y:     Centered data
%    M:     Mean vector
%
% Author Agamemnon Krasoulis
% agamemnon.krasoulis@gmail.com
%
% Modifications
% 16/12/14 AK Added option to pass mean to be removed as an additional
% argument.
% 16/12/14 AK Replaced repmat with bsxfun.
% 22/09/14 AK First Created

function [Y, M] = rrp_remove_mean(X, M)

if nargin < 2
    M = mean(X);
end

% Y = X - repmat(M, size(X,1), 1);
Y = bsxfun(@minus, X, M);
end % EOF