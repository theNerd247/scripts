% creates a string given a list of polynomial coefficients. 
% P - list of polynomials (must be one dimensional)
% f - an optional format string for how to "render" the coefficients
function s = makePolyEq(P,f="%.3f")
  s = "";
  for i = 0:(columns(P)-1)
    if(P(i+1) == 0)
      continue
    end

    frmt = sprintf("(%s)",f); 

    if(columns(P)-1-i != 0)
      frmt = sprintf("%sx^%i",frmt,columns(P)-1-i);
    end

    if(i != 0)
      frmt = [s,"+",frmt];
    end

    s = sprintf(frmt,P(i+1));
  end
endfunction
