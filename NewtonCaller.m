function [array] = NewtonCaller(d, zoom_times, res, directions)

% DO NOT CALL THIS FUNCTION DIRECTLY, INSTEAD CALL:
    % NewtonMovie2Beat for computing mp4 file
    % NewtonFractal for computing png file

%set(0,'DefaultFigureVisible','on')
t1 = tic;
tol = .5;
n = 100;
ULcorner = [-2,2];
sqrL = 4;
array = zeros(res,res,zoom_times); % WILL PASS THIS IN ORDER TO COMPUTE MOVIE FRAMES
fprintf('Started computation of fractal 1 / %d \n', zoom_times); 
% INITIAL PICTURE OF WHOLE FRACTAL CENTERED AT (0,0) AND SQUARE LENGHT = 4
a = 2.1; % PARAMETER FOR COMPUTING GENERALIZED NEWTON FRACTAL

% RESxRES ARRAY OF INTEGERS FROM 0 TO d CORRESPONDING TO THE ROOT TO
% WHICH EACH POINT IN THE MESHGRID CONVERGES TO
[out] = NewtonFractal (a,d,n,tol,res,ULcorner,sqrL,1);


array(:,:,1) = out;
prevULcorner = ULcorner;  % ULTIMATELY REDUNDANT BUT IS GOOD TO KEEP TRACK OF WHAT WE ARE DOING 
sqrL = sqrL/2; % REDUCE LENGHT OF FRAME FOR NEXT COMPUTATION
t2 = toc(t1);
fprintf('Estimated time remaining for fractal computation: %g mins \n', t2*(zoom_times-1)/60);

% HERE WE SET UP THE PARAMETERS FOR THE COMPUTATION OF THE NEXT LEVEL OF
% ZOOM AND PROCEED TO COMPUTE IT

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