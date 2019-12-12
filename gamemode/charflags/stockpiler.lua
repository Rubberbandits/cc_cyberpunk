FLAG.PrintName 	= "Stockpile Access";
FLAG.Flag 		= "M";

FLAG.Additive = true;
FLAG.OnGiven = function( ply )

	ply.StartStockpileCreation = true;
	net.Start( "nRequestStockpileName" );
	net.Send( ply );

end