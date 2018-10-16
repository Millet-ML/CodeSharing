function myNewtonMovie(d,res, directions)
zoom_times = length(directions);
set(0,'DefaultFigureVisible','off')
array = myNewtonCaller(d,zoom_times,res, directions);
writerObj = VideoWriter(strcat('Deg_',num2str(d),'_Z_', num2str(zoom_times), '_R_', num2str(res)),'MPEG-4');
writerObj.Quality = 100;
bps = 2.0105;
modulo = 10;
writerObj.FrameRate = bps*modulo; % = BPS * mod
ULcorner= [-2,2];
sqrL=4;
open(writerObj);
%array = zeros(res,res,zoom_times);
skip_by = round(length(array)/40);
fprintf('Starting computation of movie.  \n');
fprintf('%d / %d of movie computed.  \n' ,0, num2str(zoom_times));
frames = 0;

    for i = 1:zoom_times
        t1 = tic;
        % LEFT ZOOM
        if strcmp(directions(i),'L')
            count = 1;
            for k = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                xticks([])
                yticks([])
                if mod(frames,modulo) == 0
                    imagesc(toshow(k:end-k, 1:end-2*k));
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);                    
                    frames = frames+ 1;
                else
                    imagesc(toshow); 
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
                    imagesc(toshow(h:end-h, 2*h:end));
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else
                    imagesc(toshow);
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
                    imagesc(toshow(1:end-2*h, h:end-h));
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else                    
                    imagesc(toshow); 
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
                    imagesc(toshow(2*h:end, h:end - h));
                    xticks([])
                    yticks([])
                    colormap jet;
                    drawnow;
                    frame = getframe(gcf);
                    writeVideo(writerObj, frame);
                    frames = frames+ 1;
                else
                    imagesc(toshow); 
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
                toshow = array(:,:,i); % the arra
                figure
                    if mod(frames,modulo) == 0
                        imagesc(toshow(j:end-j,j:end-j));
                        xticks([])
                        yticks([])
                        colormap jet;
                        drawnow;
                        frame = getframe(gcf);
                        writeVideo(writerObj, frame);
                        frames = frames+ 1;
                    else
                        imagesc(toshow);
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
    close(writerObj);
    clear
end    
