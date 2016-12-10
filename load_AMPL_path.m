function [ full_path ] = load_AMPL_path( input_args )
%load_AMPL_path wczytanie œcie¿ki do AMPL'a z pliku
%   Detailed explanation goes here
f=fopen('AMPLpath','r');
full_path=textscan(f,'%s','Delimiter','\n');

fclose(f);

end

