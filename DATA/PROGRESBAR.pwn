#include <YSI\y_hooks>
new PlayerText:PROGRESBAR[MAX_PLAYERS][5];
new LoadingPlayerBar[MAX_PLAYERS];
new TimerLoading[MAX_PLAYERS];
//new ProgressTimer[MAX_PLAYERS][128];

HideProgresBar(playerid)
{
	PlayerTextDrawHide(playerid, PROGRESBAR[playerid][0]);
	PlayerTextDrawHide(playerid, PROGRESBAR[playerid][1]);
	PlayerTextDrawHide(playerid, PROGRESBAR[playerid][2]);
	PlayerTextDrawHide(playerid, PROGRESBAR[playerid][3]);
	PlayerTextDrawHide(playerid, PROGRESBAR[playerid][4]);
}

CreateProgresBar(playerid)
{
	PROGRESBAR[playerid][0] = CreatePlayerTextDraw(playerid, 215.000000, 343.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, PROGRESBAR[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, PROGRESBAR[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][0], 109.500000, 28.500000);
	PlayerTextDrawSetOutline(playerid, PROGRESBAR[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PROGRESBAR[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, PROGRESBAR[playerid][0], 1);
	PlayerTextDrawColor(playerid, PROGRESBAR[playerid][0], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, PROGRESBAR[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, PROGRESBAR[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, PROGRESBAR[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PROGRESBAR[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PROGRESBAR[playerid][0], 0);

	PROGRESBAR[playerid][1] = CreatePlayerTextDraw(playerid, 217.000000, 346.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, PROGRESBAR[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, PROGRESBAR[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][1], 90.000000, 22.500000);
	PlayerTextDrawSetOutline(playerid, PROGRESBAR[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PROGRESBAR[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, PROGRESBAR[playerid][1], 1);
	PlayerTextDrawColor(playerid, PROGRESBAR[playerid][1], -65281);
	PlayerTextDrawBackgroundColor(playerid, PROGRESBAR[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, PROGRESBAR[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, PROGRESBAR[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PROGRESBAR[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PROGRESBAR[playerid][1], 0);

	PROGRESBAR[playerid][2] = CreatePlayerTextDraw(playerid, 219.000000, 349.000000, "Makan...");
	PlayerTextDrawFont(playerid, PROGRESBAR[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, PROGRESBAR[playerid][2], 0.300000, 1.600000);
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PROGRESBAR[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PROGRESBAR[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, PROGRESBAR[playerid][2], 1);
	PlayerTextDrawColor(playerid, PROGRESBAR[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, PROGRESBAR[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, PROGRESBAR[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, PROGRESBAR[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, PROGRESBAR[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PROGRESBAR[playerid][2], 0);

	PROGRESBAR[playerid][3] = CreatePlayerTextDraw(playerid, 283.000000, 350.000000, "7");
	PlayerTextDrawFont(playerid, PROGRESBAR[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, PROGRESBAR[playerid][3], 0.337500, 2.049999);
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PROGRESBAR[playerid][3], 2);
	PlayerTextDrawSetShadow(playerid, PROGRESBAR[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, PROGRESBAR[playerid][3], 1);
	PlayerTextDrawColor(playerid, PROGRESBAR[playerid][3], -65281);
	PlayerTextDrawBackgroundColor(playerid, PROGRESBAR[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, PROGRESBAR[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, PROGRESBAR[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, PROGRESBAR[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PROGRESBAR[playerid][3], 0);

	PROGRESBAR[playerid][4] = CreatePlayerTextDraw(playerid, 285.000000, 364.000000, "7");
	PlayerTextDrawFont(playerid, PROGRESBAR[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, PROGRESBAR[playerid][4], -0.379166, -1.749999);
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PROGRESBAR[playerid][4], 2);
	PlayerTextDrawSetShadow(playerid, PROGRESBAR[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, PROGRESBAR[playerid][4], 1);
	PlayerTextDrawColor(playerid, PROGRESBAR[playerid][4], -65281);
	PlayerTextDrawBackgroundColor(playerid, PROGRESBAR[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, PROGRESBAR[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, PROGRESBAR[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, PROGRESBAR[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PROGRESBAR[playerid][4], 0);

}
hook OnPlayerConnect(playerid)
{
	CreateProgresBar(playerid);
	return 1;
}
//FUCH
ShowProgressbar(playerid, text[] = "", Times)
{
	if(pData[playerid][pProgress] > 0) return 1;
	LoadingPlayerBar[playerid] = 0;
	pData[playerid][pProgress] = 1;
	new Float:Value = LoadingPlayerBar[playerid]*100/100;
	new Timer = Times*1000/100;
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][1], Value, 22.5);
	PlayerTextDrawSetString(playerid, PROGRESBAR[playerid][2], text);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][0]);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][1]);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][2]);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][3]);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][4]);
	TogglePlayerControllable(playerid, 0);
	TimerLoading[playerid] = SetTimerEx("UpdtLoading", Timer, true, "d", playerid);
	return 1;
}

stock UpdateLoading(playerid)
{
	new Float:Value = LoadingPlayerBar[playerid]*100/100;
	PlayerTextDrawTextSize(playerid, PROGRESBAR[playerid][1], Value, 22.5);
	PlayerTextDrawShow(playerid, PROGRESBAR[playerid][1]);
	return 1;
}

function UpdtLoading(playerid)
{
	LoadingPlayerBar[playerid] += 1;
	UpdateLoading(playerid);
	if(LoadingPlayerBar[playerid] >= 100)
	{
		KillTimer(TimerLoading[playerid]);
		LoadingPlayerBar[playerid] = 0;
		pData[playerid][pProgress] = 0;
		HideProgresBar(playerid);
		//SetTimerEx(ProgressTimer[playerid], 500, false, "d", playerid);
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}

CMD:tesprog(playerid, params[])
{
	if(pData[playerid][pProgress] == 1) return Error(playerid, "Anda sedang melakukan activity progress");
	ShowProgressbar(playerid, "Makan", 3);
	return 1;
}