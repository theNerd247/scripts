# computes the magnetic reluctance given the magnetic permeability of a given
# material. The magnetic permeability of free space is assumed to be 4*pi*1e-7
function R = magReluctance(l,A,mu=1)
	R = l./(A.*mu*4*pi*1e-7);
end
