function outarray = apply_softmax(inarray)
    %APPLY_SOFTMAX Applies the softmax layer
    %   creates an array of "probabilities" for each of the trueclasses
    %   that the input image could be
    outarray = zeros(size(inarray));
    alpha = max(inarray);
    total = 0;
    for k = 1:size(inarray,3)
       total = total + exp(inarray(1,1,k) - alpha);
    end
    for d = 1:size(inarray,3)
        in = inarray(1,1,d);
        outarray(:,:,d) = (exp(in - alpha))/(total); 
    end
end

