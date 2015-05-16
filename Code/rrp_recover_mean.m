%
% RRP_RECOVER_MEAN Recovers the column means of a matrix
%
% Y = RRP_RECOVER_MEAN(X, M)
%
% Inputs
%    X:     Data matrix arranged in columns
%    M
%
% Outputs:
%    Y:     Data matrix with recovered column means
%
% Author Agamemnon Krasoulis
% agamemnon.krasoulis@gmail.com
%
% Modifications
% 16/12/14 AK Replaced repmat with bsxfun.
% 22/09/14 AK First Created.

function Y = rrp_recover_mean(X, M)


Y = bsxfun(@plus, X, M);
end % EOF