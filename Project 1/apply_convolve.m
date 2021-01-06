function outarray = apply_convolve(inarray, filterbank, biasvals)
    %APPLY_CONVOLVE Applys a convolution filter
    %   applies the given convolution filters to the input array ands adds the
    %   bias
    [r,c] = size(inarray,1,2);
    d2 = size(biasvals,2);
    temp = zeros(r,c,d2);
    outarray = zeros(size(temp));
    for d2 = 1:size(filterbank,4)
        bias = biasvals(d2);
        for d1 = 1:size(inarray,3)
            filter=filterbank(:,:,d1,d2);
            convo=imfilter(inarray(:,:,d1),filter,'conv');
            temp(:,:,d2) = temp(:,:,d2) + convo;
        end
        outarray(:,:,d2) = temp(:,:,d2) + bias;

    end
end

