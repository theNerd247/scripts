% calculate Phi(A) based off of the given poles
% if an error occurs Phi = []
% Octave users: this function requires the symbolic package 
% 
% Phi - Matrix Phi(A)
% as - the coefficients for the characteristic equation: s^n+a_n-1*s^(n-1)+...+a0
% which is in the from: [a0;a1;...;1]
function [Phi,as] = calcPhi(A,p)
  syms s;

  n = size(A,1);
  Phi = [];

  ps = sym(1);
  for i = 1:max(size(p))
    ps = ps*(s - p(i));
  endfor

  ps = expand(vpa(ps));
  as = sym2poly(ps);
  as = reshape(as,[],1);
  a = as;
  as = flip(as);

  Phi = A^n;
  for i = 0:(n-1)
    Phi += as(i+1)*A^i;
  endfor

end
