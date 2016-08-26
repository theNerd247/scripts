% A - D - the plant state-space model
% k - the closed loop state gain
% r - the closed loop input signal. If r == -1 nothing is plotted
% if r = [] then the step response is plotted. Otherwise lsim is called using r
% a the system input (see symoblic package for reference).
function clSys = simClStateSpace(A,B,C,k,r = [])
  clSys = ss((A-B*k),B,C);
  
  if(r == -1)
    return;
  end

  if(isempty(r))
    step(clSys);
  else
    lsim(clSys,r);
  end
end
