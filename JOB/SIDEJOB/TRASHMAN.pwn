//coordinat point buang sampah
//2110.70, -2011.13, 13.54

//-------[SIDE JOB TRASHMASTER]-------
AddTrashVehicle()
{
	TrashVeh[0] = AddStaticVehicleEx(408, 2458.38, -2116.32, 14.11, 2.46, 1, 1, VEHICLE_RESPAWN);
	TrashVeh[1] = AddStaticVehicleEx(408, 2465.29, -2116.22, 14.09, 1.79, 1, 1, VEHICLE_RESPAWN);
	TrashVeh[2] = AddStaticVehicleEx(408, 2472.31, -2116.53, 14.08, 359.74, 1, 1, VEHICLE_RESPAWN);
	TrashVeh[3] = AddStaticVehicleEx(408, 2479.58, -2116.34, 14.10, 359.75, 1, 1, VEHICLE_RESPAWN);
}

CMD:unloadtrash(playerid, params[])
{
	if(pData[playerid][pSideJob] == 5)
	{
	 	if(!IsATrashVeh(GetPVarInt(playerid, "LastVehicleID")))
	 		return Servers(playerid, "Kendaraan yang terakhir kamu kendarai bukanlah kendaraan trashmaster");

	 	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	 		return Servers(playerid, "Anda harus keluar dari kendaraan");

	 	if(HaveTrash[playerid] == 1)
	 		return Servers(playerid, "Kamu sedang memegang sampah");

	 	for(new i = 0; i < MAX_Trash; i++)
	 	{
	 		if(IsPlayerInRangeOfPoint(playerid, 1.5, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
	 		{
	 			if(!IsPlayerInRangeOfPoint(playerid, 1.5, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
	 				return Servers(playerid, "Kamu harus berada di dekat tempat sampah");

				if(VehTrashLog[GetPVarInt(playerid, "LastVehicleID")] >= 5)
					return Servers(playerid, "Kamu Sudah memiliki 5 sampah di dalam truck.");

	 			if(TrashData[i][Sampah] <= 0)
	 				return Servers(playerid, "Trash ini tidak memiliki sampah");

	 			/*if(pData[playerid][pLoading] == true)
	 				return Servers(playerid, "Kamu masih unload trash");*/

	 			if(pData[playerid][pActivityTime] > 5)
	 				return Servers(playerid, "Kamu masih memiliki activity progress");

	 			pData[playerid][pActivityTime] = 100;
	 			// pData[playerid][pLoading] = true;
	 			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
	 			SetTimerEx("UnloadTrash", 5000, false, "ii", playerid, i);
	 			ShowProgressbar(playerid,"MENGAMBIL SAMPAH",  5);
	 		}
	 	}
	}
	else return Servers(playerid, "Kamu belum memulai pekerjaan sidejob trash master");
	return 1;
}
function UnloadTrash(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(pData[playerid][pSideJob] == 5)
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
	 	for(new i = 0; i < MAX_Trash; i++)
	 	{
				if(IsPlayerInRangeOfPoint(playerid, 1.5, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
				{
					if(totaltrash >= 5) return Servers(playerid, "Kamu sudah memiliki 5 sampah");
					pData[playerid][pActivityTime] = 0;
					HaveTrash[playerid] = 1;
					TrashData[i][Sampah] -= 10;
					SetPlayerAttachedObject(playerid, 9, 1264, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35);
					TogglePlayerControllable(playerid, 1);
					ClearAnimations(playerid);
                    TrashData[i][Sampah] -= 10;
					ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 0, 0, 0, 0, 0, 1);
					ShowProgressbar(playerid, "Memulung Sampah..", 1);
					Info(playerid, "Kamu berhasil mengambil sampah");
					Info(playerid, "Kamu taruh sampah di truck sampah /loadtrash");
					Trash_Save(i);
				}
        }
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
	 	for(new i = 0; i < MAX_Trash; i++)
	 	{
				if(IsPlayerInRangeOfPoint(playerid, 1.5, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]))
				{
					pData[playerid][pActivityTime] += 5;
				}
			}
		}
	}
	return 1;
}

CMD:loadtrash(playerid, params[])
{
	if(pData[playerid][pSideJob] == 5)
	{
		if(!IsATrashVeh(GetPVarInt(playerid, "LastVehicleID")))
	 		return Servers(playerid, "Kendaraan yang terakhir kamu kendarai bukanlah kendaraan trashmaster");

		if(HaveTrash[playerid] == 0)
	 		return Servers(playerid, "Kamu belum memegang sampah");

		new Float:x, Float:y, Float:z;
		GetVehicleBoot(GetPVarInt(playerid, "LastVehicleID"), x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 4.5, x, y, z))
			return Servers(playerid, "Kamu harus berada di bagian belakang kendaraan trashmaster yang kamu bawa");
		{
			HaveTrash[playerid] = 0;
			VehTrashLog[GetPVarInt(playerid, "LastVehicleID")] += 1;
			RemovePlayerAttachedObject(playerid, 9);
			Info(playerid, "Kamu berhasil menaruh sampah kedalam kendaraan, total muatan sampah di kendaraan: "GREEN_E"%d/5", VehTrashLog[GetPVarInt(playerid, "LastVehicleID")]);
		}

	 	if(VehTrashLog[GetPVarInt(playerid, "LastVehicleID")] >= 5)
	 	{
	 		DisablePlayerRaceCheckpoint(playerid);
	 		Info(playerid, "Kendaraanmu sudah penuh dengan sampah");
	 		Info(playerid, "Ikuti checkpoint yang sudah ditandai untuk membuang sampah");
	 		SetPlayerRaceCheckpoint(playerid, 1, 2436.29, -2113.88, 13.54, 0.0, 0.0, 0.0, 3.5);
	 		return 1;
	 	}
	}
	else return Servers(playerid, "Kamu belum memulai pekerjaan sidejob trash master");
	return 1;
}

CMD:jualsampah(playerid, params[])
{
    if(pData[playerid][pSideJob] == 5)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.5, 2436.29, -2113.88, 13.54))
		{
			new vehid = GetPlayerVehicleID(playerid);
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return Servers(playerid, "Kamu harus menaiki kendaraan");

			if(!IsATrashVeh(vehid))
				return Servers(playerid, "Kendaraan ini bukanlah kendaraan trash master");

			if(VehTrashLog[vehid] <= 0)
				return Servers(playerid, "Kendaraan ini tidak mengangkut sampah");

			new pay = VehTrashLog[vehid] * 50;
			Info(playerid, "Anda berhasil menjual sampah.");
			VehTrashLog[vehid] = 0;
			totaltrash = 0;
			pData[playerid][pSideJob] = 0;
			pData[playerid][pSideJobTime] = 250;

			DisablePlayerCheckpoint(playerid);
			AddPlayerSalary(playerid, "Sidejob(Trash Master)", pay);
			Info(playerid, "Sidejob(Trash Master) telah masuk ke pending salary anda!");
			RemovePlayerFromVehicle(playerid);
			SetTimerEx("RespawnPV", 3000, false, "d", vehid);
		}
		else return Servers(playerid, "Kamu tidak berada ditempat pembuangan sampah");
	}
	else return Servers(playerid, "Kamu belum memulai pekerjaan sidejob trash master");
	return 1;
}
