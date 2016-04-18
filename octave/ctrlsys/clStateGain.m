% finds the state-controller gain K for a given state space model
function [k,E,F,a,phi] = clStateGain(A,B,p)
  n = columns(A);

  E = zeros(1,n);
  E(1,n) = 1;

  F = [];
  for i = 0:(n-1)
    F = [F,A^(i)*B];
  endfor

  Phi = calcPhi(A,p);

  k = E*inv(F)*phi;
endfunction
