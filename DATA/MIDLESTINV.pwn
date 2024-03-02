#define MAX_INVENTORY 				20

new PlayerText:NAMETD[MAX_PLAYERS][MAX_INVENTORY];//
new PlayerText:MODELTD[MAX_PLAYERS][MAX_INVENTORY];//
new PlayerText:AMOUNTTD[MAX_PLAYERS][MAX_INVENTORY];//
new PlayerText:JUMLAH[MAX_PLAYERS];
new PlayerText:GUNAKAN[MAX_PLAYERS];
new PlayerText:BERIKAN[MAX_PLAYERS];
new PlayerText:BUANG[MAX_PLAYERS];
new PlayerText:TUTUP[MAX_PLAYERS];
new PlayerText:NamainvTD[MAX_PLAYERS];

new BukaInven[MAX_PLAYERS];

enum inventoryData
{
	invExists,
	invItem[32 char],
	invModel,
	invAmount,
};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
enum e_InventoryItems
{
	e_InventoryItem[32], //Nama item
	e_InventoryModel, //Object item
	e_InventoryTotal    //Quantity item
};
//Tambahkan item
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"Red Money", 1915, 1},
	{"HandPhone", 18867, 1},
	{"Radio", 19942, 1},
	{"Perban", 11736, 1},
	{"Painkiller", 1241, 1},
	{"Joran", 18632, 1},
	{"Jerigen", 19621, 1},
	{"Batu", 1303, 1},
	{"Batu Cucian", 828, 1},
	{"Emas", 19941, 1},
	{"Tembaga", 8040, 1},
	{"Alumunium", 8841, 1},

	{"Kamera", 367, 1},
	{"Tazer", 346, 1},
	{"Desert_Eagle", 348, 1},
	{"Parang", 339, 1},
	{"Molotov", 344, 1},
	{"Slc_9mm", 346, 1},

	{"Shotgun", 349, 1},
	{"Combat_Shotgun", 351, 1},
	{"MP5", 353, 1},
	{"M4", 356, 1},
	{"Clip", 19995, 1},

	{"Snack", 2663, 1},
	{"Kanabis", 800, 1},
	{"Marijuana", 1578, 1},
	{"Papeda_Ikan", 19811, 1},
	{"Kopi", 19835, 1},
	{"Sprunk", 1484, 1},
	{"Ciki", 19565, 1},
	{"Wool", 2751, 1},
	{"Pakaian", 2399, 1},
	{"Kain", 11747, 1},
	{"Myricous", 11748, 1},
	{"Potato", 18845, 1},
	{"Wheat", 818, 1},
	{"Orange", 19574, 1},


	{"Sagu", 1611, 1},
	{"Padi", 862, 1},
	{"Biji_Kopi", 18225, 1},
	{"Gula", 19824, 1},
	{"Ikan", 19630, 1},
	{"Daging", 2804, 1},
	{"Umpan", 19566, 1},
	{"Phone", 18867, 1},
	{"Phone_Book", 18867, 1},
	{"Flashlight", 18641, 1},
	{"Lock Pick", 11746, 1},
	{"Medicine", 19182, 1},
	{"Medkit", 11738, 1},
	{"Food", 19567, 1},

	{"Jus", 1546, 1},
	{"Susu", 19570, 1},
	{"Minyak", 2969, 1},
	{"Essence", 3015, 1},
	{"Jus", 1546, 1},
	{"Sampah", 2840, 1},
	{"Ayam Hidup", 19078, 1},
	{"Ayam Bungkus", 2768, 1},
	{"Nasi Bungkus", 2218, 1},
	{"Ikan Goreng", 19882, 1},
	{"Daging Ayam", 2806, 1},
	{"Burger", 2703, 1},
	{"Kebab", 2769, 1},

	{"Baking_Soda", 2821, 1},
	{"Asam_Muriatic", 19573, 1},
	{"Uang_Kotor", 1575, 1},
	{"Seed", 859, 1},
	{"Crack", 860, 1},
	{"Sparepart", 19473, 1},
	{"Meth", 1579, 1},
	{"Materials", 2041, 1},
	{"Component", 18996, 1},
	{"Vest", 1242, 1},
	{"Uang Aseli", 1212, 1},
	{"Boombox", 19143, 1}

};
stock Inventory_Clear(playerid)
{
	static
	    string[64];

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
			InventoryData[playerid][i][invAmount] = 0;
		}
	}
	return 1;
}

stock Inventory_GetItemID(playerid, item[])
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 20)
		return -1;

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    for(new i = 0; i < MAX_INVENTORY; i++) if (InventoryData[playerid][i][invExists]) {
        count++;
	}
	return count;
}
stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventoryData[playerid][itemid][invAmount];

	return 0;
}

stock PlayerHasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_Set(playerid, item[], model, amount)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventory_Addset(playerid, item, model, amount);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount);

	else if (amount < 1 && itemid != -1)
	    Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_SetQuantity(playerid, item[], quantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	{
	    InventoryData[playerid][itemid][invAmount] = quantity;
	}
	return 1;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	{
	    for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
		{
		    if (InventoryData[playerid][itemid][invAmount] > 0)
		    {
		        InventoryData[playerid][itemid][invAmount] -= quantity;
			}
			if (quantity == -1 || InventoryData[playerid][itemid][invAmount] < 1)
			{
			    InventoryData[playerid][itemid][invExists] = false;
			    InventoryData[playerid][itemid][invModel] = 0;
			    InventoryData[playerid][itemid][invAmount] = 0;
			}
			else if (quantity != -1 && InventoryData[playerid][itemid][invAmount] > 0)
			{
			    InventoryData[playerid][itemid][invAmount] = quantity;
			}
		}
		return 1;
	}
	return 0;
}
stock Inventory_Addset(playerid, item[], model, amount = 1)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	   		InventoryData[playerid][itemid][invExists] = true;
		    InventoryData[playerid][itemid][invModel] = model;
			InventoryData[playerid][itemid][invAmount] = amount;

		    strpack(InventoryData[playerid][itemid][invItem], item, 32 char);
		    return itemid;
		}
		return -1;
	}
	else
	{
		InventoryData[playerid][itemid][invAmount] += amount;
	}
	return itemid;
}

stock Inventory_Add(playerid, item[], model)
{
	new
		itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
         	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
			{
     	 	  	InventoryData[playerid][itemid][invExists] = true;
		        InventoryData[playerid][itemid][invModel] = model;
				InventoryData[playerid][itemid][invAmount] = model;
		        return itemid;
			}
		}
		return -1;
	}
	return itemid;
}

stock Inventory_Close(playerid)
{
    if(BukaInven[playerid] == 0)
		return Error(playerid, "Kamu Belum Membuka Inventory."), PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

	PlayerTextDrawSetString(playerid, JUMLAH[playerid], "Ammount");
		
	for(new i = 0; i < 32; i++)
	{
		TextDrawHideForPlayer(playerid, INVBOX[i]);
	}
	PlayerTextDrawHide(playerid, JUMLAH[playerid]);
	PlayerTextDrawHide(playerid, NamainvTD[playerid]);
	PlayerTextDrawHide(playerid, GUNAKAN[playerid]);
	PlayerTextDrawHide(playerid, BERIKAN[playerid]);
	PlayerTextDrawHide(playerid, BUANG[playerid]);
	PlayerTextDrawHide(playerid, TUTUP[playerid]);
	CancelSelectTextDraw(playerid);
	pData[playerid][pSelectItem] = -1;
	BukaInven[playerid] = 0;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
		PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
	}
	return 1;
}

stock Inventory_Show(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;
		
    pData[playerid][pGiveAmount] = 0;

	new str[256], string[256];
	BarangMasuk(playerid);
	BukaInven[playerid] = 1;
	format(str, sizeof(str), "%s", pData[playerid][pName]);
	PlayerTextDrawSetString(playerid, NamainvTD[playerid], str);
	for(new i = 0; i < 32; i++)
	{
		TextDrawShowForPlayer(playerid, INVBOX[i]);
	}
	PlayerPlaySound(playerid, 1039, 0,0,0);
	PlayerTextDrawShow(playerid, JUMLAH[playerid]);
	PlayerTextDrawShow(playerid, NamainvTD[playerid]);
	PlayerTextDrawShow(playerid, GUNAKAN[playerid]);
	PlayerTextDrawShow(playerid, BERIKAN[playerid]);
	PlayerTextDrawShow(playerid, BUANG[playerid]);
	PlayerTextDrawShow(playerid, TUTUP[playerid]);
	SelectTextDraw(playerid, COLOR_LBLUE);
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		PlayerTextDrawShow(playerid, AMOUNTTD[playerid][i]);

		if(InventoryData[playerid][i][invExists])
		{
			PlayerTextDrawShow(playerid, NAMETD[playerid][i]);
			PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][i], InventoryData[playerid][i][invModel]);

			//sesuakian dengan object item kalian
			if(InventoryData[playerid][i][invModel] == 18867)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], -254.000000, 0.000000, 0.000000, 2.779998);
			}
			else if(InventoryData[playerid][i][invModel] == 2703)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], -80.000000, 0.000000, -12.000000, 2.779998);
			}
			PlayerTextDrawShow(playerid, MODELTD[playerid][i]);
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%dx", InventoryData[playerid][i][invAmount]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
		}
	}
	return 1;
}

forward OnPlayerUseItem(playerid, itemid, name[]);
public OnPlayerUseItem(playerid, itemid, name[])
{
	if(!strcmp(name, "Snack"))
	{
	    if(pData[playerid][pHunger] > 95)
		    return Error(playerid, "Character kamu sudah kenyang");
		    
		pData[playerid][pSnack]--;
		pData[playerid][pHunger] += 15;
		//Info(playerid, "Anda telah berhasil menggunakan snack.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~SNACK");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	else if(!strcmp(name, "Sprunk"))
	{
	    if(pData[playerid][pEnergy] > 95)
		    return Error(playerid, "Character kamu tidak haus");
		    
	    pData[playerid][pSprunk]--;
		pData[playerid][pEnergy] += 15;
		//Info(playerid, "Anda telah berhasil meminum sprunk.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~SPRUNK");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	else if(!strcmp(name, "Marijuana"))
	{
	    new Float:armor;
		GetPlayerArmour(playerid, armor);
		if(armor+10 > 90) return Error(playerid, "Over dosis!");

		pData[playerid][pMarijuana]--;
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~r~MARIJUANA");
		SetPlayerArmourEx(playerid, armor+10);
		SetPlayerDrunkLevel(playerid, 4000);
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
 	else if(!strcmp(name, "Red Money"))
	{
	    Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Sparepart"))
	{
	    Error(playerid, "Items ini tidak bisa digunakan diluar jangkauan Point Sparepart");
	}
	else if(!strcmp(name, "Flashlight"))
	{
     	if(pData[playerid][pUsedFlashlight] == 0)
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
			if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
			SetPlayerAttachedObject(playerid, 8, 18656, 6, 0.25, -0.0175, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
			SetPlayerAttachedObject(playerid, 9, 18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s attach the flashlight to the gun.", ReturnName(playerid));

			pData[playerid][pUsedFlashlight] = 1;
		}
		else
		{
			RemovePlayerAttachedObject(playerid,8);
			RemovePlayerAttachedObject(playerid,9);
			pData[playerid][pUsedFlashlight] =0;
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take the flashlight off the gun.", ReturnName(playerid));
		}
	}
	else if(!strcmp(name, "Lock Pick"))
	{
	    Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Perban"))
	{
	    new Float:darah;
		GetPlayerHealth(playerid, darah);
		pData[playerid][pBandage]--;
		SetPlayerHealthEx(playerid, darah+15);
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~PERBAN");
	}
	else if(!strcmp(name, "Medicine"))
	{
	    pData[playerid][pMedicine]--;
		pData[playerid][pSick] = 0;
		pData[playerid][pSickTime] = 0;
		SetPlayerDrunkLevel(playerid, 0);
		//Info(playerid, "Anda menggunakan medicine.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~MEDICINE");

		//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	else if(!strcmp(name, "Medkit"))
	{
	    return callcmd::rescue(playerid, "rescue");
	}
	else if(!strcmp(name, "Jerigen"))
	{
	    if(IsPlayerInAnyVehicle(playerid))
			return Error(playerid, "Anda harus berada diluar kendaraan!");

		if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");

		new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
		if(IsValidVehicle(vehicleid))
		{
			new fuel = GetVehicleFuel(vehicleid);

			if(GetEngineStatus(vehicleid))
				return Error(playerid, "Turn off vehicle engine.");

			if(fuel >= 999.0)
				return Error(playerid, "This vehicle gas is full.");

			if(!IsEngineVehicle(vehicleid))
				return Error(playerid, "This vehicle can't be refull.");

			if(!GetHoodStatus(vehicleid))
				return Error(playerid, "The hood must be opened before refull the vehicle.");

			pData[playerid][pGas]--;
			Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			pData[playerid][pActivityStatus] = 1;
			pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			/*InfoTD_MSG(playerid, 10000, "Refulling...");
			//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));*/
			return 1;
		}
	}
	else if(!strcmp(name, "Materials"))
	{
	    Error(playerid, "Items ini tidak bisa digunakan");
	}
 	else if(!strcmp(name, "Component"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Food"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Myricous"))
	{
		pData[playerid][pObat]--;
		pData[playerid][pSick] = 0;
		pData[playerid][pSickTime] = 0;
		pData[playerid][pHead] = 100;
		pData[playerid][pPerut] = 100;
		pData[playerid][pRHand] = 100;
		pData[playerid][pLHand] = 100;
		pData[playerid][pRFoot] = 100;
		pData[playerid][pLFoot] = 100;
		SetPlayerDrunkLevel(playerid, 0);
		//Info(playerid, "Anda menggunakan Obat Myricous.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~MYRICOUS");

		//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	else if(!strcmp(name, "Padi"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Potato"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Wheat"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
 	else if(!strcmp(name, "Orange"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Ikan"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Ayam Hidup"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
 	else if(!strcmp(name, "Daging Ayam"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
 	else if(!strcmp(name, "Ayam Bungkus"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Nasi Bungkus"))
	{
	    if(pData[playerid][pHunger] > 95)
		    return Error(playerid, "Character kamu sudah kenyang");
		    
		pData[playerid][pNasi]--;
		pData[playerid][pHunger] += 20;
		//pData[playerid][pTrash] += 1;
		//Info(playerid, "Anda telah berhasil menggunakan snack dan terdapat sampah di inventory.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~NASI BUNGKUS");
		ApplyAnimation(playerid,"FOOD", "EAT_Burger", 4.0, 1, 0, 0, 0, 0, 1);
	}
	else if(!strcmp(name, "Ikan Goreng"))
	{
	    if(pData[playerid][pHunger] > 95)
		    return Error(playerid, "Character kamu sudah kenyang");
		    
		pData[playerid][pAGoreng]--;
		pData[playerid][pHunger] += 30;
	//	pData[playerid][pTrash] += 1;
		//Info(playerid, "Anda telah berhasil memakan Ikan Goreng dan terdapat sampah di inventory.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~IKAN GORENG");
		ApplyAnimation(playerid,"FOOD", "EAT_Burger", 4.0, 1, 0, 0, 0, 0, 1);
	}
 	else if(!strcmp(name, "Burger"))
	{
	    if(pData[playerid][pHunger] > 95)
		    return Error(playerid, "Character kamu sudah kenyang");
		    
		pData[playerid][pBurger]--;
		pData[playerid][pHunger] += 30;
		//pData[playerid][pTrash] += 1;
		//Info(playerid, "Anda telah berhasil menggunakan snack dan terdapat sampah di inventory.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~BURGER");
		ApplyAnimation(playerid,"FOOD", "EAT_Burger", 4.0, 1, 0, 0, 0, 0, 1);
	}
 	else if(!strcmp(name, "Kebab"))
	{
	    if(pData[playerid][pHunger] > 95)
		    return Error(playerid, "Character kamu sudah kenyang");
		    
		pData[playerid][pKebab]--;
		pData[playerid][pHunger] += 30;
	//	pData[playerid][pTrash] += 1;
		//Info(playerid, "Anda telah berhasil memakan kebab dan terdapat sampah di inventory.");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~KEBAB");
		ApplyAnimation(playerid,"FOOD", "EAT_Burger", 4.0, 1, 0, 0, 0, 0, 1);
	}
 	else if(!strcmp(name, "Susu"))
	{
        if(pData[playerid][pEnergy] > 95)
		    return Error(playerid, "Character kamu tidak haus");
		    
		pData[playerid][pSusu]--;
		pData[playerid][pEnergy] += 25;
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~g~SUSU");
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
 	else if(!strcmp(name, "Crack"))
	{
		new Float:armor;
		GetPlayerArmour(playerid, armor);
		if(armor+20 > 90) return Error(playerid, "Over dosis!");

		pData[playerid][pCrack]--;
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~r~CRACK");
		SetPlayerArmourEx(playerid, armor+20);
		SetPlayerDrunkLevel(playerid, 4000);
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	else if(!strcmp(name, "Batu"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Batu Cucian"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Emas"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Tembaga"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Alumunium"))
	{
		Error(playerid, "Items ini tidak bisa digunakan");
	}
	else if(!strcmp(name, "Uang Aseli"))
	{
		Error(playerid, "/pay Untuk Mengaksesnya");
	}
	else if(!strcmp(name, "Boombox"))
	{
		    new string[128], Float:BBCoord[4], pNames[MAX_PLAYER_NAME];
		    GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
		    GetPlayerFacingAngle(playerid, BBCoord[3]);
		    SetPVarFloat(playerid, "BBX", BBCoord[0]);
		    SetPVarFloat(playerid, "BBY", BBCoord[1]);
		    SetPVarFloat(playerid, "BBZ", BBCoord[2]);
		    GetPlayerName(playerid, pNames, sizeof(pNames));
		    BBCoord[0] += (2 * floatsin(-BBCoord[3], degrees));
		   	BBCoord[1] += (2 * floatcos(-BBCoord[3], degrees));
		   	BBCoord[2] -= 1.0;
			if(GetPVarInt(playerid, "PlacedBB")) return SCM(playerid, -1, "Kamu Sudah Memasang Boombox");
			foreach(new i : Player)
			{
		 		if(GetPVarType(i, "PlacedBB"))
		   		{
		  			if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")))
					{
		   				SendClientMessage(playerid, COLOR_WHITE, "Kamu Tidak Dapat Memasang Boombox Disini, Karena Orang Sudah Lain Sudah Memasang Boombox Disini");
					    return 1;
					}
				}
			}
			new string2[128];
			format(string2, sizeof(string2), "%s Telah Memasang Boombox!", pNames);
			SendNearbyMessage(playerid, 15, COLOR_PURPLE, string2);
			SetPVarInt(playerid, "PlacedBB", CreateDynamicObject(2102, BBCoord[0], BBCoord[1], BBCoord[2], 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			format(string, sizeof(string), "Creator "WHITE_E"%s\n["RED_E"/bbhelp for info"WHITE_E"]", pNames);
			SetPVarInt(playerid, "BBLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, BBCoord[0], BBCoord[1], BBCoord[2]+0.6, 5, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBArea", CreateDynamicSphere(BBCoord[0], BBCoord[1], BBCoord[2], 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBInt", GetPlayerInterior(playerid));
			SetPVarInt(playerid, "BBVW", GetPlayerVirtualWorld(playerid));
			ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
		    ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
	}
	else if(!strcmp(name, "Vest"))
	{
        new Float:armor;
		GetPlayerArmour(playerid, armor);
        
        pData[playerid][pVest]--;
        if(armor+100 > 200) return Error(playerid, "vest Kamu Sudah 200% !");
		InfoTD_MSG(playerid, 3000, "REMOVE 1x ~r~Vest");
		SetPlayerArmourEx(playerid, armor+100);
		ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
	}
	return 1;
}

stock CreatePlayerInv(playerid)
{
    NamainvTD[playerid] = CreatePlayerTextDraw(playerid, 139.000000, 111.000000, "Zuo Yousuke");
	PlayerTextDrawFont(playerid, NamainvTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, NamainvTD[playerid], 0.237498, 0.949998);
	PlayerTextDrawTextSize(playerid, NamainvTD[playerid], 361.000000, 0.000000);
	PlayerTextDrawSetOutline(playerid, NamainvTD[playerid], 0);
	PlayerTextDrawSetShadow(playerid, NamainvTD[playerid], 0);
	PlayerTextDrawAlignment(playerid, NamainvTD[playerid], 1);
	PlayerTextDrawColor(playerid, NamainvTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, NamainvTD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, NamainvTD[playerid], 50);
	PlayerTextDrawUseBox(playerid, NamainvTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, NamainvTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, NamainvTD[playerid], 0);

    JUMLAH[playerid] = CreatePlayerTextDraw(playerid, 421.000000, 182.000000, "Ammount");
	PlayerTextDrawFont(playerid, JUMLAH[playerid], 1);
	PlayerTextDrawLetterSize(playerid, JUMLAH[playerid], 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, JUMLAH[playerid], 9.000000, 47.000000);
	PlayerTextDrawSetOutline(playerid, JUMLAH[playerid], 0);
	PlayerTextDrawSetShadow(playerid, JUMLAH[playerid], 0);
	PlayerTextDrawAlignment(playerid, JUMLAH[playerid], 2);
	PlayerTextDrawColor(playerid, JUMLAH[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, JUMLAH[playerid], 255);
	PlayerTextDrawBoxColor(playerid, JUMLAH[playerid], 50);
	PlayerTextDrawUseBox(playerid, JUMLAH[playerid], 0);
	PlayerTextDrawSetProportional(playerid, JUMLAH[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, JUMLAH[playerid], 1);

	GUNAKAN[playerid] = CreatePlayerTextDraw(playerid, 422.000000, 209.500000, "Use");
	PlayerTextDrawFont(playerid, GUNAKAN[playerid], 1);
	PlayerTextDrawLetterSize(playerid, GUNAKAN[playerid], 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, GUNAKAN[playerid], 9.000000, 22.000000);
	PlayerTextDrawSetOutline(playerid, GUNAKAN[playerid], 0);
	PlayerTextDrawSetShadow(playerid, GUNAKAN[playerid], 0);
	PlayerTextDrawAlignment(playerid, GUNAKAN[playerid], 2);
	PlayerTextDrawColor(playerid, GUNAKAN[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, GUNAKAN[playerid], 255);
	PlayerTextDrawBoxColor(playerid, GUNAKAN[playerid], 50);
	PlayerTextDrawUseBox(playerid, GUNAKAN[playerid], 0);
	PlayerTextDrawSetProportional(playerid, GUNAKAN[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, GUNAKAN[playerid], 1);

	BERIKAN[playerid] = CreatePlayerTextDraw(playerid, 422.000000, 236.500000, "Give");
	PlayerTextDrawFont(playerid, BERIKAN[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BERIKAN[playerid], 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, BERIKAN[playerid], 9.000000, 26.500000);
	PlayerTextDrawSetOutline(playerid, BERIKAN[playerid], 0);
	PlayerTextDrawSetShadow(playerid, BERIKAN[playerid], 0);
	PlayerTextDrawAlignment(playerid, BERIKAN[playerid], 2);
	PlayerTextDrawColor(playerid, BERIKAN[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BERIKAN[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BERIKAN[playerid], 50);
	PlayerTextDrawUseBox(playerid, BERIKAN[playerid], 0);
	PlayerTextDrawSetProportional(playerid, BERIKAN[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BERIKAN[playerid], 1);

	BUANG[playerid] = CreatePlayerTextDraw(playerid, 422.000000, 264.000000, "Drop");
	PlayerTextDrawFont(playerid, BUANG[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BUANG[playerid], 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, BUANG[playerid], 9.000000, 27.500000);
	PlayerTextDrawSetOutline(playerid, BUANG[playerid], 0);
	PlayerTextDrawSetShadow(playerid, BUANG[playerid], 0);
	PlayerTextDrawAlignment(playerid, BUANG[playerid], 2);
	PlayerTextDrawColor(playerid, BUANG[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BUANG[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BUANG[playerid], 50);
	PlayerTextDrawUseBox(playerid, BUANG[playerid], 0);
	PlayerTextDrawSetProportional(playerid, BUANG[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BUANG[playerid], 1);

	TUTUP[playerid] = CreatePlayerTextDraw(playerid, 422.000000, 292.000000, "Close");
	PlayerTextDrawFont(playerid, TUTUP[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TUTUP[playerid], 0.300000, 1.350000);
	PlayerTextDrawTextSize(playerid, TUTUP[playerid], 9.000000, 28.000000);
	PlayerTextDrawSetOutline(playerid, TUTUP[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TUTUP[playerid], 0);
	PlayerTextDrawAlignment(playerid, TUTUP[playerid], 2);
	PlayerTextDrawColor(playerid, TUTUP[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TUTUP[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TUTUP[playerid], 50);
	PlayerTextDrawUseBox(playerid, TUTUP[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TUTUP[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TUTUP[playerid], 1);
	
    MODELTD[playerid][0] = CreatePlayerTextDraw(playerid, 144.000000, 132.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][0], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][0], 18866);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][0], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][0], 1, 1);

	MODELTD[playerid][1] = CreatePlayerTextDraw(playerid, 187.000000, 132.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][1], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][1], 2663);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][1], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][1], 1, 1);

	MODELTD[playerid][2] = CreatePlayerTextDraw(playerid, 232.000000, 133.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][2], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][2], 1484);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][2], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][2], 1, 1);

	MODELTD[playerid][3] = CreatePlayerTextDraw(playerid, 275.000000, 133.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][3], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][3], 1241);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][3], 1, 1);

	MODELTD[playerid][4] = CreatePlayerTextDraw(playerid, 319.000000, 132.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][4], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][4], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][4], 1650);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][4], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][4], 1, 1);

	MODELTD[playerid][5] = CreatePlayerTextDraw(playerid, 141.000000, 191.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][5], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][5], 2769);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][5], -112.000000, 0.000000, 43.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][5], 1, 1);

	MODELTD[playerid][6] = CreatePlayerTextDraw(playerid, 185.000000, 191.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][6], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][6], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][6], 11736);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][6], -58.000000, 6.000000, -36.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][6], 1, 1);

	MODELTD[playerid][7] = CreatePlayerTextDraw(playerid, 231.000000, 191.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][7], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][7], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][7], 11738);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][7], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][7], 1, 1);

	MODELTD[playerid][8] = CreatePlayerTextDraw(playerid, 275.000000, 191.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][8], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][8], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][8], 2041);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][8], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][8], 1, 1);

	MODELTD[playerid][9] = CreatePlayerTextDraw(playerid, 318.000000, 192.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][9], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][9], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][9], 19473);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][9], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][9], 1, 1);

	MODELTD[playerid][10] = CreatePlayerTextDraw(playerid, 142.000000, 250.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][10], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][10], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][10], 859);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][10], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][10], 1, 1);

	MODELTD[playerid][11] = CreatePlayerTextDraw(playerid, 187.000000, 250.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][11], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][11], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][11], 19577);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][11], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][11], 1, 1);

	MODELTD[playerid][12] = CreatePlayerTextDraw(playerid, 230.000000, 249.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][12], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][12], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][12], 815);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][12], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][12], 1, 1);

	MODELTD[playerid][13] = CreatePlayerTextDraw(playerid, 275.000000, 250.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][13], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][13], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][13], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][13], 19574);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][13], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][13], 1, 1);

	MODELTD[playerid][14] = CreatePlayerTextDraw(playerid, 314.000000, 256.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][14], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][14], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][14], 19078);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][14], 71.000000, 0.000000, 114.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][14], 1, 1);

	MODELTD[playerid][15] = CreatePlayerTextDraw(playerid, 143.000000, 311.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][15], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][15], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][15], 2806);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][15], -48.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][15], 1, 1);

	MODELTD[playerid][16] = CreatePlayerTextDraw(playerid, 187.000000, 311.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][16], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][16], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][16], 2768);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][16], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][16], 1, 1);

	MODELTD[playerid][17] = CreatePlayerTextDraw(playerid, 230.000000, 311.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][17], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][17], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][17], 1578);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][17], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][17], 1, 1);

	MODELTD[playerid][18] = CreatePlayerTextDraw(playerid, 275.000000, 311.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][18], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][18], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][18], 1579);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][18], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][18], 1, 1);

	MODELTD[playerid][19] = CreatePlayerTextDraw(playerid, 324.000000, 302.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][19], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][19], 36.000000, 44.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][19], 255);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][19], 2355);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][19], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][19], 1, 1);
	
 	NAMETD[playerid][0] = CreatePlayerTextDraw(playerid, 142.000000, 127.000000, "Smartphone");
	PlayerTextDrawFont(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][0], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][0], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][0], 0);

	NAMETD[playerid][1] = CreatePlayerTextDraw(playerid, 185.500000, 127.000000, "Snack");
	PlayerTextDrawFont(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][1], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][1], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][1], 0);

	NAMETD[playerid][2] = CreatePlayerTextDraw(playerid, 229.500000, 127.000000, "Sprunk");
	PlayerTextDrawFont(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][2], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][2], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][2], 0);

	NAMETD[playerid][3] = CreatePlayerTextDraw(playerid, 273.500000, 127.000000, "Bandage");
	PlayerTextDrawFont(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][3], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][3], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][3], 0);

	NAMETD[playerid][4] = CreatePlayerTextDraw(playerid, 317.500000, 127.000000, "Gas Fuel");
	PlayerTextDrawFont(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][4], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][4], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][4], 0);

	NAMETD[playerid][5] = CreatePlayerTextDraw(playerid, 142.000000, 186.000000, "Kebab");
	PlayerTextDrawFont(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][5], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][5], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][5], 0);

	NAMETD[playerid][6] = CreatePlayerTextDraw(playerid, 185.500000, 186.000000, "Medicine");
	PlayerTextDrawFont(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][6], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][6], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][6], 0);

	NAMETD[playerid][7] = CreatePlayerTextDraw(playerid, 229.500000, 186.000000, "Medkit");
	PlayerTextDrawFont(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][7], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][7], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][7], 0);

	NAMETD[playerid][8] = CreatePlayerTextDraw(playerid, 273.500000, 186.000000, "Material");
	PlayerTextDrawFont(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][8], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][8], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][8], 0);

	NAMETD[playerid][9] = CreatePlayerTextDraw(playerid, 317.500000, 186.000000, "Component");
	PlayerTextDrawFont(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][9], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][9], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][9], 0);

	NAMETD[playerid][10] = CreatePlayerTextDraw(playerid, 142.000000, 245.500000, "~g~[Farmer] ~w~Seed");
	PlayerTextDrawFont(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][10], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][10], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][10], 0);

	NAMETD[playerid][11] = CreatePlayerTextDraw(playerid, 185.500000, 245.500000, "~g~[Farmer] ~w~Potato");
	PlayerTextDrawFont(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][11], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][11], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][11], 0);

	NAMETD[playerid][12] = CreatePlayerTextDraw(playerid, 229.500000, 245.500000, "~g~[Farmer] ~w~Wheat");
	PlayerTextDrawFont(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][12], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][12], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][12], 0);

	NAMETD[playerid][13] = CreatePlayerTextDraw(playerid, 273.500000, 245.500000, "~g~[Farmer] ~w~Orange");
	PlayerTextDrawFont(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][13], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][13], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][13], 0);

	NAMETD[playerid][14] = CreatePlayerTextDraw(playerid, 317.500000, 245.500000, "Ayam Hidup");
	PlayerTextDrawFont(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][14], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][14], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][14], 0);

	NAMETD[playerid][15] = CreatePlayerTextDraw(playerid, 142.000000, 305.500000, "Ayam Potong");
	PlayerTextDrawFont(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][15], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][15], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][15], 0);

	NAMETD[playerid][16] = CreatePlayerTextDraw(playerid, 185.500000, 305.500000, "Ayam Fillet");
	PlayerTextDrawFont(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][16], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][16], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][16], 0);

	NAMETD[playerid][17] = CreatePlayerTextDraw(playerid, 229.500000, 305.500000, "~r~Marijuana");
	PlayerTextDrawFont(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][17], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][17], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][17], 0);

	NAMETD[playerid][18] = CreatePlayerTextDraw(playerid, 273.500000, 305.500000, "~r~Crack");
	PlayerTextDrawFont(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][18], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][18], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][18], 0);

	NAMETD[playerid][19] = CreatePlayerTextDraw(playerid, 317.500000, 305.500000, "Nasi Goreng");
	PlayerTextDrawFont(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][19], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][19], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawColor(playerid, NAMETD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][19], 0);

 	AMOUNTTD[playerid][0] = CreatePlayerTextDraw(playerid, 141.500000, 170.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][0], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][0], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][0], 0);

	AMOUNTTD[playerid][1] = CreatePlayerTextDraw(playerid, 185.000000, 170.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][1], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][1], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][1], 0);

	AMOUNTTD[playerid][2] = CreatePlayerTextDraw(playerid, 229.000000, 170.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][2], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][2], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][2], 0);

	AMOUNTTD[playerid][3] = CreatePlayerTextDraw(playerid, 273.000000, 170.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][3], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][3], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][3], 0);

	AMOUNTTD[playerid][4] = CreatePlayerTextDraw(playerid, 317.000000, 170.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][4], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][4], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][4], 0);

	AMOUNTTD[playerid][5] = CreatePlayerTextDraw(playerid, 141.500000, 229.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][5], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][5], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][5], 0);

	AMOUNTTD[playerid][6] = CreatePlayerTextDraw(playerid, 185.000000, 229.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][6], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][6], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][6], 0);

	AMOUNTTD[playerid][7] = CreatePlayerTextDraw(playerid, 229.000000, 229.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][7], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][7], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][7], 0);

	AMOUNTTD[playerid][8] = CreatePlayerTextDraw(playerid, 273.000000, 229.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][8], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][8], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][8], 0);

	AMOUNTTD[playerid][9] = CreatePlayerTextDraw(playerid, 317.000000, 229.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][9], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][9], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][9], 0);

	AMOUNTTD[playerid][10] = CreatePlayerTextDraw(playerid, 141.500000, 289.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][10], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][10], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][10], 0);

	AMOUNTTD[playerid][11] = CreatePlayerTextDraw(playerid, 185.000000, 289.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][11], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][11], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][11], 0);

	AMOUNTTD[playerid][12] = CreatePlayerTextDraw(playerid, 229.000000, 289.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][12], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][12], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][12], 0);

	AMOUNTTD[playerid][13] = CreatePlayerTextDraw(playerid, 273.000000, 289.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][13], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][13], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][13], 0);

	AMOUNTTD[playerid][14] = CreatePlayerTextDraw(playerid, 317.000000, 289.000000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][14], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][14], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][14], 0);

	AMOUNTTD[playerid][15] = CreatePlayerTextDraw(playerid, 141.500000, 349.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][15], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][15], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][15], 0);

	AMOUNTTD[playerid][16] = CreatePlayerTextDraw(playerid, 185.000000, 349.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][16], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][16], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][16], 0);

	AMOUNTTD[playerid][17] = CreatePlayerTextDraw(playerid, 229.000000, 349.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][17], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][17], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][17], 0);

	AMOUNTTD[playerid][18] = CreatePlayerTextDraw(playerid, 273.000000, 349.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][18], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][18], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][18], 0);

	AMOUNTTD[playerid][19] = CreatePlayerTextDraw(playerid, 317.000000, 349.500000, "0x");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][19], 0.158333, 0.800000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][19], 400.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][19], 0);
	return 1;
}

stock BarangMasuk(playerid)
{
	Inventory_Set(playerid, "Snack", 2663, pData[playerid][pSnack]);//
	Inventory_Set(playerid, "Sprunk", 1484, pData[playerid][pSprunk]);//
	Inventory_Set(playerid, "Marijuana", 1578, pData[playerid][pMarijuana]);//
	Inventory_Set(playerid, "Red Money", 1915, pData[playerid][pRedMoney]);//
	Inventory_Set(playerid, "Sparepart", 19473, pData[playerid][pSparepart]);//
	Inventory_Set(playerid, "Flashlight", 18641, pData[playerid][pFlashlight]);//
	Inventory_Set(playerid, "Lock Pick", 11746, pData[playerid][pLockPick]);//
	Inventory_Set(playerid, "Perban", 11736, pData[playerid][pBandage]);//
	Inventory_Set(playerid, "Medicine", 19182, pData[playerid][pMedicine]);//
	Inventory_Set(playerid, "Medkit", 11738, pData[playerid][pMedkit]);//
	Inventory_Set(playerid, "Jerigen", 19621, pData[playerid][pGas]);//
	Inventory_Set(playerid, "Materials", 2041, pData[playerid][pMaterial]);//
	Inventory_Set(playerid, "Component", 18996, pData[playerid][pComponent]);//
	Inventory_Set(playerid, "Food", 19567, pData[playerid][pFood]);//
	Inventory_Set(playerid, "Myricous", 11748, pData[playerid][pObat]);//
	Inventory_Set(playerid, "Padi", 862, pData[playerid][pSeed]);//
	Inventory_Set(playerid, "Potato", 18845, pData[playerid][pPotato]);//
	Inventory_Set(playerid, "Wheat", 818, pData[playerid][pWheat]);//
	Inventory_Set(playerid, "Orange", 19574, pData[playerid][pOrange]);//
	Inventory_Set(playerid, "Ikan", 19630, pData[playerid][pFish]);//
	Inventory_Set(playerid, "Ayam Hidup", 19078, pData[playerid][AyamHidup]);//
	Inventory_Set(playerid, "Daging Ayam", 2806, pData[playerid][AyamPotong]);//
	Inventory_Set(playerid, "Ayam Bungkus", 2768, pData[playerid][AyamFillet]);//
	Inventory_Set(playerid, "Nasi Bungkus", 2218, pData[playerid][pNasi]);//
	Inventory_Set(playerid, "Ikan Goreng", 19882, pData[playerid][pAGoreng]);//
	Inventory_Set(playerid, "Burger", 2703, pData[playerid][pBurger]);//
	Inventory_Set(playerid, "Kebab", 2769, pData[playerid][pKebab]);//
	Inventory_Set(playerid, "Susu", 19570, pData[playerid][pSusu]);//
	Inventory_Set(playerid, "Crack", 860, pData[playerid][pCrack]);//
	Inventory_Set(playerid, "Batu", 1303, pData[playerid][Batu]);//
	Inventory_Set(playerid, "Batu Cucian", 828, pData[playerid][BatuCucian]);//
	Inventory_Set(playerid, "Emas", 19941, pData[playerid][bEmas]);//
	Inventory_Set(playerid, "Tembaga", 8040, pData[playerid][bTembaga]);//
	Inventory_Set(playerid, "Alumunium", 8841, pData[playerid][bAlumunium]);//
	Inventory_Set(playerid, "Uang Aseli", 1212, pData[playerid][pMoney]);//
	Inventory_Set(playerid, "Boombox", 19143, pData[playerid][pBoombox]);
	Inventory_Set(playerid, "Vest", 1242, pData[playerid][pVest]);
	Inventory_Update(playerid);
}

stock Inventory_Update(playerid)
{
	new str[256], string[256];
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(InventoryData[playerid][i][invExists])
		{
			//sesuakian dengan object item kalian
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%d", InventoryData[playerid][i][invAmount]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
			PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
			PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		}
	}
}

stock MenuStore_SelectRow(playerid, row)
{
	pData[playerid][pSelectItem] = row;
    PlayerTextDrawHide(playerid,MODELTD[playerid][row]);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][row], COLOR_YELLOW);
	PlayerTextDrawShow(playerid,MODELTD[playerid][row]);
}

stock MenuStore_UnselectRow(playerid)
{
	if(pData[playerid][pSelectItem] != -1)
	{
		new row = pData[playerid][pSelectItem];
		PlayerTextDrawHide(playerid,MODELTD[playerid][row]);
		PlayerTextDrawBoxColor(playerid, MODELTD[playerid][row], COLOR_WHITE);
		PlayerTextDrawShow(playerid,MODELTD[playerid][row]);
	}

	pData[playerid][pSelectItem] = -1;
}
