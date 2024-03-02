enum BlinkingLights
{
	V_BLINK,
	V_BLINKING
};
enum vEnum
{
    bool:vSlight,
    vElm,
    vLights
};

new InfoVeh[MAX_VEHICLES][vEnum];
new g_vehicle_params[MAX_VEHICLES][BlinkingLights];
new sirenPD[5][MAX_VEHICLES];

forward BlinkingLight(playerid);
public BlinkingLight(playerid)
{
	new vehicleid = GetPVarInt(playerid,"BlinkVehID"), panels, doors, lights, tires;
	if(g_vehicle_params[vehicleid][V_BLINK] == 1)
{
GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

if(g_vehicle_params[vehicleid][V_BLINKING] == 1)
{
	UpdateVehicleDamageStatus(vehicleid, 0, doors, 1, tires);
	g_vehicle_params[vehicleid][V_BLINKING] = 69;
	}
		else if(g_vehicle_params[vehicleid][V_BLINKING] == 69)
		{
			UpdateVehicleDamageStatus(vehicleid, 0, doors, 69, tires);
			g_vehicle_params[vehicleid][V_BLINKING] = 0;
		}
		else if(g_vehicle_params[vehicleid][V_BLINKING] == 0)
		{
			UpdateVehicleDamageStatus(vehicleid, 0, doors, 1, tires);
			g_vehicle_params[vehicleid][V_BLINKING] = 4;
		}
		else
		{
			UpdateVehicleDamageStatus(vehicleid, 0, doors, 4, tires);
			g_vehicle_params[vehicleid][V_BLINKING] = 1;
		}
	}
}

CMD:slight(playerid, params[])
{
    new idveh = GetPlayerVehicleID(playerid);
    if(pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 3)
	if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "Anda tidak berada di dalam kendaraan");
    if(!InfoVeh[idveh][vSlight])
    {
        ToggleVehicleLightEx(idveh, 1);
        InfoVeh[idveh][vElm] = 0;
        InfoVeh[idveh][vSlight] = true;
    }
    else if(InfoVeh[idveh][vSlight])
    {
        InfoVeh[idveh][vElm] = 0;
        ToggleVehicleLightEx(idveh, InfoVeh[idveh][vLights]);
        static panels, tires, lights, doors;
        GetVehicleDamageStatus(idveh, panels, doors, lights, tires);
        UpdateVehicleDamageStatus(idveh, panels, doors, 0, tires);
        InfoVeh[idveh][vSlight] = false;
    }
    return 1;
}

function ToggleVehicleLightEx(vehicleid, toggle)
{
	static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, toggle, alarm, doors, bonnet, boot, objective);
    return true;
}

stock encodelight(light1, light2, light3, light4)
{
    return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);
}

task EmergencyLight[15]()
{
    for(new v = 1, x = GetVehiclePoolSize(); v <= x; v++)
    {
        if(InfoVeh[v][vSlight])
        {
            static panels, doors, lights, tires, elm;
            GetVehicleDamageStatus(v, panels, doors, lights, tires);

            switch(InfoVeh[v][vElm])
            {
                case 1:
                {
                    InfoVeh[v][vElm] = 0;
                    elm = 1;
                }
                case 0:
                {
                    elm = 2;
                    InfoVeh[v][vElm] = 1;
                }
            }

            if(elm == 1) lights = encodelight(0, 1, 0, 0);
            else if(elm == 2) lights = encodelight(0, 0, 1, 0);

            UpdateVehicleDamageStatus(v, panels, doors, lights, tires);
        }
    }
    return 1;
}

CMD:sirenmenu(playerid, params[])
{
	if(pData[playerid][pFaction] == 1 || pData[playerid][pFaction] == 3)
	{
		if(!IsPlayerInAnyVehicle(playerid) || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return Error(playerid, "Anda tidak berada di dalam kendaraan");
		ShowPlayerDialog(playerid, 7227, DIALOG_STYLE_LIST, "Vehicle Siren", "LSPD Car\n\
		SFPD Car\n\
		LVPD Car\n\
		Police Ranger\n\
		Sultan\n\
		Cheetah\n\
		Bullet\n\
		HPV1000\n\
		Enforcer\n\
		SWAT\n\
		Ambulance\n\
		Hapus Siren", "Select", "Close");
	}
	else return Error(playerid, "Anda bukan seorang anggota polisi maupun dokter");
	return 1;
}