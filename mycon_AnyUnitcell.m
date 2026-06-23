function [c,ceq] = mycon_AnyUnitcell(x)

c = -1;

% ceq = [];
% 
% for i_vec = 1 : length(x)/3
% 
%     ceq = [ ceq;     ];
%     
% end


y=x.^2;

ceq=zeros(length(y)/3,1);



for i_vec = 1 : length(y)/3
    
    ceq(i_vec)=sum( y( 3*i_vec-2 : 3*i_vec ) ) - 1;
    
end


end

