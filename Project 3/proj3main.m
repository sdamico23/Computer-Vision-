function proj3main(dirstring, maxframenum, lambda, alpha, gamma)
%This is the main function for project 3
% dirstring: where the input image files are read from
% maxframenum: the the last image file
% lambda: # between 0-255, abs diff value for converting absolute
%intensity to binary
% alpha: float from 0-1, blending parameter used in adaptive
%background subtraction
% gamma: # between 0-255, decay value for persistant frame
%differencing

%  This function performs four simple motion detection algorithms: simple
%  backround subtraction, simple frame differencing, adaptive background
%  subtraction, and persistent frame differencing

    %create filename str
    fileName = sprintf('%s/f0001.jpg', dirstring);
    %create four different background frames, one for each algorithm
    background = rgb2gray(imread(fileName));
    previousFrame = background;
    backgroundT = background;
    backgroundT1 = background;
    HT = 0;
    HT1 = 0;
    %divide by 255 because we use imbinarize
    T = lambda/255;
    %loop through all imgs
    for frame = 1:maxframenum
        %get img and convert to grey scale 
        fileName = sprintf('%s/f%04d.jpg', dirstring, frame);
        currentFrame = rgb2gray(imread(fileName));
        %simple background subtraction
        bgDiff = abs(background - currentFrame);
        bgSub = imbinarize(bgDiff, T);
        %simple frame differencing: background replaced w/prev image
        frameDiff = abs(previousFrame - currentFrame);
        frameSub = imbinarize(frameDiff, T);
        %adaptive background subtraction: current image "blended" into
        %background using alpha value
        adaptBgDiff = abs(backgroundT1 - currentFrame);
        adaptBgSub = imbinarize(adaptBgDiff, T);

        %persistent frame differencing: combine imgs with decay 
        tmp = max(HT1 - gamma, 0);
        %using frameSub from frame diff 
        HT = max(255 * frameSub, tmp);
        
        %create output image (all 4 frames from each alg in one)
        % convert persistant frame to 0-1 by dividing by 255
        outImage = [bgSub, frameSub; adaptBgSub, HT./255];
        imshow(outImage)
        %save output image
        outName = sprintf('%s/outf%04d.png', dirstring, frame);
        imwrite(outImage, outName);
        % set new background for adaptive bg subtraction using alpha
        backgroundT = (alpha * currentFrame) + ((1 - alpha) * backgroundT1);
        %set new backgrounds for simple frame 
        %differencing and persistent frame differencing
        backgroundT1 = backgroundT;
        previousFrame = currentFrame;
        HT1 = HT;

    end


end

