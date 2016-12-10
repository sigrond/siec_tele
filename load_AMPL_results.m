function [ x, d ] = load_AMPL_results( input_args )
%load_AMPL_results wczyta wyniki z pliku out
%   Detailed explanation goes here
f=fopen('out','r');
tmp0=textscan(f,'%s',1,'Delimiter','\n');
tmp1=textscan(f,'%s',1,'Delimiter','\n');
tmp2=fscanf(f,'x [*,*]\n');
tmp3=fscanf(f,': ');
[tmp4,N]=fscanf(f,'%d ');
tmp5=fscanf(f,' :=\n');
tmp6=fscanf(f,'%f ',[N+1, N]);
x=tmp6(2:N+1,:)';
tmp7=fscanf(f,';\n\n');
tmp8=fscanf(f,'d [*,*]\n');
tmp9=fscanf(f,': ');
[tmp10,tmpN]=fscanf(f,'%d ');
tmp11=fscanf(f,' :=\n');
tmp12=fscanf(f,'%f ',[N+1, N]);
d=tmp12(2:N+1,:)';

fclose(f);

end

