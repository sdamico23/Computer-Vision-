% file to test and create videos 
% create video writer
v = VideoWriter('AShipDeck.mp4');
open(v);

background = rgb2gray(imread('AShipDeck/f0001.jpg'));
previousFrame = background;
backgroundT = background;
backgroundT1 = background;
HT = 0;
HT1 = 0;
maxframenum = 295;
lambda = 35;
T = lambda/255;
alpha = .5;
gamma = 18;
for frame = 1:maxframenum

    fileName = sprintf('AShipDeck/f%04d.jpg', frame);
    currentFrame = rgb2gray(imread(fileName));
    
    bgDiff = abs(background - currentFrame);
    bgSub = imbinarize(bgDiff, T);
    
    frameDiff = abs(previousFrame - currentFrame);
    frameSub = imbinarize(frameDiff, T);
    
    adaptBgDiff = abs(backgroundT1 - currentFrame);
    adaptBgSub = imbinarize(adaptBgDiff, T);
    
    
    tmp = max(HT1 - gamma, 0);
    HT = max(255 * frameSub, tmp);
    outImage = [bgSub, frameSub; adaptBgSub, HT./255];
    imshow(outImage)
    
    outName = sprintf('AShipDeck/outf%04d.png', frame);
    imwrite(outImage, outName);
    %write to video
    writeVideo(v,outImage);
    
    backgroundT = (alpha * currentFrame) + ((1 - alpha) * backgroundT1);
    
    backgroundT1 = backgroundT;
    previousFrame = currentFrame;
    HT1 = HT;
    
end

close(v);
