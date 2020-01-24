tomo = dynamo_read_subtomogram('<filename>', 'r',48,'c',[126,181,76]); %Read tomogram into matlab workspace
dynamo_wedge_estimate(tomo,'show',1); %analyze the missing wedge. This can also be done with maps.
