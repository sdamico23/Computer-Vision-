function outarray = apply_relu(inarray)
    %APPLY_RELU Apply Rectified Linear Unit
    % input and output array both are NxMxD
    %   threshold all elements of an array to make negative numbers zero
    outarray = max(inarray,0);
end

