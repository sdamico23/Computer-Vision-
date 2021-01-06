load('vue2CalibInfo.mat')
load('vue4CalibInfo.mat')
load('Subject4-Session3-Take4_mocapJoints.mat')

mocapFnum = 500;
[p2, p4] = projectToPointFrameImage(mocapFnum);

pmat2 = vue2.Pmat;
kmat2 = vue2.Kmat;
cam4Location = [vue4.position.'; 1];
% using K, P, Pw equation 
el = kmat2 * pmat2 * cam4Location;
el = el./el(3,:);

colors = ['r', 'b', 'm', 'y', 'g', 'c', 'w', 'k', 'r', 'b', 'm', 'y'];
for i = 1:12

m = (el(2)-p2(2,i))/(el(1)-p2(1,i));
b = p2(2,i) - m * p2(1,i);
y = m*1920+b;

figure(1)
hold on;
title('Epipolar lines for Vue2')
line([1920 el(1)],[y el(2)],'color', colors(i), 'LineWidth', 2)
end

pmat4 = vue4.Pmat;
kmat4 = vue4.Kmat;
cam2Location = [vue2.position.'; 1];
% using K, P, Pw equation 
er = kmat4 * pmat4 * cam2Location;
er = er./er(3,:);
for i = 1:12

m = (er(2)-p4(2,i))/(er(1)-p4(1,i));
b = p4(2,i) - m * p4(1,i);
y = m*0+b;

figure(2)
hold on;
title('Epipolar lines for Vue4')
line([0 er(1)],[y er(2)],'color', colors(i), 'LineWidth', 2)
end