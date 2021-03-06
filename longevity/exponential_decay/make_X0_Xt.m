% MAKE_X_XT design matrices for the exponential decay fits
%
%=INPUT
%
%   T_trode
%       Table made using MAKE_T_TRODE
%
%   regressors_used
%       A logical row array specifying whether each regressor is used
%
%   trodes_used
%       A logical vector array specifying whether electrodes are used
%=OUTPUT
%
%   X0
%       The columns of the design matrix that specifies the initial count
%
%   Xt
%       The columns of the design matrix that specifies the decay rate
function [X0, Xt] = make_X0_Xt(T_trode, regressors_used, trodes_used)
P = get_parameters;
% The 1st and n/2+1 column, which are constant terms
n=numel(regressors_used);
idx_y0 = regressors_used(2:n/2);
idx_k = regressors_used(n/2+2:end);
if nargin < 3
    trodes_used = true(size(T_trode,1),1);
end
T_trode = T_trode(trodes_used,:);
X_factors = T_trode{:, P.ED_trode_factors};
X0 = X_factors(:,idx_y0);
Xt = X_factors(:,idx_k);
X0  = [ones(sum(trodes_used),1), X0];
Xt = [ones(sum(trodes_used),1), Xt];