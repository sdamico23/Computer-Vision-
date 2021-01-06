load('Subject4-Session3-Take4_mocapJoints.mat')
load('vue2CalibInfo.mat')
load('vue4CalibInfo.mat')


outarray = zeros(size(mocapJoints,1),3,12);
outarray2 = zeros(size(outarray));
onearray = ones(1,12);

for mocapFnum = 1:26214
    
    [p2, p4] = projectToPointFrame(mocapFnum);
    
    outarray(mocapFnum,:,:) = p2;
    outarray2(mocapFnum,:,:) = p4;
   
end
p=0;
for i = 1:26214
    i=i-p;
    if outarray(i,:,:) == 0
        outarray(i,:,:) = [];
        outarray2(i,:,:) = [];
        mocapJoints(i,:,:) = [];
        p=p+1;
    end
end

L2 = zeros(size(outarray,1),12);
for mocapFnum = 1:size(outarray,1)
    for jointNum = 1:12
    %create unit vector that points to point p and passes through camera 2

        pmat2 = vue2.Pmat;
        kmat2 = vue2.Kmat;
        rmat2 = vue2.Rmat;
        %get t values from pMat
        t2 = vue2.Pmat(:,4);
        % get specific joints coordinates
        coord2 = outarray(mocapFnum,:,jointNum).';
        %revise this? 
        ray2 =(inv(rmat2)*inv(kmat2)*coord2);
        ray2 = ray2./norm(ray2);


    %create unit vector that points to point p and passes through camera 4

        pmat4 = vue4.Pmat;
        kmat4 = vue4.Kmat;
        rmat4 = vue4.Rmat;

        t4 = vue4.Pmat(:,4);

        coord4 = outarray2(mocapFnum,:,jointNum).';

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

    %determine error
        coords = permute(squeeze(mocapJoints(mocapFnum,:,1:3)),[2 1]);
    
        
        
        L2(mocapFnum, jointNum) = sqrt((coords(1,jointNum)- p(1))^2 + (coords(2,jointNum)- p(2))^2 + (coords(3,jointNum)- p(3))^2);
    end
end

individualJointMean = mean(L2);
individualJointStd = std(L2);
individualJointMin = min(L2);
individualJointMax = max(L2);
individualJointMedian = median(L2);

allJointsMean = mean(L2, 'all');
allJointsStd = std(L2, 0, 'all');
allJointsMin = min(L2, [], 'all');
allJointsMax = max(L2, [], 'all');
allJointsMedian = median(L2, 'all');

allJointsSumPerFrame = sum(permute(L2,[2 1]));
x = 1:size(allJointsSumPerFrame,2);
figure()
plot(x,allJointsSumPerFrame)




