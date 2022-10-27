function [wfs beta]=WFS_COSINE_mirror(Y,x,k,sigma)
% function [wfs beta]=WFS_COSINE_mirror(Y,x,k,sigma)
%
% Construct the k-th degree weighted cosine  series (WFS)
% representation on functional data Y(x) on interval [0 1] with 
% periodic constraint at the end point such that Y(0) = Y(1). 
% This can be achieved by connecting basis in [0, 0.5] and [0.5 1] as mirror
% relection. To squeeze basis in [0,1] into [0, 0.5], need to multifly
% argument of basis by 2. 
%
% The method is equivalent to performing heat kernel smoothing with 
% bandwidth sigma. If sigma = 0, we have the usaul cosine Fourier 
% series expansion.
%
% Y    : function value to smooth out. It can be a collection of functions 
%        in a matrix form: # of points x # of features
% x    : domain of function Y. dimension of Y match that of X. It should be
%        a vector of size # of points x 1.
% k    : degree of expansion
% sigma: amount of smoothing
%
% The technical detail and explanation on paramters are given in [1] and [2].
% 
% [1] Chung, M.K., Adluru, N., Lee, J.E., Lazar, M.,Lainhart, J.E., Alexander, A.L.
%     2010. Cosine series representation of 3D curves and its application to white 
%     matter fiber bundles in diffusion tensor imaging. Statistics and Its Interface. 
%     3:69-80. http://www.stat.wisc.edu/~mchung/papers/chung.2010.SII.pdf
%
% [2] Chung, M.K., Singh, V., Kim, P.T., Dalton, K.M., Davidson, R.J. 2009.
%     Topological characterization of signal in brain images using the min-max diagram.
%     12th International Conference on Medical Image Computing and Computer Assisted 
%     Intervention (MICCAI). Lecture Notes in Computer Science (LNCS). 5762:158-166.
%     http://www.stat.wisc.edu/~mchung/papers/miccai.2009.pdf 
%
% The above paper uses cosine basis only. For both sine and cosine basis
% together, see
%
% Wang, Y., Ombao, H., Chung, M.K. 2018 Topological data analysis of 
% single-trial electroencephalographic signals. Annals of Applied Statistics, 12:1506-1534
% https://pages.stat.wisc.edu/~mchung/papers/wang.2018.annals.pdf
%
% (C) 2008 Zijian Chen, Moo K. Chung
%     mkchung@wisc.edu
%     University of Wisconsin-Madison
%
%     Histroy: 2008 created
%              2015 June 30 Input matrix data  
%              2022 July 15 updated
%              2022 Oct. 27 Zijian Chen's mirror reflection 

%n_vertex=length(Y);
n_vertex=size(Y,1);

%Squeeze the domain [0,1] of basis into [0, 0.5] and 
% connect them over [0, 0.5] and [0.5, 1]. 
% l-th cosine basis
psi1=inline('sqrt(2)*cos(pi*l.*x./0.5)');
% To add additional sine basis
psi2=inline('sqrt(2)*sin(pi*l.*x./0.5)');
%% CHECK IF they are orthonormal basis or not. 


%Y= psi*beta
% inv(psi)*Y = psi \ Y= beta

% design matrix of cosine basis
 DX1=[];
 for l=0:k
     psi=psi1(l,x);
     DX1=[DX1 psi];
end

% design matrix of sine basis
 DX2=[];
 for l=1:k
    psi=psi2(l,x);
    DX2=[DX2 psi];
 end

%DX=DX1; % n_vertex x # k number of basis
DX=[DX1 DX2];

%Solve matrix equation Y = DX*beta using the least squares estimation
%DX'*Y = D
beta=pinv(DX'*DX)*DX'*Y; %# k number of basis x # of features (columns of Y)
%weight=diag(exp(-[0:k]'.^2*pi^2*sigma)); %square matrix of heat kernel weights (k x k)
weight =diag([exp(-[0:k]'.^2*pi^2*sigma./0.5^2) ;exp(-[1:k]'.^2*pi^2*sigma./0.5^2)]); %add this line for cosine + sine basis
wfs=DX*(weight*beta); %smoothed out data. Size of wfs should be indentical to input Y


