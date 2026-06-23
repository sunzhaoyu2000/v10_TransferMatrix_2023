
function [x, fval] = Core_optimize_TransferMatrix_AnyUnitcell( iMPS_u, num_eig )


t_=clock;
for i1 = 1 : floor(t_(5)*60+t_(6))
aaa=random_unit_vector(1);
end

% unit_cell = 2;
% a1     b1     a2     b2
%(1 2 3. 4 5 6. 7 8 9. 10 11 12.)
unit_cell = length(iMPS_u);

for i1 = 1 : 2*unit_cell
    init_angle( 3*i1-2 : 3*i1) = random_unit_vector(1);
end

lb_angle( 1 : 3*2*unit_cell ) = -1;  %B
ub_angle( 1 : 3*2*unit_cell ) =  1;  %B



%% ===================================================================
                    
problem = createOptimProblem('fmincon','objective', ...
    @(x)obj_TransferMatrix_AnyUnitcell_lambda( x, iMPS_u, num_eig ), ...
    'x0',init_angle, ...
    'lb',lb_angle,   ...
    'ub',ub_angle,   ...
    'nonlcon', @mycon_AnyUnitcell, 'options', optimset('Algorithm','sqp','Display','off'));



[x, fval] = fmincon(problem);

fval = abs(fval);

end
