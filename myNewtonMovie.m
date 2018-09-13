function myNewtonMovie(d,res, directions)
zoom_times = length(directions);
set(0,'DefaultFigureVisible','off')
array = myNewtonCaller(d,zoom_times,res, directions);
writerObj = VideoWriter(strcat('Deg_',num2str(d),'_Z_', num2str(zoom_times), '_R_', num2str(res)),'MPEG-4');
writerObj.Quality = 100;
writerObj.FrameRate = 10;
ULcorner= [-2,2];
sqrL=4;
open(writerObj);
skip_by = 6;
fprintf('Starting computation of movie.  \n');
fprintf('%d / %d of movie computed.  \n' ,0, num2str(zoom_times)); 
    for i = 1:zoom_times
        t1 = tic;
        % LEFT ZOOM
        if strcmp(directions(i),'L')
            for k = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                imagesc(toshow(k:end-k, 1:end-2*k)); 
                
                xticks([1 res]);
                yticks([1 res]);
                xticklabels({num2str(ULcorner(1)), num2str(ULcorner(1)+sqrL)});
                yticklabels({num2str(ULcorner(2)), num2str(ULcorner(2)-sqrL)});                               
                colormap parula
                drawnow;
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
            end    
            ULcorner(1) = ULcorner(1) + (1/2)*sqrL;
            ULcorner(2) = ULcorner(2) - (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
            
        % RIGHT ZOOM    
        elseif strcmp(directions(i),'R')   
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                imagesc(toshow(h:end-h, 2*h:end)); 
                
                xticks([1 res]);
                yticks([1 res]);
                xticklabels({num2str(ULcorner(1)), num2str(ULcorner(1)+sqrL)});
                yticklabels({num2str(ULcorner(2)), num2str(ULcorner(2)-sqrL)});
                colormap parula
                drawnow;
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
            end    
            ULcorner(2) = ULcorner(2) - (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
            
        % TOP ZOOM    
        elseif strcmp(directions(i),'T')  
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                imagesc(toshow(1:end-2*h, h:end-h)); 
                
                xticks([1 res]);
                yticks([1 res]);
                xticklabels({num2str(ULcorner(1)), num2str(ULcorner(1)+sqrL)});
                yticklabels({num2str(ULcorner(2)), num2str(ULcorner(2)-sqrL)});    
                colormap parula
                drawnow;
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
            end    
            ULcorner(1) = ULcorner(1) + (1/4)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden
        
        % BOTTOM ZOOM    
        elseif strcmp(directions(i),'B')   
            for h = 1:skip_by:length(array)/4              
                toshow = array(:,:,i);
                figure
                imagesc(toshow(2*h:end, h:end - h)); 
                
                xticks([1 res]);
                yticks([1 res]);
                xticklabels({num2str(ULcorner(1)), num2str(ULcorner(1)+sqrL)});
                yticklabels({num2str(ULcorner(2)), num2str(ULcorner(2)-sqrL)});
                colormap parula
                drawnow;
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
            end 
            ULcorner(1) = ULcorner(1) + (1/4)*sqrL;
            ULcorner(2) = ULcorner(2) - (1/2)*sqrL;
            sqrL = sqrL/2;
            close all
            close all hidden    
            
        % CENTER ZOOM    
        elseif strcmp(directions(i),'C')      
            for j = 1:skip_by:length(array)/4
                toshow = array(:,:,i);
                figure

                imagesc(toshow(j:end-j,j:end-j));
                xticks([1 res]);
                yticks([1 res]);
                xticklabels({num2str(ULcorner(1)), num2str(ULcorner(1)+sqrL)});
                yticklabels({num2str(ULcorner(2)), num2str(ULcorner(2)-sqrL)});
                colormap parula
                drawnow;
                frame = getframe(gcf);
                writeVideo(writerObj, frame);
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
    clc
end    
