clear
clc
restoredefaultpath;

%Root_QuantumNetwork = '~/Software/QuantumNetwork/QuantumInformation/MultipartiteNonlocality/v10_TransferMatrix_2023/';

%path(path,[Root_QuantumNetwork,'/home/c2019/2021_S_vs_n/v8_NonlocalityMPO_MPOpurification_LTR_X_test_TM/']);
%path(path,[Root_QuantumNetwork,'/home/c2019/2021_S_vs_n/v8_NonlocalityMPO_MPOpurification_LTR_X_test_TM/LeftMost']);
%path(path,[Root_QuantumNetwork,'/home/c2019/2021_S_vs_n/v8_NonlocalityMPO_MPOpurification_LTR_X_test_TM/RightMost']);
%path(path,[Root_QuantumNetwork,'/home/c2019/2021_S_vs_n/v8_NonlocalityMPO_MPOpurification_LTR_X_test_TM/Middle']);
Root_QuantumNetwork = './';

path(path,[Root_QuantumNetwork]);
path(path,[Root_QuantumNetwork,'./Tool_LandR_iMPS']);
 
format short

t_=clock;
for i1 = 1 : floor(t_(5)*60+t_(6))
aaa=random_unit_vector(1);
end
random_unit_vector(1)


%% 
%%      load iMPS.mat
%%      unit_cell=4; %length(iMPS);
%%      %[43x2x30 double]    [30x2x31 double]    [31x2x30 double]    [30x2x43 double]
%%      iMPS_u = iMPS; clear iMPS;


iMPS

A = MPS{1,1};
A = permute(A,[1 3 2]);

iMPS_u{1}=A;
iMPS_u{2}=A;
iMPS_u{3}=A;
iMPS_u{4}=A;

length(iMPS_u)



%%
%% iMPS_u: an iMPS with any unit cell.
%% For instance, -A-A-A-A-, -A-B-A-B-, -A-B-C-D-
%% the function will optimize all these types automatically !
%% 
%% Waring: 
%% The shape of the local tensors need to be D1*2*D2 !
%% 


[Left , etaL] =  leftEigenVector_eigs_iMPS( iMPS_u );
[Right, etaR] = rightEigenVector_eigs_iMPS( iMPS_u );
     

     
     

%%��2�� save main data



multi_ini = 10;

%fval = zeros(multi_ini,1);

x_final = [];
f_final = -999;

num_eig  = 1;
num_eig6 = 6;








if exist("T_data.mat")
	load T_data.mat
	start_job = length(Res)+1;
else
	start_job = 1;
end







for i1 = start_job : multi_ini
    
i1

[ x0, fval ] = Core_optimize_TransferMatrix_AnyUnitcell( iMPS_u, num_eig );
fval

vector_lambda = TransferMatrix_AnyUnitcell_lambda( x0, iMPS_u, num_eig6 );

Res{i1}.vector_ab = x0;

Res{i1}.lambda    = vector_lambda;

save T_data.mat  Left Right Res

end





%   method:
%
%   load T_spectrum.mat 
%
%   Res{3}.lambda
%   Res{3}.lambda(1)
%   ...
%   Res{3}.lambda(6)
% 
% 



%%��3��  analyze Res{3}.lambda and figure out  abs( lambda )

% For all lambda,
% choose the best one and use a number to estiate the reliability of the
% result.

i1_mark = -9;
v_final   = -99;

for i1 = 1 : multi_ini
    
    y1 = abs( Res{i1}.lambda(1) );
    
    if y1 > v_final
        
        i1_mark = i1;
        v_final = y1;
        
    end
    
end


v_abs_lambda  = abs( Res{i1_mark}.lambda );

v_abs_lambda_ = v_abs_lambda ./ norm(v_abs_lambda); 

total = 0;


figure

for i1 = 1 : multi_ini
    
    y1 = abs( Res{i1}.lambda ); y1 = y1 ./ norm( y1 );
    subplot(2,1,1)
    plot(i1, y1(1), 'o'); hold on; plot(i1, y1(2), 'x'); hold on; plot(i1, y1(3), 'o'); hold on; plot(i1, y1(4), 'x'); hold on; plot(i1, y1(5), 'o'); hold on; plot(i1, y1(6), 'x'); hold on;
    
    subplot(2,1,2)
    plot(i1, y1' * v_abs_lambda_, 'o');hold on;
    
    total = total + y1' * v_abs_lambda_;
    
end

print(gcf, '-dpdf', 'spectr.pdf')

close all


total = total ./ multi_ini;

save lambda.mat v_abs_lambda total multi_ini


