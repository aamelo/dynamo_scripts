
%User input 
myData='<filename>';
myTable=dread('<filename>');
templateFolder='./template';
tableFolder='./table';
projectName='<filename>';


%Run script for
%Table randomization and averaging
zRandomized_tb = dynamo_table_randomize_azimuth (myTable);
avg_Randomized = daverage(myData,'t', zRandomized_tb,'fc',1);

%Save template and table
dwrite(oaRandomized.average,[templateFolder '/<filename>_zRandomized.em']);
dwrite(zRandomized_tb, [tableFolder '/<filename>_zRandomized.tbl']);

%Creating G01 alignment project
dvput(projectName,'ite_r1',3,'cr_r1',4,'cs_r1',2,'ir_r1',30,'is_r1',6,'dim_r1',50,'lim_r1',[10,10,10],'limm_r1',1,'low_r1',24);
dvput(projectName,'ite_r2',3,'cr_r2',4,'cs_r2',2,'ir_r2',10,'is_r2',2,'dim_r2',100,'lim_r1',[14,14,14],'limm_r1',1,'low_r1',32);
