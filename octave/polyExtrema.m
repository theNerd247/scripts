%find the extrema of the given polynomial coefficients
function [xs,ys] = polyExtrema(f)
  f = vpa(poly2sym(f));
  fp = diff(f);
  loc = solve(fp == 0,sym('x'));
  extrema = function_handle(f)(loc);

  ys = double(extrema);
  xs = double(loc);
end
