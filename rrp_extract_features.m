% Reads data table and returns desing matrix, output vector, string vector 
% with feature names and binary (logical) vector with categorical variables.
% Optional input variable m denotes the maximum number of possible values 
% that a feature can take so that it is assumed to be categorical (default 5). 
% Alternatively, m can take the value 'rand'. In that case the labels are
% assigned randomly for variables P1 - P37.

% For open date, the number of years since opening is computed.

function [X,Y,feat_names,ctgr] = rrp_extract_features(data, m)

if nargin < 2
    m = 5;
end

if ischar(m)
    if ~strcmp(m, 'rand')
        error('Not valid input argument for categorical assignment variable.')
    end
end

num_feat = size(data,2)-2;
X = zeros(size(data,1), num_feat);
feat_names = cell(num_feat,1);

% P1-P37
for jj = 1:1:37 
    X(:,jj) = eval(strcat('data.P', num2str(jj)));
    feat_names{jj} = strcat('P', num2str(jj));
end

% Years since opening
dateChar = char(data.OpenDate);
X(:, 38) = ones(size(data,1),1)*2014 - str2num(dateChar(:,end-3:end)); %#ok<ST2NM>
feat_names{38} = 'Years';

% City Group
X(strcmp(data.CityGroup,'Big Cities'),39) = 1; 
X(strcmp(data.CityGroup,'Other'),39) = 2;
feat_names{39} = 'City group';

% Restaurant type
X(strcmp(data.Type,'DT'),40) = 1;
X(strcmp(data.Type,'FC'),40) = 2;
X(strcmp(data.Type,'IL'),40) = 3;
feat_names{40} = 'Restaurant type';

% City name (start iwith cities only in the training set, and then move on
% with cities only in the test set.
[train_data, test_data] = rrp_load_data;
cities_train_unique = unique(train_data.City); % First get city names in the training set
for jj = 1:1:numel(cities_train_unique)
    X(strcmp(data.City, cities_train_unique(jj)),41) = jj;
end
cities_test_unique = unique(test_data.City);
difference = setdiff(cities_test_unique, cities_train_unique);
for jj = 1:1:numel(difference)
    X(strcmp(data.City, difference(jj)),41) = numel(cities_train_unique) + jj;
end
feat_names{41} = 'City';

% Which variables are categorical
ctgr = zeros(num_feat,1);
for jj = 1:1:37
    if isnumeric(m)
        if numel(unique(X(:,jj))) < m
            ctgr(jj) = 1;
        end
    elseif ischar(m)
        if strcmp(m, 'rand')
            tmp = randn(1,37);
            tmp(tmp<0)=0; tmp(tmp>0) = 1;
            ctgr(1:1:37) = tmp;
        end
    end
end
ctgr(39:41) = 1;
ctgr = logical(ctgr);

% Revenue
if nargout > 1
    Y = log(data.revenue); % Log-transform of revenue
end
