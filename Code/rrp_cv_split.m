% CV Split (K-fold) for RRP data
% Returns a structure with Training and Testing indices
% Inputs: 
%   num_samples: dataset size
%   num_folds: number of folds
% Outputs:
%   CV: Structure of size number of folds with fields IndTr and IndTs.

function CV = rrp_cv_split(num_samples, num_folds)

spf = ceil(num_samples/num_folds); % Samples per fold

difrn = num_folds*spf - num_samples ; % The split is not exact

% Initialize output structure
CV(1:num_folds) = struct('IndTr', [], 'IndTs', []);

% Go
stp = 0;
for jj = 1:1:num_folds
    if jj < difrn + 1 % For the first m folds, use one spf-1 samples to balance the folds.
        tst_ind = stp+1:1:stp+spf-1;
        stp = stp+spf-1;
    else % Otherwise use spf samples
        tst_ind = stp+1:1:stp+spf;
        stp = stp+spf;
    end
    CV(jj).IndTr = 1:1:num_samples;
    CV(jj).IndTr(tst_ind) = []; 
    CV(jj).IndTs = tst_ind;
end
