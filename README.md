### Functional Data Analysis on Circle via Heat Kernel Smoothing

The main objective is to match two functional data (corpus callosum boundaries) defined on a circle for cross comparison that reduces spatial variability in statistical analysis. The dataset came from studies

[1] Chung, M.K., Robbins,S., Dalton, K.M., Davidson, Alexander, A.L., R.J., Evans, A.C. 2005. Cortical thickness analysis in autism via heat kernel 
smoothing. NeuroImage 25:1256-1265 https://pages.stat.wisc.edu/~mchung/papers/ni_heatkernel.pdf

[2] Hoffmann, T.J., Chung, M.K., Dalton, K.M., Alexander, A.L., Wahba, G., Davidson, R.J. 2004. Subpixel curvature estimation of the corpus callosum via splines and its application to autism, 10th Annual Meeting of the Organization for Human Brain Mapping (OHBM). https://pages.stat.wisc.edu/~mchung/papers/HBM2004/HBM2004thomas.html

Run script SCRIPT-circle.m. Heat kernel smoothing in [0,1] with kernel bandwith 0.00001 is shown below. The method smooths most of curve segements excpet betwen the segment betewen the first and the last points (green segment). The cosine basis is periodic basis along the circle. However, the way we are fitting the data, we are not able to smooth
and connect the first point and the last point smoothly.

![alt text](https://github.com/laplcebeltrami/circle/blob/main/CC.jpg?raw=true)

One way to remedy the problem is connecting data across the start and end points as in Huang, S.-G., Chung, M.K., Carroll, I.C., Goldsmith, H.H. 2019 Dynamic functional connectivity using heat kernel. IEEE Data Science Workshop (DSW), 222-226
https://pages.stat.wisc.edu/~mchung/papers/huang.2019.DSW.pdf

However, it is not working. See if you can find the quick-fix to the problem.


(C) 2005- Moo K. Chung
University of Wisconsin-Madison
