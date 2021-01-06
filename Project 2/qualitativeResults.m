%load the files
load('Subject4-Session3-Take4_mocapJoints.mat', 'mocapJoints')
load('vue2CalibInfo.mat', 'vue2')
load('vue4CalibInfo.mat', 'vue4')

onearray = ones(1,12);

%get 3D coordinates for each joint in frame
mocapFnum = 22866;
coords = [mocapJoints(mocapFnum,:,1); mocapJoints(mocapFnum,:,2); mocapJoints(mocapFnum,:,3); onearray];
%create the skeleton for 3D 
figure(1)
title('Input 3D Data (black) and Reconstructed Data (red)')
%filenamemp4 = 'Subject4-Session3-Take4_mocapJoints.mat';
%video = VideoReader(filenamemp4);

%now we can read in the video for any mocap frame mocapFnum.
%the (50/100) factor is here to account for the difference in frame
%rates between video (50 fps) and mocap (100 fps).
%video.CurrentTime = (mocapFnum-1)*(50/100)/video.FrameRate;
%vidFrame = readFrame(video);
%image(vidFrame)
axis on;
hold on;
colors = ['r', 'b', 'm', 'y', 'g', 'c', 'k', 'k', 'r', 'b', 'm', 'y'];
%plot each 3D point
for i = 1:12
 plot3(coords(1,i),coords(2,i), coords(3,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
end
%shoulder to elbow
plot3([coords(1, 1), coords(1,2)],[coords(2,1),coords(2,2)],[coords(3,1), coords(3,2)],'k-')
plot3([coords(1, 4), coords(1,5)],[coords(2,4),coords(2,5)],[coords(3,4), coords(3,5)],'k-')
%elbow to wrist
plot3([coords(1, 2), coords(1,3)],[coords(2,2),coords(2,3)],[coords(3,2), coords(3,3)],'k-')
plot3([coords(1, 4), coords(1,6)],[coords(2,5),coords(2,6)],[coords(3,5), coords(3,6)],'k-')
%hip to knee
plot3([coords(1, 7), coords(1,8)],[coords(2,7),coords(2,8)],[coords(3,7), coords(3,8)],'k-')
plot3([coords(1, 10), coords(1,11)],[coords(2,10),coords(2,11)],[coords(3,10), coords(3,11)],'k-')
%knee to ankle
plot3([coords(1, 8), coords(1,9)],[coords(2,8),coords(2,9)],[coords(3,8), coords(3,9)],'k-')
plot3([coords(1, 11), coords(1,12)],[coords(2,11),coords(2,12)],[coords(3,11), coords(3,12)],'k-')
%hip to shoulder
plot3([coords(1, 1), coords(1,7)],[coords(2,1),coords(2,7)],[coords(3,1), coords(3,7)],'k-')
plot3([coords(1, 4), coords(1,10)],[coords(2,4),coords(2,10)],[coords(3,4), coords(3,10)],'k-')
%shoulder to shoulder
plot3([coords(1, 1), coords(1,4)],[coords(2,1),coords(2,4)],[coords(3,1), coords(3,4)],'k-')
%hip to hip
plot3([coords(1, 7), coords(1,10)],[coords(2,7),coords(2,10)],[coords(3,7), coords(3,10)],'k-')

%spine: midpoint of shoulders to midpoint of hip 
midshoulder =( coords(1:3,4) + coords(1:3,1))/2;
midhip = ( coords(1:3,7) + coords(1:3,10))/2;
plot3([midshoulder(1), midhip(1)], [midshoulder(2),midhip(2)],[midshoulder(3),midhip(3)],'k-')

% project points to camera vue2
figure(2)
%initialization of VideoReader for the vue video.
%YOU ONLY NEED TO DO THIS ONCE AT THE BEGINNING
filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
vue2video = VideoReader(filenamevue2mp4);
%now we can read in the video for any mocap frame mocapFnum.
%the (50/100) factor is here to account for the difference in frame
%rates between video (50 fps) and mocap (100 fps).
[p2, p4] = projectToPointFrame(mocapFnum);
vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);
image(vid2Frame)
axis on;
hold on;
title('Vue2 2D')
for i = 1:12
plot(p2(1,i),p2(2,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
end
%shoulder to elbow
plot([p2(1, 1), p2(1,2)],[p2(2,1),p2(2,2)],'w-')
plot([p2(1, 4), p2(1,5)],[p2(2,4),p2(2,5)],'w-')
%elbow to wrist
plot([p2(1, 2), p2(1,3)],[p2(2,2),p2(2,3)],'w-')
plot([p2(1, 4), p2(1,6)],[p2(2,5),p2(2,6)],'w-')
%hip to knee
plot([p2(1, 7), p2(1,8)],[p2(2,7),p2(2,8)],'w-')
plot([p2(1, 10), p2(1,11)],[p2(2,10),p2(2,11)],'w-')
%knee to ankle
plot([p2(1, 8), p2(1,9)],[p2(2,8),p2(2,9)],'w-')
plot([p2(1, 11), p2(1,12)],[p2(2,11),p2(2,12)],'w-')
%hip to shoulder
plot([p2(1, 1), p2(1,7)],[p2(2,1),p2(2,7)],'w-')
plot([p2(1, 4), p2(1,10)],[p2(2,4),p2(2,10)],'w-')
%shoulder to shoulder
plot([p2(1, 1), p2(1,4)],[p2(2,1),p2(2,4)],'w-')
%hip to hip
plot([p2(1, 7), p2(1,10)],[p2(2,7),p2(2,10)],'w-')

%spine: midpoint of shoulders to midpoint of hip 
midshoulder2 =( p2(1:2,4) + p2(1:2,1))/2;
midhip2 = ( p2(1:2,7) + p2(1:2,10))/2;
plot([midshoulder2(1), midhip2(1)], [midshoulder2(2),midhip2(2)],'w-')

% test points from camera vue4
figure(3)
filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';
vue4video = VideoReader(filenamevue4mp4);
vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);
image(vid4Frame)
axis on;
hold on;
title('Vue4 2D')
for i = 1:12
plot(p4(1,i),p4(2,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
end

%shoulder to elbow
plot([p4(1, 1), p4(1,2)],[p4(2,1),p4(2,2)],'w-')
plot([p4(1, 4), p4(1,5)],[p4(2,4),p4(2,5)],'w-')
%elbow to wrist
plot([p4(1, 2), p4(1,3)],[p4(2,2),p4(2,3)],'w-')
plot([p4(1, 4), p4(1,6)],[p4(2,5),p4(2,6)],'w-')
%hip to knee
plot([p4(1, 7), p4(1,8)],[p4(2,7),p4(2,8)],'w-')
plot([p4(1, 10), p4(1,11)],[p4(2,10),p4(2,11)],'w-')
%knee to ankle
plot([p4(1, 8), p4(1,9)],[p4(2,8),p4(2,9)],'w-')
plot([p4(1, 11), p4(1,12)],[p4(2,11),p4(2,12)],'w-')
%hip to shoulder
plot([p4(1, 1), p4(1,7)],[p4(2,1),p4(2,7)],'w-')
plot([p4(1, 4), p4(1,10)],[p4(2,4),p4(2,10)],'w-')
%shoulder to shoulder
plot([p4(1, 1), p4(1,4)],[p4(2,1),p4(2,4)],'w-')
%hip to hip
plot([p4(1, 7), p4(1,10)],[p4(2,7),p4(2,10)],'w-')

%spine: midpoint of shoulders to midpoint of hip 
midshoulder3 =( p4(1:2,4) + p4(1:2,1))/2;
midhip3 = ( p4(1:2,7) + p4(1:2,10))/2;
plot([midshoulder3(1), midhip3(1)], [midshoulder3(2),midhip3(2)],'w-')

%triangulate and plot 3D points again
onearray = ones(1,12);
L2 = zeros(1,12);

[p2, p4] = projectToPointFrame(mocapFnum);

coords = [mocapJoints(mocapFnum,:,1); mocapJoints(mocapFnum,:,2);
       mocapJoints(mocapFnum,:,3); onearray];
pArr = zeros(3,12);
for jointNum = 1:12
%create unit vector that points to point p and passes through camera 2

    pmat2 = vue2.Pmat;
    kmat2 = vue2.Kmat;
    rmat2 = vue2.Rmat;
    %get t values from pMat
    t2 = vue2.Pmat(:,4);
    % get specific joints coordinates
    coord2 = p2(:,jointNum);
    
    ray2 =(lambda2(:,jointNum).*inv(rmat2)*inv(kmat2)*coord2);
    ray2 = ray2./norm(ray2);


%create unit vector that points to point p and passes through camera 4

    pmat4 = vue4.Pmat;
    kmat4 = vue4.Kmat;
    rmat4 = vue4.Rmat;

    t4 = vue4.Pmat(:,4);

    coord4 = p4(:,jointNum);

    ray4 = (lambda4(:,jointNum).*inv(rmat4)*inv(kmat4)*coord4);
    ray4 = ray4./norm(ray4);

%create unit vector u3 that is perpendicular to ray2 and ray 4


    u3 = cross(ray2,ray4);
    u3 = u3./norm(u3);

%solve the system of equations to determine the coefficiants

    c = vue4.position.' - vue2.position.';

    A = [ray2, u3, -ray4];

    X = linsolve(A,c);

    a = X(1);
    b = X(3);

%determine point p

    p12 = vue2.position.' + a.*ray2;
    p22 = vue4.position.' + b.*ray4;

    p = (p12 + p22)./2;
    pArr(1:3, jointNum) = p;
    %display p for each joint and draw skeleton
    %create the skeleton for 3D 

%determine error
    L2(jointNum) = sqrt((coords(1,jointNum)- p(1))^2 + (coords(2,jointNum)- p(2))^2 + (coords(3,jointNum)- p(3))^2);
end

figure(1)
axis on;
hold on;
%plot each 3D point
for i = 1:12
 plot3(pArr(1,i),pArr(2,i), pArr(3,i), 'r+', 'MarkerSize', 30, 'LineWidth', 2, 'color', colors(i));
end
%shoulder to elbow
plot3([pArr(1, 1), pArr(1,2)],[pArr(2,1),pArr(2,2)],[pArr(3,1), pArr(3,2)],'r-')
plot3([pArr(1, 4), pArr(1,5)],[pArr(2,4),pArr(2,5)],[pArr(3,4), pArr(3,5)],'r-')
%elbow to wrist
plot3([pArr(1, 2), pArr(1,3)],[pArr(2,2),pArr(2,3)],[pArr(3,2), pArr(3,3)],'r-')
plot3([pArr(1, 4), pArr(1,6)],[pArr(2,5),pArr(2,6)],[pArr(3,5), pArr(3,6)],'r-')
%hip to knee
plot3([pArr(1, 7), pArr(1,8)],[pArr(2,7),pArr(2,8)],[pArr(3,7), pArr(3,8)],'r-')
plot3([pArr(1, 10), pArr(1,11)],[pArr(2,10),pArr(2,11)],[pArr(3,10), pArr(3,11)],'r-')
%knee to ankle
plot3([pArr(1, 8), pArr(1,9)],[pArr(2,8),pArr(2,9)],[pArr(3,8), pArr(3,9)],'r-')
plot3([pArr(1, 11), pArr(1,12)],[pArr(2,11),pArr(2,12)],[pArr(3,11), pArr(3,12)],'r-')
%hip to shoulder
plot3([pArr(1, 1), pArr(1,7)],[pArr(2,1),pArr(2,7)],[pArr(3,1), pArr(3,7)],'r-')
plot3([pArr(1, 4), pArr(1,10)],[pArr(2,4),pArr(2,10)],[pArr(3,4), pArr(3,10)],'r-')
%shoulder to shoulder
plot3([pArr(1, 1), pArr(1,4)],[pArr(2,1),pArr(2,4)],[pArr(3,1), pArr(3,4)],'r-')
%hip to hip
plot3([pArr(1, 7), pArr(1,10)],[pArr(2,7),pArr(2,10)],[pArr(3,7), pArr(3,10)],'r-')

%spine: midpoint of shoulders to midpoint of hip 
midshoulder4 =( pArr(1:3,4) + pArr(1:3,1))/2;
midhip4 = ( pArr(1:3,7) + pArr(1:3,10))/2;
plot3([midshoulder4(1), midhip4(1)], [midshoulder4(2),midhip4(2)],[midshoulder4(3),midhip4(3)],'r-')




