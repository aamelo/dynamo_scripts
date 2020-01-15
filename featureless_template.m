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

