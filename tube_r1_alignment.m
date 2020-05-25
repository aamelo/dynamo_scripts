dcmodels cat/batch2 -nc mfilament -ws o -gm 1

c=1 %counter for tube number
for tomo = 1:length(o.models)   % loop over tomograms
    m = o.models{tomo};  % read models
    tomogram=m.cvolume.file; %get tomogram path
    box='180'; %define boxsize
    Ntomo=tomogram(:,60:62); %get number of the tomogram
    label=m.cvolume.catalogue.label; %label of the catalogue
    
    %Input parameters for creating Refine 1 alignment project
    pr=(['ali/' m.cvolume.catalogue.label '/bits_' tomogram(:,60:62) '_tube_' num2str(c) '_r1']);
    myData=(['particles/' label '/bits_' Ntomo '_tube_' num2str(c) '_box_' box]); %Define output data for particles
    myTable=dread(['table/' m.cvolume.catalogue.label '/bits_' tomogram(:,60:62) '_tube_' num2str(c) '_Randomized.tbl']);
    
    %dwrite(myTable{c},['table/' m.cvolume.catalogue.label '/bits_' tomogram(:,60:62) '_tube_' num2str(c) '.tbl']);
    
    %Creating lowpass template
    vol=dread(['template/' m.cvolume.catalogue.label '/bits_' tomogram(:,60:62) '_tube_' num2str(c) '_box_' box '.em']);
    template=dynamo_mollify(vol,8); %apply gaussian filter
    
    %Create ali project
    dvpr(pr,'data',myData,'table',myTable,'template',template,'hint','masks'); 
    %create all masks with a spherical mask 
    %which has to be manually replaced due to the different tube sizes
    
    %Copy numerical parameters and computing enviroment from a defined
    %project
    dvcopy_numerical('ali/t241/tube1_sl200_box64_r1',pr);
        
    c=c+1;
end
