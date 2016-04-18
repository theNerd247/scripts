% converts the given symbolic transfer function to a state space model.
function [A,B,C,D] = toStateSpace(G)
  [n,d] = numden(G);
  nDeg = double(degree(n));
  dDeg = double(degree(d));
  dCoeffs = double(sym2poly(d));

 if(dDeg > 0)
    dCoeffs = double(sym2poly(d));
  else
    dCoeffs = [double(d)];
  endif

  if(nDeg > 0)
    nCoeffs = double(sym2poly(n));
  else
    nCoeffs = [double(n)];
  endif

  % put into standard form.
  a = dCoeffs(1,1);
  dCoeffs = dCoeffs./a;
  nCoeffs = nCoeffs./a;

  A = eye(dDeg,dDeg);
  A = [zeros(dDeg-1,1), A(2:dDeg,2:dDeg)];
  A(dDeg,:) = -1*flip(dCoeffs)(1,1:(dDeg));

  B = [zeros(dDeg-1,1); 1];

  C = flip(nCoeffs);

  for i = (columns(nCoeffs)+1):1:dDeg
    C(1,i) = 0;
  endfor
  
  D = [0];
end
