function [xc1_shifted,yc1_shifted]=locating_target1_fun(I,row_p,col_p,bk_size_0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% centroid of a single target near a selected location in pixels.
% 
% Inputs:
%       (1) 'I', image intensity field 
%       (2) '(row_p,col_p)', row and column picked (clicked) for centroiding
%       (3) 'bk_size_0', bolck size for initial searching a target (such as 10 pixels)
%
% Outputs:
%       [xc1_shifted,yc1_shifted], calculated target centroids in pixels
%
% Developed by Western Michigan University for NASA Langley Research Center
% Email: tianshu.liu@wmich.edu or aburner@cox.net to report bugs or suggest improvements
% Version date: August 28, 2006
% Primary author: Tianshu Liu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


k=1;
while (k<=20)  
% give initial neighbourhood around the target
	    neighb_0=I((row_p-bk_size_0):(row_p+bk_size_0),(col_p-bk_size_0):(col_p+bk_size_0));
	    neighb_d_0=double(neighb_0);

% initial centroid estimate
	    [xc0,yc0]=centroid_cal_fun(neighb_d_0);
   
% refine the neighbourhood
		x_cut=neighb_d_0(round(yc0),:);
		[bd_x,i_x]=min(x_cut);
		bk_size_x_1=round(abs(double(i_x)-xc0));
	
		y_cut=neighb_d_0(:,round(xc0));
		[bd_y,i_y]=min(y_cut);
		bk_size_y_1=round(abs(double(i_y)-yc0));
	
		b_row_1=round(row_p-bk_size_0+yc0-bk_size_y_1);
		b_row_2=round(row_p-bk_size_0+yc0+bk_size_y_1);
		b_col_1=round(col_p-bk_size_0+xc0-bk_size_x_1);
		b_col_2=round(col_p-bk_size_0+xc0+bk_size_x_1);

		neighb_1=I(b_row_1:b_row_2,b_col_1:b_col_2);
	
		neighb_1d=double(neighb_1);

% substrating the background
		Imax=max(max(neighb_1d));
		Imin=min(min(neighb_1d));
		dI=Imax-Imin;
		I_low=Imin+dI*0.5;
		I_high=Imax;
		neighb_1_cut=neighb_1d-I_low;

% generate a normalizaed neighbourhood image whose value is between 0 and 1
		neighb_norm=roicolor(neighb_1_cut,0,I_high);
		neighb_norm1=double(neighb_norm);
		neighb_new=neighb_1d.*neighb_norm1;

% refined centroid estimate
		[xc1,yc1]=centroid_cal_fun(neighb_new);
        
   
% final centroid coordinates in the entire image
        % shifted coordinates in the whole image
        xc1_shifted=b_col_1+xc1-1; % -1 pixel shift is needed
        yc1_shifted=b_row_1+yc1-1; % -1 pixel shift is needed

        % refine the intial position and block size
        col_p=round(xc1_shifted);
        row_p=round(yc1_shifted);
        bk_size=max([bk_size_x_1;bk_size_y_1]);   
        k=k+1;
end


