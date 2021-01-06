function projected2DPoints = project3DTo2D(cam, worldCoord3DPoints)
%PROJECT3DTO2D Summary of this function goes here
%   Detailed explanation goes here


        worldCoord3DPoints = [worldCoord3DPoints; ones(1,size(worldCoord3DPoints,2))];

       % get p matrix and k matrix
       pmat = cam.Pmat;
       kmat = cam.Kmat;

       % using K, P, Pw equation 
       projected2DPoints = kmat * pmat * worldCoord3DPoints;
       
       lambda = projected2DPoints(3,:);
       projected2DPoints = projected2DPoints./lambda;
end

