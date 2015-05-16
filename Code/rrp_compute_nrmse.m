% NRMSE metric

function nrmse = rrp_compute_nrmse(actual,predicted)
ssqe = sum((actual-predicted).^2);
nrmse = sqrt((1/numel(actual))*ssqe);
end % EOF