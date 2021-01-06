function outarray = apply_fullconnect(inarray, filterbank, biasvals)
    %APPLY_FULLCONNECT Applies the fullconnect layer
    %   Detailed explanation goes here
    outarray = zeros(1,1,size(biasvals,2));
    for d2 = 1:size(biasvals,2)
        filter = filterbank(:,:,:,d2);
        bias = biasvals(d2);
        outarray(1,1,d2) = sum(sum(dot(inarray, filter))) + bias;
    end
end

