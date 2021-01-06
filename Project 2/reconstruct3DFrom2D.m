function recovered3DPoints = reconstruct3DFrom2D(cam1, cam1PixelCoords, cam2, cam2PixelCoords)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


recovered3DPoints = zeros(3,size(cam1PixelCoords,2));

    for jointNum = 1:size(cam1PixelCoords,2)
    %create unit vector that points to point p and passes through camera 2


        kmat1 = cam1.Kmat;
        rmat1 = cam1.Rmat;
        %get t values from pMat

        % get specific joints coordinates
        coord1 = cam1PixelCoords(:,jointNum);
        %revise this? 
        ray1 =(inv(rmat1)*inv(kmat1)*coord1);
        ray1 = ray1./norm(ray1);


    %create unit vector that points to point p and passes through camera 4


        kmat2 = cam2.Kmat;
        rmat2 = cam2.Rmat;



        coord2 = cam2PixelCoords(:,jointNum);

        ray2 = (inv(rmat2)*inv(kmat2)*coord2);
        ray2 = ray2./norm(ray2);

    %create unit vector u3 that is perpendicular to ray2 and ray 4


        u3 = cross(ray1,ray2);
        u3 = u3./norm(u3);

    %solve the system of equations to determine the coefficiants

        c = cam2.position.' - cam1.position.';

        A = [ray1, u3, -ray2];

        X = linsolve(A,c);

        a = X(1);
        b = X(3);

    %determine point p

        p12 = cam2.position.' + a.*ray1;
        p22 = cam1.position.' + b.*ray2;

        p = (p12 + p22)./2;


        recovered3DPoints(:,jointNum) = p; 
    end



end

