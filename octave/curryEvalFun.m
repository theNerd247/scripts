%evaluates the given function f(x1,x2,x3,....) using the values in the given
%cell array {a1,a2,a3,....} where xi = ai. Essentially this performs function
%currying and evaluates the curried function over the arguments supplied by
%args.
%
% This is usefull if you have a function that takes multiple args and you want
% to store the args in a single cell array structure.
function y = curryEvalFun(f,args)
	if(isempty(args))
    printf("args cannot be empty!\n");
    return
  end

  n = size(args,1);

  if(n == 1)
    n = size(args,2);
  end

  if(n == 1)
    y = f(args{1});
    return
  end

  g = @(varargin) f(args{1},varargin{:});

  y = curryEvalFun(g, args(2:n));
end
