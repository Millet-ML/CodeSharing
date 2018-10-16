function [array] = myNewtonCaller(d, zoom_times, res, directions)
%set(0,'DefaultFigureVisible','on')
t1 = tic;
tol = .5;
n = 100;
ULcorner = [-2,2];
sqrL = 4;
array = zeros(res,res,zoom_times);
fprintf('Started computation of fractal 1 / %d \n', zoom_times); 
% INITIAL PICTURE OF WHOLE FRACTAL
a = 2.1;
[out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,1);
array(:,:,1) = out;
prevULcorner = ULcorner;   
sqrL = sqrL/2;
t2 = toc(t1);
fprintf('Estimated time remaining for fractal computation: %g mins \n', t2*(zoom_times-1)/60);
    for i = 2:zoom_times
        t3 = tic;
        fprintf('Started computation of fractal %d / %d \n',i,zoom_times); 
        % Fractal centered at the EXACT CENTER of the previous fractal
        if strcmp(directions(i-1),'C')
            ULcorner(1) = prevULcorner(1) + (1/2)*sqrL;
            ULcorner(2)= prevULcorner(2) - (1/2)*sqrL;
            [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,i);
            array(:,:,i) = out;
            %saveas(fig ,[pwd sprintf('/IMGS/PNGS/%s.png', titles)]);
            prevULcorner = ULcorner;            
            sqrL = sqrL/2;
        
        % Fractal centered at the center of the LEFT HALF of the previous fractal
        elseif strcmp(directions(i-1),'L')
            ULcorner(1)=prevULcorner(1);
            ULcorner(2)=prevULcorner(2) - (1/2)*sqrL;
            [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,i);
            array(:,:,i) = out;
            prevULcorner = ULcorner;
            sqrL = sqrL/2;
        
        % Fractal centered at the center of the RIGHT HALF of the previous fractal
        elseif strcmp(directions(i-1),'R')   
            ULcorner(1)=prevULcorner(1) + sqrL;
            ULcorner(2)=prevULcorner(2) - (1/2)*sqrL;
            [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,i);
            array(:,:,i) = out;
            prevULcorner = ULcorner;
            sqrL = sqrL/2;    
        
        % Fractal centered at the center of the TOP HALF of the previous fractal
        elseif strcmp(directions(i-1),'T')
            ULcorner(1)=prevULcorner(1) + (1/2)*sqrL;
            [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,i);
            array(:,:,i) = out;
            prevULcorner = ULcorner;
            sqrL = sqrL/2;
            
        % Fractal centered at the center of the BOTTOM HALF of the previous fractal
        elseif strcmp(directions(i-1),'B') 
            ULcorner(1)=prevULcorner(1) + (1/2)*sqrL;
            ULcorner(2)=prevULcorner(2) - sqrL;
            [out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,i);
            array(:,:,i) = out;
            prevULcorner = ULcorner;
            sqrL = sqrL/2;
         
        % Wrong directions input case    
        else
            sprintf('Please enter a valid set of directions to zoom into: "C", "T", "B", "L", "R" \n');
        end
        t4 = toc(t3);
        fprintf('Estimated time remaining for fractal computation: %g mins \n', t4*(zoom_times-i)/60);
    end
end