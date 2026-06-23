function O = MatrixProductOperator(vec_a,vec_a1,i_site, start_site, end_site  )

% See MPO markdown for details.

   m  = operator_vector(vec_a (:));
   m1 = operator_vector(vec_a1(:));

   if i_site == start_site  %                        [O===============================================]
       
       %O = [m,m1];       
       %O=reshape(O,[2 2 1 2]);
       O(:,:,1,1) = m ;
       O(:,:,1,2) = m1;
       
   elseif i_site > start_site && i_site < end_site % [======================O=========================]
   
       %O = [m+m1, m1-m;      ...
       %     m-m1, m1+m] ./ 2;        
       %O=reshape(O,[2 2 2 2]); 
       
       O(:,:,1,1) = m+m1;
       O(:,:,1,2) = m1-m;    
       O(:,:,2,1) = m-m1;
       O(:,:,2,2) = m1+m;
       
       O = O ./ 2;
       
   elseif i_site == end_site  %                      [===============================================O]
     %  For Mn ---------
       %O = [m+m1;      ...
       %     m-m1] ./ 2;         
       %O=reshape(O,[2 2 2 1]); 
       O(:,:,1,1) = m+m1;
       O(:,:,2,1) = m-m1;  
       
       O = O ./ 2;
         
     %  For Mn'  -------  
     %  O = [m1-m;       ...
     %       m1+m] ./ 2 ;
      
     %  For Sn  --------
     %  O = [m1;       ...
     %       m  ] ./ 2^(1/2) ;  
       
   end
        
 

end