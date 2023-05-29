function save_variable (var, format, filename)

% function save_variable (var, format, filename)
%
% Saves a variable var to filename using format,
% e.g., save_variable (x, '%d', 'input.dat');

[fid, message] = fopen(filename, 'w');
if fid == -1
	disp('File error. Message returned was:')
	disp(message)
	return
end
fprintf(fid, [format,'\n'], var);
fclose(fid);
return;
