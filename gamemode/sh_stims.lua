local meta = FindMetaTable( "Player" );

function meta:HasActiveStim( stim )

	if( !self.ActiveStims ) then
	
		return false
		
	end

	return (self.ActiveStims[stim] ~= nil);

end