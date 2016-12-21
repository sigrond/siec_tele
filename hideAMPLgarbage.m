function [ B ] = hideAMPLgarbage( A )
%hideAMPLgarbage zmienie w macierzy pola prawie zerowe na zerowe
%   Detailed explanation goes here

L=abs(A)>1e-6;
B=A.*L;

end

