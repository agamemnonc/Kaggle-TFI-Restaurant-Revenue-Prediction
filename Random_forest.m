% Random forests prediction on test set.
% Multiple runs. For each run, the training data are shuffled, such that
% different subsets create the CV folds.
% Also, the categorical values for P variables are set randomly during each
% run. All predictions are averaged in the end. 
% The log revenue is predicted and then back-transformed to the orignal
% signal.

clear 
close all
clc
rng(1) % For reproducibility
warning('off', 'MATLAB:table:ModifiedVarnames'); % Do not print warnings

nruns = 200;
ntrees = 10000;
paroptions = statset('UseParallel',true, 'UseSubstreams',false);

% Load data
[train, test] = rrp_load_data;

% Get features for training and testing
[X_tr, Y_tr, feat_names, ctgr] = rrp_extract_features(train);
X_ts = rrp_extract_features(test);


% Initialize arrays
prediction_test = zeros(size(X_ts,1), nruns);
oob_err = zeros(1, nruns);

% Go 
for jj = 1:1:nruns 
    fprintf('\nRun %4.2i\n', jj)
    % Shuffle training data
    train = train(randperm(size(train,1)),:);
    
    % Assign categorical tags randomly to P1-P37
    [X_tr, Y_tr, feat_names, ctgr] = rrp_extract_features(train, 'rand');
    
    % Train Random Forest
    B = TreeBagger(ntrees,X_tr,Y_tr, 'OOBPred', 'on', ...
        'Method', 'regression', 'CategoricalPredictors', ctgr, ...
        'NVarToSample', 14, ...
        'MinLeaf', 3, 'Options', paroptions);

        oob_err(jj) = oobError(B, 'mode', 'ensemble');
                
        prediction_test(:,jj) = predict(B, X_ts);
end % For all runs

prediction_test = exp(prediction_test);

Options.numruns = nruns;
Options.featNames = feat_names;
Results.predictedTs = prediction_test;
Results.ooberr = oob_err;
save(strcat('Random_forests_',date), 'Results', 'Options')

        