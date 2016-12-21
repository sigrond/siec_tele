function [ x ] = load_AMPL_results15( input_args )
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


fclose(f);

end

