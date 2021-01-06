%this one runs the triangulation and determines the L^2 for all 12 joints
%in a single frame

load('vue2CalibInfo.mat')
load('vue4CalibInfo.mat')
load('Subject4-Session3-Take4_mocapJoints.mat')

mocapFnum = 500;
onearray = ones(1,12);
L2 = zeros(1,12);
[p2, p4] = projectToPointFrameImage(mocapFnum);

fullP = zeros(3,size(p2,2));

coords = [mocapJoints(mocapFnum,:,1); mocapJoints(mocapFnum,:,2);
       mocapJoints(mocapFnum,:,3); onearray];
for jointNum = 1:12
%create unit vector that points to point p and passes through camera 2

    pmat2 = vue2.Pmat;
    kmat2 = vue2.Kmat;
    rmat2 = vue2.Rmat;
    %get t values from pMat
    t2 = vue2.Pmat(:,4);
    % get specific joints coordinates
    coord2 = p2(:,jointNum);
    %revise this? 
    ray2 =(inv(rmat2)*inv(kmat2)*coord2);
    ray2 = ray2./norm(ray2);


%create unit vector that points to point p and passes through camera 4

    pmat4 = vue4.Pmat;
    kmat4 = vue4.Kmat;
    rmat4 = vue4.Rmat;

    t4 = vue4.Pmat(:,4);

    coord4 = p4(:,jointNum);

    ray4 = (inv(rmat4)*inv(kmat4)*coord4);
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
    
    fullP(:,jointNum) = p; 

%determine error
    
    L2(jointNum) = sqrt((coords(1,jointNum)- p(1))^2 + (coords(2,jointNum)- p(2))^2 + (coords(3,jointNum)- p(3))^2);
end