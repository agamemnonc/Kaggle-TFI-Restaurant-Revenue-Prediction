% Returns the training and CV data for the j'th fold. 

function [X_tr_tr, X_tr_cv, Y_tr_tr, Y_tr_cv] = rrp_cv_data(X_tr, Y_tr, CV)

X_tr_tr = X_tr(CV.IndTr,:);
Y_tr_tr = Y_tr(CV.IndTr,:);
X_tr_cv = X_tr(CV.IndTs,:);
Y_tr_cv = Y_tr(CV.IndTs,:);

% EOF