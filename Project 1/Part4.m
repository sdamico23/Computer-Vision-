%load debuggingTest.mat
load CNNparameters.mat
load cifar10testdata.mat
%imrgb is test image

%outarray is 10x10
outarray = zeros(10,10);
yarray = zeros(10);
%imageset, trueclass, and classlabel defined already
%imrgb = imageset(:,:,:,inds(1)); to get one image 
for j = 1:size(imageset, 4)
       %get each image of the dataset with its true class
       image = imageset(:,:,:,j);      
       %get the true class?
       trueim = trueclass(:,j);
       
   for i = 1:size(layertypes,2)
       %apply each layer
       image = apply(layertypes{i},image,filterbanks{i},biasvectors{i});
       %find max prob and index 
       %disp(image);
       %image is 32x32x3 - 10x10x1
   end
       classprobvec = squeeze(image); %squeeze removes one dimension of array
       [maxprob,maxclass] = max(classprobvec);
       %finding if image is in top kth class
       for i = 1:10
           %return arrays containing top k values and their indexes 
           [maxprobArr, maxclassArr] = maxk(classprobvec, i);
           %check if trueim class is one of the top classes
           belongs = ismember(trueim, maxclassArr);
           %if it belongs add one to the yarray 
           if belongs == 1 
               yarray(i) = yarray(i) + 1;
           end
       end
               
       %add one to corresponding i,j value in confusion table 
       %classprobvec 10x1
       %maxclass is double

       
       outarray(trueim, maxclass) = outarray(trueim,maxclass) + 1;
   
end
numerator = 0;
denominator = 0;
for i = 1:10
    numerator = numerator + outarray(i,i);
    for j = 1:10
        denominator = denominator + outarray(i,j);
    end
end
accuracy = numerator/denominator;


%plot: x axis from 0 to 10, y axis from 0 to 100 percent

xarray = [1 2 3 4 5 6 7 8 9 10];
%divide y array by total images to get percentages
yprob = rdivide(yarray, 10000);
%create plot 
plot(xarray, yprob)
title('Classifaction Accuracy With Respect To Top-K classes')
xlabel('Top K Class')
ylabel('% of Times Correct Class is in Top-K Ranked Classes')



    



