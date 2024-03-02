
CMD:createvest(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.5, -1637.206298,-2235.819824,31.476562)) return Error(playerid, "Kamu harus di blackmarket!");
	if(pData[playerid][pLevel] < 2) return Error(playerid, "Kamu tidak memiliki skill createvest.");
	if(pData[playerid][pMaterial] < 300) return Error(playerid, "Kamu tidak memiliki 300 Material.");
	if(pData[playerid][bTembaga] < 100) return Error(playerid, "Kamu tidak memiliki 100 Tembaga.");
	if(pData[playerid][pFamily] == -1) return Error(playerid, "Kamu bukan anggota Geng/ Family.");

	if(pData[playerid][pBladder] == 85) return Error(playerid, "Anda Sedang Stres,Pergilah Ke Tempat santai!");
    if(pData[playerid][pVestStatus] == 1) return Error(playerid, "Anda masih memiliki activity progress!");
    TogglePlayerControllable(playerid, 0);
    ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.0, 1, 0, 0, 0, 0,1);
    pData[playerid][pVestStatus] += 1;
    pData[playerid][timercreatevest] = SetTimerEx("CreateVest", 200, true, "id", playerid);
    PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Create Vest...");
    PlayerTextDrawShow(playerid, ActiveTD[playerid]);
    ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
	return 1;
}
function CreateVest(playerid)
{
	if(pData[playerid][pActivityTime] >= 100)
	{
	    Info(playerid, "Kamu telah berhasil membuat senjata ilegal.");
		TogglePlayerControllable(playerid, 1);
		InfoTD_MSG(playerid, 8000, "Weapon Created!");
		KillTimer(pData[playerid][timercreatevest]);
		pData[playerid][pVestStatus] -= 1;
		pData[playerid][pActivityTime] = 0;
		HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
		PlayerTextDrawHide(playerid, ActiveTD[playerid]);
		pData[playerid][pVest] += 2;
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
