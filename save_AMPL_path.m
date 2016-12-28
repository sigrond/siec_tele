function [ output_args ] = save_AMPL_path( folder_name )
%save_AMPL_path Summary of this function goes here
%   Detailed explanation goes here
f=fopen('AMPLpath','w');

fprintf(f,'%s',folder_name);

fclose(f);

end

