function outarray = apply(layertype,inarray,filterbank,biasvals)
    %APPLY call the correct layer function of the cnn
    %   This calls the function corresponding to the appropriate layer of the
    %   CNN along with the correct input array, filterbank, and bias values
    %i=1;
    if strcmp('imnormalize',layertype)
        outarray = apply_imnormalize(inarray);
        %figure; image(outarray);
    elseif strcmp('convolve', layertype)
        outarray = apply_convolve(inarray,filterbank,biasvals);
        %figure; image(outarray(:,:,i));
    elseif strcmp('relu', layertype)
        outarray = apply_relu(inarray);
        %figure; image(outarray(:,:,i));
    elseif strcmp('maxpool', layertype)
        outarray = apply_maxpool(inarray);
        %figure; image(outarray(:,:,i));
    elseif strcmp('fullconnect', layertype)
        outarray = apply_fullconnect(inarray,filterbank,biasvals);
        %figure; image(outarray(:,:,i));
    elseif strcmp('softmax', layertype)
        outarray = apply_softmax(inarray);

    end
end

