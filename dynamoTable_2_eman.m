%%%   This file transforms coordinates from dynamo .omd file (picked from dtmslice) to eman2 coordinates

m=dread('mfilamentRings.omd'); %read models file

%Save crop points into separate matrices
X1=m.crop_points(:,1);
Y1=m.crop_points(:,2);
Z1=m.crop_points(:,3);

%Save into file based on EMAN .json particles
fileID=fopen('dyn_particlePosition_XYZ_ts01.txt','w');

%[X-center,Y-center,Z-center,method,score,class #]
formatSpec='[%3.3f,%3.3f,%3.3f,"manual",0,1],\n';
fprintf(fileID,formatSpec,X1,Y1,Z1);

%For now, the best way is to copy and paste into the .json file of the respective tomogram
