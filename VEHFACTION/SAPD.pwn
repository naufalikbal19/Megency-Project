CMD:despawnpd(playerid, params[])
{
	// Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1564.8981,-1656.3313,28.3979)
	|| IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1564.8981,-1656.3313,28.3979))
	{
		if(pData[playerid][pFaction] != 1)
	        return Error(playerid, "You must be at police officer faction!.");
	        
		new vehicleid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehicleid))
			return Error(playerid, "Kamu tidak berada didalam kendaraan.");

    	DestroyVehicle(SAPDVeh[playerid]);
		pData[playerid][pSpawnSapd] = 0;
    	GameTextForPlayer(playerid, "~w~SAPD Vehicles ~r~Despawned", 3500, 3);
    }
    return 1;
}
CMD:spawnpd(playerid, params[])
{
    // Sapd Vehicle
	if(IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1564.8981,-1656.3313,28.3979)
	|| IsPlayerInRangeOfPoint(playerid, 8.0, 1568.40, -1695.66, 5.89) || IsPlayerInRangeOfPoint(playerid, 8.0, 1564.8981,-1656.3313,28.3979))
	{
		if(pData[playerid][pFaction] != 1)
	        return Error(playerid, "You must be at police officer faction!.");

		if(pData[playerid][pSpawnSapd] == 1) return Error(playerid,"Anda sudah mengeluarkan 1 kendaraan.!");

	    new ZENN[10000], String[10000];
	    strcat(ZENN, "Vehicles Name\tType\n");
		format(String, sizeof(String), "Police Ls\tCars\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sf\tCars\n");// 597
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Lv\tCars\n");// 598
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Copcarru\tCars\n"); // 599
		strcat(ZENN, String);
		format(String, sizeof(String), "Police S.W.A.T\tCars\n"); // 601
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Enforcer\tCars\n"); // 427
		strcat(ZENN, String);
		format(String, sizeof(String), "Police F.B.I Truck\tCars\n"); // 528
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Infernus\tSport Cars\n"); // 411
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sultan\tUnique Cars\n"); // 560
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Sanchez\tMotorcycle\n"); // 468
		strcat(ZENN, String);
		format(String, sizeof(String), "Police FCR-900\tMotorcycle\n");  // 521
		strcat(ZENN, String);
		format(String, sizeof(String), "Police HPV-1000\tMotorcycle\n");  // 523
		strcat(ZENN, String);
		format(String, sizeof(String), "Police NRG-500\tMotorcyle\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police TowTruck\tTruck\n");// 596
		strcat(ZENN, String);
		format(String, sizeof(String), "Police Maverick\tHelicopter\n"); // 497
		strcat(ZENN, String);
		ShowPlayerDialog(playerid,DIALOG_SAPD_GARAGE, DIALOG_STYLE_TABLIST_HEADERS,"Static Vehicles SA:PD", ZENN, "Spawn","Cancel");
	}
	return 1;
}
