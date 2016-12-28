function [ p, kos, kar, cen ] = load_from_AMPL_data( fname )
%load_from_AMPL_data wczyta dane z pliku .dat
%   bez gwarancji idiotoodpornoœci
f=fopen(fname,'r');
N=fscanf(f,'param N %*[:=] %d ;\n',1);
fscanf(f,'param p :\n',1);
tmp1=fscanf(f,'\t%d',[N+2]);
fscanf(f,' :=\n',1);
tmp2=fscanf(f,'%d ',[N+3, N+2]);
p=tmp2(2:N+3,:)';
fscanf(f,';\n\n param kos :\n',1);
tmp1=fscanf(f,'\t%d',[N+2]);
fscanf(f,' :=\n',1);
tmp2=fscanf(f,'%d ',[N+3, N+2]);
kos=tmp2(2:N+3,:)';
fscanf(f,';\n\n param kar :\n',1);
tmp1=fscanf(f,'\t%d',[N+2]);
fscanf(f,' :=\n',1);
tmp2=fscanf(f,'%d ',[N+3, N+2]);
kar=tmp2(2:N+3,:)';
fscanf(f,';\n\n param cen :\n',1);
tmp1=fscanf(f,'\t%d',[N+2]);
fscanf(f,' :=\n',1);
tmp2=fscanf(f,'%d ',[N+3, N+2]);
cen=tmp2(2:N+3,:)';


tmp0=fscanf(f,'%s');



fclose(f);
end

