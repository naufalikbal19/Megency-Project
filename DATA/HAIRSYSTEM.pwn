//HAIR SYSTEM

CMD:cukur(playerid, params[])
{
	new hair;
    {
	    if(sscanf(params,"i", hair))return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]Usage: /hair [1 - 5]");
	    if(hair > 5)return SendClientMessage(playerid,0xFF0000AA,"Only 5 available Hair Styles.");
	    if(hair == 1)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 18640, 2, 0.081841, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "Your Changed your Hair Style into Afro");
	        GivePlayerMoney(playerid, -200);
	    }
	    if(hair == 2)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 18975, 2, 0.128191, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "Your Changed your Hair Style into Afro 2");
	        GivePlayerMoney(playerid, -210);
	    }
	    if(hair == 3)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19077, 2, 0.124588, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "Your Changed your Hair Style into Police Hair");
	        GivePlayerMoney(playerid, -250);
	    }
	    if(hair == 4)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19136, 2, 0.141113, 0.006911, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "Your Changed your Hair Style into Rockstar Hair");
	        GivePlayerMoney(playerid, -350);
	    }
	    if(hair == 5)
	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19274, 2, 0.099879, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "YYour Changed your Hair Style into Clown Hair");
	        GivePlayerMoney(playerid, -150);
	    }
    }

 	return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]You must in barber to use this command");
}

CMD:hair(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 20, 421.4878, -78.2720, 1001.8047)) return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]You must in barber to use this command");
    if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
    SendClientMessage(playerid, green, "You Changed yuor Hair Style to your Normal one.");
    GivePlayerMoney(playerid, -50);
    return 1;
}
