function [Ao,Bo,Co,L] = observer(A,B,C,ps)
  syms s;

  r = size(A,1);

  [o,V,rnk] = observeable(A,C);

  if(!o)
    printf("The system is not observable\n");
    return
  end

  W = zeros(r,1);
  W(r) = 1;

  Phi = calcPhi(A,ps);

  if(isempty(Phi))
    printf("Could not calculate Phi!\n");
    return
  end

  L = Phi * inv(V) * W;

  Ao = A - L*C;
  Bo = eye(r);
  Co = eye(r);
end
