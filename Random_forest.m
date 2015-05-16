% Random forest regression for Restaurant Revenue Prediction challenge
% For instructions, please refer to
% https://github.com/agamemnonc/Kaggle-Restaurant_Revenue_Prediction 

% Agamemnon Krasoulis
% agamemnon.krasoulis@gmail.com
% 15/05/2015

clear 
close allR
clc
rng(1) % For reproducibility

nruns = 200;
ntrees = 10000;
% Set up parallel options for TreeBagger function
paroptions = statset('UseParallel',true, 'UseSubstreams',false);

% Load data
train =readtable('train.csv');
test =readtable('test.csv');

% Get features for training and testing
X_ts = rrp_extract_features(test);

% Initialize array
prediction_test = zeros(size(X_ts,1), nruns);

% Go 
for jj = 1:1:nruns 
    % Shuffle training data
    train = train(randperm(size(train,1)),:);
    
    % Assign categorical tags randomly to P1-P37
    [X_tr, Y_tr, feat_names, ctgr] = rrp_extract_features(train, 'rand');
    
    % Train Random Forest
    B = TreeBagger(ntrees,X_tr,Y_tr, 'OOBPred', 'on', ...
        'Method', 'regression', 'CategoricalPredictors', ctgr, ...
        'NVarToSample', 14, ...
        'MinLeaf', 3, 'Options', paroptions);
                
        prediction_test(:,jj) = predict(B, X_ts);
end % For all runs

prediction_test = exp(prediction_test);
final_prediction = mean(prediction_test,2);

% Create a submission file
Id = (0:1:99999)';
T = table(Id, final_prediction);
writetable(T,'submission.csv')

        