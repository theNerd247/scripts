function S = toLatexString(M,frmt,preLine = [])
  S = '';
  r = rows(preLine);

  if(ischar(frmt))
    fr = 0;
  else
    fr = size(frmt);
  end

  x = y = 1;

  for i = 1:rows(M)

    if(r == 1)
      S = [S,preLine];
    elseif((r > 1) && !(i > r))
      S = [S,preLine(i,:)];
    end

    for j = 1:columns(M)
      % get the format string in matrix, row, column, or single form.
      if(fr == 0)
        p = ['%s ',frmt];
      else
        if(i <= fr(1))
          x = i;
        end

        if(j <= fr(2))
          y = j;
        end

        p  = ['%s ', frmt{x,y}];
      end

      S = sprintf(p,S,M(i,j));

      if(j != columns(M))
        S = [S,' & '];
      end
    end

    if(i != rows(M))
      S = [S,'\n \\\\ '];
    end

  end
end
