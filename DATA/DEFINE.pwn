// Server Define
#define TEXT_GAMEMODE	"SGRP v2"
#define TEXT_WEBURL		"shinegreen.id"
#define TEXT_LANGUAGE	"Indonesia/ English"
#define SERVER_BOT      "FreedomBot"
#define SERVER_NAME     "Shine Green Roleplay"

// MySQL hosting
// #define		MYSQL_HOST 			"157.254.166.212"
// #define		MYSQL_USER 			"u204_81LEzWrLg3"
// #define		MYSQL_PASSWORD 		"D68Cd+BkAfxuSRiggkT.8+nN"
// #define		MYSQL_DATABASE 		"s204_shine"

// mysql localhost
#define		MYSQL_HOST 			"localhost"
#define		MYSQL_USER 			"root"
#define		MYSQL_PASSWORD 		""
#define		MYSQL_DATABASE 		"server"

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	200

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1744.3411
#define 	DEFAULT_POS_Y 		-1862.8655
#define 	DEFAULT_POS_Z 		13.3983
#define 	DEFAULT_POS_A 		270.0000

//Android Client Check
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

new g_player_listitem[MAX_PLAYERS][96];
#define GetPlayerListitemValue(%0,%1) 		g_player_listitem[%0][%1]
#define SetPlayerListitemValue(%0,%1,%2) 	g_player_listitem[%0][%1] = %2
// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define Servers(%1,%2) SendClientMessageEx(%1, ARWIN, "[SERVER]: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, ARWIN, "[INFO]: "WHITE_E""%2)
#define Vehicle(%1,%2) SendClientMessageEx(%1, ARWIN, "[VEHICLE]: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, ARWIN , "[USAGE]: "WHITEP_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, COLOR_GREY3, ""RED_E"[ERROR]: "WHITE_E""%2)
#define AdminCMD(%1,%2) SendClientMessageEx(%1, COLOR_RED , "[AdmCmd]: "WHITEP_E""%2)
#define Gps(%1,%2) SendClientMessageEx(%1, COLOR_GREY3, ""COLOR_GPS"[GPS]: "WHITE_E""%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_RED, "[ERROR]: "WHITE_E"Kamu tidak memiliki akses untuk melakukan command ini!")
#define SCM SendClientMessage
#define SM(%0,%1) \
    SendClientMessageEx(%0, COLOR_YELLOW, "»"WHITE_E" "%1)

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

#define NT_DISTANCE 25.0
//---------[ Define Faction ]-----
#define SAPD	1		//locker 1573.26, -1652.93, -40.59
#define	SAGS	2		// 1464.10, -1790.31, 2349.68
#define SAMD	3		// -1100.25, 1980.02, -58.91
#define SANEW	4		// 256.14, 1776.99, 701.08
//---------[ JOB ]---------//
#define BOX_INDEX            9 // Index Box Barang

#define MAX_VEHICLE_OBJECT 10

#define MODEL_SELECTION_Loco    14
#define MODEL_SELECTION_Transfender     16
#define MODEL_SELECTION_Waa     15
#define MODEL_SELECTION_CADE    17
#define MAX_BARRICADES 				100
#define BODY_PART_TORSO (3)

#define MAX_DAMAGE 1000
#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

#if !defined MAX_CHAT_LINES

	#define MAX_CHAT_LINES                               10

#endif



#if defined strcpy_undefined__

    #define strcpy(%0,%1) strcat((%0[0] = '\0', %0), %1)

#endif
// new     SPAWN_SKIN_MALE     = mS_INVALID_LISTID,
//         SPAWN_SKIN_FEMALE   = mS_INVALID_LISTID,
//         SHOP_SKIN_MALE      = mS_INVALID_LISTID,
//         SHOP_SKIN_FEMALE    = mS_INVALID_LISTID,
//         VIP_SKIN_MALE       = mS_INVALID_LISTID,
//         VIP_SKIN_FEMALE     = mS_INVALID_LISTID,
//         SAPD_SKIN_MALE      = mS_INVALID_LISTID,
//         SAPD_SKIN_FEMALE    = mS_INVALID_LISTID,
//         SAPD_SKIN_WAR       = mS_INVALID_LISTID,
//         SAGS_SKIN_MALE      = mS_INVALID_LISTID,
//         SAGS_SKIN_FEMALE    = mS_INVALID_LISTID,
//         SAMD_SKIN_MALE      = mS_INVALID_LISTID,
//         SAMD_SKIN_FEMALE    = mS_INVALID_LISTID,
//         SANA_SKIN_MALE      = mS_INVALID_LISTID,
//         SANA_SKIN_FEMALE    = mS_INVALID_LISTID,
//         TOYS_MODEL          = mS_INVALID_LISTID,
//         VIPTOYS_MODEL       = mS_INVALID_LISTID;
