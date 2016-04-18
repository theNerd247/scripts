% finds the closed loop poles of system given Xi and Wn and a multiplier for the
% their pole (m). For example if m = 10 then the third pole will be 10 times
% farther away from the imaginary axis than the other two poles.
function ps = closedPoles(Xi,Wn,m)
  ps = roots([1,2*Xi*Wn,Wn^2]);
  ps = [ps;real(ps(1,1))*m];
end
