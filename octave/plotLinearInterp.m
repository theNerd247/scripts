function [P,xs,ys] = plotLinearInterp(X,Y,N,minx=0)

  if(N == 0)
    a = (X'*X) \ (X'*Y);
    P = [a,0];
  else
	  P = polyfit(X,Y,N);
  end

	xs = linspace(minx,max(X),100);
	xp=[];
	
	for i = (columns(P)-1):-1:0
	  xp = [xp;xs.^i];
	end
	
	ys = (P*xp)';
  xs = xs';
	
end
