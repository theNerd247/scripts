function saveData(fpath,data)
	f = fopen(fpath,'w');
  fprintf(f,data);
  fclose(f);
end
