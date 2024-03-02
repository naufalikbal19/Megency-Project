forward DCC_DM(str[]);
public DCC_DM(str[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();
	DCC_SendChannelMessage(PM, str);
	return 1;
}

forward DCC_DM_EMBED(str[], pin, id[]);
public DCC_DM_EMBED(str[], pin, id[])
{
    new DCC_Channel:PM, query[200];
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="Shine Green Roleplay", .image_url="https://media.discordapp.net/attachments/1180870964913901678/1196405301717512212/LOGO_BARU.jpg?ex=65b78244&is=65a50d44&hm=5b61c660d7e0d259fe9e322a9df4535f039d690e043d78c0fec690c16fb4edb3&=&format=webp&width=603&height=584");
	new str1[500];

	format(str1, sizeof str1, "```py\nHalo!\nUCP kamu berhasil terverifikasi,\nGunakan PIN dibawah ini untuk login ke Game\n> UCP : %s\n> PIN : %d\n```", str, pin);
	DCC_SetEmbedDescription(embed, str1);
	DCC_SendChannelEmbedMessage(PM, embed);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `playerucp` (`ucp`, `verifycode`, `DiscordID`) VALUES ('%e', '%d', '%e')", str, pin, id);
	mysql_tquery(g_SQL, query);
	return 1;
}

forward CheckDiscordUCP(DiscordID[], Nama_UCP[]);
public CheckDiscordUCP(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows();
	new DCC_Role: WARGA, DCC_Guild: guild, DCC_User: user, dc[100];
	new verifycode = RandomEx(111111, 988888);
	if(rows > 0)
	{
		return SendDiscordMessage(7, "```py\n[INFO]: Nama UCP account tersebut sudah terdaftar```");
	}
	else 
	{
		new ns[32];
		guild = DCC_FindGuildById("1167807490944143460");
		WARGA = DCC_FindRoleById("1176118258932396044");
		user = DCC_FindUserById(DiscordID);
		format(ns, sizeof(ns), "Warga | %s ", Nama_UCP);
		DCC_SetGuildMemberNickname(guild, user, ns);
		DCC_AddGuildMemberRole(guild, user, WARGA);

		format(dc, sizeof(dc),  "```\nUCP @%s BERHASIL TERDAFTAR , SILAHKAN CEK DM ANDA !\n```", Nama_UCP);
		SendDiscordMessage(7, dc);
		DCC_CreatePrivateChannel(user, "DCC_DM_EMBED", "sds", Nama_UCP, verifycode, DiscordID);
	}
	return 1;
}

forward CheckDiscordID(DiscordID[], Nama_UCP[]);
public CheckDiscordID(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows(), ucp[20], dc[100];
	if(rows > 0)
	{
		cache_get_value_name(0, "ucp", ucp);

		format(dc, sizeof(dc),  "**Oops:** Anda sudah mempunyai akun dengan nama %s", ucp);
		return SendDiscordMessage(7, dc);
	}
	else 
	{
		new characterQuery[178];
		mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `ucp` = '%s'", Nama_UCP);
		mysql_tquery(g_SQL, characterQuery, "CheckDiscordUCP", "ss", DiscordID, Nama_UCP);
	}
	return 1;
}

DCMD:register(user, channel, params[])
{
	new id[21];
    if(channel != DCC_FindChannelById("1176118512041853080"))
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**USE:** /register [UCP Name]");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "**ERROR:** Harap gunakan nama IC");
	if(strlen(params) < 5)
		return DCC_SendChannelMessage(channel, "**ERROR:** Nama tidak Bisa kurang dari 5 huruf!");
	
	DCC_GetUserId(user, id, sizeof id);

	new characterQuery[178];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `DiscordID` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckDiscordID", "ss", id, params);
	return 1;
}

DCMD:server(user, channel, params[])
{
	foreach(new i : Player)
	{
		new DCC_Embed:embed = DCC_CreateEmbed(.title = "Shine Green RP");
		new str1[100], str2[100], name[MAX_PLAYER_NAME+1];
		GetPlayerName(i, name, sizeof(name));

		format(str1, sizeof str1, "**NAME SERVER**");
		format(str2, sizeof str2, "\nShine Green Roleplay");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**WEBSITE**");
		format(str2, sizeof str2, "\nhttp://bit.ly/ShineGreenRolePlayy");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**PLAYERS**");
		format(str2, sizeof str2, "\n%d Online", pemainic);
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "**MATA UANG**");
		format(str2, sizeof str2, "\nDOLAR KECIL");
		DCC_AddEmbedField(embed, str1, str2, false);
		format(str1, sizeof str1, "__[ID]\tName\tLevel\tPing__\n");
		format(str2, sizeof str2, "**%i\t%s\t%i\t%i**\n", i, name, GetPlayerScore(i), GetPlayerPing(i));
		DCC_AddEmbedField(embed, str1, str2, false);

		DCC_SendChannelEmbedMessage(channel, embed);
		return 1;
	}
	return 1;
}
