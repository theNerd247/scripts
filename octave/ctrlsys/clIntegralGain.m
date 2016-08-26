%computes the integral gain for a state space controller.
% Ke the integral constant
% Ks the state-controller gain
function [Ke,K,ac]= clIntegralGain(A,B,C,ps)
  syms s;

  r = size(A,1);

  if(max(size(ps)) != r+1)
    printf("ps must be a vector of length: %i\n",r+1);
    return
  end

  K = [];
  for i = 1:r
    K = [K,sym(sprintf('k%i',i))];
  end

  Ke = [];
  for i = 1:size(C,1)
    Ke = [Ke,sym(sprintf('ke%i',i))];
  end

  [Phi,as] = calcPhi(A,ps);

  ac = [[A-B*K, B*Ke];[-C,zeros(size(C,1))]];

  % compute the characteristic equation for the new state-space model
  ii = factor(det(s*eye(size(ac)) - ac),'s');
  rs = coeffs(factor(det(s*eye(size(ac)) - ac),'s'),'s');

  % set up the equations for calculating K and Ke
  x = sym(vpa(flip(as)))';
  t = (rs == x);
  t = t(2:r+2);

    % create a cell array for storing the arguments to solve
  Y = {};
  for i = 1:size(t,2)
    Y{i} = t(i);
  end

  Ks = [K,Ke];
  for i = 1:size(Ks,2)
    Y{i+r+1} = Ks(i);
  end

  %solve for K and Ke
  ks = curryEvalFun(@solve,Y);

  %extact constants and convert data types
  ks = struct2cell(ks);
  for i = 1:(size(ks)-1)
    K(i) = ks{i};
  end

  Ke = double(ks{size(ks)});
  K = double(K);
end
