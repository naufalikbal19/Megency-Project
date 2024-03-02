
CMD:karung(playerid, params[])
{
    new otherid;
    if(sscanf(params, "u", otherid))
    	return Usage(playerid, "/karung [playerid");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "That player is disconnected.");

    if(otherid == playerid)
        return Error(playerid, "You cannot detained yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near this player.");

    if(pData[otherid][pKarung] == 1)
    {
    	PlayerTextDrawShow(playerid, KARUNG[playerid][0]);
    	PlayerTextDrawShow(playerid, KARUNG[playerid][1]);
    }
    else
    {
    	if(pData[otherid][pKarung] == 0)
    	PlayerTextDrawHide(playerid, KARUNG[playerid][0]);
    	PlayerTextDrawHide(playerid, KARUNG[playerid][1]);
    }
	return 1;
}