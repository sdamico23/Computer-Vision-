function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

EpipolarLines1 = zeros(3, size(cam1PixelCoords, 2));
EpipolarLines2 = zeros(3, size(cam2PixelCoords, 2));

p1 = cam1PixelCoords;
p2 = cam2PixelCoords;

pmat1 = cam1.Pmat;
kmat1 = cam1.Kmat;
cam2Location = [cam2.position.'; 1];
% using K, P, Pw equation 
el = kmat1 * pmat1 * cam2Location;
el = el./el(3,:);

colors = ['r', 'b', 'm', 'y', 'g', 'c', 'w', 'k', 'r', 'b', 'm', 'y'];

for i = 1:size(cam1PixelCoords, 2)

m = (el(2)-p1(2,i))/(el(1)-p1(1,i));
b = p1(2,i) - m * p1(1,i);
y = m*1920+b;

EpipolarLines1(:,i) = [m; -1; b];

figure(1)
hold on;
line([1920 el(1)],[y el(2)],'color', colors(i), 'LineWidth', 2)
end

pmat2 = cam2.Pmat;
kmat2 = cam2.Kmat;
cam1Location = [cam1.position.'; 1];
% using K, P, Pw equation 
er = kmat2 * pmat2 * cam1Location;
er = er./er(3,:);

for i = 1:size(cam2PixelCoords, 2)

m = (er(2)-p2(2,i))/(er(1)-p2(1,i));
b = p2(2,i) - m * p2(1,i);
y = m*0+b;

EpipolarLines2(:,i) = [m; -1; b];

figure(2)
hold on;
line([0 er(1)],[y er(2)],'color', colors(i), 'LineWidth', 2)
end
end

