function [arc_length  para]=parameterize_arclength(tract)
% function [length  para]=parameterize_arclength(tract)
%
% Computes the arc length and perform the arclength parameterization and then 
%          reparameterize to unit interval
%
% The method is based on Chung, M.K. Adluru, N., Lee, J.E., Lazar, M., 
% Lainhart, J.E., Alexander, A.L. 2010. Cosine series representation 
% of 3D curves and its application to white matter fiber bundles in 
% diffusion tensor imaging. Statistics and Its Interface  3:69-80.
%https://pages.stat.wisc.edu/~mchung/papers/chung.2010.sii.pdf
%
%
% INPUT
% tract : 3 x n_vertex or 2 x n_vertex coordinates
%
% OUTPUT
% arc_length: total arc length
% para  : number between 0 and 1 that maps the track to a unit interval.
%
% The code is downloaded from
% https://github.com/laplcebeltrami/circle
% http://brainimaging.waisman.wisc.edu/~chung/tracts/
%
% (C) 2008- Moo K. Chung & Nagesh Adluru
%     mkchung@wisc.edu
%     University of Wisconsin-Madison
%
% Update history
% 2008 created Chung
% 2009 optimized Adluru
% 2010 comments added Chung
% 2022 July 15 updated Chung

n_vertex=size(tract,2);
% n_vertex >=2 in order for this function to work.

p0=tract(:,1:(n_vertex-1));
p1=tract(:,2:n_vertex);
disp=p1-p0;
%January 22, 2009.
%Nagesh Adluru.
%Now computes directly: no function call overhead.
%L2=L2norm(disp');
L2=sqrt(sum(disp'.^2,2));

arc_length=sum(L2);
%length=0; % length up to the i-th vertex.
%para=zeros(1,n_vertex);
% for i=1:(n_vertex-1)
%     length=length + L2(i);
%     para(i+1)=  length/arc_length;
% end;

%January 21, 2009.
%Nagesh Adluru.
%Removing the above for-loop.
cum_len=cumsum(L2)/arc_length;
para=zeros(1,n_vertex);
para(2:end)=cum_len';

