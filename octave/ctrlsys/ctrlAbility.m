function [c,CM] = ctrlAbility(A,B)
	CM = [];
  for i = 0:(columns(A)-1)
    CM = [CM,A^(i)*B];
  endfor

  c = rank(CM) == columns(A);
end
