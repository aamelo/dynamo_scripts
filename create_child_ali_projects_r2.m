%This script is used to create refine2 projects from many refine1 projects.
%It uses dynamo_vpr_branch to import files from the iteration from user
%input.

%User input before starting this script
%One needs to generate a list of the files which will be used for the
%script. Normally it should be r1. It can also be r2, but one needs 
%files=dir('ali/batch2/bits_*_r1');

%Input parent directory
prompt = 'What is the parent directory?use strings';
parent_dir = input(prompt);

%Input iteration
prompt = 'What was the last iteration on source project?use numbers';
last_iteration = input(prompt);

%Input project to copy numerical parameters
prompt= 'From which alignment project to copy numerical parameters from?use strings';
numerical_project = input(prompt);


for i=1:length(files)
    %indicate source project - before this loop, run
    %files=dir('ali/batch2/bits_*_r1');
    source_project = files(i).name
        
    %count string lenght
    length_source_project = strlength(source_project);
    
    %assign target project - This line gives the root name and #2
    root_name = source_project(:,1:(length_source_project-1))
    target_project = ([root_name '2'])
    
    %settings=([parent_dir '' source_project ' ' parent_dir '' target_project ' -ite ' num2str(last_iteration) ' -b 1 -noise 0;']);
    %Input parematers for dynamo_vpr_branch
    sproj = ([parent_dir '' source_project]);
    tproj = ([parent_dir '' target_project]);
    dynamo_vpr_branch(sproj,tproj,'ite',last_iteration,'b',1,'noise',0);
    
    %Copy numerical parameters from a defined project (numerical project)
    dvcopy_numerical_test(numerical_project,tproj);
    
    %Check and unfold
    dvpr(tproj,'s','cu');
end
