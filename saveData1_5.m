function [ output_args ] = saveData1_5( p, name )
%saveData1_5 zapisze p i N do pliku o nazwie name
%   name = 'dataV15.dat'

M=int32(p);
fname = strcat(name,'.dat');
[n k] = size(M);
Z=[[0:n-1]' M];
a= [0:k-1];
fid=fopen(fname,'w');
fprintf(fid,'param N = %d ;\n\n',(n-2));
fprintf(fid,'param p ');
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

