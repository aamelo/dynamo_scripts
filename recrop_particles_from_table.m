%Recrop
%Add the following files to matlab workspace

%Tomogram as "tomo"
tomo=dread(<tomogram>);
%Example:>> tomo=dread('bits_234_bin4_WBP.rec');

%Table as "tb"
ddb <project_name>:rt -ws tb1;
%Example:>> ddb bits234_r1:rt -ws tb;
%Preparing table for recroping: Add columns 4 to 6 to columns 24 to 26 and center particles
tbnew=tb1;
tbnew(:,24:26)=tb(:,24:26) + tb(:,4:6);
tbnew = dpktbl.centerCropPoints (tbnew);
tb=tbnew;

%targetFolder
myData='<file_path>';
%Example: >> myData='particles/bits234_bin4_WBP_box64';

%Crop particles
box_size=64; %or any other number 
%%%check the following website for optimal box size(https://blake.bcm.edu/emanwiki/EMAN2/BoxSize)
dtcrop(tomo,tb,myData,box_size);

%Averaging
oa=daverage(myData,'t',[myData '/crop.tbl'],'fc',1);
%View average
dview(oa.average);
