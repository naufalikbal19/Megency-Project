//PROJEK JOB NAMBANG BY BAGASS
//JOBS
function nambang1(playerid)
{
	new dapetbatu = RandomEx(1,4);
	if(pData[playerid][pActivityTime] >= 100)
	{
	    pData[playerid][Batu] += dapetbatu;
	    pData[playerid][pMenambangStatus] -= 1;
	    pData[playerid][pActivityTime] = 0;
	    KillTimer(pData[playerid][timerambilbatu]);
	    HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	    PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	    RemovePlayerAttachedObject(playerid, 3);
	    TogglePlayerControllable(playerid, 1);
	    ClearAnimations(playerid);
		if(dapetbatu == 1)
		{
			InfoTD_MSG(playerid, 800, "~g~Batu +1");
		}
		if(dapetbatu == 1)
		{
			InfoTD_MSG(playerid, 800, "~g~Batu +1");
		}
		if(dapetbatu == 1)
		{
			InfoTD_MSG(playerid, 800, "~g~Batu +1");
		}
		if(dapetbatu == 1)
		{
			InfoTD_MSG(playerid, 800, "~g~Batu +1");
		}
	}
	else if(pData[playerid][pActivityTime] < 100)
    {
        pData[playerid][pActivityTime] += 5;
        SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
        ApplyAnimation(playerid,"GRENADE","WEAPON_throw",4.0, 1, 0, 0, 0, 0, 1);
		SetPlayerAttachedObject(playerid, 3, 18635, 6, 0.000000, -0.025000, 0.066000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
    }
	return 1;
}
CMD:wehdcweydshdddf(playerid, params[])
{
	if(pData[playerid][pJob] == 11 || pData[playerid][pJob2] == 11)
    {
        new total = pData[playerid][Batu];
        if(total > 10) return Error(playerid, "Batu terlalu penuh di Inventory! Maximal 10.");
        if(pData[playerid][pBladder] == 85) return Error(playerid, "Anda Sedang Stres,Pergilah Ke Tempat santai!");
        if(pData[playerid][pMenambangStatus] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
        if(pData[playerid][Batu] == 10) return Error(playerid, "Anda sudah membawa 10 Batu!");
        TogglePlayerControllable(playerid, 0);
        ApplyAnimation(playerid,"GRENADE","WEAPON_throw",4.0, 1, 0, 0, 0, 0, 1);
		SetPlayerAttachedObject(playerid, 3, 18635, 6, 0.000000, -0.025000, 0.066000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
        pData[playerid][pMenambangStatus] += 1;
        pData[playerid][timerambilbatu] = SetTimerEx("nambang1", 400, true, "id", playerid);
        PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Menambang...");
        PlayerTextDrawShow(playerid, ActiveTD[playerid]);
        ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
    }
	return 1;
}
enum E_PENAMBANG
{
    STREAMER_TAG_MAP_ICON:LockerMap,
    STREAMER_TAG_MAP_ICON:NambangMap,
    STREAMER_TAG_MAP_ICON:CuciMap,
    STREAMER_TAG_MAP_ICON:PeleburanMap,
    STREAMER_TAG_MAP_ICON:PenjualanMap,
	STREAMER_TAG_CP:LockerTambang,
	STREAMER_TAG_CP:TakeCarTambang,
	STREAMER_TAG_CP:Nambang,
	STREAMER_TAG_CP:Nambang2,
	STREAMER_TAG_CP:Nambang3,
	STREAMER_TAG_CP:Nambang4,
	STREAMER_TAG_CP:Nambang5,
	STREAMER_TAG_CP:Nambang6,
	STREAMER_TAG_CP:CuciBatu,
	STREAMER_TAG_CP:Peleburan,
	STREAMER_TAG_CP:Penjualan,
}

CMD:fviewefgredbde(playerid, params[])
{
    if(pData[playerid][pJob] == 11 || pData[playerid][pJob2] == 11)
    {
	    if(pData[playerid][pCuciStatus] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	    if(pData[playerid][pBladder] == 85) return Error(playerid, "Anda Sedang Stres,Pergilah Ke Tempat santai!");
	    if(pData[playerid][Batu] < 1) return Error(playerid, "Anda Tidak Memiliki Batu ( Max 1 )");
	    TogglePlayerControllable(playerid, 0);
	    ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
	    pData[playerid][pCuciStatus] += 1;
	    pData[playerid][timerpencucianbatu] = SetTimerEx("cucibatu", 300, true, "id", playerid);
	    PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Mencuci Batuan...");
	    PlayerTextDrawShow(playerid, ActiveTD[playerid]);
	    pData[playerid][BatuCucian] += 1;
        pData[playerid][Batu] -= 1;
	    ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
    }
	return 1;
}

forward cucibatu(playerid);
public cucibatu(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(pData[playerid][pActivityTime] >= 100)
    {
        KillTimer(pData[playerid][timerpencucianbatu]);
        pData[playerid][pActivityTime] = 0;
        pData[playerid][pCuciStatus] -= 1;
        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid, 1);
        InfoTD_MSG(playerid, 5000, "~g~Batu ~w~-5 ~g~Batu Cucian ~w~+5");
        return 1;
    }
    else if(pData[playerid][pActivityTime] < 100)
    {
        pData[playerid][pActivityTime] += 5;
        SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
        ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
    }
    return 1;
}

CMD:uwdhewvdtwedbb(playerid, params[])
{
    if(pData[playerid][pJob] == 11 || pData[playerid][pJob2] == 11)
    {
	    if(pData[playerid][pLeburStatus] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
	    if(pData[playerid][pBladder] == 85) return Error(playerid, "Anda Sedang Stres,Pergilah Ke Tempat santai!");
	    if(pData[playerid][bTembaga] == 30) return Error(playerid, "Anda Sudah Membawa 30 Tembaga!");
	    if(pData[playerid][bEmas] == 30) return Error(playerid, "Anda Sudah Membawa 30 Emas!");
	    if(pData[playerid][bAlumunium] == 30) return Error(playerid, "Anda Sudah Membawa 30 Aluminium!");
	    if(pData[playerid][BatuCucian] < 1) return Error(playerid, "Anda Tidak Memiliki Batu Cucian");
	    TogglePlayerControllable(playerid, 0);
	    ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
	    pData[playerid][pLeburStatus] += 1;
	    pData[playerid][timerpeleburanbatu] = SetTimerEx("leburkanbatuan", 400, true, "id", playerid);
	    PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Meleburkan Batuan...");
	    PlayerTextDrawShow(playerid, ActiveTD[playerid]);
	    ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
    }
	return 1;
}

function leburkanbatuan(playerid)
{
    new rand = RandomEx(1, 4);
    new mstr[64];
    if(!IsPlayerConnected(playerid)) return 0;
    if(pData[playerid][pActivityTime] >= 100)
    {
        TogglePlayerControllable(playerid, 1);
        if(rand == 1)
		{
		    new rand1 = RandomEx(2, 4);
			pData[playerid][bEmas] += rand1;
		  	pData[playerid][BatuCucian] -= 1;
			format(mstr, sizeof(mstr), "~y~Emas ~w~+%d ~g~Batu Cucian ~w~-1", rand1);
			InfoTD_MSG(playerid, 5000, mstr);
		}
		if(rand == 2)
		{
		    new rand2 = RandomEx(3, 8);
			pData[playerid][bTembaga] += rand2;
		  	pData[playerid][BatuCucian] -= 1;
			format(mstr, sizeof(mstr), "~g~Tembaga ~w~+%d ~g~Batu Cucian ~w~-1", rand2);
			InfoTD_MSG(playerid, 5000, mstr);
		}
		if(rand == 3)
		{
			new rand3 = RandomEx(4, 7);
			pData[playerid][bAlumunium] += rand3;
		  	pData[playerid][BatuCucian] -= 1;
			format(mstr, sizeof(mstr), "~g~Alumunium ~w~+%d ~g~Batu Cucian ~w~-1", rand3);
			InfoTD_MSG(playerid, 5000, mstr);
		}
  		if(rand == 4)
		{
		    new rand2 = RandomEx(1, 1);
			format(mstr, sizeof(mstr), "~g~Anda Tidak Mendapatkan Apa Apa Yahaha. ~w~-1", rand2);
			InfoTD_MSG(playerid, 5000, mstr);
		}
        KillTimer(pData[playerid][timerpeleburanbatu]);
        pData[playerid][pActivityTime] = 0;
        pData[playerid][pLeburStatus] -= 1;
        HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
        PlayerTextDrawHide(playerid, ActiveTD[playerid]);
        ClearAnimations(playerid);
        return 1;
    }
    else if(pData[playerid][pActivityTime] < 100)
    {
        pData[playerid][pActivityTime] += 5;
        SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    }
	return 1;
}

CMD:uvfbrtyhpukik(playerid, params[])
{
    new total = pData[playerid][bEmas];
    if( pData[playerid][bEmas] < 1) return Error(playerid, "Anda Tidak Memiliki Emas");
	new pay = pData[playerid][bEmas] * 10;
	GivePlayerMoneyEx(playerid, pay);
	pData[playerid][bEmas] -= total;
	new str[500];
	format(str, sizeof(str), "Uang_%dx / Emas_%dx", pay, total);
	InfoTD_MSG(playerid, 5000, str);
    Inventory_Update(playerid);
	return 1;
}

CMD:ebydtcyvrvnfbv(playerid, params[])
{
    new total = pData[playerid][bAlumunium];
    if( pData[playerid][bAlumunium] < 1) return Error(playerid, "Anda Tidak Memiliki Alumunium");
	new pay = pData[playerid][bAlumunium] * 5;
	GivePlayerMoneyEx(playerid, pay);
	pData[playerid][bAlumunium] -= total;
	new str[500];
	format(str, sizeof(str), "Uang_%dx / Alumunium_%dx", pay, total);
	InfoTD_MSG(playerid, 5000, str);
    Inventory_Update(playerid);
	return 1;
}
CMD:pofcdbxvcfw(playerid, params[])
{
    new total = pData[playerid][bTembaga];
    if( pData[playerid][bTembaga] < 1) return Error(playerid, "Anda Tidak Memiliki Tembaga");
	new pay = pData[playerid][bTembaga] * 7;
	GivePlayerMoneyEx(playerid, pay);
	pData[playerid][bTembaga] -= total;
	new str[500];
	format(str, sizeof(str), "Uang_%dx / Tembaga_%dx", pay, total);
	InfoTD_MSG(playerid, 5000, str);
    Inventory_Update(playerid);
	return 1;
}

function TungguNambang1(playerid)
{
	pData[playerid][pTimeTambang1] = 0;
	return 1;
}
function TungguNambang2(playerid)
{
	pData[playerid][pTimeTambang2] = 0;
	return 1;
}
function TungguNambang3(playerid)
{
	pData[playerid][pTimeTambang3] = 0;
	return 1;
}
function TungguNambang4(playerid)
{
	pData[playerid][pTimeTambang4] = 0;
	return 1;
}
function TungguNambang5(playerid)
{
	pData[playerid][pTimeTambang5] = 0;
	return 1;
}
function TungguNambang6(playerid)
{
	pData[playerid][pTimeTambang6] = 0;
	return 1;
}
