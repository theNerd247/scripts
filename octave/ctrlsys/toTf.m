% creates the transfer function in symbolic form for a state-space model.
function Gs = toTf(A,B,C,D,fctr=true)
	syms s;
  if(fctr)
    Gs = factor(C * inv((s*eye(size(A)) - A)) * B + D);
  else
    Gs = C * inv((s*eye(size(A)) - A)) * B + D;
  end
end
