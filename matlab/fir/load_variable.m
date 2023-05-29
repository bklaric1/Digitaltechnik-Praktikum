function y = load_variable (format, filename);

% function y = load_variable (format, filename)
%
% Loads data from filename into the variable y using format,
% e.g., y = load_variable ('%d', 'input.dat');

[fid, message] = fopen(filename, 'r');
if fid == -1
	disp('File error. Message returned was:')
	disp(message)
	return;
end
y = fscanf(fid, [format,'\n']);
y = y';
fclose(fid);
return;