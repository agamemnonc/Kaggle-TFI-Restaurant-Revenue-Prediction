% Same as rrp_extract_features, except it does not return the city name
function [X,Y,feat_names,ctgr] = rrp_extract_features_no_city(data, m)

if nargin < 2
    m = 5;
end

if ischar(m)
    if ~strcmp(m, 'rand')
        error('Not valid input argument for categorical assignment variable.')
    end
end

num_feat = size(data,2)-3;
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
ctgr(39:40) = 1;
ctgr = logical(ctgr);

% Revenue
if nargout > 1
    Y = log(data.revenue); % Log-transform of revenue
end
