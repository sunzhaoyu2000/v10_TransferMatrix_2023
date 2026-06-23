function lambda = obj_TransferMatrix_AnyUnitcell_lambda( x, iMPS_u, num_eig )


vec_O = cell(length(iMPS_u),1);


%% length of x is   1 ~ 6*length(iMPS)

for i1 = 1 : length(iMPS_u)
   
 vec_a1  = x( 6*i1-5 : 6*i1-3 );
 vec_b1  = x( 6*i1-2 : 6*i1   );

 m  = operator_vector( vec_a1(:) );
 m1 = operator_vector( vec_b1(:) );
 
       O(:,:,1,1) = m+m1;
       O(:,:,1,2) = m1-m;    
       O(:,:,2,1) = m-m1;
       O(:,:,2,2) = m1+m;
       
       vec_O{i1} = O ./ 2;  %
    
end
       
       
% eig(T) -> figure out lambda
% -----------------------------
%num_eig = 1;
[~,eta] = rightEigenVector_eigs_TransferMatrix_AnyUnitcell(iMPS_u, vec_O, num_eig);

lambda = - abs(eta);

end