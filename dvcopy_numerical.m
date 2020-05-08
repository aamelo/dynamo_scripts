% This function is a modified function from Dynamo dvcopy. It copies only Numerical parameters from iteration round 1 and 2. 
% If one nedds to copy other rounds just add to the "parametersToExport" .
% Add this file to matlab path or to dynamo folder:dynamo/matlab/src/.

% Example:  dvcopy_numerical('ali_project1','ali_project2');
%                               source        target                   

function [vpr_new,o] = dvcopy_numerical(source,target,varargin)

vpr_new = [];
o = pparse.output();
o.leading = 'dvcopy_numerical';


vpr_source=dynamo_vpr_load(source);
vpr_target=dynamo_vpr_load(target);

parametersToExport = {'gpu_identifier_set','destination','how_many_processors',....
'MCR_CACHE_ROOT','cluster_header','matlab_workers_average','ite_r1','ite_r2','ite_r2',....
'cone_range_r1','cone_range_r2','cone_sampling_r1','vpr_target.cone_sampling_r2',....
'inplane_range_r1','inplane_range_r2','inplane_sampling_r1','inplane_sampling_r2','low_r1',....
'low_r2','dim_r1','dim_r2','area_search_r1','area_search_r2','area_search_modus_r1','area_search_modus_r2'};

for i=1:length(parametersToExport)
myParameter = parametersToExport{i};
try
vpr_target.(myParameter) = vpr_source.(myParameter);
end
end

vpr_new=vpr_target;
vpr_result = dynamo_vpr_save(vpr_new);

if isempty(vpr_result)
    o.echo('apparent errot when saving project');
   return
end

o.echo(' ');
o.echo('Done: project named "%s" has been created as a copy of "%s".',{target,source});
o.echo(' ');
o.bars();

o.ok = true;
