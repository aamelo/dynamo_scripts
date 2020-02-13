%This script will get the coordinates from a dynamo table into a relion .coords file
%Name the dynamo table as 'dtable.tbl'

tb=dread('dtable.tbl');
tomo1=dtgrep(tb,'tr','&20=1')

%In case of overpicked particles
%tomo1_Ex = dpktbl.exclusionPerVolume(tomo1,44);

tomo1(:,24:26)=tomo1(:,24:26)+tomo1(:,4:6);
X1=tomo1(:,24);
Y1=tomo1(:,25);
Z1=tomo1(:,26);

fileID=fopen('tomogram1_XYZ.txt','w');
%formatSpec='[%3.3f, %3.3f, %3.3f, "manual", 0, 0],\n'; %for EMAN
formatSpec='%4.1f %4.1f %4.1f\n'; %for Relion
fprintf(fileID,formatSpec,X1,Y1,Z1);

