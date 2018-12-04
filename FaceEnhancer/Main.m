function Main()
    %Call Our Program And Display Results
    [final,percentatgeAltered,numberOfBlemishesRemoved] = faceEnhancer('Example2.jpg');
    imshow(final);
    disp(percentatgeAltered + " Percent of the subject's face has been altered, with " + numberOfBlemishesRemoved(1) + " blemishes removed!");
end