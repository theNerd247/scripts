function [xi,wn] = xiWn(Ts,Os)
  xi = sqrt(1/((-pi/log(Os))^2+1));
  wn = 4/(xi*Ts);
end
