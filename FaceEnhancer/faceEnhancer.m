function [final,percentatgeAltered,numberOfBlemishesRemoved] = faceEnhancer(orig_img)
    %Obtain Points of Square Around Identified Face in Given Image
    [topLeft,topRight,bottomLeft,bottomRight,center] = faceDetect(orig_img);
    %Read In Original Image
    I = imread(orig_img);
    %Crop Out Face
    [I2] = imcrop(I,[topLeft(1),topLeft(2),(topRight(1)-topLeft(1)),(bottomLeft(2)-topLeft(2))]);
    imshow(I2);
    %Save This Image Seperate As The Target Of Our Program
    imwrite(I2,'pimple.jpg');
    %Obtain All The Radii and Locations of Blemishes of The Target 
    [I3,centers,radii] = pimpleApplication('pimple.jpg');
    %Save processed Image
    imwrite(I3,'targets.jpg');
    %Doctor Target Image To Remove Blemishes Specified Earlier
    secondToLastImg = evenSkin(centers, radii,'pimple.jpg');
    %Read In The Cleared Face
    cropped_img = imread('clearedFace.jpg');
    imshow(cropped_img);
    %Resize Doctored Image Back To Original Area In Original Img
    J = imresize(cropped_img,[(bottomLeft(2)-topLeft(2)+1) (topRight(1)-topLeft(1)+1)]);
    imshow(J);
    %Create Final Image
    final = I;
    imshow(final);
    %Paste Doctored Image On Top Of The Original Image In The Same Location
    final(topLeft(2):bottomLeft(2),topLeft(1):topRight(1),:) = J;
    imwrite(final,'final.jpg');
    %Calculate Percentage of Target's Face That Was Altered and The Amount
    %of Blemishes Removed
    sizeOfFace = (bottomRight(2) - topLeft(2))*(bottomRight(2) - topLeft(2));
    totalAreaOfBlemishes = 0;
    for i = 1:size(radii)
        totalAreaOfBlemishes = totalAreaOfBlemishes + (pi*((radii(i)+8)*(radii(i)+8)));
    end
    percentatgeAltered = (totalAreaOfBlemishes/sizeOfFace)*100;
    numberOfBlemishesRemoved = size(radii);
end