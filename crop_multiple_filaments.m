%User input - Start this script on the root folder
dcmodels <catalogue_name> -nc mfilament -ws o -gm 1 %nc --> contains the following terminology

c=1; % counter for table
for tomo = 1:length(o.models)   % loop over tomograms
    m = o.models{tomo};  % read models
    myTable{c}=m.grepTable(); %get table from model
    tomogram=m.cvolume.file; %get tomogram path
    box='180'; %define boxsize
    [filepath,filename,ext]=fileparts(tomogram); %break tomogram into parts
    Ntomo=filename(:,1:7); %get number of the tomogram
    label=m.cvolume.catalogue.label; %label of the catalogue
    myData=(['particles/' label '/' Ntomo '_tube_' num2str(c) '_box_' box]); %Define output data for particles
    dwrite(myTable{c},['table/' m.cvolume.catalogue.label '/' Ntomo '_tube_' num2str(c) '.tbl']);
    
    %Cropping particles
    dtcrop(tomogram,myTable{c},myData,box,'mw',5); 
    
    %update cropTable
    myTable_cropped{c}= dread([myData, '/crop.tbl']);
    
    %Randomizing table along azimuth and average
    tbRand=dynamo_table_randomize_azimuth(myTable_cropped{c}); %randomize table along azimuth
    oaRand=daverage(myData,'t',tbRand,'fc',1,'mw',5); %average randomized particles
    
    %Saving files
    dwrite(tbRand,['table/' m.cvolume.catalogue.label '/' Ntomo '_tube_' num2str(c) '_Randomized.tbl']);
    dwrite(oaRand.average,['template/' m.cvolume.catalogue.label '/' Ntomo '_tube_' num2str(c) '_box_' box '.em']);
    c=c+1;
end
