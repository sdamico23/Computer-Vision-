function [p2, p4] = projectToPointFrame(mocapFnum)

%performs the projection from world to pixel at the specified frame of the
%mocap
% each joint has 30,000 frames 
    load('Subject4-Session3-Take4_mocapJoints.mat', 'mocapJoints')
     load('vue2CalibInfo.mat', 'vue2')
    load('vue4CalibInfo.mat', 'vue4')

       onearray = ones(1,12);
       % get x, y, z coordinates
       
       if (sum(mocapJoints(mocapFnum,:,4))~= 12)
           p2 = zeros(3,12);
           p4 = zeros(3,12);
           return
       end
       
       coords = [mocapJoints(mocapFnum,:,1); mocapJoints(mocapFnum,:,2); mocapJoints(mocapFnum,:,3); onearray];
       % get p matrix and k matrix
       pmat2 = vue2.Pmat;
       kmat2 = vue2.Kmat;

       % using K, P, Pw equation 
       p2 = kmat2 * pmat2 * coords;
       
       lambda2 = p2(3,:);
       p2 = p2./lambda2;

       pmat4 = vue4.Pmat;
       kmat4 = vue4.Kmat;


       p4 = kmat4 * pmat4 * coords;
       lambda4 = p4(3,:);
       p4 = p4./lambda4;
%     colors = ['r', 'b', 'm', 'y', 'g', 'c', 'w', 'k', 'r', 'b', 'm', 'y'];
%     % test points from camera vue2
%     figure(1)
%     %initialization of VideoReader for the vue video.
%     %YOU ONLY NEED TO DO THIS ONCE AT THE BEGINNING
%     filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
%     vue2video = VideoReader(filenamevue2mp4);
%     %now we can read in the video for any mocap frame mocapFnum.
%     %the (50/100) factor is here to account for the difference in frame
%     %rates between video (50 fps) and mocap (100 fps).
%     vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
%     vid2Frame = readFrame(vue2video);
%     image(vid2Frame)
%     axis on;
%     hold on;
%     for i = 1:12
%         plot(p2(1,i),p2(2,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
%     end
% 
%     % test points from camera vue4
%     figure(2)
%     filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';
%     vue2video = VideoReader(filenamevue2mp4);
%     vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
%     vid2Frame = readFrame(vue2video);
%     image(vid2Frame)
%     axis on;
%     hold on;
%     for i = 1:12
%         plot(p4(1,i),p4(2,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
%     end
end

