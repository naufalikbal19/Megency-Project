public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
 	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		if(playertextid == MODELTD[playerid][i])
		{
			if(InventoryData[playerid][i][invExists])
			{
			    MenuStore_SelectRow(playerid, i);
			    new name[48];
            	strunpack(name, InventoryData[playerid][pData[playerid][pSelectItem]][invItem]);
			}
			else
			{
			    MenuStore_UnselectRow(playerid);
			    Error(playerid,"[Inventory] Tidak Ada Barang Di Slot Tersebut");
			}
		}
	}
	if(playertextid == GUNAKAN[playerid])
	{
		new id = pData[playerid][pSelectItem];

		if(id == -1)
		{
		    Error(playerid,"[Inventory] Tidak Ada Barang Di Slot Tersebut");
		}
		else
		{
			new string[64];
		    strunpack(string, InventoryData[playerid][id][invItem]);

		    if(!PlayerHasItem(playerid, string))
		    {
		   		Error(playerid,"[Inventory] Kamu Tidak Memiliki Barang Tersebut");
				MenuStore_UnselectRow(playerid);
                Inventory_Show(playerid);
			}
			else
			{
				CallLocalFunction("OnPlayerUseItem", "dds", playerid, id, string);
				Inventory_Close(playerid);
			}
		}
	}
	else if(playertextid == TUTUP[playerid])
	{
		Inventory_Close(playerid);
	}
	else if(playertextid == BERIKAN[playerid])
	{
		new id = pData[playerid][pSelectItem], str[500], count = 0;
		if(id == -1)
		{
			Info(playerid,"[Inventory] Pilih Barang Terlebih Dahulu");
		}
		else
		{
		    if (pData[playerid][pGiveAmount] < 1)
				return Info(playerid,"[Inventory] Masukan Jumlah Terlebih Dahulu"), PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

			//ShowPlayerDialog(playerid, DIALOG_GIVE, DIALOG_STYLE_INPUT, "Memberikan Barang", "Kantong Yang Ingin Di Berikan:", "Berikan", "Batal");
			foreach(new i : Player) if(IsPlayerConnected(i) && NearPlayer(playerid, i, 1) && i != playerid)
			{
				format(str, sizeof(str), "Kantong: %d\n", i);
				SetPlayerListitemValue(playerid, count++, i);
			}
			if(!count) ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Shine Green - Inventory", "Tidak ada player disekitarmu", "Tutup", ""), PlayerPlaySound(playerid, 1055, 0.0, 0.0, 0.0);
			else ShowPlayerDialog(playerid, DIALOG_GIVE, DIALOG_STYLE_LIST, "Shine Green - Inventory", str, "Pilih", "Tutup");
		}
	}
	else if(playertextid == JUMLAH[playerid])
	{
		ShowPlayerDialog(playerid, DIALOG_AMOUNT, DIALOG_STYLE_INPUT, "Jumlah", "Masukan Jumlah:", "Enter", "Batal");
	}
	else if(playertextid == BUANG[playerid])
	{
		Error(playerid, "Fitur Ini Dinonaktifkan Oleh Server");
	}
	if(playertextid == KLIKKEMBALI[playerid])
	{
		for(new i = 0; i < 29; i++)
		{
			PlayerTextDrawHide(playerid, TDHPV2[playerid][i]);
		}
		PlayerTextDrawHide(playerid, KLIKKEMBALI[playerid]); 
		PlayerTextDrawHide(playerid, KLIKSMS[playerid]); 
		PlayerTextDrawHide(playerid, KLIKGPS[playerid]); 
		PlayerTextDrawHide(playerid, KLIKKONTAK[playerid]); 
		PlayerTextDrawHide(playerid, KLIKRUMAH[playerid]); 
		PlayerTextDrawHide(playerid, KLIKTW[playerid]); 
		PlayerTextDrawHide(playerid, KLIKSHARELOC[playerid]); 
		PlayerTextDrawHide(playerid, KLIKSETTING[playerid]); 
		PlayerTextDrawHide(playerid, KLIKCALL[playerid]); 
		PlayerTextDrawHide(playerid, KLIKPS[playerid]); 
		CancelSelectTextDraw(playerid);
	}
    if(playertextid == KLIKSMS[playerid])
    {
    	if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		ShowPlayerDialog(playerid, DIALOG_PHONE_SENDSMS, DIALOG_STYLE_INPUT, "Tulis Pesan Text", "Silahkan Tulis Pesan Yang Akan Dikirim:", "Select", "Back");
    }
    if(playertextid == KLIKGPS[playerid])
    {
    	if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
    }
    if(playertextid == KLIKKONTAK[playerid])
    {
    	if (pData[playerid][pPhoneStatus] == 0)
			return Error(playerid, "Your phone must be powered on.");

		if(pData[playerid][pPhoneBook] == 0)
			return Error(playerid, "You dont have a phone book.");

		ShowContacts(playerid);
    }
    if(playertextid == KLIKRUMAH[playerid])
    {
    	return callcmd::myhouse(playerid);
    }
    if(playertextid == KLIKTW[playerid])
    {
    	new notif[20];
		if(pData[playerid][pTwitterStatus] == 1)
		{
			notif = "{ff0000}OFF";
		}
		else
		{
			notif = "{3BBD44}ON";
		}

		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		if(pData[playerid][pTwitter] < 1)
		{	
			return Error(playerid, "Anda belum memiliki Twitter, harap download!");
		}

		new string[100];
		format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: %s", pData[playerid][pTwittername], notif);
		//format(string, sizeof(string), "Tweet\nChangename Twitter({0099ff}%s{ffffff})\nNotification: %s", pData[playerid][pTwittername], notif);
		ShowPlayerDialog(playerid, DIALOG_TWITTER, DIALOG_STYLE_LIST, "Twitter", string, "Select", "Close");
    }
    if(playertextid == KLIKSHARELOC[playerid])
    {
    	if(pData[playerid][pPhoneStatus] == 0)
    	{
    		return Error(playerid, "Headphone Kamu Sedang Mati");
    	}
    	ShowPlayerDialog(playerid, DIALOG_PHONE_SHARELOC, DIALOG_STYLE_INPUT, "Shareloc System", "TAHAP PENGEMBANGAN UNTUK SEMENTARA GUNAKAN /reqloc", "Select", "Cancel");
    }
    if(playertextid == KLIKSETTING[playerid])
    {
    	ShowPlayerDialog(playerid, DIALOG_TOGGLEPHONE, DIALOG_STYLE_LIST, "Setting", "Phone On\nPhone Off", "Select", "Back");
    }
    if(playertextid == KLIKCALL[playerid])
    {
    	if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		
		ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Masukan Nomor", "Silahkan Tulis Nomor Yang Ingin Anda Telpon:", "Dial", "Back");
    }
    if(playertextid == KLIKPS[playerid])
    {
    	if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		new string[512];
		format(string, sizeof(string),"App Store\nIsi Kuota");
		ShowPlayerDialog(playerid, DIALOG_ISIKUOTA, DIALOG_STYLE_LIST,"Phone",string,"Pilih","Batal");
    }
	if(playertextid == KLIKSTATS[playerid])
	{
		hidepanel(playerid);
		return callcmd::stats(playerid, "stats");
	}
	if(playertextid == KLIKINV[playerid])
	{
		hidepanel(playerid);
		return callcmd::i(playerid, "");
	}
	if(playertextid == KLIKHP[playerid])
	{
		hidepanel(playerid);
		return callcmd::phone(playerid, "");
	}
	if(playertextid == KLIKTOYS[playerid])
	{
		if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "This command can only be used on foot, exit your vehicle!");
		if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "You must be logged in to attach objects to your character!");
		new string[350];
		if(pToys[playerid][0][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 1\n");
		}
		else strcat(string, ""dot"Slot 1 "RED_E"(Used)\n");

		if(pToys[playerid][1][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 2\n");
		}
		else strcat(string, ""dot"Slot 2 "RED_E"(Used)\n");

		if(pToys[playerid][2][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 3\n");
		}
		else strcat(string, ""dot"Slot 3 "RED_E"(Used)\n");

		if(pToys[playerid][3][toy_model] == 0)
		{
		    strcat(string, ""dot"Slot 4\n");
		}
		else strcat(string, ""dot"Slot 4 "RED_E"(Used)\n");
		
		strcat(string, ""dot">"RED_E"Reset Toys");

		ShowPlayerDialog(playerid, DIALOG_TOY, DIALOG_STYLE_LIST, ""RED_E"SHINE GREEN RP: "WHITE_E"Player Toys", string, "Select", "Cancel");
		hidepanel(playerid);
	}
	if(playertextid == KLIKVEH[playerid])
	{
		hidepanel(playerid);
	    return callcmd::mypv(playerid, "");
	}
	if(playertextid == KLIKEXIT[playerid])
	{
		hidepanel(playerid);
	}
	if(playertextid == KLIKMTK[playerid])
	{
		return Error(playerid, "Vitur Ini Telah Dihapus oleh Server.");
	}
    return 1;
}

