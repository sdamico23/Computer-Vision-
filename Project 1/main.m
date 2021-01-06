load cifar10testdata.mat
load CNNparameters.mat

%this takes a single image of a plane and outputs all of the intermediate
%steps of the CNN as images from the outputs of each layer. It also
%produces a bar graph of the "probabilities" at the end

image = imageset(:,:,:,500);
figure; imagesc(image);
for i = 1:size(layertypes,2)
   image = apply(layertypes{i},image,filterbanks{i},biasvectors{i});
   if strcmp(layertypes{i}, 'softmax')
        figure; bar(image(:))
   elseif strcmp(layertypes{i}, 'fullconnect')
        figure; bar(image(:))
   else
        figure; imagesc(image(:,:,1));
   end
end

