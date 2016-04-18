%computes the integral gain for a state space controller.
% the new system's state-space is also returned (Ac,...Dc)
% Ke the integral constant
% Ks 
function [Ke,K,Ac,Bc,Cc,Dc]= clIntegralGain(A,B,C,ps)
  syms s ke;

  r = size(A,1);

  K = [];
  for i = 1:r
    K = [K,sym(sprintf('k%i',i))];
  end

  [Phi,as] = calcPhi(A,ps);

  ac = [[A-B*K, B*ke];[-C,0]];

  % compute the characteristic equation for the new state-space model
  rs = coeffs(factor(det(s*eye(size(ac)) - ac),'s'),'s');

  % set up the equations for calculating K and ke
  t = ((rs == sym(vpa(flip(as)))')(2:r+2));

  % create a cell array for storing the arguments to solve
  Y = {};
  for i = 1:size(t,2)
    Y{i} = t(i);
  end

  Ks = [K,ke];
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
