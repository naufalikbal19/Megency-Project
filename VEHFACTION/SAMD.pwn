CMD:despawnmd(playerid, params[])
{
	// Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1090.036132,-1360.547851,19.967163) || IsPlayerInRangeOfPoint(playerid, 8.0, 1162.471313,-1313.788330,31.492673))
	{
		if(pData[playerid][pFaction] != 3)
	        return Error(playerid, "You must be at medical officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAMDVeh[playerid]);
		pData[playerid][pSpawnSamd] = 0;
    	GameTextForPlayer(playerid, "~w~SAMD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnmd(playerid, params[])
{
    // Samd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1090.036132,-1360.547851,19.967163))
	{
		if(pData[playerid][pFaction] != 3)
	        return Error(playerid, "You must be at medical officer faction!.");

		if(pData[playerid][pSpawnSamd] == 1) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new Zann[10000], String[10000];
	    strcat(Zann, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Ambulance\tCars\n");// 596
		strcat(Zann, String);
		format(String, sizeof(String), "Fire Truck\tCars\n");// 597
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter\tCars\n");// 598
		strcat(Zann, String);
		format(String, sizeof(String), "Helicopter 2\tCars\n"); // 599
		strcat(Zann, String);
		format(String, sizeof(String), "Fire Truck 2\tCars\n"); // 599
		strcat(Zann, String);
		ShowPlayerDialog(playerid,DIALOG_SAMD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:MD", Zann, "Spawn","Cancel");
	}
	return 1;
}