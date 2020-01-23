%Creation of mask at the membrane 

mr = dpktomo.examples.motiveTypes.Membrane();   % create membrane object
mr.thickness  = 18;       % choose thickness of membrane
mr.sidelength = 48;       % choose sidelength of box
mr.getMask();             % compute mask 

%In case one needs to rotate the mask
rotMask=drot(mr.mask,[0,90,0]);
                    % tdrot,tilt,narot
                    
  
