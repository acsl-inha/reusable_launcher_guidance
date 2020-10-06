global outSim

myVideo = VideoWriter('myVideoFile'); %open video file
myVideo.FrameRate = 10;  %can adjust this, 5 - 10 works well for me
open(myVideo)
 


curve = animatedline('LineWidth',2);
set(gca,'XLim',[-200 800],'YLim',[-200 800],'ZLim',[0 800]);
view(43,24);


xlabel('N [m]')
ylabel('E [m]')
zlabel('U [m]')

hold on;
grid on;
 for i = 1: length(outSim.X_L)
     addpoints(curve,outSim.X_L(i),outSim.Y_L(i),-outSim.Z_L(i));
     head = scatter3(outSim.X_L(i),outSim.Y_L(i),-outSim.Z_L(i),'filled','MarkerFaceColor','b','MarkerEdgeColor','b');
     q =quiver3(outSim.X_L(i),outSim.Y_L(i),-outSim.Z_L(i),outSim.Thr_x_L(i) * 0.0003,outSim.Thr_y_L(i) * 0.0003,-outSim.Thr_z_L(i) * 0.0003);
     q.Color = 'red';
     q.LineWidth = 2;
     q.MaxHeadSize = 2;
     drawnow
     pause(0.05);
     frame = getframe(gcf); %get frame
     writeVideo(myVideo, frame);
     delete(q);
     delete(head);
     


 end
 
 close(myVideo)
 