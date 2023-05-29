function [y, shift] = truncate (x, b, w_out, w_in)

% function [y, shift] = truncate (x, b, w_out, w_in)
% Determines the dynamic range defined by impulse response b (integer) and
% truncates to w_out bit by proper shifting. Parameter shift shows the
% number of bits that were removed (LSBs). 

% w_dyn = ceil(log2(max(abs(x)))) + 1;
w_dyn = w_in + ceil(log2(sum(abs(b))));
disp (['Output wordlength required: ' num2str(w_dyn)]);
shift = w_dyn - w_out;
if shift >= 0	
 	xs = floor(x/2^shift);
else
    xs = x;
 	disp ('Negative shift is not possible!');
end
disp (['Output wordlength after shift: ' num2str(w_out)]);
disp (['Output dynamic after shift: ' num2str(ceil(log2(max(abs(xs))))+1)]);
y = xs;