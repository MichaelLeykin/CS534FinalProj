function finalImg = evenSkin(centers, radii,orig_img)

    clc;        % Clear the command window.
    close all;  % Close all figures 
    %clear;      % Erase all existing variables
    workspace;  % Display workspace panel  
    format long g;
    format compact;
    fontSize = 25;

    % Read in image.
    rgbImage = imread(orig_img);

    imshow(rgbImage);
    hold on;
    
    [sizeX, sizeY] = size(centers);

    for (i = 1: sizeX)
        %Calculate Position Of Blemish
        x = centers(i, 1);
        y = centers(i, 2);
        r = radii(i)+5;
        %Calculate Average Color Of Pixels Around Blemish
        pixel1 = impixel(rgbImage,x+5,y);
        pixel2 = impixel(rgbImage,x+5,y+5);
        pixel3 = impixel(rgbImage,x+5,y-5);
        pixel4 = impixel(rgbImage,x+5,y+10);
        pixel5 = impixel(rgbImage,x+5,y-10);
        pixel6 = impixel(rgbImage,x-5,y);
        pixel7 = impixel(rgbImage,x-5,y+5);
        pixel8 = impixel(rgbImage,x-5,y-5);
        pixel9 = impixel(rgbImage,x-5,y+10);
        pixel10 = impixel(rgbImage,x-5,y-10);
        pixel11 = impixel(rgbImage,x+10,y+10);
        pixel12 = impixel(rgbImage,x+10,y-10);
        pixel13 = impixel(rgbImage,x+10,y);
        pixel14 = impixel(rgbImage,x+10,y-5);
        pixel15 = impixel(rgbImage,x+10,y+5);
        R = ((pixel1(1) + pixel2(1) + pixel3(1) + pixel4(1) + pixel5(1) + pixel6(1) + pixel7(1) + pixel8(1) + pixel9(1) + pixel10(1) + pixel11(1) + pixel12(1) + pixel13(1) + pixel14(1) + pixel15(1))/15);
        G = ((pixel1(2) + pixel2(2) + pixel3(2) + pixel4(2) + pixel5(2) + pixel6(2) + pixel7(2) + pixel8(2) + pixel9(2) + pixel10(2) + pixel11(2) + pixel12(2) + pixel13(2) + pixel14(2) + pixel15(2))/15);
        B = ((pixel1(3) + pixel2(3) + pixel3(3) + pixel4(3) + pixel5(3) + pixel6(3) + pixel7(3) + pixel8(3) + pixel9(3) + pixel10(3) + pixel11(3) + pixel12(3) + pixel13(3) + pixel14(3) + pixel15(3))/15);
        color = [(1/255)*R (1/255)*G (1/255)*B];
        if isnan(color)
            continue;
        end
        a = x - r/2;
        b = y - r/2;
        pos = [a b (r+3) (r+5)]; 
        %Place Correction
        rectangle('Position',pos,'Curvature',[1 1], 'FaceColor',color, 'EdgeColor', color)
    end

    %Display and save new image with changes
    newImageName = 'clearedFace.jpg';
    saveas(gcf, newImageName); %to merge rectangles in to the image and save
    finalImg = newImageName;
    imshow(finalImg);
    close all;  % Close all figures 
end