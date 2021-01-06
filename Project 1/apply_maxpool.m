function outarray = apply_maxpool(inarray)
    %APPLY_MAXPOOL applies a max pool to the input array
    %   reduces the spatial rows and columns of the input array by 2, using the
    %   maximum value in 2x2 areas
    %input array is 2Nx2MxD, output is NxMxD
    [n,m] = size(inarray,1,2);
    n=ceil(n/2);
    m=ceil(m/2);
    d1 = size(inarray,3);
    temp1=zeros(n,m);
    temp2=zeros(n,m);
    temp3=zeros(n,m);
    temp4=zeros(n,m);
    outarray=zeros(n,m,d1);
    for d1 = 1:size(inarray,3)
        for n = 1:2:size(inarray,1)
           for m = 1:2:size(inarray,2)
              temp1(ceil(n/2),ceil(m/2)) = inarray(n,m,d1); 
           end
           for m = 2:2:size(inarray,2)
              temp2(ceil(n/2),ceil(m/2)) = inarray(n,m,d1);
           end
        end
        for n = 2:2:size(inarray,1)
           for m = 1:2:size(inarray,2)
              temp3(ceil(n/2),ceil(m/2)) = inarray(n,m,d1); 
           end
           for m = 2:2:size(inarray,2)
              temp4(ceil(n/2),ceil(m/2)) = inarray(n,m,d1);
           end  
        end
        outarray(:,:,d1) = max(temp1,temp2);
        outarray(:,:,d1) = max(outarray(:,:,d1),temp3);
        outarray(:,:,d1) = max(outarray(:,:,d1),temp4);
    end
end

