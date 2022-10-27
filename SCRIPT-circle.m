%% Functional Data Analysis on Circle via heat kernel smoothing

% (C) 2005 Moo K. Chung
% The main objective is to match two functional data defined on a circle 
% for cross comparison that reduces spatial variability in statistical analysis.
% The dataset is published in

% [1] Hoffmann, T.J., Chung, M.K., Dalton, K.M., Alexander, A.L., Wahba, G., Davidson, R.J. 
%2004. Subpixel curvature estimation of the corpus callosum via splines and its 
%application to autism, 10th Annual Meeting of the Organization for Human Brain Mapping (OHBM)
%https://pages.stat.wisc.edu/~mchung/papers/HBM2004/HBM2004thomas.html
%
% [2] Hoffmann, T.J. 2004. Subpixel morphometric analysis of corpus callosum 
% with application to autism. BSc thesis. TR 1101. Department of Statistics, 
% University of Wisconsin-Madison.
% https://pages.stat.wisc.edu/~mchung/papers/hoffmann.2004.TR1101.pdf
%
% Created 2005 Febuary 7
% Updated 2022 July 15

%--------
%% Loading circular data of two subjects
%subject1.data %Coordinates and curvature measures of subject 1.
%subject2.data %Coordinates and curvature measures of subject 2.

load subject1.data; 
load subject2.data;

%The data consists of 3 columns. First two columns are x and y coordinates of 
% scatter points along a point on the corpus callosum boundary. 
% The last column is the curvature estimated from a quintic spline.
%
%8.0000 2.5000 -0.0764
%7.3333 3.3333 -0.0745
%6.5000 4.0000 -0.1196
%5.0000 4.5000 -0.0929
%4.5000 5.0000 -0.1081
%3.0000 5.0000 -0.1938

x1=subject1(:,1);
y1=subject1(:,2);
figure; plot(x1,y1,'-k')
hold on; plot(x1,y1,'.k')

x2=subject2(:,1);
y2=subject2(:,2);
hold on; plot(x2,y2,'-r')
hold on; plot(x2,y2,'.r')

%---------
% Cosine series representation of functional data. The method is first 
% introduced in Chung, M.K. Adluru, N., Lee, J.E., Lazar, M., 
% Lainhart, J.E., Alexander, A.L. 2010. Cosine series representation 
% of 3D curves and its application to white matter fiber bundles in 
% diffusion tensor imaging. Statistics and Its Interface  3:69-80.
% https://pages.stat.wisc.edu/~mchung/papers/chung.2010.sii.pdf

%% Arclenth parameterization
[arc_length  para]=parameterize_arclength([x1 y1]');
figure; plot(para, x1(:), '.-');
hold on; plot(para, y1(:),'.-');
legend('x-coordinates', 'y-coordinates')
figure_bigger(16); figure_bg('w')
%para is the arclenth parameteriation that is reparameterized 
%into the unit interval.

%% Heat kernel smoothing in [0,1] with kernel bandwith 0.00001
% The cosine basis is periodic basis along the circle
% However, the way we are fitting the data, it is not able to smooth
% connect the first point and the last point smoothly

Y = [x1 y1]; x=para';
[wfs beta]=WFS_COSINE(Y,x,20,0.00001);
figure;plot(x1(:),y1(:),'.-')
hold on; plot(wfs(:,1),wfs(:,2),'-r', 'LineWidth',2);
hold on; plot([wfs(end,1);wfs(1,1)], [wfs(end,2);wfs(1,2)], '-g','LineWidth',2)

%One appraoch to remedy the problem is to expand the data acorss the
%boundary as in
%Huang, S.-G., Chung, M.K., Carroll, I.C., Goldsmith, H.H. 2019 
%Dynamic functional connectivity using heat kernel. 
%IEEE Data Science Workshop (DSW), 222-226 
%https://pages.stat.wisc.edu/~mchung/papers/huang.2019.DSW.pdf


Y = [x1 y1]; x=para';
[wfs beta]=WFS_COSINE_mirror(Y,x,20,0.00001);
figure;plot(x1(:),y1(:),'.-')
hold on; plot(wfs(:,1),wfs(:,2),'-r', 'LineWidth',2);
hold on; plot([wfs(end,1);wfs(1,1)], [wfs(end,2);wfs(1,2)], '-g','LineWidth',2)

