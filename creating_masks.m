%Creation of mask at the membrane 

mr = dpktomo.examples.motiveTypes.Membrane();   % create membrane object
mr.thickness  = 18;       % choose thickness of membrane
mr.sidelength = 48;       % choose sidelength of box
mr.getMask();             % compute mask 

%In case one needs to rotate the mask
rotMask=drot(mr.mask,[0,90,0]);
                    % tdrot,tilt,narot
                    
  
%Apply gaussian to it
gaussian_Mask=dynamo_mollify(mr.mask,4); %The value is in pixels

%One can also create a mask based on a smeared template
ref=dread('<filepath>');
boxsize=;

refsm=zeros(size(ref));
refav=sum(ref,1)./boxsize;
%(ref,1) for smearing x
%(ref,2) for smearing y
%(ref,3) for smearing z

for i=1:boxsize
    
    refsm(i,:,:)=refav;
    %    (x,y,z)
end

sm_mask=(refsm)*(-1)+1; %Invert contrast
sm_mask(sm_mask<1)=0; %Binerize the mask
gau_mask=dynamo_mollify(sm_mask,4); % apply gaussian to the mask
dwrite(gau_mask,'<filename>'); %save mask

