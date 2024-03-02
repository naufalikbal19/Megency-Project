#include <YSI\y_hooks>

hook OnGameModeInit()
{
    for (new i; i < sizeof(ColorList); i++) {
        format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 16 == 0) ? ("\n") : (""));
    }

    for (new i; i < sizeof(FontNames); i++) {
        format(object_font, sizeof(object_font), "%s%s\n", object_font, FontNames[i]);
    }

    TransFender = LoadModelSelectionMenu("transfender.txt");
	viptoyslist = LoadModelSelectionMenu("viptoys.txt");
	vtoylist = LoadModelSelectionMenu("vtoylist.txt");
	Waa = LoadModelSelectionMenu("waa.txt");
	LoCo = LoadModelSelectionMenu("loco.txt");
    return 1; 
}

hook OnPlayerModelSelection(playerid, response, listid, modelid)
{
    //modshop
	if(listid == TransFender)
	{
		if(response)
        {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, COLOR_ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}

	if(listid == Waa)
	{
		if(response)
        {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, COLOR_ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}

	if(listid == LoCo)
	{
		if(response)
        {
            new
            price = 5000,
            vehicleid
            ;

            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
                return Error(playerid, "You need to be inside vehicle as driver");

            vehicleid = Vehicle_Nearest(playerid);

            if(vehicleid == -1)
                return 0;

            Vehicle_ObjectAddObjects(playerid, vehicleid, modelid, OBJECT_TYPE_BODY);

            SendClientMessageEx(playerid, COLOR_ARWIN,"MODSHOP: "WHITE_E"You have purchased a {00FFFF}%s "WHITE_E"for "GREEN_E"$%s.", GetVehObjectNameByModel(modelid), FormatMoney(price));
        }
	}
    if(listid == vtoylist)
	{
		if(response)
		{
			new x = pData[playerid][VehicleID], Float:vPosx, Float:vPosy, Float:vPosz;
			GetVehiclePos(x, vPosx, vPosy, vPosz);
			foreach(new i: PVehicles)
			if(x == pvData[i][cVeh])
			{
				new vehid = pvData[i][cVeh];
				new toyslotid = pvData[vehid][vtoySelected];
				vtData[vehid][toyslotid][vtoy_modelid] = modelid;

				if(pvData[vehid][PurchasedvToy] == false) 			// Cek kalo gada database di mysql auto di buat
				{
					MySQL_CreateVehicleToy(i);
				}

				printf("VehicleID: %d, Object: %d, Pos: (%f ,%f, %f), ToySlotID: %d", vehid, vtData[vehid][toyslotid][vtoy_modelid], vPosx, vPosy, vPosz, toyslotid);

				vtData[vehid][toyslotid][vtoy_model] = CreateObject(modelid, vPosx, vPosy, vPosz, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(vtData[vehid][toyslotid][vtoy_model], vehid, vtData[vehid][toyslotid][vtoy_x], vtData[vehid][toyslotid][vtoy_y], vtData[vehid][toyslotid][vtoy_z], vtData[vehid][toyslotid][vtoy_rx], vtData[vehid][toyslotid][vtoy_ry], vtData[vehid][toyslotid][vtoy_rz]);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memasang toys untuk vehicleid(%d) object ID %d", ReturnName(playerid), vehid, modelid);
				ShowPlayerDialog(playerid, DIALOG_MODTACCEPT, DIALOG_STYLE_MSGBOX, "Vehicle Toys", "Do You Want To Save it?", "Yes", "Cancel");
			}
		}
		else return Servers(playerid, "Canceled buy toys");
	}
    if(listid == vtoylist)
	{
		if(response)
		{
			new x = pData[playerid][VehicleID], Float:vPosx, Float:vPosy, Float:vPosz;
			GetVehiclePos(x, vPosx, vPosy, vPosz);
			foreach(new i: PVehicles)
			if(x == pvData[i][cVeh])
			{
				new vehid = pvData[i][cVeh];
				new toyslotid = pvData[vehid][vtoySelected];
				vtData[vehid][toyslotid][vtoy_modelid] = modelid;

				if(pvData[vehid][PurchasedvToy] == false) 			// Cek kalo gada database di mysql auto di buat
				{
					MySQL_CreateVehicleToy(i);
				}

				printf("VehicleID: %d, Object: %d, Pos: (%f ,%f, %f), ToySlotID: %d", vehid, vtData[vehid][toyslotid][vtoy_modelid], vPosx, vPosy, vPosz, toyslotid);

				vtData[vehid][toyslotid][vtoy_model] = CreateObject(modelid, vPosx, vPosy, vPosz, 0.0, 0.0, 0.0);
				AttachObjectToVehicle(vtData[vehid][toyslotid][vtoy_model], vehid, vtData[vehid][toyslotid][vtoy_x], vtData[vehid][toyslotid][vtoy_y], vtData[vehid][toyslotid][vtoy_z], vtData[vehid][toyslotid][vtoy_rx], vtData[vehid][toyslotid][vtoy_ry], vtData[vehid][toyslotid][vtoy_rz]);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memasang toys untuk vehicleid(%d) object ID %d", ReturnName(playerid), vehid, modelid);
				ShowPlayerDialog(playerid, DIALOG_MODTACCEPT, DIALOG_STYLE_MSGBOX, "Vehicle Toys", "Do You Want To Save it?", "Yes", "Cancel");
			}
		}
		else return Servers(playerid, "Canceled buy toys");
	}
    return 1;
}