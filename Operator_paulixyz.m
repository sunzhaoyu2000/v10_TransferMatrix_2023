% paulixyz   Pauli matrices
%   Defines x,y,z and e as the 2x2 Pauli spin
%   matrices and the identity.

x=operator([0 1;1 0]);
y=operator(-[0 1i;-1i 0]); 
z=operator([1 0; 0 -1]);
e=operator([1 0; 0 1]);


