function [train, test] = rrp_load_data

train =readtable(strcat(rrp_data_folder, '/train.csv'));
test =readtable(strcat(rrp_data_folder, '/test.csv'));

end % EOF