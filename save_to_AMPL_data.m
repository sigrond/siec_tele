function [ output_args ] = save_to_AMPL_data( M, name )
%save_to_AMPL_data zapisze macierz M do pliku AMPL .dat
%   name - nazwa parametru

M=int32(M);
fname = strcat(name,'.dat');
[n k] = size(M);
Z=[[1:n]' M];
a= [1:k];
fid=fopen(fname,'w');
fprintf(fid,'param %s ', name);
if(k > 1)
	fprintf(fid,':');
    fprintf(fid,'\n\t');
	fprintf(fid,'%d\t', a);
end
fprintf(fid,' := ');
for i = 1:n
    fprintf(fid,'\n');
    fprintf(fid,'%d\t', Z(i,:));
end
fprintf(fid,' ; \n \n');
fclose(fid);

end

