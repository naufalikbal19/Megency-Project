CMD:despawnsana(playerid, params[])
{
	// Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414) || IsPlayerInRangeOfPoint(playerid, 8.0, 741.9764,-1371.2441,25.8835))
	{
		if(pData[playerid][pFaction] != 4)
	        return Error(playerid, "You must be at Sana officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SANAVeh[playerid]);
		pData[playerid][pSpawnSana] = 0;
    	GameTextForPlayer(playerid, "~w~SANA Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnsana(playerid, params[])
{
    // Sana Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 743.5262, -1332.2343, 13.8414))
	{
		if(pData[playerid][pFaction] != 4)
	        return Error(playerid, "You must be at Sana officer faction!.");

		if(pData[playerid][pSpawnSana] == 1) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zanv[10000], String[10000];
	    strcat(Zanv, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Sanew\tCars\n");// 596
		strcat(Zanv, String);
		format(String, sizeof(String), "Sanew\tMotorcycle\n");// 597
		strcat(Zanv, String);
		format(String, sizeof(String), "Helicopter\tMotor Mabur\n");// 598
		strcat(Zanv, String);/*
		format(String, sizeof(String), "Helicopter 2\tCars\n"); // 599
		strcat(Zann, String);
		format(String, sizeof(String), "Premier\tSport Cars\n"); // 599
		strcat(Zann, String);*/
		ShowPlayerDialog(playerid,DIALOG_SANA_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles San Andreas Agency", Zanv, "Spawn","Cancel");
	}
	return 1;
}