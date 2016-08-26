function [c,CM,rnk] = controlable(A,B)
	CM = [];
  for i = 0:(columns(A)-1)
    CM = [CM,A^(i)*B];
  endfor

  rnk = rank(CM);
  c = rnk == columns(A);
end
