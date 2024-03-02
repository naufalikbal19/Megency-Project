CMD:despawnsg(playerid, params[])
{
	// Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1487.641357,-1834.032592,13.546875) || IsPlayerInRangeOfPoint(playerid, 8.0, 1422.383789,-1797.327880,33.429672))
	{
		if(pData[playerid][pFaction] != 2)
	        return Error(playerid, "You must be at sags officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAGSVeh[playerid]);
		pData[playerid][pSpawnSags] = 0;
    	GameTextForPlayer(playerid, "~w~SAGS Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnsg(playerid, params[])
{
    // Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1487.641357,-1834.032592,13.546875))
	{
		if(pData[playerid][pFaction] != 2)
	        return Error(playerid, "You must be at sags officer faction!.");

		if(pData[playerid][pSpawnSags] == 1) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zann[10000], String[10000];
	    strcat(Zann, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Stretch\tCars\n");// 409
		strcat(Zann, String);
		format(String, sizeof(String), "Bullet\tCars\n");// 541
		strcat(Zann, String);
		format(String, sizeof(String), "infernus\tCars\n");// 411
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter Maverick\tCars\n"); // 487
		strcat(Zann, String);
		format(String, sizeof(String), "NRG-500\tMotor\n"); // 522
		strcat(Zann, String);
		ShowPlayerDialog(playerid,DIALOG_SAGS_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:MD", Zann, "Spawn","Cancel");
	}
	return 1;
}