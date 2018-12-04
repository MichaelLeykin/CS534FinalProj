function [topLeft,topRight,bottomLeft,bottomRight,center] = faceDetect(img)
    %Create Object Detector, Utilizes Viola-Jones algorithm
    faceDetector = vision.CascadeObjectDetector;
    shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 255]);
    %Read Image In
    I = imread(img);
    imshow(I);shg;
    bbox = step(faceDetector, I);
    %Caluculate Corner Coordinates
    row1 = ceil(bbox(2));
    row2 = row1 + bbox(3);
    column1 = ceil(bbox(1));
    column2 = column1 + bbox(4);
    centerColumn = column1 + ceil((column2-column1)/2);
    centerRow = row1 + ceil((row2-row1)/2);
    topLeft = [column1 row1];
    topRight = [column2 row1];
    bottomLeft = [column2 row2];
    bottomRight = [column1 row2];
    center = [centerColumn centerRow];
    %Show Results
    I_faces = step(shapeInserter, I, int32(bbox));
    imwrite(I_faces,'detectedFace.jpg');
    %imshow(I_faces), title('Detected faces');
end