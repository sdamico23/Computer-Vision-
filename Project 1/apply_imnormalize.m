function outarray = apply_imnormalize(inarray)
%APPLY_IMNORMALIZE Apply Image Normalization
%input and output are both array of size NxMx3
%   Scales each color channel's pixel values into output range -0.5 to 0.5
temp = double(inarray);
outarray = (temp/255) - 0.5;
end

