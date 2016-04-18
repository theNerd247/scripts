% determines if a given statespace model is observeable given the A and C
% matrices.
% o - 1 if the system is observable, 0 otherwise
% Om - the observeability matrix: [C;CA;CA^2;...]
% rnk - the rank of the matrix Om
function [o,Om,rnk] = observeable(A,C)
  r = size(A,1);

  Om = [C];

  for i = 1:r-1
    Om = [Om;C*(A^i)];
  end

  rnk = rank(Om);

  o = rnk == r;
end
