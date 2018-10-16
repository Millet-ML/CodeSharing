function NewtonMovie2Beat(d,res, directions)

% TO CALL FUNCTION, SELECT:
    % d = REAL NUMBER, DEGREE OF POLYNOMIAL OF THE FORM f(x) = x^d-1
    % res = INTEGER, RESOLUTION OF THE RESULTING VIDEO (res x res)
    % directions = STRING,(CAPS) IN-ORDER DIRECTIONS OF WHERE TO ZOOM IN
        % L for left zoom, R for right zoom, T for top zoom, B for bottom
        % zoom, C for center zoom
    % EXAMPLE: NewtonMovie(7,100,'LLTRCB') This would zoom in six times   

zoom_times = length(directions);   % THE NUMBER OF TIMES WILL WE BE ZOOMING IN
set(0,'DefaultFigureVisible','off')  
array = NewtonCaller(d,zoom_times,res, directions); %3D ARRAY, DIMS: RESxRESxZOOM_TIMES

% INITIALIZE VIDEO OBJECT AND SET PARAMETERS
writerObj = VideoWriter(strcat('Deg_',num2str(d),'_Z_', num2str(zoom_times), '_R_', num2str(res)),'MPEG-4');
writerObj.Quality = 100;
bps = 2.0105; % BEATS PER SECOND
modulo = 10;
writerObj.FrameRate = bps*modulo;
ULcorner= [-2,2];
sqrL=4;
open(writerObj);
%array = zeros(res,res,zoom_times); FOR TESTING PURPOSES
skip_by = round(length(array)/40);
fprintf('Starting computation of movie.  \n');
fprintf('%d / %d of movie computed.  \n' ,0, num2str(zoom_times));
frames = 0;

% BEGIN RENDERING AND CAPTURING FRAMES
    for i = 1:zoom_times
        t1 = tic; % START RECORDING TIME IN ORDER TO GIVE USER APPROXIMATE COMPUTING TIME 
        % LEFT ZOOM
        if strcmp(directions(i),'L')
            count = 1;
            for k = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                xticks([])
                yticks([])
                if mod(frames,modulo) == 0
                    imagesc(toshow); 
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);                    
                    frames = frames+ 1;
                else
                    imagesc(toshow(k:end-k, 1:end-2*k));
                    
                    xticks([])
                    yticks([])
                    colormap parula;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                end     
                count = count+1;
            end    
            ULcorner(1) = ULcorner(1) + (1/2)*sqrL;
            ULcorner(2) = ULcorner(2) - (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
            
        % RIGHT ZOOM    
        elseif strcmp(directions(i),'R')  
            count = 1;
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                 
                
                if mod(frames,modulo) == 0
                    imagesc(toshow);
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else
                    imagesc(toshow(h:end-h, 2*h:end));
                    
                    xticks([])
                    yticks([])
                    colormap parula;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                end     
                count = count+1;
            end    
            ULcorner(2) = ULcorner(2) - (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
            
        % TOP ZOOM    
        elseif strcmp(directions(i),'T')  
            count = 1;
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                
                if mod(frames,modulo) == 0
                    imagesc(toshow); 
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else        
                    imagesc(toshow(1:end-2*h, h:end-h));                    
                    xticks([])
                    yticks([])
                    colormap parula;
                    drawnow;
                    frame = getframe(gcf);                    
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                end     
                count = count+1;
            end    
            ULcorner(1) = ULcorner(1) + (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
        
        % BOTTOM ZOOM    
        elseif strcmp(directions(i),'B')  
            count = 1;
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                
                if mod(frames,modulo) == 0
                    imagesc(toshow);
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else
                    imagesc(toshow(2*h:end, h:end - h));                     
                    xticks([])
                    yticks([])
                    colormap parula;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                end
                count = count+1;                
                
            end 
            ULcorner(1) = ULcorner(1) + (1/4)*sqrL;
            ULcorner(2) = ULcorner(2) - (1/2)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden    
            
        % CENTER ZOOM    
        elseif strcmp(directions(i),'C')
            count = 1;
            for j = 1:skip_by:length(array)/4 % too slow if we do pixel by pixel in large resolution
                toshow = array(:,:,i); 
                figure
                    if mod(frames,modulo) == 0
                        imagesc(toshow);
                        xticks([])
                        yticks([])
                        colormap jet;
                        drawnow;
                        frame = getframe(gcf);
                        writeVideo(writerObj, frame);
                        frames = frames+ 1;
                    else
                        imagesc(toshow(j:end-j,j:end-j));                        
                        xticks([])
                        yticks([])
                        colormap parula;
                        drawnow;
                        frame = getframe(gcf);
                        writeVideo(writerObj, frame);
                        frames = frames+ 1;
                    end
                count = count+1;
            end
            ULcorner(1) = ULcorner(1) + (1/4)*sqrL;
            ULcorner(2)= ULcorner(2)/2;
            sqrL = sqrL/2;            
            close all
            close all hidden
        end 
      fprintf('%d / %d of movie computed. \n' ,i, zoom_times); 
      fprintf('Estimated total time remaining: %g mins \n',toc(t1)*(zoom_times - i)/60);
    end
    close(writerObj); % CLOSE MOVIE OBJECT, TERMINATE PROCESS
    clear
end    
