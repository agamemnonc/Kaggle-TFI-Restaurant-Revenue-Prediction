% MAE metric

function mae = rrp_compute_mae(actual,predicted)
sae = sum(abs(actual-predicted));
mae = ((1/numel(actual))*sae);
end % EOF