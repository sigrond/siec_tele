function [ output_args ] = saveData2( p,kos,kar,cen,name )
%saveData2 zapisze do name.dat dane dla modelu V2
%   Detailed explanation goes here

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

M=int32(kos);
[n k] = size(M);
Z=[[0:n-1]' M];
a= [0:k-1];
fprintf(fid,'param kos ');
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

M=int32(kar);
[n k] = size(M);
Z=[[0:n-1]' M];
a= [0:k-1];
fprintf(fid,'param kar ');
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

M=int32(cen);
[n k] = size(M);
Z=[[0:n-1]' M];
a= [0:k-1];
fprintf(fid,'param cen ');
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

