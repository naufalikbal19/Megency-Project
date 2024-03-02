//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
		            ____                     _                 _
		          
		          SHINE GREEN ROLEPLAY
														
                   * BASED OF GAMEMODE: LRP v4

               [================== THANKS TO ==================]
               [ + God   + Parents + Dandy for Base script     ]
               [ + Adit ( Shine Green Pride Developer )            	       ]
               [ + Shine Green Pride Staff's                               ]
               [===============================================]


                   GAMEMODE v9 FIXED.

*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS	100
#include <crashdetect>
#include <gvar>
#include <a_mysql>
#include <a_actor>
#include <a_zones>
#include <progress2>
#include <Pawn.CMD>
#include <mSelection>
#include <eSelectionv2>
#include <FiTimestamp>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>
#include <streamer>
#include <EVF2>
#include <YSI\y_timers>
#include <YSI\y_ini>
#include <sscanf2>
#include <yom_buttons>
#include <geoiplite>
#include <garageblock>
#include <tp>
#include <compat>
#define DCMD_PREFIX '!'
#include <discord-connector>
#include <discord-cmd>      
#include <easyDialog>

//-----[ Modular ]-----
#include "DATA\DEFINE.pwn"

//-----[ Quiz ]-----
new quiz,
	answers[256],
	answermade,
	qprs;
//new bool:antifs[MAX_PLAYERS];
new

    PlayerText: Chat_TextDraw[MAX_CHAT_LINES],

    Chat_Text[MAX_PLAYERS][MAX_CHAT_LINES][128],

    Chat_Toggled[MAX_PLAYERS] = false;

    
new bool:pCBugging[MAX_PLAYERS];
new ptmCBugFreezeOver[MAX_PLAYERS];
new ptsLastFiredWeapon[MAX_PLAYERS];

new timercj[MAX_PLAYERS];
//model selection
	#define VELOCITY_MULT	(3.0)
#define VELOCITY_NORM	(1.0)
#define HEIGHT_GAIN		(0.5)

new
	fly[MAX_PLAYERS];
//new vtoylist = mS_INVALID_LISTID;
//-----[ Twitter ]-----
new tweet[60];

//fitur gendong
new Targetgendong[MAX_PLAYERS],
    Yangmenggendong[MAX_PLAYERS],
    gendongtimer[MAX_PLAYERS];
//-----[ Rob ]-----
new RobMember = 0;
//rob
new DCC_Channel:chLogsRobbank;
//-----[ Event ]-----
new EventCreated = 0, 
	EventStarted = 0, 
	EventPrize = 500;
new Float: RedX, 
	Float: RedY, 
	Float: RedZ, 
	EventInt, 
	EventWorld;
new Float: BlueX, 
	Float: BlueY, 
	Float: BlueZ;
new EventHP = 100,
	EventArmour = 0,
	EventLocked = 0;
new EventWeapon1, 
	EventWeapon2, 
	EventWeapon3, 
	EventWeapon4, 
	EventWeapon5;
new BlueTeam = 0, 
	RedTeam = 0;
new MaxRedTeam = 5, 
	MaxBlueTeam = 5;
new IsAtEvent[MAX_PLAYERS];

new AntiBHOP[MAX_PLAYERS];

//new Healing;
new Text3D:cNametag[MAX_PLAYERS];
//-----[ Discord Connector ]-----
new pemainic;
new upt = 0;
//-----[ Selfie System ]-----
new takingselfie[MAX_PLAYERS];
new Float:Degree[MAX_PLAYERS];
const Float: Radius = 1.4; //do not edit this
const Float: Speed  = 1.25; //do not edit this
const Float: Height = 1.0; // do not edit this
new Float:lX[MAX_PLAYERS];
new Float:lY[MAX_PLAYERS];
new Float:lZ[MAX_PLAYERS];

//#define NOTICE_ANTIFAKESPAWN "Anda mengunakan fake spawn"
enum
{
	DIALOG_MAKE_CHAR,
	DIALOG_CHARLIST,
	DIALOG_VERIFYCODE,
	DIALOG_UNUSED,
    DIALOG_LOGIN,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_EMAIL,
	DIALOG_PASSWORD,
	DIALOG_AMOUNT,
	DIALOG_GIVE,
	DIALOG_STATS,
	DIALOG_SETTINGS,
	DIALOG_HBEMODE,
	DIALOG_CHANGEAGE,
	DIALOG_GOLDSHOP,
	DIALOG_GOLDNAME,
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,
	DIALOG_SELL_HOUSES,
	DIALOG_SELL_HOUSE,
	DIALOG_MY_HOUSES,
	HOUSE_INFO,
	HOUSE_STORAGE,
	HOUSE_WEAPONS,
	HOUSE_MONEY,
	HOUSE_REALMONEY,
	HOUSE_WITHDRAW_REALMONEY,
	HOUSE_DEPOSIT_REALMONEY,
	HOUSE_REDMONEY,
	HOUSE_WITHDRAW_REDMONEY,
	HOUSE_DEPOSIT_REDMONEY,
	HOUSE_FOODDRINK,
	HOUSE_FOOD,
	HOUSE_FOOD_DEPOSIT,
	HOUSE_FOOD_WITHDRAW,
	HOUSE_DRINK,
	HOUSE_DRINK_DEPOSIT,
	HOUSE_DRINK_WITHDRAW,
	HOUSE_DRUGS,
	HOUSE_MEDICINE,
	HOUSE_MEDICINE_DEPOSIT,
	HOUSE_MEDICINE_WITHDRAW,
	HOUSE_MEDKIT,
	HOUSE_MEDKIT_DEPOSIT,
	HOUSE_MEDKIT_WITHDRAW,
	HOUSE_BANDAGE,
	HOUSE_BANDAGE_DEPOSIT,
	HOUSE_BANDAGE_WITHDRAW,
	HOUSE_OTHER,
	HOUSE_SEED,
	HOUSE_SEED_DEPOSIT,
	HOUSE_SEED_WITHDRAW,
	HOUSE_MATERIAL,
	HOUSE_MATERIAL_DEPOSIT,
	HOUSE_MATERIAL_WITHDRAW,
	HOUSE_COMPONENT,
	HOUSE_COMPONENT_DEPOSIT,
	HOUSE_COMPONENT_WITHDRAW,
	HOUSE_MARIJUANA,
	HOUSE_MARIJUANA_DEPOSIT,
	HOUSE_MARIJUANA_WITHDRAW,
	DIALOG_FINDVEH,
	DIALOG_TRACKVEH,
	DIALOG_TRACKVEH2,
	DIALOG_TRACKPARKEDVEH,
	DIALOG_GOTOVEH,
	DIALOG_GETVEH,
	DIALOG_DELETEVEH,
	DIALOG_BUYPV,
	DIALOG_BUYVIPPV,
	DIALOG_BUYPLATE,
	DIALOG_BUYPVCP,
	DIALOG_BUYPVCP_BIKES,
	DIALOG_BUYPVCP_CARS,
	DIALOG_BUYPVCP_UCARS,
	DIALOG_BUYPVCP_JOBCARS,
	DIALOG_BUYPVCP_VIPCARS,
	DIALOG_BUYPVCP_CONFIRM,
	DIALOG_BUYPVCP_VIPCONFIRM,
	DIALOG_RENT_JOBCARS,
	DIALOG_RENT_JOBCARSCONFIRM,
	DIALOG_RENT_BOAT,
	DIALOG_RENT_BOATCONFIRM,
	DIALOG_RENT_BIKE,
	DIALOG_RENT_BIKECONFIRM,
	DIALOG_SUSUSAPI,
	DIALOG_GARKOT,
	DIALOG_MY_VEHICLE,
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYEDIT_ANDROID,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	DIALOG_TOYPOSSX,
	DIALOG_TOYPOSSY,
	DIALOG_TOYPOSSZ,
	// MODSHOP
	DIALOG_MODMENU,
	DIALOG_MODSHOP,
	DIALOG_MODTOY,
	DIALOG_MODTBUY,
	DIALOG_MODTEDIT,
	DIALOG_MODTPOSX,
	DIALOG_MODTPOSY,
	DIALOG_MODTPOSZ,
	DIALOG_MODTPOSRX,
	DIALOG_MODTPOSRY,
	DIALOG_MODTPOSRZ,
	DIALOG_MODTSELECTPOS,
	DIALOG_MODTSETVALUE,
	DIALOG_MODTSETCOLOUR,
	DIALOG_MODTSETPOS,
	DIALOG_MODTACCEPT,
	//dialog pedagang
	DIALOG_MENU,
	DIALOG_MENUMASAK,
	DIALOG_LOCKERPEDAGANG,
	DIALOG_WEAPONPEDAGANG,
	//
	DIALOG_PENAMBANG,
	DIALOG_PENAMBANG1,
	//PEDAGANG
	PEDAGANG_MENU,
	PDG_KENTANG,
	PDG_MINERAL,
	PDG_SNACK,
	PDG_CHICKEN,
	PDG_COCACOLA,
	PDG_JERUK,
	PDG_BURGER,
	PDG_PIZZA,
	PDG_AYAM_FILET,
	//
	PDG_KENTANG1,
	PDG_MINERAL1,
	PDG_SNACK1,
	PDG_CHICKEN1,
	PDG_COCACOLA1,
	PDG_JERUK1,
	PDG_BURGER1,
	PDG_PIZZA1,
	PDG_AYAM_FILET1,
	//---[ DIALOG OWN FARM ]---
	FARM_STORAGE,
	FARM_INFO,
	FARM_POTATO,
	FARM_WHEAT,
	FARM_ORANGE,
	FARM_MONEY,
	FARM_DEPOSITPOTATO,
	FARM_WITHDRAWPOTATO,
	FARM_DEPOSITWHEAT,
	FARM_WITHDRAWWHEAT,
	FARM_DEPOSITORANGE,
	FARM_WITHDRAWORANGE,
	FARM_DEPOSITMONEY,
	FARM_WITHDRAWMONEY,
	//
	DIALOG_HELP,
	DIALOG_GPS,
	DIALOG_JOB,
	DIALOG_GPS_JOB,
	DIALOG_GPS_PUBLIC,
	DIALOG_GPS_PROPERTIES,
	DIALOG_GPS_GENERAL,
	DIALOG_GPS_MISSION,
	DIALOG_TRACKBUSINESS,
	DIALOG_ELECTRONIC_TRACK,
	DIALOG_PAY,
	DIALOG_EDITBONE,
	FAMILY_SAFE,
	FAMILY_STORAGE,
	FAMILY_WEAPONS,
	FAMILY_MARIJUANA,
	FAMILY_WITHDRAWMARIJUANA,
	FAMILY_DEPOSITMARIJUANA,
	FAMILY_COMPONENT,
	FAMILY_WITHDRAWCOMPONENT,
	FAMILY_DEPOSITCOMPONENT,
	FAMILY_MATERIAL,
	FAMILY_WITHDRAWMATERIAL,
	FAMILY_DEPOSITMATERIAL,
	FAMILY_MONEY,
	FAMILY_WITHDRAWMONEY,
	FAMILY_DEPOSITMONEY,
	FAMILY_INFO,
	DIALOG_SERVERMONEY,
	DIALOG_SERVERMONEY_STORAGE,
	DIALOG_SERVERMONEY_WITHDRAW,
	DIALOG_SERVERMONEY_DEPOSIT,
	DIALOG_SERVERMONEY_REASON,
	DIALOG_LOCKERSAPD,
	DIALOG_WEAPONSAPD,
	DIALOG_LOCKERSAGS,
	DIALOG_WEAPONSAGS,
	DIALOG_LOCKERSAMD,
	DIALOG_WEAPONSAMD,
	DIALOG_DRUGSSAMD,
	DIALOG_LOCKERSANEW,
	DIALOG_WEAPONSANEW,
	DIALOG_LOCKERVIP,
	DIALOG_SERVICE,
	DIALOG_SERVICE_COLOR,
	DIALOG_SERVICE_COLOR2,
	DIALOG_SERVICE_PAINTJOB,
	DIALOG_SERVICE_WHEELS,
	DIALOG_SERVICE_SPOILER,
	DIALOG_SERVICE_HOODS,
	DIALOG_SERVICE_VENTS,
	DIALOG_SERVICE_LIGHTS,
	DIALOG_SERVICE_EXHAUSTS,
	DIALOG_SERVICE_FRONT_BUMPERS,
	DIALOG_SERVICE_REAR_BUMPERS,
	DIALOG_SERVICE_ROOFS,
	DIALOG_SERVICE_SIDE_SKIRTS,
	DIALOG_SERVICE_BULLBARS,
	DIALOG_SERVICE_NEON,
	DIALOG_MENU_TRUCKER,
	DIALOG_SHIPMENTS,
	DIALOG_SHIPMENTS_VENDING,
	DIALOG_HAULING,
	DIALOG_RESTOCK,
	DIALOG_RESTOCK_VENDING,
	DIALOG_ARMS_GUN,
	DIALOG_ARMS_VEST,
	DIALOG_PLANT,
	DIALOG_EDIT_PRICE,
	DIALOG_EDIT_PRICE1,
	DIALOG_EDIT_PRICE2,
	DIALOG_EDIT_PRICE3,
	DIALOG_EDIT_PRICE4,
	DIALOG_SIRINE,
	DIALOG_OFFER,
	DIALOG_MATERIAL,
	DIALOG_COMPONENT,
	DIALOG_DRUGS,
	DIALOG_FOOD,
	DIALOG_FOOD_BUY,
	DIALOG_SEED_BUY,
	DIALOG_PRODUCT,
	DIALOG_GASOIL,
	DIALOG_APOTEK,
	DIALOG_ATM,
	DIALOG_TRACKATM,
	DIALOG_ATMWITHDRAW,
	DIALOG_BANK,
	DIALOG_BANKDEPOSIT,
	DIALOG_BANKWITHDRAW,
	DIALOG_BANKREKENING,
	DIALOG_BANKTRANSFER,
	DIALOG_BANKCONFIRM,
	DIALOG_BANKSUKSES,
	DIALOG_PHONE,
	DIALOG_TWITTER,
	DIALOG_TWITTERPOST,
	DIALOG_TWITTERNAME,
	DIALOG_PHONE_ADDCONTACT,
	DIALOG_PHONE_CONTACT,
	DIALOG_PHONE_NEWCONTACT,
	DIALOG_PHONE_INFOCONTACT,
	DIALOG_PHONE_SENDSMS,
	DIALOG_PHONE_TEXTSMS,
	DIALOG_PHONE_SHARELOC, 
	DIALOG_PHONE_DIALUMBER,
	DIALOG_TOGGLEPHONE,
	DIALOG_IBANK,
	DIALOG_REPORTS,
	DIALOG_ANSWER_REPORTS,
	DIALOG_ASKS,
	DIALOG_SALARY,
	DIALOG_PAYCHECK,
	DIALOG_SWEEPER,
	DIALOG_BUS,
	DIALOG_FORKLIFT,
	DIALOG_MOWER,
	DIALOG_RUTE_SWEEPER,
	DIALOG_RUTE_BUS,
	DIALOG_BAGGAGE,
	DIALOG_HEALTH,
	DIALOG_OBAT,
	DIALOG_ISIKUOTA,
	DIALOG_DOWNLOAD,
	DIALOG_KUOTA,
	DIALOG_STUCK,
	DIALOG_TDM,
	DIALOG_PICKUPVEH,
	DIALOG_TRACKPARK,
	DIALOG_MY_WS,
	DIALOG_TRACKWS,
	WS_MENU,
	WS_SETNAME,
	WS_SETOWNER,
	WS_SETEMPLOYE,
	WS_SETEMPLOYEE,
	WS_SETOWNERCONFIRM,
	WS_SETMEMBER,
	WS_SETMEMBERE,
	WS_MONEY,
	WS_WITHDRAWMONEY,
	WS_DEPOSITMONEY,
	WS_COMPONENT,
	WS_COMPONENT2,
	WS_MATERIAL,
	WS_MATERIAL2,
	DIALOG_ACTORANIM,
	DIALOG_MY_VENDING,
	DIALOG_VENDING_INFO,
	DIALOG_VENDING_BUYPROD,
	DIALOG_VENDING_MANAGE,
	DIALOG_VENDING_NAME,
	DIALOG_VENDING_VAULT,
	DIALOG_VENDING_WITHDRAW,
	DIALOG_VENDING_DEPOSIT,
	DIALOG_VENDING_EDITPROD,
	DIALOG_VENDING_PRICESET,
	DIALOG_VENDING_RESTOCK,
	DIALOG_SPAWN_1,
	DIALOG_MYVEH,
	DIALOG_MYVEH_INFO,
	DIALOG_FAMILY_INTERIOR,
	DIALOG_SPAREPART,
	DIALOG_BUYPARTS,
	DIALOG_BUYPARTS_DONE,
	VEHICLE_STORAGE,
	VEHICLE_WEAPON,
	VEHICLE_MONEY,
	VEHICLE_REALMONEY,
	VEHICLE_REALMONEY_WITHDRAW,
	VEHICLE_REALMONEY_DEPOSIT,
	VEHICLE_REDMONEY,
	VEHICLE_REDMONEY_WITHDRAW,
	VEHICLE_REDMONEY_DEPOSIT,
	VEHICLE_DRUGS,
	VEHICLE_MEDICINE,
	VEHICLE_MEDICINE_WITHDRAW,
	VEHICLE_MEDICINE_DEPOSIT,
	VEHICLE_MEDKIT,
	VEHICLE_MEDKIT_WITHDRAW,
	VEHICLE_MEDKIT_DEPOSIT,
	VEHICLE_BANDAGE,
	VEHICLE_BANDAGE_WITHDRAW,
	VEHICLE_BANDAGE_DEPOSIT,
	VEHICLE_OTHER,
	VEHICLE_SEED,
	VEHICLE_SEED_WITHDRAW,
	VEHICLE_SEED_DEPOSIT,
	VEHICLE_MATERIAL,
	VEHICLE_MATERIAL_WITHDRAW,
	VEHICLE_MATERIAL_DEPOSIT,
	VEHICLE_COMPONENT,
	VEHICLE_COMPONENT_WITHDRAW,
	VEHICLE_COMPONENT_DEPOSIT,
	VEHICLE_MARIJUANA,
	VEHICLE_MARIJUANA_WITHDRAW,
	VEHICLE_MARIJUANA_DEPOSIT,
	//STORAGE NEW
	VEHICLE_BARANG,
	//PROJEK BAGASI
	VEHICLE_TEMBAGA,
	VEHICLE_TEMBAGA_WITHDRAW,
    VEHICLE_TEMBAGA_DEPOSIT,
    //EMAS
    VEHICLE_EMASKONTOL,
    VEHICLE_EMAS_WITHDRAW,
    VEHICLE_EMAS_DEPOSIT,
    //ALUMINIUM
    VEHICLE_ALUMINIUM,
    VEHICLE_ALUMINIUM_WITHDRAW,
    VEHICLE_ALUMINIUM_DEPOSIT,
    //Vehicle Toys
	DIALOG_MMENU,
	VTOY_ACCEPT,
	DIALOG_VTOY,
	DIALOG_VTOYBUY,
	DIALOG_VTOYEDIT,
	DIALOG_VTOYPOSX,
	DIALOG_VTOYPOSY,
	DIALOG_VTOYPOSZ,
	DIALOG_VTOYPOSRX,
	DIALOG_VTOYPOSRY,
	DIALOG_VTOYPOSRZ,
	DIALOG_ENTER_VALUE,
	//dealership
	DIALOG_BUYDEALERCARS_CONFIRM_M,
	DIALOG_BUYJOBCARSVEHICLE,
	DIALOG_ACLAIM,
	DIALOG_BUYDEALERCARS_CONFIRM,
	DIALOG_BUYTRUCKVEHICLE,
	DIALOG_BUYMOTORCYCLEVEHICLE,
	DIALOG_BUYUCARSVEHICLE,
	DIALOG_BUYCARSVEHICLE,
	DIALOG_BUYKAPALVEHICLE, 
	DIALOG_DEALER_MANAGE,
	DIALOG_DEALER_VAULT,
	DIALOG_DEALER_WITHDRAW,
	DIALOG_PRISONMENU,
	DIALOG_DEALER_DEPOSIT,
	DIALOG_DEALER_NAME,
	DIALOG_DEALER_RESTOCK,
	DIALOG_TAKEFOOD,
	DIALOG_TDC,
	DIALOG_TDC_PLACE,
	//bb
	DIALOG_BOOMBOX,
	DIALOG_BOOMBOX1,
	DIALOG_NONRPNAME,
	//static veh faction
	DIALOG_SAMD_GARAGE,
	DIALOG_SANA_GARAGE,
	DIALOG_SAPD_GARAGE,
	DIALOG_SAGS_GARAGE, 
}

//-----[ Download System ]-----
new download[MAX_PLAYERS];

//-----[ Count System ]-----
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

//-----[ Rob System ]-----
new robmoney;

//-----[ Server Uptime ]-----
new up_days,
	up_hours,
	up_minutes,
	up_seconds,
	WorldTime = 10,
	WorldWeather = 24;

//-----[ Faction Vehicle ]-----	
#define VEHICLE_RESPAWN 7200
//fixxed
new SAPDVeh[MAX_PLAYERS];
new SAMDVeh[MAX_PLAYERS];
new SANAVeh[MAX_PLAYERS];
new SAGSVeh[MAX_PLAYERS];

new SAPDVehicles[75],
	SAGSVehicles[30],
	SAMDVehicles[30],
	SANAVehicles[30];

IsSAPDCar(carid)
{
	for(new v = 0; v < sizeof(SAPDVehicles); v++)
	{
	    if(carid == SAPDVehicles[v]) return 1;
	}
	return 0;
}

IsGovCar(carid)
{
	for(new v = 0; v < sizeof(SAGSVehicles); v++)
	{
	    if(carid == SAGSVehicles[v]) return 1;
	}
	return 0;
}

IsSAMDCar(carid)
{
	for(new v = 0; v < sizeof(SAMDVehicles); v++)
	{
	    if(carid == SAMDVehicles[v]) return 1;
	}
	return 0;
}

IsSANACar(carid)
{
	for(new v = 0; v < sizeof(SANAVehicles); v++)
	{
	    if(carid == SANAVehicles[v]) return 1;
	}
	return 0;
}

//AFK SYSTEM BAGAS
/*new afk_check[MAX_PLAYERS];
new afk_tick[MAX_PLAYERS];
new afk_time[MAX_PLAYERS];*/
//-----[ Showroom Checkpoint ]-----	
new ShowRoomCP,
	ShowRoomCPRent;

new DutyTimer;
new MalingKendaraan;

//-----[ Button ]-----	
new SAGSLobbyBtn[8],
	SAGSLobbyDoor[4],
	SAMCLobbyBtn[6],
	SAMCLobbyDoor[3];

//-----[ MySQL Connect ]-----	
new MySQL: g_SQL;

new TogOOC = 1;

//-----[ Player Data ]-----	
enum E_PLAYERS
{
	pID,
	pUCP[22],
	pExtraChar,
	pChar,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pIP[16],
	pLeaveIP[16],
    pLeaveTime,
	pVerifyCode,
	pPassword[65],
	pSalt[17],
	pEmail[40],
	pAdmin,
	pHelper,
	pLevel,
	pLevelUp,
	pVip,
	pVipTime,
	pGold,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pRedMoney,
	Text3D:pMaskLabel,
	pBankMoney,
	pBankRek,
	pPhone,
	pPhoneCredit,
	pContact,
	pPhoneBook,
	pSMS,
	pCall,
	pCallTime,
	pWT,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pAge[50],
	pInDoor,
	pInHouse,
	pInBiz,
	pInVending,
	pInFamily,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pEnergy,
	pHungerTime,
	pEnergyTime,
	pTimerBladder,
	pBladder, 
	pStresTime,
	pSick,
	pSickTime,
	pHospital,
	pHospitalTime,
	pInjured,
	Text3D: pInjuredLabel,
	pOnDuty,
	pOnDutyTime,
	pFaction,
	pFactionRank,
	pFactionLead,
	pTazer,
	pBroadcast,
	pNewsGuest,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pJob2,
	pJobTime,
	pExitJob,
	pMedicine,
	pMedkit,
	pMask,
	pHelmet,
	pSnack,
	pSprunk,
	pGas,
	pBandage,
	pGPS,
	pGpsActive,
	pMaterial,
	pComponent,
	pSpawnSapd,
	pSpawnSamd,
	pSpawnSana,
	pSpawnSags,
	pFood,
	pSeed,
	pPotato,
	pWheat,
	pOrange,
	pPrice1,
	pPrice2,
	pPrice3,
	pPrice4,
	pMarijuana,
	pPlant,
	pPlantTime,
	pFishTool,
	pWorm,
	pFish,
	pInFish,
	pIDCard,
	pIDCardTime,
	pDriveLic,
	pDriveLicTime,
	pDriveLicApp,
	pBoatLic,
	pBoatLicTime,
	pWeaponLic,
	pWeaponLicTime,
	pFlyLic,
	pFlyLicTime,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	//Not Save
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	LoginTimer,
	pSpawned,
	pSpawnList,
	pAdminDuty,
	pFreezeTimer,
	pFreeze,
	pMaskID,
	pMaskOn,
	pSPY,
	pTogPM,
	pTogLog,
	pTogAds,
	pTogWT,
	Text3D:pAdoTag,
	Text3D:pBTag,
	bool:pBActive,
	bool:pAdoActive,
	pFlare,
	bool:pFlareActive,
	pTrackCar,
	pBuyPvModel,
	pTrackHouse,
	pTrackBisnis,
	pTrackVending,
	pFacInvite,
	pFacOffer,
	pFamInvite,
	pFamOffer,
	pFindEms,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	pProductModify,
	pEditingVendingItem,
	pVendingProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHBEMode,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	//Player Progress Bar
	PlayerBar:spfuelbar,
	PlayerBar:spdamagebar,
	PlayerBar:sphungrybar,
	PlayerBar:spenergybar,
	PlayerBar:activitybar,
	pProducting,
	pProductingStatus,
	pCooking,
	pCookingStatus,
	pArmsDealer,
	pArmsDealerStatus,
	pMechanic,
	pMechanicStatus,
	pActivity,
	pActivityStatus,
	pActivityTime,
	//Jobs
	bool:TempatHealing,
	pSideJob,
	pSideJobTime,
	pSweeperTime,
	pForklifterTime,
	pBusTime,
	pMowerTime,
	pGetJob,
	pGetJob2,
	pTaxiDuty,
	pTaxiTime,
	pFare,
	pFareTimer,
	pTotalFare,
	Float:pFareOldX,
	Float:pFareOldY,
	Float:pFareOldZ,
	Float:pFareNewX,
	Float:pFareNewY,
	Float:pFareNewZ,
	pMechDuty,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	//progres
	pProgress,
	//KARUNG
	pKarung,
	//ATM
	EditingATMID,
	//lumber job
	EditingTreeID,
	CuttingTreeID,
	bool:CarryingLumber,
	//Miner job
	EditingOreID,
	MiningOreID,
	CarryingLog,
	LoadingPoint,
	//Vending
	EditingVending,
	//production
	CarryProduct,
	//-----[ FARM PRIVATE]
	pFarm,
	pFarmRank,
	pFarmInvite,
	pFarmOffer,
	//trucker
	pMission,
	pHauling,
	pVendingRestock,
	bool: CarryingBox,
	//Farmer
	pHarvest,
	pHarvestID,
	pOffer,
	//VEST 
	pVest,
	pVestStatus,
	timercreatevest,
	//Bank
	pTransfer,
	pTransferRek,
	pTransferName[128],
	//Gas Station
	pFill,
	pFillStatus,
	pFillTime,
	pFillPrice,
	//Gate
	gEditID,
	gEdit,
	// WBR
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	// Inspect Offer
 	pInsOffer,
 	// Obat System
 	pObat,
 	//Pedagang
	pdgMenuType,
	pInPdg,
 	//inv
 	pNasi, 
 	pAGoreng, 
 	pBurger,
 	pPizza, 
 	pMineral, 
 	pCola, 
 	pChiken, 

 	pKebab, 
 	pSusu,
 	pCrack, 
 	pSelectItem, 
 	pGiveAmount, 
 	pLockPick,
 	pBody, 
 	//pemotong ayam
	timerambilayamhidup,
    timerpotongayam,
    timerpackagingayam,
    timerjualayam,
    AyamHidup,
	AyamPotong,
	AyamFillet,
	sedangambilayam,
    sedangpotongayam,
    sedangfilletayam,
    sedangjualayam,
    //penambang
	timerambilbatu,
    timerpencucianbatu,
    timerpeleburanbatu,
    Batu,
    pTimeTambang1,
    pTimeTambang2,
    pTimeTambang3,
    pTimeTambang4,
    pTimeTambang5,
    pTimeTambang6,
	BatuCucian,
	bEmas,
	bTembaga,
	bAlumunium,
	sedangambilbatu,
    sedangpencucianbatu,
    sedangpeleburanbatu,
    pMenambangStatus, 
	pCuciStatus,
	pLeburStatus,
	//boombox
	pBoombox,
 	// Suspect
 	pSuspectTimer,
 	pSuspect,
 	// Phone On Off
 	pPhoneStatus,
 	// Kurir
 	pKurirEnd,
 	// Shareloc Offer
 	pLocOffer,
 	// Twitter
 	pTwitter,
	pTwitterStatus, 
	pTwittername[MAX_PLAYER_NAME],
	pTwitterPostCooldown,
	pTwitterNameCooldown,
 	pRegTwitter,
 	// Kuota
 	pKuota,
 	// DUTY SYSTEM
 	pDutyHour,
 	// CHECKPOINT
 	pCP,
 	// ROBBERY
 	pRobTime,
 	pRobOffer,
 	pRobLeader,
 	pRobMember,
 	pMemberRob,
	pTrailer,
	//robbank
	pCs,
	pPanelHacking,
	pBomb,
	// Smuggler
	bool:pTakePacket,
	pTrackPacket,
	// Garkot
	pPark,
	pLoc,
	// WS
	pMenuType,
	pInWs,
	pTransferWS,
	pWsLog,
	//Baggage
	pBaggage,
	pDelayBaggage,
	pTrailerBaggage,
	//Anticheat
	pACWarns,
	pACTime,
	pJetpack,
	pArmorTime,
	pLastUpdate,
	//Checkpoint
	pCheckPoint,
	pBus,
	pSweeper,
	pMower,
	//SpeedCam
	pSpeedTime,
	//ammo------------
	pAmmo9mm,
	pAmmoSi,
	pAmmoDe,
	pAmmoSg,
	pAmmoSgm,
	pAmmoSp,
	pAmmoUzi,
	pAmmoMp5,
	pAmmoAk,
	pAmmoM4,
	pAmmoTec,
	pAmmoKar,
	pAmmoAwm,
	pAmmoRpg,
	pType9mm,
	//Forklifter New System
	pForklifter,
	pForklifterLoad,
	pForklifterLoadStatus,
	pForklifterUnLoad,
	pForklifterUnLoadStatus,
	// Vehicle Toys
	EditStatus,
	VehicleID,
	pInDealer,
	//Starterpack
	pStarterpack,
	//Anim
	pLoopAnim,
	//Rob Car
	pLastChop,
	pLastChopTime,
	pIsStealing,
	//Sparepart
	pSparepart,
	//Kontol
	pUangKorup,
	//Senter
	pFlashlight,
	pUsedFlashlight,
	//Moderator
	pServerModerator,
	pEventModerator,
	pFactionModerator,
	pFamilyModerator,
	//
	pPaintball,
	pPaintball2,
	//
	pDutySapi,
	pSusuSapi,
	pDelaySapi,
	//
	pDelayIklan,
	pMarkTemp
};
new pData[MAX_PLAYERS][E_PLAYERS];
new g_MysqlRaceCheck[MAX_PLAYERS];
//-----[ Smuggler ]-----	

new Text3D:packetLabel,
	packetObj,
	Float:paX, 
	Float:paY, 
	Float:paZ;

//-----[ Forklifter Object ]-----	
new 
	VehicleObject[MAX_VEHICLES] = {-1, ...};


//-----[ Lumber Object Vehicle ]-----	
#define MAX_BOX 50
#define BOX_LIFETIME 100
#define BOX_LIMIT 5

enum    E_BOX
{
	boxDroppedBy[MAX_PLAYER_NAME],
	boxSeconds,
	boxObjID,
	boxTimer,
	boxType,
	Text3D: boxLabel
}
new BoxData[MAX_BOX][E_BOX],
	Iterator:Boxs<MAX_BOX>;

new
	BoxStorage[MAX_VEHICLES][BOX_LIMIT];

//-----[ Lumber Object Vehicle ]-----	
#define MAX_LUMBERS 50
#define LUMBER_LIFETIME 100
#define LUMBER_LIMIT 10

enum    E_LUMBER
{
	lumberDroppedBy[MAX_PLAYER_NAME],
	lumberSeconds,
	lumberObjID,
	lumberTimer,
	Text3D: lumberLabel
}
new LumberData[MAX_LUMBERS][E_LUMBER],
	Iterator:Lumbers<MAX_LUMBERS>;

new
	LumberObjects[MAX_VEHICLES][LUMBER_LIMIT];

	
new
	Float: LumberAttachOffsets[LUMBER_LIMIT][4] = {
	    {-0.223, -1.089, -0.230, -90.399},
		{-0.056, -1.091, -0.230, 90.399},
		{0.116, -1.092, -0.230, -90.399},
		{0.293, -1.088, -0.230, 90.399},
		{-0.123, -1.089, -0.099, -90.399},
		{0.043, -1.090, -0.099, 90.399},
		{0.216, -1.092, -0.099, -90.399},
		{-0.033, -1.090, 0.029, -90.399},
		{0.153, -1.089, 0.029, 90.399},
		{0.066, -1.091, 0.150, -90.399}
	};



//-----[ Ores Miner ]-----	
#define LOG_LIFETIME 100
#define LOG_LIMIT 10
#define MAX_LOG 100

enum E_DLOG
{
	dlOwner,
	dlTarget[MAX_PLAYER_NAME + 1],
	dlBody,
	dlWeapon,
	Float:dlDamage,
};

new DamageData[MAX_DAMAGE][E_DLOG],
Iterator: DamageLog<MAX_DAMAGE>;


//Variable Player Damage Logs
new GetDamageID[MAX_PLAYERS];

enum    E_LOG
{
	bool:logExist,
	logType,
	logDroppedBy[MAX_PLAYER_NAME],
	logSeconds,
	logObjID,
	logTimer,
	Text3D:logLabel
}
new LogData[MAX_LOG][E_LOG];

new
	LogStorage[MAX_VEHICLES][2];

//-----[ Trucker ]-----	
new VehProduct[MAX_VEHICLES];
new VehGasOil[MAX_VEHICLES];

//-----[ Baggage ]-----	
new bool:DialogBaggage[10];
new bool:MyBaggage[MAX_PLAYERS][10];

//-----[ Type Checkpoint ]-----	
enum
{
	CHECKPOINT_NONE = 0,
	CHECKPOINT_FORKLIFTER,
	CHECKPOINT_DRIVELIC,
	CHECKPOINT_SWEEPER,
	CHECKPOINT_BAGGAGE,
	CHECKPOINT_MOWER,
	CHECKPOINT_MISC,
	CHECKPOINT_BUS
}

//-----[ Storage Limit ]-----	
enum
{
	LIMIT_SNACK,
	LIMIT_SPRUNK,
	LIMIT_MEDICINE,
	LIMIT_MEDKIT,
 	LIMIT_BANDAGE,
 	LIMIT_SEED,
	LIMIT_MATERIAL,
	LIMIT_COMPONENT,
	LIMIT_MARIJUANA,
	LIMIT_TEMBAGA,
	LIMIT_EMAS,
	LIMIT_ALUMINIUM
};

//-----[ eSelection Define ]-----	
#define 	SPAWN_SKIN_MALE 		1
#define 	SPAWN_SKIN_FEMALE 		2
#define 	SHOP_SKIN_MALE 			3
#define 	SHOP_SKIN_FEMALE 		4
#define 	VIP_SKIN_MALE 			5
#define 	VIP_SKIN_FEMALE 		6
#define 	SAPD_SKIN_MALE 			7
#define 	SAPD_SKIN_FEMALE 		8
#define 	SAPD_SKIN_WAR 			9
#define 	SAGS_SKIN_MALE 			10
#define 	SAGS_SKIN_FEMALE 		11
#define 	SAMD_SKIN_MALE 			12
#define 	SAMD_SKIN_FEMALE 		13
#define 	SANA_SKIN_MALE 			14
#define 	SANA_SKIN_FEMALE 		15
#define 	TOYS_MODEL 				16
#define 	VIPTOYS_MODEL 			17


new SpawnSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 14, 100, 299
};

new SpawnSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41
};

new ShopSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new ShopSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};

new SAPDSkinWar[] =
{
	121, 285, 286, 287, 117, 118, 165, 166
};

new SAPDSkinMale[] =
{
	280, 281, 282, 283, 284, 288, 300, 301, 302, 303, 304, 305, 310, 311, 165, 166
};

new SAPDSkinFemale[] =
{
	306, 307, 309, 148, 150
};

new SAGSSkinMale[] =
{
	171, 17, 71, 147, 187, 165, 166, 163, 164, 255, 295, 294, 303, 304, 305, 189, 253
};

new SAGSSkinFemale[] =
{
	9, 11, 76, 141, 150, 219, 169, 172, 194, 263
};

new SAMDSkinMale[] =
{
	70, 187, 303, 304, 305, 274, 275, 276, 277, 278, 279, 165, 71, 177
};

new SAMDSkinFemale[] =
{
	308, 76, 141, 148, 150, 169, 172, 194, 219
};

new SANASkinMale[] =
{
	171, 187, 189, 240, 303, 304, 305, 20, 59
};

new SANASkinFemale[] =
{
	172, 194, 211, 216, 219, 233, 11, 9
};

/*new PDGSkinMale[] =
{
	155, 167, 168, 189 
};

new PDGSkinFemale[] =
{
	205, 211, 194, 6 
};*/
new ToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142
};

new VipToysModel[] =
{
	19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022,
	19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19801, 18891, 18892, 18893,
	18894, 18895, 18896, 18897, 18898, 18899, 18900, 18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910,
	18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 19036, 19037, 19038, 19557, 11704, 19472, 18974,
	19163, 19064, 19160, 19352, 19528, 19330, 19331, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930,
	18931, 18932, 18933, 18934, 18935, 18939, 18940, 18941, 18942, 18943, 18944, 18945, 18946, 18947, 18948, 18949, 18950,
	18951, 18953, 18954, 18960, 18961, 19098, 19096, 18964, 18967, 18968, 18969, 19106, 19113, 19114, 19115, 18970, 18638,
	19553, 19558, 19554, 18971, 18972, 18973, 19101, 19116, 19117, 19118, 19119, 19120, 18952, 18645, 19039, 19040, 19041,
	19042, 19043, 19044, 19045, 19046, 19047, 19053, 19421, 19422, 19423, 19424, 19274, 19518, 19077, 19517, 19317, 19318,
	19319, 19520, 1550, 19592, 19621, 19622, 19623, 19624, 19625, 19626, 19555, 19556, 19469, 19085, 19559, 19904, 19942, 
	19944, 11745, 19773, 18639, 18640, 18641, 18635, 18633, 3028, 11745, 19142
};

new VipSkinMale[] =
{
	1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33,
	34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 68, 72, 73,
	78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
	110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170,
	171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203,
	204, 206, 208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240, 241,
	242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289, 290, 291, 292, 293,
	294, 295, 296, 297, 299
};

new VipSkinFemale[] =
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 85, 88, 89, 90, 91, 92,
	93, 129, 130, 131, 138, 140, 141, 145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195, 196,
	197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245,
	246, 251, 256, 257, 263, 298
};


//-----[ Modular ]-----	
main() 
{
	SetTimer("onlineTimer", 1000, true);
	SetTimer("TDUpdates", 8000, true);
}

#include "DATA\COLOR.pwn"
#include "DATA\UCP.pwn"
#include "DATA\TEXTDRAW.pwn"
#include "DATA\ANIMS.pwn"
#include "DATA\GARKOT.pwn"
#include "DATA\RENTAL.pwn"
#include "DATA\PRIVATE_VEHICLE.pwn"
#include "DATA\VSTORAGE.pwn"
#include "DATA\REPORT.pwn"
#include "DATA\ASK.pwn"
#include "DATA\WEAPON_ATTH.pwn"
#include "DATA\TOYS.pwn"
#include "DATA\HELMET.pwn"
#include "DATA\SERVER.pwn"
#include "DATA\DOOR.pwn"
#include "DATA\FAMILY.pwn"
#include "DATA\HOUSE.pwn"
#include "DATA\BISNIS.pwn"
#include "DATA\GAS_STATION.pwn"
#include "DATA\DYNAMIC_LOCKER.pwn"
#include "DATA\NATIVE.pwn"
#include "DATA\VOUCHER.pwn"
#include "DATA\SALARY.pwn"
#include "DATA\ATM.pwn"
#include "DATA\ARMS_DEALER.pwn"
#include "DATA\GATE.pwn"
#include "DATA\GUDANG_PEDAGANG.pwn"
//#include "AUDIO.pwn"
#include "DATA\ROBBERY.pwn"
#include "DATA\WORKSHOP.pwn"
#include "DATA\DMV.pwn"
#include "DATA\ANTICHEAT.pwn"
#include "DATA\SPEEDCAM.pwn"
#include "DATA\ACTOR.pwn"
#include "DATA\VENDING.pwn"
#include "DATA\CONTACT.pwn"
#include "DATA\TOLL.pwn"
#include "DATA\MIDLESTINV.pwn"
#include "DATA\TEXTCLICK.pwn"
#include "DATA\SIREN.pwn"
//DARM
#include "DATA\PRIVATE_FARM.pwn"
//VEH SAPD
#include "VEHFACTION\SAPD.pwn"
#include "VEHFACTION\SAMD.pwn"
#include "VEHFACTION\SANA.pwn"
#include "VEHFACTION\SAGS.pwn"

#include "JOB\JOB_PRODUCTION.pwn"
#include "JOB\JOB_FORKLIFT.pwn"
#include "JOB\JOB_SMUGGLER.pwn"
#include "JOB\JOB_SWEEPER.pwn"
#include "JOB\JOB_TRUCKER.pwn"
#include "JOB\JOB_BAGGAGE.pwn"
#include "JOB\JOB_LUMBER.pwn"
#include "JOB\JOB_FARMER.pwn"
#include "JOB\JOB_MINER.pwn"
//#include "JOB\JOB_NAMBANG.pwn"
//#include "JOB\JOB_KURIR.pwn"
#include "JOB\JOB_MOWER.pwn"
#include "JOB\JOB_TAXI.pwn"
#include "JOB\JOB_MECH.pwn"
#include "JOB\JOB_FISH.pwn"
#include "JOB\JOB_BUS.pwn"

#include "CMD\FACTION.pwn"
#include "CMD\PLAYER.pwn"
#include "CMD\ADMIN.pwn"

#include "DATA\SAPD_TASER.pwn"
#include "DATA\SAPD_SPIKE.pwn"

#include "DATA\MAPPING.pwn"

#include "DATA\KARUNG.pwn"
#include "CMD\ALIAS\ALIAS_PRIVATE_VEHICLE.pwn"
#include "CMD\ALIAS\ALIAS_PLAYER.pwn"
#include "CMD\ALIAS\ALIAS_BISNIS.pwn"
#include "CMD\ALIAS\ALIAS_ADMIN.pwn"
#include "CMD\ALIAS\ALIAS_HOUSE.pwn"

//PROGRES
#include "DATA\PROGRESBAR.pwn"
//#include "DATA\VTOYS.pwn"

#include "DATA\EVENT.pwn"

#include "DATA\FUNCTION.pwn"

#include "DATA\TASK.pwn"

#include "CMD\DISCORD.pwn"

#include "DATA\flymode.pwn"
#include "DATA\VestBuy.pwn"
#include "DATA\ROBBANK.pwn"
//DYNAMIC SGRP
#include "DYNAMIC\DEALERSHIP.pwn"
// MODSHOP
#include "DATA\MODSHOP.pwn"
#include "DATA\MODSHOP\main.pwn"
#include "DATA\VTOYS.pwn"

#include "DATA\DIALOG.pwn"
//-----[ Discord Status ]-----	
forward BotStatus();
public BotStatus()
{
    new h = 0, m = 0, statuz[256];
	h = floatround(upt / 3600);
	m = floatround((upt / 60) - (h * 60));
	upt++;
	//format(statuz,sizeof(statuz),"!register [nama ucp]");
	format(statuz,sizeof(statuz),"SGRP %d Players | %dh %02dm Uptime", pemainic, h, m);
	DCC_SetBotActivity(statuz);
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:g_Discord_Chat;
    g_Discord_Chat = DCC_FindChannelById("909028196291321856");
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == g_Discord_Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new user_name[32 + 1], str[152];
       	DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "{8a6cd1}[DISCORD] {aa1bb5}%s: {ffffff}%s", user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }

    return 1;
}

stock GetCS(playerid)
{
 	new astring[48];
 	if(pData[playerid][pCs] == 0)format(astring, sizeof(astring), ""RED_E"None");
	else if(pData[playerid][pCs] == 1)format(astring, sizeof(astring), ""LG_E"Approved");
	return astring;
}

public OnGameModeInit()
{
	for(new x; x<MAX_PLAYERS; x++)
	{
		if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}

	//mysql_log(ALL);
	SetTimer("BotStatus", 1000, true);
	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE, option_id);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("MySQL connection failed. Server is shutting down.");
		SendRconCommand("exit");
		return 1;
	}
	print("MySQL connection is successful.");

	mysql_tquery(g_SQL, "SELECT * FROM `server`", "LoadServer");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	mysql_tquery(g_SQL, "SELECT * FROM `dealership`", "LoadDealership");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `speedcameras`", "LoadSpeedCam");
	mysql_tquery(g_SQL, "SELECT * FROM `actor`", "LoadActor");
	mysql_tquery(g_SQL, "SELECT * FROM `pedagang`", "LoadPedagang");
	mysql_tquery(g_SQL, "SELECT * FROM `vending`", "LoadVending");
	mysql_tquery(g_SQL, "SELECT * FROM `farm`", "LoadFarm");
	
	ShowNameTags(0);
	EnableTirePopping(0);
	CreateTextDraw();
	CreateServerPoint();
	CreateJoinLumberPoint();
	CreateJoinTaxiPoint();
	CreateJoinMechPoint();
	CreateJoinMinerPoint();
	CreateDynamicObjectBank();
	CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateArmsPoint();
	DestroyDynaimcRobBank();
	//CreateJoinKurirPoint();
	CreateJoinFarmerPoint();
	LoadTazerSAPD();
	CreateJoinSmugglerPoint();
	CreateJoinBaggagePoint();
	CreateCarStealingPoint();
	LoadMap();
	
	ResetCarStealing();
   // Healing = CreateDynamicSphere(89.6223,-1884.4120,-0.6834, 80.0, 0, 0);

	new gm[32];
	format(gm, sizeof(gm), "%s", TEXT_GAMEMODE);
	SetGameModeText(gm);
	format(gm, sizeof(gm), "weburl %s", TEXT_WEBURL);
	SendRconCommand(gm);
	format(gm, sizeof(gm), "language %s", TEXT_LANGUAGE);
	SendRconCommand(gm);
	//SendRconCommand("hostname Xero Gaming Roleplay");
	SendRconCommand("mapname San Andreas");
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	//SetNameTagDrawDistance(20.0);
	//DisableNameTagLOS();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetWorldTime(WorldTime);
	SetWeather(WorldWeather);
	BlockGarages(.text="NO ENTER");
	//Audio_SetPack("default_pack");	
	
	new strings[150];
	
	for(new i = 0; i < sizeof(rentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Bike Rental]\n{FFFFFF}/rentbike");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(rentBoat); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Boat Rental]\n{FFFFFF}/rentboat");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(unrentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Unrent Vehicle]\n{FFFFFF}/unrentpv\n to unrent your vehicle");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

    //JOBS
	CreateDynamicPickup(1239, 23, -1637.206298,-2235.819824,31.476562, -1, -1, -1, 50);
	format(strings, sizeof(strings), "{7fffd4}[Vest Create]\n{FFFFFF}/createvest");
	CreateDynamic3DTextLabel(strings, COLOR_GREY, -1637.206298,-2235.819824,31.476562, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	//-----[ Toll System ]-----	
	for(new i;i < sizeof(BarrierInfo);i ++)
	{
		new
		Float:X = BarrierInfo[i][brPos_X],
		Float:Y = BarrierInfo[i][brPos_Y];

		ShiftCords(0, X, Y, BarrierInfo[i][brPos_A]+90.0, 3.5);
		CreateDynamicObject(966,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z],0.00000000,0.00000000,BarrierInfo[i][brPos_A]);
		if(!BarrierInfo[i][brOpen])
		{
			gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,90.00000000,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[i][brPos_A]+180);
		}
		else gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,20.00000000,BarrierInfo[i][brPos_A]+180);
	}

    format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}/SP{ffffff}' UNTUK MENDAPATKAN STATERPACK");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1749.652343, -1863.090454, 13.575497, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ikea

    format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk mengakses Ikea");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 2796.739257, -1087.630126, 30.719810, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ikea
	
	/*format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk Menambang");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -492.876525, -1772.059570, 19.629934, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk Mencuci Batu");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -378.903869, -1830.367553, 2.506488, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk Mencuci Batu");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -388.388641, -1831.794555, 2.438773, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk Meleburkan Batu");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -412.251220, -1791.600830, 6.530358, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	format(strings, sizeof(strings), "{ffffff}Gunakan '{00ff00}ALT{ffffff}' Untuk Meleburkan Batu");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -409.752868, -1791.146606, 6.512632, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);*/

	CreateDynamicPickup(1239, 23, -2082.9756, 2675.5081, 1500.9647, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[City Hall]\n{FFFFFF}/newidcard - create new ID Card\n/newage - Change Birthday\n/sellhouse - sell your house\n/sellbusiness - sell your bisnis");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2082.9756, 2675.5081, 1500.9647, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card
	
	CreateDynamicPickup(1239, 23, 1296.0533, -1264.1348, 13.5939, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Veh Insurance]\n{FFFFFF}/buyinsu - buy insurance\n/claimpv - claim insurance\n/sellpv - sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1296.0533, -1264.1348, 13.5939, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	CreateDynamicPickup(1239, 23, 1294.1837, -1267.9083, 20.6199, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Sparepart Shop]\n{FFFFFF}/buysparepart\n");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1294.1837, -1267.9083, 20.6199, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	CreateDynamicPickup(1239, 23, -2578.5625, -1383.2179, 1500.7570, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[License]\n{FFFFFF}/newdrivelic - create new license");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -2578.5625, -1383.2179, 1500.7570, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 101.9294, 1064.6431, -48.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 101.9294, 1064.6431, -48.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota LS
	
	CreateDynamicPickup(1239, 23, 85.0160, 1070.5106, -48.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 85.0160, 1070.5106, -48.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, -1466.4567, 2600.2031, 19.6310, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -1466.4567, 2600.2031, 19.6310, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota Dilimore
	
	CreateDynamicPickup(1239, 23, -1469.6188, 2600.2039, 19.6310, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -1469.6188, 2600.2039, 19.6310, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Ls
	
	CreateDynamicPickup(1239, 23, 59.6879, 1067.4708, -50.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Arrest Point]\n{FFFFFF}/arrest - arrest wanted player");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 59.6879, 1067.4708, -50.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest
	
	CreateDynamicPickup(1239, 23, 1142.38, -1330.74, 13.62, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 1142.38, -1330.74, 13.62, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital
	
	CreateDynamicPickup(1239, 23, -2667.4021, 802.2328, 1500.9688, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/newrek - create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2667.4021, 802.2328, 1500.9688, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, -2679.9041, 806.8085, 1500.9688, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/bank - access rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2679.9041, 806.8085, 1500.9688, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, -192.3483, 1338.7361, 1500.9823, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[IKLAN]\n{FFFFFF}/ads - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -192.3483, 1338.7361, 1500.9823, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1241, 23, -1775.2911, -1994.0675, 1500.7853, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MYRICOUS PRODUCTION]\n{FFFFFF}/mix");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -1775.2911, -1994.0675, 1500.7853, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat

	CreateDynamicPickup(1239, 23, -427.3773, -392.3799, 16.5802, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Exchange Money]\n{FFFFFF}/washmoney");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -427.3773, -392.3799, 16.5802, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pencucian uang haram
	
	 // SAGS GARAGE
	CreateDynamicPickup(1239, 23, 1487.641357, -1834.032592, 13.546875, -1);
	format(strings, sizeof(strings), ""LB_E"Sags Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnsg"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnsg"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1487.641357, -1834.032592, 13.546875, 5.0); // Vehicles Stats Sags

    // SAGS DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 1422.383789, -1797.327880, 33.429672, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnsg"WHITE_E"' to despawn helicopter sags");
	CreateDynamic3DTextLabel(strings, ARWIN, 1422.383789, -1797.327880, 33.429672, 5.0);

	// SANA GARAGE
	CreateDynamicPickup(1239, 23, 743.5262, -1332.2343, 13.8414, -1);
	format(strings, sizeof(strings), ""LB_E"Sana Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnsana"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnsana"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 743.5262, -1332.2343, 13.8414, 5.0); // Vehicles Stats Sana
	
	 // SAPD GARAGE
	CreateDynamicPickup(1239, 23, 1568.40, -1695.66, 5.89, -1);
	format(strings, sizeof(strings), ""LB_E"Sapd Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnpd"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnpd"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1568.40, -1695.66, 5.89, 5.0); // Vehicles Stats Sapd

	 // SAMD GARAGE
	CreateDynamicPickup(1239, 23, 1090.036132,-1360.547851,19.967163, -1);
	format(strings, sizeof(strings), ""LB_E"Sapd Vehicles\n"WHITE_E"use '"YELLOW_E"/spawnmd"WHITE_E"' to spawn vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn vehicles");
	CreateDynamic3DTextLabel(strings, ARWIN, 1090.036132,-1360.547851,19.967163, 5.0); // Vehicles Stats Samd
	
	// SAPD DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 1564.8981,-1656.3313,28.3979, -1);
	format(strings, sizeof(strings), ""LB_E"Sapd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnpd"WHITE_E"' to despawn helicopter police");
	CreateDynamic3DTextLabel(strings, ARWIN, 1564.8981,-1656.3313,28.3979, 5.0);
	
	// SAMD DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 1162.8176, -1313.8239, 32.2215, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn helicopter medical");
	CreateDynamic3DTextLabel(strings, ARWIN, 1162.8176, -1313.8239, 32.2215, 5.0);
	
	// SANA DESPAWN HELICOPTER
	CreateDynamicPickup(1239, 23, 741.9764,-1371.2441,25.8835, -1);
	format(strings, sizeof(strings), ""LB_E"Samd Vehicles\n"WHITE_E"use '"YELLOW_E"/despawnmd"WHITE_E"' to despawn helicopter agency");
	CreateDynamic3DTextLabel(strings, ARWIN, 741.9764,-1371.2441,25.8835, 5.0);

	//-----[ Dynamic Checkpoint ]-----	
	ShowRoomCP = CreateDynamicCP(1763.187011,-1768.922119,13.793242, 1.0, -1, -1, -1, 5.0);
	CreateDynamicPickup(1239, 23, 1763.187011,-1768.922119,13.793242, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fffd4}Vehicle Showroom\n{ffffff}Stand Here!", COLOR_GREEN, 1763.187011,-1768.922119,13.793242, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
	
	ShowRoomCPRent = CreateDynamicCP(1763.303344,-1775.025390,13.793242, 1.0, -1, -1, -1, 5.0);
	CreateDynamicPickup(1239, 23, 1763.303344,-1775.025390,13.793242, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fff00}Rental Vehicle\n{ffffff}Stand Here!"YELLOW_E"\n/unrentpv", COLOR_LBLUE, 1763.303344,-1775.025390,13.793242, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
	
	SAGSLobbyBtn[0] = CreateButton(-2688.83, 808.989, 1501.67, 180.0000);//bank
	SAGSLobbyBtn[1] = CreateButton(-2691.719238, 807.353333, 1501.422241, 0.000000); //bank
	SAGSLobbyBtn[2] = CreateButton(-2067.57, 2692.6, 1501.75, 90.0000);
	SAGSLobbyBtn[3] = CreateButton(-2067.81, 2692.64, 1501.64, -90.0000);
	SAGSLobbyBtn[4] = CreateButton(-2062.34, 2695.24, 1501.72, -90.0000);
	SAGSLobbyBtn[5] = CreateButton(-2062.09, 2695.21, 1501.7, 90.0000);
	SAGSLobbyBtn[6] = CreateButton(-2062.33, 2706.59, 1501.71, -90.0000);
	SAGSLobbyBtn[7] = CreateButton(-2062.08, 2706.69, 1501.73, 90.0000);
	SAGSLobbyDoor[0] = CreateDynamicObject(1569, -2689.33, 807.425, 1499.95, 0.000000, 0.000000, -179.877, -1, -1, -1, 300.00, 300.00);//Bank
	SAGSLobbyDoor[1] = CreateDynamicObject(1569, -2067.72, 2694.67, 1499.96, 0.000000, 0.000000, -89.6241, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[2] = CreateDynamicObject(1569, -2062.2, 2693.16, 1499.98, 0.000000, 0.000000, 89.9741, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[3] = CreateDynamicObject(1569, -2062.22, 2704.74, 1499.96, 0.000000, 0.000000, 90.2693, -1, -1, -1, 300.00, 300.00);

	SAMCLobbyBtn[0] = CreateButton(-1786.67, -1999.45, 1501.55, 90.0000);
	SAMCLobbyBtn[1] = CreateButton(-1786.89, -1999.48, 1501.56, -90.0000);
	SAMCLobbyBtn[2] = CreateButton(-1773.67, -1994.98, 1501.57, 180.0000);
	SAMCLobbyBtn[3] = CreateButton(-1773.71, -1995.25, 1501.56, 0.0000);
	SAMCLobbyBtn[4] = CreateButton(-1758.02, -1999.46, 1501.56, -90.0000);
	SAMCLobbyBtn[5] = CreateButton(-1757.81, -1999.46, 1501.57, 90.0000);
	SAMCLobbyDoor[0] = CreateDynamicObject(1569, -1786.8, -1997.48, 1499.77, 0.000000, 0.000000, -90.4041, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[1] = CreateDynamicObject(1569, -1771.77, -1995.14, 1499.77, 0.000000, 0.000000, -179.415, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[2] = CreateDynamicObject(1569, -1757.91, -1997.48, 1499.76, 0.000000, 0.000000, -91.6195, -1, -1, -1, 300.00, 300.00);
	
	//-----[ Sidejob Vehicle ]-----	
	AddSweeperVehicle();
	AddBusVehicle();
	//AddKurirVehicle();
	AddForVehicle();
	AddMowerVehicle();

	//-----[ Job Vehicle ]-----	
	AddBaggageVehicle();

	//-----[ DMV ]-----	
	AddDmvVehicle();

	//model selection
	//vtoylist = LoadModelSelectionMenu("vtoylist.txt");
	
	printf("[Objects]: %d Loaded.", CountDynamicObjects());
	return 1;
}

public OnGameModeExit()
{
	new count = 0, count1 = 0;
	foreach(new gsid : GStation)
	{
		if(Iter_Contains(GStation, gsid))
		{
			count++;
			GStation_Save(gsid);
		}
	}
	printf("[Gas Station]: %d Saved.", count);
	
	foreach(new pid : Plants)
	{
		if(Iter_Contains(Plants, pid))
		{
			count1++;
			Plant_Save(pid);
		}
	}
	printf("[Farmer Plants]: %d Saved.", count1);
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1);
		}
	}
	UnloadTazerSAPD();
	//Audio_DestroyTCPServer();
	mysql_close(g_SQL);
	return 1;
}

/*public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	new
	    File:file = fopen("mysql_error.txt", io_append);

	if(file)
	{
	    new
	        string[2048];

		format(string, sizeof(string), "[%s]\r\nError ID: %i\r\nCallback: %s\r\nQuery: %s\r\n[!] %s\r\n\r\n", GetDate(), errorid, callback, query, error);
		fwrite(file, string);
		fclose(file);
	}

	SendStaffMessage(COLOR_RED, "[ERROR MySQL]:{ffffff} MySQL terjadi kesalahan (error %i). Detail ditulis di mysql_error.txt.", errorid);
	return 1;
}*/

//-----[ Button System ]-----	
function SAGSLobbyDoorClose()
{
	MoveDynamicObject(SAGSLobbyDoor[0], -2689.33, 807.425, 1499.95, 3);
	MoveDynamicObject(SAGSLobbyDoor[1], -2067.72, 2694.67, 1499.96, 3);
	MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2693.16, 1499.98, 3);
	MoveDynamicObject(SAGSLobbyDoor[3], -2062.22, 2704.74, 1499.96, 3);
	return 1;
}

function SAMCLobbyDoorClose()
{
	MoveDynamicObject(SAMCLobbyDoor[0], -1786.8, -1997.48, 1499.77, 3);
	MoveDynamicObject(SAMCLobbyDoor[1], -1771.77, -1995.14, 1499.77, 3);
	MoveDynamicObject(SAMCLobbyDoor[2], -1757.91, -1997.48, 1499.76, 3);
	return 1;
}


public OnPlayerPressButton(playerid, buttonid)
{
	if(buttonid == SAGSLobbyBtn[0] || buttonid == SAGSLobbyBtn[1])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[0], -2687.77, 807.428, 1499.95, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[2] || buttonid == SAGSLobbyBtn[3])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[1], -2067.73, 2696.24, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[4] || buttonid == SAGSLobbyBtn[5])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[2], -2062.2, 2691.63, 1499.98, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAGSLobbyBtn[6] || buttonid == SAGSLobbyBtn[7])
	{
	    if(pData[playerid][pFaction] == 2)
	    {
	        MoveDynamicObject(SAGSLobbyDoor[3], -2062.21, 2703.22, 1499.96, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAGSLobbyDoorClose", 5000, 0);
	    }
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[0] || buttonid == SAMCLobbyBtn[1])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[0], -1786.79, -1995.97, 1499.77, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[2] || buttonid == SAMCLobbyBtn[3])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[1], -1770.25, -1995.13, 1499.77, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	if(buttonid == SAMCLobbyBtn[4] || buttonid == SAMCLobbyBtn[5])
	{
		if(pData[playerid][pFaction] == 3)
		{
			MoveDynamicObject(SAMCLobbyDoor[2], -1757.87, -1995.95, 1499.76, 3, -1000.0, -1000.0, -1000.0);
			SetTimer("SAMCLobbyDoorClose", 5000, 0);
		}
		else
	    {
	        Error(playerid, "Akses ditolak.");
			return 1;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//RemovePlayerAttachedObject(playerid, BOX_INDEX);
	//angkatBox[playerid] = false;
	if(!ispassenger)
	{
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
			    Error(playerid, "Anda bukan SANEWS!");
			}
		}
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 10 && pData[playerid][pJob2] != 10)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                Error(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
			}
		}
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                Error(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				Info(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
			}
		}
		/*if(IsAKurirVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
                Error(playerid, "Kamu tidak bekerja sebagai Courier");
			}
		}*/
		/*foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) && pvData[pv][cLocked] == 1)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					Error(playerid, "This bike is locked by owner.");
				}
			}
		}*/
	}
	return 1;
}

stock SGetName(playerid)
{
    new name[ 64 ];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

public OnPlayerText(playerid, text[])
{
	if(isnull(text)) return 0;
	new str[150];
	format(str,sizeof(str),"[CHAT] %s: %s", GetRPName(playerid), text);
	LogServer("Chat", str);
	printf(str);
	
	/*if(pData[playerid][pAdminDuty] == 1)
	{
		new lstr[200];
		format(lstr, sizeof(lstr), "{FF0000}%s : {FFFFFF}(( %s ))", ReturnName(playerid), text);
		ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
	}*/
	
	if(pData[playerid][pSpawned] == 0 && pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be spawned or logged in to use chat.");
	    return 0;
	}
	//-----[ Auto RP ]-----	
	if(!strcmp(text, "rpgun", true) || !strcmp(text, "gunrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s lepaskan senjatanya dari sabuk dan siap untuk menembak kapan saja.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcrash", true) || !strcmp(text, "crashrp", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s kaget setelah kecelakaan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfish", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memancing dengan kedua tangannya.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfall", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s jatuh dan merasakan sakit.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpmad", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa kesal dan ingin mengeluarkan amarah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprob", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menggeledah sesuatu dan siap untuk merampok.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcj", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mencuri kendaraan seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpwar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berperang dengan sesorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdie", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s pingsan dan tidak sadarkan diri.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfixmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memperbaiki mesin kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcheckmeka", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memeriksa kondisi kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfight", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s ribut dan memukul seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpcry", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang bersedih dan menangis.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rprun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s berlari dan kabur.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpfear", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa ketakutan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdropgun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meletakkan senjata kebawah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rptakegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s mengamnbil senjata.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpgivegun", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memberikan kendaraan kepada seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpshy", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s merasa malu.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnusuk", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s menusuk dan membunuh seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpharvest", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memanen tanaman.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockhouse", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci rumah.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rplockcar", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s sedang mengunci kendaraan.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpnodong", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s memulai menodong seseorang.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpeat", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s makan makanan yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(!strcmp(text, "rpdrink", true))
	{
		SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s meminum minuman yang ia beli.", ReturnName(playerid));
		return 0;
	}
	if(text[0] == '@')
	{
		if(pData[playerid][pSMS] != 0)
		{
			if(pData[playerid][pPhoneCredit] < 1)
			{
				Error(playerid, "Anda tidak memiliki Credit!");
				return 0;
			}
			if(pData[playerid][pInjured] != 0)
			{
				Error(playerid, "Tidak dapat melakukan saat ini.");
				return 0;
			}
			new tmp[512];
			foreach(new ii : Player)
			{
				if(text[1] == ' ')
				{
			 		format(tmp, sizeof(tmp), "%s", text[2]);
				}
				else
				{
				    format(tmp, sizeof(tmp), "%s", text[1]);
				}
				if(pData[ii][pPhone] == pData[playerid][pSMS])
				{
					if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii))
					{
						Error(playerid, "Nomor ini tidak aktif!");
						return 0;
					}
					SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", pData[playerid][pSMS], tmp);
					SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], tmp);
					PlayerPlaySound(ii, 6003, 0,0,0);
					pData[ii][pSMS] = pData[playerid][pPhone];
					
					pData[playerid][pPhoneCredit] -= 1;
					return 0;
				}
			}
		}
	}
	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		format(lstr, sizeof(lstr), "[CellPhone] %s says: %s", ReturnName(playerid), text);
		ProxDetector(10, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		SendClientMessageEx(pData[playerid][pCall], COLOR_YELLOW, "[CELLPHONE] "WHITE_E"%s.", text);
		return 0;
	}
	else
	{
		// Anti-Caps
		if(GetPVarType(playerid, "Caps"))
			UpperToLower(text);
		new lstr[1024];
		if(!IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdminDuty] == 1)
			{
				if(strlen(text) > 64)
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", ReturnName(playerid), text);
					SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", text[64]);
					return 0;
				}
				else
				{
					SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", ReturnName(playerid), text);
					return 0;
				}
			}

			format(lstr, sizeof(lstr), "%s says: %s", ReturnName(playerid), text);
			ProxDetector(25, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			SetPlayerChatBubble(playerid, text, COLOR_WHITE, 10.0, 3000);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		{
			if(pData[playerid][pAdmin] < 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: (( %s ))", ReturnName(playerid), text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
			else if(pData[playerid][pAdmin] > 1 || pData[playerid][pHelper] > 1)
			{
				format(lstr, sizeof(lstr), "[OOC ZONE] %s: %s", pData[playerid][pAdminname], text);
				ProxDetector(40, playerid, lstr, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
			}
		}
		return 0;
	}
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1)
    {
        Error(playerid, "Unknown Command! Gunakan /help untuk info lanjut.");
        return 0;
    }
	new str[150];
	format(str,sizeof(str),"[CMD] %s: [%s] [%s]", GetRPName(playerid), cmd, params);
	LogServer("Command", str);
	printf(str);
    return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}

public OnPlayerConnect(playerid)
{	
	pData[playerid][pIP] = ReturnIP(playerid);
    if((GetTickCount() - pData[playerid][pLeaveTime]) < 5000 && !strcmp(ReturnIP(playerid), pData[playerid][pLeaveIP]))
    {
        SendAdminMessage(COLOR_RED, "AdmWarn: %s (%s) was kicked for possible rejoin hacks.", ReturnName(playerid), ReturnIP(playerid));
        printf("AdmWarn: %s (%s) was kicked for possible rejoin hacks.", ReturnName(playerid), ReturnIP(playerid));
        KickEx(playerid);
        return 1;
    }
    Chat_Create(playerid);
	Chat_Toggle(playerid);
    //antifs[playerid] = false;
	GetDamageID[playerid] = INVALID_PLAYER_ID;
	g_MysqlRaceCheck[playerid]++;
	pemainic++;
	CreatePlayerInv(playerid);
    pData[playerid][pSelectItem] = 0;
    for (new i = 0; i != MAX_INVENTORY; i ++)
	{
	    InventoryData[playerid][i][invExists] = false;
	    InventoryData[playerid][i][invModel] = 0;
	}
	// Reset the data belonging to this player slot
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;

	Player_EditVehicleObject[playerid] = -1;
    Player_EditVehicleObjectSlot[playerid] = -1;
    Player_EditingObject[playerid] = 0;

	pData[playerid][pMarkTemp] = 0;
	AntiBHOP[playerid] = 0;
	IsAtEvent[playerid] = 0;
	takingselfie[playerid] = 0;
	pData[playerid][pDriveLicApp] = 0;
	
	//AntiCheat
	pData[playerid][pJetpack] = 0;
	pData[playerid][pLastUpdate] = 0;
	pData[playerid][pArmorTime] = 0;
	pData[playerid][pACTime] = 0;
	//Anim
	pData[playerid][pLoopAnim] = 0;
	//Rob
	pData[playerid][pLastChop] = 0;
	//Pengganti IsValidTimer
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pActivityTime] = 0;
	pData[playerid][timerpencucianbatu] = 0;
	pData[playerid][pCuciStatus] = 0;

	ResetVariables(playerid);
	RemoveMappingGreenland(playerid);
	CreatePlayerTextDraws(playerid);

	/*LagiKerja[playerid] = false;
	Kurir[playerid] = false;
	angkatBox[playerid] = false;*/

	SetPlayerMapIcon(playerid, 12, 1001.29,-1356.507,12.992, 51 , 0, MAPICON_LOCAL); // ICON TRUCKER
	
	GetPlayerName(playerid, pData[playerid][pUCP], MAX_PLAYER_NAME);
	pData[playerid][pID] = playerid;
	InterpolateCameraPos(playerid, 1429.946655, -1597.120483, 41, 2098.130615, -1775.991210, 41.111639, 50000);
	InterpolateCameraLookAt(playerid, 247.605590, -1841.989990, 39.802570, 817.645996, -1645.395751, 29.292520, 15000);

	SetTimerEx("SafeLogin", 1000, 0, "i", playerid);
	//Prose Load Data
	new query[103];
	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `playerucp` WHERE `ucp` = '%e' LIMIT 1", pData[playerid][pUCP]);
	mysql_pquery(g_SQL, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);
	SetPlayerColor(playerid, COLOR_WHITE);

	pData[playerid][activitybar] = CreatePlayerProgressBar(playerid, 273.500000, 157.333541, 88.000000, 8.000000, 5930683, 100, 0);
	
	//HBE textdraw Simple
	pData[playerid][spdamagebar] = CreatePlayerProgressBar(playerid, 385.000000, 419.000000, 41.000000, 7.500000, -16776961, 1000.0, 0);
	pData[playerid][spfuelbar] = CreatePlayerProgressBar(playerid, 385.000000, 435.000000, 41.000000, 7.500000, -16776961, 1000.0, 0);
                
	pData[playerid][sphungrybar] = CreatePlayerProgressBar(playerid, 530.000000, 401.000000, 64.000000, 9.500000, 852308735, 100.0, 0);
	pData[playerid][spenergybar] = CreatePlayerProgressBar(playerid, 530.000000, 425.000000, 64.000000, 9.500000, 1687547391, 100.0, 0);
	
	pData[playerid][pInjuredLabel] = CreateDynamic3DTextLabel("", COLOR_ORANGE, 0.0, 0.0, -0.3, 10, .attachedplayer = playerid, .testlos = 1);

    if(pData[playerid][pHead] < 0) return pData[playerid][pHead] = 20;

    if(pData[playerid][pPerut] < 0) return pData[playerid][pPerut] = 20;

    if(pData[playerid][pRFoot] < 0) return pData[playerid][pRFoot] = 20;

    if(pData[playerid][pLFoot] < 0) return pData[playerid][pLFoot] = 20;

    if(pData[playerid][pLHand] < 0) return pData[playerid][pLHand] = 20;
   
    if(pData[playerid][pRHand] < 0) return pData[playerid][pRHand] = 20;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{	
	pData[playerid][pLeaveTime] = GetTickCount();
	Player_ResetDamageLog(playerid);
	if(IsValidDynamic3DTextLabel(cNametag[playerid]))
              DestroyDynamic3DTextLabel(cNametag[playerid]);
	pemainic--;
	SetPlayerName(playerid, pData[playerid][pUCP]);
	ResetPlayerVariables(playerid);
	//Pengganti IsValidTimer
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	pData[playerid][pActivityTime] = 0;
	pData[playerid][timerpencucianbatu] = 0;
	pData[playerid][pCuciStatus] = 0;

	DestroyDynamic3DTextLabel(pData[playerid][pInjuredLabel]);
	/*LagiKerja[playerid] = false;
	Kurir[playerid] = false;*/
	pData[playerid][pDriveLicApp] = 0;
	pData[playerid][pSpawnList] = 0;
	takingselfie[playerid] = 0;
	//KillTimer(Unload_Timer[playerid]);
	
	if(IsPlayerInAnyVehicle(playerid))
	{
        RemovePlayerFromVehicle(playerid);
    }
	
	for(new i; i <= 9; i++)
	{
		if(MyBaggage[playerid][i] == true)
		{
		    MyBaggage[playerid][i] = false;
		    DialogBaggage[i] = false;
			if(IsValidVehicle(pData[playerid][pTrailerBaggage]))
		    	DestroyVehicle(pData[playerid][pTrailerBaggage]);  //jika player disconnect maka trailer akan kembali seperti awal
		}
    }
	//UpdateWeapons(playerid);
	g_MysqlRaceCheck[playerid]++;
	
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(IsAtEvent[playerid] == 0)
		{
			UpdatePlayerData(playerid);
		}
		RemovePlayerVehicle(playerid);
		Report_Clear(playerid);
		Ask_Clear(playerid);
		Player_ResetMining(playerid);
		Player_ResetCutting(playerid);
		Player_RemoveLumber(playerid);
		Player_ResetHarvest(playerid);
		KillTazerTimer(playerid);
		if(IsValidVehicle(pData[playerid][pTrailer]))
			DestroyVehicle(pData[playerid][pTrailer]);

		pData[playerid][pTrailer] = INVALID_VEHICLE_ID;
		if(IsAtEvent[playerid] == 1)
		{
			if(GetPlayerTeam(playerid) == 1)
			{
				if(EventStarted == 1)
				{
					RedTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 2)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 1)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							RedTeam = 0;
						}
					}
				}
			}
			if(GetPlayerTeam(playerid) == 2)
			{
				if(EventStarted == 1)
				{
					BlueTeam -= 1;
					foreach(new ii : Player)
					{
						if(GetPlayerTeam(ii) == 1)
						{
							GivePlayerMoneyEx(ii, EventPrize);
							Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
						else if(GetPlayerTeam(ii) == 2)
						{
							Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
							SetPlayerPos(ii, pData[ii][pPosX], pData[ii][pPosY], pData[ii][pPosZ]);
							pData[playerid][pHospital] = 0;
							ClearAnimations(ii);
							BlueTeam = 0;
						}
					}
				}
			}
			SetPlayerTeam(playerid, 0);
			IsAtEvent[playerid] = 0;
			pData[playerid][pInjured] = 0;
			pData[playerid][pSpawned] = 1;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
		}
		if(GetPVarType(playerid, "PlacedBB"))
    	{
        	DestroyDynamicObject(GetPVarInt(playerid, "PlacedBB"));
        	DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "BBLabel"));
        	if(GetPVarType(playerid, "BBArea"))
        	{
            	foreach(new i : Player)
            	{
                	if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "BBArea")))
                	{
                    	StopAudioStreamForPlayer(i);
                    	SendClientMessage(i, COLOR_PURPLE, " The boombox creator has disconnected from the server.");
                	}
            	}
        	}
        }
		if(pData[playerid][pRobLeader] == 1)
		{
			foreach(new ii : Player) 
			{
				if(pData[ii][pMemberRob] > 1)
				{
					Servers(ii, "* Pemimpin Perampokan anda telah keluar! [ MISI GAGAL ]");
					pData[ii][pMemberRob] = 0;
					RobMember = 0;
					pData[ii][pRobLeader] = 0;
					ServerMoney += robmoney;
				}
			}
		}
		if(pData[playerid][pMemberRob] == 1)
		{
			pData[playerid][pMemberRob] = 0;
			foreach(new ii : Player) 
			{
				if(pData[ii][pRobLeader] > 1)
				{
					Servers(ii, "* Member berkurang 1");
					pData[ii][pMemberRob] -= 1;
					RobMember -= 1;
				}
			}
		}
	}
	
	if(IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

    if(IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);
			
	if(IsValidDynamicObject(pData[playerid][pFlare]))
            DestroyDynamicObject(pData[playerid][pFlare]);
    
    if(pData[playerid][pMaskOn] == 1)
            DestroyDynamic3DTextLabel(pData[playerid][pMaskLabel]);

    pData[playerid][pAdoActive] = false;
	
	/*if(cache_is_valid(pData[playerid][Cache_ID]) && pData[playerid][IsLoggedIn] == false)
	{
		cache_delete(pData[playerid][Cache_ID]);
		pData[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}*/

	if (pData[playerid][LoginTimer])
	{
		KillTimer(pData[playerid][LoginTimer]);
		pData[playerid][LoginTimer] = 0;
	}

	pData[playerid][IsLoggedIn] = false;
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	foreach(new ii : Player)
	{
		if(IsPlayerInRangeOfPoint(ii, 40.0, x, y, z))
		{
			switch(reason)
			{
				case 0:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:"YELLOW_E" %s disconnected from the server.{7fffd4}(FC/Crash/Timeout)", pData[playerid][pName]);
				}
				case 1:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:"YELLOW_E" %s disconnected from the server.{7fffd4}(Disconnected)", pData[playerid][pName]);
				}
				case 2:
				{
					SendClientMessageEx(ii, COLOR_RED, "[SERVER]:"YELLOW_E" %s disconnected from the server.{7fffd4}(Kick/Banned)", pData[playerid][pName]);
				}
			}
		}
	}
	new reasontext[526];
	switch(reason)
	{
	    case 0: reasontext = "Timeout/ Crash";
	    case 1: reasontext = "Quit";
	    case 2: reasontext = "Kicked/ Banned";
	}

	new dc[100];
	format(dc, sizeof(dc),  "```\n%s disconnected from the server(%s).```", pData[playerid][pName], reasontext);
	SendDiscordMessage(0, dc);
	return 1;
}
function timerSpawn(playerid)
{
    if(GetPlayerSkin(playerid) == 0) { Kick(playerid); }
    return 1;
}
public OnPlayerSpawn(playerid)
{
	/*for(new i = 0; i < 4; i++) 
	{
	   TextDrawShowForPlayer(playerid, BAGASTOPAN[i]);
	}
	PlayerTextDrawShow(playerid, BAGASANGIN[playerid]);*/
	//SetSpawnInfo(playerid, 0, pData[playerid][pSkin], pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ], pData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
	//SpawnPlayer(playerid);
	//LagiKerja[playerid] = false;
	//Kurir[playerid] = false;
	/*if(antifs[playerid] == false)
	{
		Error(playerid, NOTICE_ANTIFAKESPAWN);
		return Kick(playerid);
	}*/
	timercj[playerid] = SetTimerEx("timerSpawn", 5000, true, "i", playerid);
	new string[256];
	format(string, sizeof(string), "%d", playerid);
	PlayerTextDrawSetString(playerid, BarID[playerid], string );
	StopAudioStreamForPlayer(playerid);
	SetPlayerInterior(playerid, pData[playerid][pInt]);
	SetPlayerVirtualWorld(playerid, pData[playerid][pWorld]);
	SetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	SetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 0);
	SetPlayerSpawn(playerid);
	LoadAnims(playerid);
	
	SetPlayerSkillLevel(playerid, WEAPON_COLT45, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SILENCED, 1);
	SetPlayerSkillLevel(playerid, WEAPON_DEAGLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGUN, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SAWEDOFF, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SHOTGSPA, 1);
	SetPlayerSkillLevel(playerid, WEAPON_UZI, 1);
	SetPlayerSkillLevel(playerid, WEAPON_MP5, 1);
	SetPlayerSkillLevel(playerid, WEAPON_AK47, 1);
	SetPlayerSkillLevel(playerid, WEAPON_M4, 1);
	SetPlayerSkillLevel(playerid, WEAPON_TEC9, 1);
	SetPlayerSkillLevel(playerid, WEAPON_RIFLE, 1);
	SetPlayerSkillLevel(playerid, WEAPON_SNIPER, 1);
	return 1;
}
SetPlayerSpawn(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(pData[playerid][pGender] == 0)
		{
			TogglePlayerControllable(playerid,0);
			SetPlayerHealth(playerid, 100.0);
			SetPlayerArmour(playerid, 0.0);
			SetPlayerPos(playerid, 1716.1129, -1880.0715, -10.0);
			SetPlayerCameraPos(playerid,1429.946655, -1597.120483, 41);
			SetPlayerCameraLookAt(playerid,247.605590, -1841.989990, 39.802570);
			SetPlayerVirtualWorld(playerid, 0);
			ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Tanggal Lahir", "Masukan tanggal lahir\n(Tgl/Bulan/Tahun)\nMisal : 15/04/1998", "Enter", "Batal");
		}
		else
		{
			SetPlayerColor(playerid, COLOR_WHITE);
			CheckPlayerSpawn3Titik(playerid);
			if(pData[playerid][pHBEMode] == 1) //modern
			{
				for(new i = 0; i < 12; i++)
				{
					PlayerTextDrawShow(playerid, HBEV2[playerid][i]);
					PlayerTextDrawShow(playerid, BarMakan[playerid]);
					PlayerTextDrawShow(playerid, BarMinum[playerid]);
					PlayerTextDrawShow(playerid, BarArmor[playerid]);
					PlayerTextDrawShow(playerid, BarID[playerid]);
					PlayerTextDrawShow(playerid, BarMap[playerid]);
				}
			}
			else
			{
				
			}
            for(new i = 0; i < 4; i++)
            {
            	TextDrawShowForPlayer(playerid, TDSERVERNEW[i]);
            }
            TextDrawShowForPlayer(playerid, TextDate);
			TextDrawShowForPlayer(playerid, TextTime);
			for(new i = 0; i < 5; i++) 
			{
				TextDrawHideForPlayer(playerid, WelcomeTD[i]);
			}

			CheckPlayerSpawn3Titik(playerid);
			SetPlayerSkin(playerid, pData[playerid][pSkin]);
			if(pData[playerid][pOnDuty] >= 1)
			{
				SetPlayerSkin(playerid, pData[playerid][pFacSkin]);
				SetFactionColor(playerid);
			}
			if(pData[playerid][pAdminDuty] > 0)
			{
				SetPlayerColor(playerid, COLOR_RED);
			}
			SetTimerEx("SpawnTimer", 6000, false, "i", playerid);
		}
	}
}

function SpawnTimer(playerid)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pData[playerid][pMoney]);
	SetPlayerScore(playerid, pData[playerid][pLevel]);
	SetPlayerHealth(playerid, pData[playerid][pHealth]);
	SetPlayerArmour(playerid, pData[playerid][pArmour]);
	pData[playerid][pSpawned] = 1;
	TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	AttachPlayerToys(playerid);
	SetWeapons(playerid);
	SetPlayerArmedWeapon(playerid, 0);
	if(pData[playerid][pJail] > 0)
	{
		JailPlayer(playerid); 
	}
	if(pData[playerid][pArrestTime] > 0)
	{
		SetPlayerArrest(playerid, pData[playerid][pArrest]);
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerCameraPos(playerid,1429.946655, -1597.120483, 41);
	SetPlayerCameraLookAt(playerid,247.605590, -1841.989990, 39.802570);
	InterpolateCameraPos(playerid, 1429.946655, -1597.120483, 41, 2098.130615, -1775.991210, 41.111639, 50000);
	InterpolateCameraLookAt(playerid, 247.605590, -1841.989990, 39.802570, 817.645996, -1645.395751, 29.292520, 15000);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if (pData[playerid][pSpawned] == 0)
    {
        Error(playerid, "You must be spawned or logged in to use chat.");
        return 0;
    }
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	fly[playerid] = false;
	DeletePVar(playerid, "UsingSprunk");
	SetPVarInt(playerid, "GiveUptime", -1);
	pData[playerid][pSpawned] = 0;
	Player_ResetCutting(playerid);
	Player_RemoveLumber(playerid);
	Player_ResetMining(playerid);
	Player_ResetHarvest(playerid);
	
	pData[playerid][CarryProduct] = 0;
	pData[playerid][pProductingStatus] = 0;
	pData[playerid][pCookingStatus] = 0;
	pData[playerid][pMechanicStatus] = 0;
	pData[playerid][pActivityStatus] = 0;
	pData[playerid][pArmsDealerStatus] = 0;
	pData[playerid][pForklifterLoadStatus] = 0;
	pData[playerid][pForklifterUnLoadStatus] = 0;
	pData[playerid][pFillStatus] = 0;
	
	KillTimer(pData[playerid][pActivity]);
	KillTimer(pData[playerid][pMechanic]);
	KillTimer(pData[playerid][pProducting]);
	KillTimer(pData[playerid][pCooking]);
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	pData[playerid][pMechVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	pData[playerid][timerpencucianbatu] = 0;
	pData[playerid][pCuciStatus] = 0;
	
	pData[playerid][pMechDuty] = 0;
	pData[playerid][pTaxiDuty] = 0;
	pData[playerid][pMission] = -1;
	
	pData[playerid][pSideJob] = 0;
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	RemovePlayerAttachedObject(playerid, 9);
	GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
	foreach(new ii : Player)
    {
        if(pData[ii][pAdmin] > 0)
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
			new dc[128];
			format(dc, sizeof(dc),  "%s :skull_crossbones: %s :gun: %s", GetRPName(playerid), GetRPName(killerid), ReturnWeaponName(reason));
			SendDiscordMessage(4, dc);	
			return 1;
        }
    }
    if(IsAtEvent[playerid] == 1)
    {
    	SetPlayerPos(playerid, 1474.65, -1736.36, 13.38);
    	SetPlayerVirtualWorld(playerid, 0);
    	SetPlayerInterior(playerid, 0);
    	ClearAnimations(playerid);
    	ResetPlayerWeaponsEx(playerid);
       	SetPlayerColor(playerid, COLOR_WHITE);
    	if(GetPlayerTeam(playerid) == 1)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		RedTeam -= 1;
    	}
    	else if(GetPlayerTeam(playerid) == 2)
    	{
    		Servers(playerid, "Anda sudah terkalahkan");
    		BlueTeam -= 1;
    	}
    	if(BlueTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 1)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 2)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    		}
    	}
    	if(RedTeam == 0)
    	{
    		foreach(new ii : Player)
    		{
    			if(GetPlayerTeam(ii) == 2)
    			{
    				GivePlayerMoneyEx(ii, EventPrize);
    				Servers(ii, "Selamat, Tim Anda berhasil memenangkan Event dan Mendapatkan Hadiah $%d per orang", EventPrize);
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				BlueTeam = 0;
    			}
    			else if(GetPlayerTeam(ii) == 1)
    			{
    				Servers(ii, "Maaf, Tim anda sudah terkalahkan, Harap Coba Lagi lain waktu");
    				pData[playerid][pHospital] = 0;
    				ClearAnimations(ii);
    				RedTeam = 0;
    			}
    		}
    	}
    	SetPlayerTeam(playerid, 0);
    	IsAtEvent[playerid] = 0;
    	pData[playerid][pInjured] = 0;
    	pData[playerid][pSpawned] = 1;
		UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
    }
    if(IsAtEvent[playerid] == 0)
    {
    	new asakit = RandomEx(0, 5);
    	new bsakit = RandomEx(0, 9);
    	new csakit = RandomEx(0, 7);
    	new dsakit = RandomEx(0, 6);
    	pData[playerid][pLFoot] -= dsakit;
    	pData[playerid][pLHand] -= bsakit;
    	pData[playerid][pRFoot] -= csakit;
    	pData[playerid][pRHand] -= dsakit;
    	pData[playerid][pHead] -= asakit;
    }
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ,Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	new weaponid = EditingWeapon[playerid];
    if(weaponid)
    {
        if(response == 1)
        {
            new enum_index = weaponid - 22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
            RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
 
            Servers(playerid, "You have successfully adjusted the position of your %s.", weaponname);
           
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", pData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
        }
		else if(response == 0)
		{
			new enum_index = weaponid - 22;
			SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
		}
        EditingWeapon[playerid] = 0;
		return 1;
    }
	else
	{
		if(response == 1)
		{
			InfoTD_MSG(playerid, 4000, "~g~~h~Toy Position Updated~y~!");

			pToys[playerid][index][toy_x] = fOffsetX;
			pToys[playerid][index][toy_y] = fOffsetY;
			pToys[playerid][index][toy_z] = fOffsetZ;
			pToys[playerid][index][toy_rx] = fRotX;
			pToys[playerid][index][toy_ry] = fRotY;
			pToys[playerid][index][toy_rz] = fRotZ;
			pToys[playerid][index][toy_sx] = fScaleX;
			pToys[playerid][index][toy_sy] = fScaleY;
			pToys[playerid][index][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
		}
		else if(response == 0)
		{
			InfoTD_MSG(playerid, 4000, "~r~~h~Selection Cancelled~y~!");

			SetPlayerAttachedObject(playerid,
				index,
				modelid,
				boneid,
				pToys[playerid][index][toy_x],
				pToys[playerid][index][toy_y],
				pToys[playerid][index][toy_z],
				pToys[playerid][index][toy_rx],
				pToys[playerid][index][toy_ry],
				pToys[playerid][index][toy_rz],
				pToys[playerid][index][toy_sx],
				pToys[playerid][index][toy_sy],
				pToys[playerid][index][toy_sz]);
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Player_EditingObject[playerid])
	{
		if (response == EDIT_RESPONSE_FINAL)
		{
			new
                vehicleid = Player_EditVehicleObject[playerid],
                vehid = GetPlayerVehicleID(playerid),
                slot = Player_EditVehicleObjectSlot[playerid],
                Float:vx,
                Float:vy,
                Float:vz,
                Float:va,
                Float:real_x,
                Float:real_y,
                Float:real_z,
                Float:real_a
            ;

            GetVehiclePos(vehid, vx, vy, vz);
            GetVehicleZAngle(vehid, va); // Coba lagi

            real_x = x - vx;
            real_y = y - vy;
            real_z = z - vz;
            real_a = rz - va;

            new Float:v_size[3];
            GetVehicleModelInfo(pvData[vehicleid][cModel], VEHICLE_MODEL_INFO_SIZE, v_size[0], v_size[1], v_size[2]);
            if(	(real_x >= v_size[0] || -v_size[0] >= real_x) ||
                (real_y >= v_size[1] || -v_size[1] >= real_y) ||
                (real_z >= v_size[2] || -v_size[2] >= real_z))
            {
                SendClientMessageEx(playerid, COLOR_ARWIN,"MODSHOP: "WHITE_E"Posisi object terlal jauh dari body kendaraan.");
                ResetEditing(playerid);
                return 1;
            }

            VehicleObjects[vehicleid][slot][vehObjectPosX] = real_x;
            VehicleObjects[vehicleid][slot][vehObjectPosY] = real_y;
            VehicleObjects[vehicleid][slot][vehObjectPosZ] = real_z;
            VehicleObjects[vehicleid][slot][vehObjectPosRX] = rx;
            VehicleObjects[vehicleid][slot][vehObjectPosRY] = ry;
            VehicleObjects[vehicleid][slot][vehObjectPosRZ] = real_a;
		
			Streamer_UpdateEx(playerid, VehicleObjects[vehicleid][slot][vehObjectPosX], VehicleObjects[vehicleid][slot][vehObjectPosY], VehicleObjects[vehicleid][slot][vehObjectPosZ]);
			if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
			{
				SetDynamicObjectMaterial(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectModel], "none", "none", RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectColor]]));
			}
			else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
			{
				SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectText], 130, VehicleObjects[vehicleid][slot][vehObjectFont], VehicleObjects[vehicleid][slot][vehObjectFontSize], 1, RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectFontColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			}
			AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], real_x, real_y, real_z, rx, ry, real_a);
        	Vehicle_ObjectUpdate(vehicleid, slot);
			//Vehicle_AttachObject(vehicleid, slot);
            Vehicle_ObjectSave(vehicleid, slot);
			
            if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
            {
                Dialog_Show(playerid, VACCSE, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nChange Color\nRemove Modification\nSave", "Select", "Back");
            }
            else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
            {
                Dialog_Show(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification\nSave", "Select", "Back");
            }
            else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
            {
                Dialog_Show(playerid, VACCSE2, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nRemove Modification\nSave", "Select", "Back");
            }
			return 1;
		}

		if(response == EDIT_RESPONSE_CANCEL)
		{
			ResetEditing(playerid);
			return 1;
		}
	}
	if(pData[playerid][EditingTreeID] != -1 && Iter_Contains(Trees, pData[playerid][EditingTreeID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        TreeData[etid][treeX] = x;
	        TreeData[etid][treeY] = y;
	        TreeData[etid][treeZ] = z;
	        TreeData[etid][treeRX] = rx;
	        TreeData[etid][treeRY] = ry;
	        TreeData[etid][treeRZ] = rz;

	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_X, TreeData[etid][treeX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Y, TreeData[etid][treeY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[etid][treeLabel], E_STREAMER_Z, TreeData[etid][treeZ] + 1.5);

		    Tree_Save(etid);
	        pData[playerid][EditingTreeID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingTreeID];
	        SetDynamicObjectPos(objectid, TreeData[etid][treeX], TreeData[etid][treeY], TreeData[etid][treeZ]);
	        SetDynamicObjectRot(objectid, TreeData[etid][treeRX], TreeData[etid][treeRY], TreeData[etid][treeRZ]);
	        pData[playerid][EditingTreeID] = -1;
	    }
	}
	if(pData[playerid][EditingOreID] != -1 && Iter_Contains(Ores, pData[playerid][EditingOreID]))
	{
	    if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        OreData[etid][oreX] = x;
	        OreData[etid][oreY] = y;
	        OreData[etid][oreZ] = z;
	        OreData[etid][oreRX] = rx;
	        OreData[etid][oreRY] = ry;
	        OreData[etid][oreRZ] = rz;

	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_X, OreData[etid][oreX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Y, OreData[etid][oreY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, OreData[etid][oreLabel], E_STREAMER_Z, OreData[etid][oreZ] + 1.5);

		    Ore_Save(etid);
	        pData[playerid][EditingOreID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingOreID];
	        SetDynamicObjectPos(objectid, OreData[etid][oreX], OreData[etid][oreY], OreData[etid][oreZ]);
	        SetDynamicObjectRot(objectid, OreData[etid][oreRX], OreData[etid][oreRY], OreData[etid][oreRZ]);
	        pData[playerid][EditingOreID] = -1;
	    }
	}
	if(pData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, pData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_X, AtmData[etid][atmX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Y, AtmData[etid][atmY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AtmData[etid][atmLabel], E_STREAMER_Z, AtmData[etid][atmZ] + 0.3);

		    Atm_Save(etid);
	        pData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = pData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        pData[playerid][EditingATMID] = -1;
	    }
	}
	if(pData[playerid][EditingVending] != -1 && Iter_Contains(Vendings, pData[playerid][EditingVending]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new venid = pData[playerid][EditingVending];
	        VendingData[venid][vendingX] = x;
	        VendingData[venid][vendingY] = y;
	        VendingData[venid][vendingZ] = z;
	        VendingData[venid][vendingRX] = rx;
	        VendingData[venid][vendingRY] = ry;
	        VendingData[venid][vendingRZ] = rz;

	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_X, VendingData[venid][vendingX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Y, VendingData[venid][vendingY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, VendingData[venid][vendingText], E_STREAMER_Z, VendingData[venid][vendingZ] + 0.3);

		    Vending_Save(venid);
	        pData[playerid][EditingVending] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new venid = pData[playerid][EditingVending];
	        SetDynamicObjectPos(objectid, VendingData[venid][vendingX], VendingData[venid][vendingY], VendingData[venid][vendingZ]);
	        SetDynamicObjectRot(objectid, VendingData[venid][vendingRX], VendingData[venid][vendingRY], VendingData[venid][vendingRZ]);
	    	pData[playerid][EditingVending] = -1;
	    }
	}
	if(pData[playerid][gEditID] != -1 && Iter_Contains(Gates, pData[playerid][gEditID]))
	{
		new id = pData[playerid][gEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, gPosX[playerid], gPosY[playerid], gPosZ[playerid]);
			SetDynamicObjectRot(objectid, gRotX[playerid], gRotY[playerid], gRotZ[playerid]);
			gPosX[playerid] = 0; gPosY[playerid] = 0; gPosZ[playerid] = 0;
			gRotX[playerid] = 0; gRotY[playerid] = 0; gRotZ[playerid] = 0;
			Servers(playerid, " You have canceled editing gate ID %d.", id);
			Gate_Save(id);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(pData[playerid][gEdit] == 1)
			{
				gData[id][gCX] = x;
				gData[id][gCY] = y;
				gData[id][gCZ] = z;
				gData[id][gCRX] = rx;
				gData[id][gCRY] = ry;
				gData[id][gCRZ] = rz;
				if(IsValidDynamic3DTextLabel(gData[id][gText])) DestroyDynamic3DTextLabel(gData[id][gText]);
				new str[64];
				format(str, sizeof(str), "Gate ID: %d", id);
				gData[id][gText] = CreateDynamic3DTextLabel(str, COLOR_WHITE, gData[id][gCX], gData[id][gCY], gData[id][gCZ], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 10.0);
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's closing position.", id);
				gData[id][gStatus] = 0;
				Gate_Save(id);
			}
			else if(pData[playerid][gEdit] == 2)
			{
				gData[id][gOX] = x;
				gData[id][gOY] = y;
				gData[id][gOZ] = z;
				gData[id][gORX] = rx;
				gData[id][gORY] = ry;
				gData[id][gORZ] = rz;
				
				pData[playerid][gEditID] = -1;
				pData[playerid][gEdit] = 0;
				Servers(playerid, " You have finished editing gate ID %d's opening position.", id);

				gData[id][gStatus] = 1;
				Gate_Save(id);
			}
		}
	}
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == pData[playerid][LoadingPoint])
	{
	    if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		return 1;
	}
	if(checkpointid == ShowRoomCP)
	{
		ShowPlayerDialog(playerid, DIALOG_BUYPVCP, DIALOG_STYLE_LIST, "{7fffd4}Shine Green City Showroom", "Motorcycle\nMobil\nKendaraan Unik\nKendaraan Job", "Select", "Cancel");
	}
	if(checkpointid == ShowRoomCPRent)
	{
		new str[1024];
		format(str, sizeof(str), "Kendaraan\tHarga\n"WHITE_E"%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days\n%s\t"LG_E"$500 / one days",
		GetVehicleModelName(414), 
		GetVehicleModelName(455), 
		GetVehicleModelName(456),
		GetVehicleModelName(498),
		GetVehicleModelName(499),
		GetVehicleModelName(609),
		GetVehicleModelName(478),
		GetVehicleModelName(422),
		GetVehicleModelName(543),
		GetVehicleModelName(554),
		GetVehicleModelName(525),
		GetVehicleModelName(438),
		GetVehicleModelName(420)
		);
		
		ShowPlayerDialog(playerid, DIALOG_RENT_JOBCARS, DIALOG_STYLE_TABLIST_HEADERS, "Rent Job Cars", str, "Rent", "Close");
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	switch(pData[playerid][pCheckPoint])
	{
		case CHECKPOINT_BAGGAGE:
		{
			if(pData[playerid][pBaggage] > 0)
			{
				if(pData[playerid][pBaggage] == 1)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.4792, -2435.2844, 13.2118, 1524.4792, -2435.2844, 13.2118, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 2)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 3;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.7998, -2392.8328, 13.2083, 2087.7998, -2392.8328, 13.2083, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2087.7998, -2392.8328, 13.2083, 179.9115, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 3)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 4;
					SetPlayerRaceCheckpoint(playerid, 1, 1605.2043, -2435.4360, 13.2153, 1605.2043, -2435.4360, 13.2153, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 4)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 5;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.6425, -2340.5103, 13.2045, 2006.6425, -2340.5103, 13.2045, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.6425, -2340.5103, 13.2045, 90.0068, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 5)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 6;
					SetPlayerRaceCheckpoint(playerid, 1, 1684.9463, -2435.2239, 13.2137, 1684.9463, -2435.2239, 13.2137, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 6)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 7;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2006.4136, -2273.7458, 13.2012, 2006.4136, -2273.7458, 13.2012, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2006.4136, -2273.7458, 13.2012, 92.4049, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 7)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 8;
					SetPlayerRaceCheckpoint(playerid, 1, 1765.8700, -2435.1189, 13.2090, 1765.8700, -2435.1189, 13.2090, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 8)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 9;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2056.9043, -2392.0959, 13.2038, 2056.9043, -2392.0959, 13.2038, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2056.9043, -2392.0959, 13.2038, 179.4666, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 9)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 10;
					SetPlayerRaceCheckpoint(playerid, 1, 1524.1018, -2435.0664, 13.2139, 1524.1018, -2435.0664, 13.2139, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 10)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 11;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2099.8982, -2200.7234, 13.2042, 2099.8982, -2200.7234, 13.2042, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[0] = false;
					MyBaggage[playerid][0] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 400);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGGAGE 2
				else if(pData[playerid][pBaggage] == 12)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 13;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.7626, -2638.8113, 13.2074, 1891.7626, -2638.8113, 13.2074, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 13)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 14;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.5886, -2406.7236, 13.2065, 2007.5886, -2406.7236, 13.2065, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2007.5886, -2406.7236, 13.2065, 85.9836, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 14)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 15;
					SetPlayerRaceCheckpoint(playerid, 1, 1822.6267, -2637.9224, 13.2049, 1822.6267, -2637.9224, 13.2049, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 15)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 16;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2007.2054, -2358.0920, 13.2030, 2007.2054, -2358.0920, 13.2030, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 2007.2054, -2358.0920, 13.2030, 89.7154, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 16)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 17;
					SetPlayerRaceCheckpoint(playerid, 1, 1617.9980, -2638.5725, 13.2034, 1617.9980, -2638.5725, 13.2034, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 17)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 18;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1874.9221, -2348.8616, 13.2039, 1874.9221, -2348.8616, 13.2039, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1874.9221, -2348.8616, 13.2039, 274.8172, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 18)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 19;
					SetPlayerRaceCheckpoint(playerid, 1, 1681.0703, -2638.5410, 13.2045, 1681.0703, -2638.5410, 13.2045, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 19)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 20;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1424.8074, -2415.5378, 13.2094, 1424.8074, -2415.5378, 13.2094, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1424.8074, -2415.5378, 13.2094, 268.7459, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 20)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 21;
					SetPlayerRaceCheckpoint(playerid, 1, 1755.4872, -2639.1306, 13.2014, 1755.4872, -2639.1306, 13.2014, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 21)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 22;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint terakhir di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2110.0212, -2211.1377, 13.2008, 2110.0212, -2211.1377, 13.2008, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 22)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[1] = false;
					MyBaggage[playerid][1] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 400);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				//RUTE BAGGAGE 3
				else if(pData[playerid][pBaggage] == 23)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 24;
					SetPlayerRaceCheckpoint(playerid, 1, 1509.5022, -2431.4277, 13.2163, 1509.5022, -2431.4277, 13.2163, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 24)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 25;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1913.4680, -2678.1877, 13.2135, 1913.4680, -2678.1877, 13.2135, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 1913.4680, -2678.1877, 13.2135, 358.3546, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 25)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 26;
					SetPlayerRaceCheckpoint(playerid, 1, 1591.0934, -2432.3208, 13.2094, 1591.0934, -2432.3208, 13.2094, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 26)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 27;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1593.1262, -2685.6423, 13.2016, 1593.1262, -2685.6423, 13.2016, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1593.1262, -2685.6423, 13.2016, 359.1027, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 27)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 28;
					SetPlayerRaceCheckpoint(playerid, 1, 1751.1523, -2432.6274, 13.2132, 1751.1523, -2432.6274, 13.2132, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 28)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 29;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 1706.6799, -2686.6472, 13.2031, 1706.6799, -2686.6472, 13.2031, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(607, 1706.6799, -2686.6472, 13.2031, 358.5210, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 29)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 30;
					SetPlayerRaceCheckpoint(playerid, 1, 1892.2029, -2344.9568, 13.2069, 1892.2029, -2344.9568, 13.2069, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 30)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 31;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint selanjutnya di GPSmu, Untuk mengambil muatan!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2160.3184, -2390.0625, 13.2055, 2160.3184, -2390.0625, 13.2055, 5.0);
						pData[playerid][pTrailerBaggage] = CreateVehicle(606, 2160.3184, -2390.0625, 13.2055, 157.5291, 1, 1, -1);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 31)
				{
					DisablePlayerRaceCheckpoint(playerid);
					SendClientMessage(playerid, COLOR_LBLUE,"[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mengirim muatan!.");
					pData[playerid][pBaggage] = 32;
					SetPlayerRaceCheckpoint(playerid, 1, 1891.8900, -2261.1121, 13.2071, 1891.8900, -2261.1121, 13.2071, 5.0);
					return 1;
				}
				else if(pData[playerid][pBaggage] == 32)
				{
					if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBaggage] = 33;
						DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
						SendClientMessage(playerid, COLOR_LBLUE, "[BAGGAGE]: {FFFFFF}Pergi ke checkpoint di GPSmu, Untuk mendapatkan gajimu!.");
						SetPlayerRaceCheckpoint(playerid, 1, 2087.1458, -2192.2161, 13.2047, 2087.1458, -2192.2161, 13.2047, 5.0);
						return 1;
					}
				}
				else if(pData[playerid][pBaggage] == 33)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					DisablePlayerRaceCheckpoint(playerid);
					pData[playerid][pBaggage] = 0;
					pData[playerid][pJobTime] += 1380;
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DialogBaggage[2] = false;
					MyBaggage[playerid][2] = false;
					AddPlayerSalary(playerid, "Job(Baggage)", 400);
					Info(playerid, "Job(Baggage) telah masuk ke pending salary anda!");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}	
			}
		}
		case CHECKPOINT_DRIVELIC:
		{
			if(pData[playerid][pDriveLicApp] > 0)
			{
				if(pData[playerid][pDriveLicApp] == 1)
				{
					pData[playerid][pDriveLicApp] = 2;
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint2, dmvpoint2, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 2)
				{
					pData[playerid][pDriveLicApp] = 3;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint3, dmvpoint3, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 3)
				{
					pData[playerid][pDriveLicApp] = 4;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint4, dmvpoint4, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 4)
				{
					pData[playerid][pDriveLicApp] = 5;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint5, dmvpoint5, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 5)
				{
					pData[playerid][pDriveLicApp] = 6;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint6, dmvpoint6, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 6)
				{
					pData[playerid][pDriveLicApp] = 7;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint7, dmvpoint7, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 7)
				{
					pData[playerid][pDriveLicApp] = 8;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint8, dmvpoint8, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 8)
				{
					pData[playerid][pDriveLicApp] = 9;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint9, dmvpoint9, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 9)
				{
					pData[playerid][pDriveLicApp] = 10;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint10, dmvpoint10, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 10)
				{
					pData[playerid][pDriveLicApp] = 11;
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 1, dmvpoint11, dmvpoint11, 5.0);
					return 1;
				}
				else if(pData[playerid][pDriveLicApp] == 11)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					pData[playerid][pDriveLicApp] = 0;
					pData[playerid][pDriveLic] = 1;
					pData[playerid][pDriveLicTime] = gettime() + (30 * 86400);
					pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
					DisablePlayerRaceCheckpoint(playerid);
					GivePlayerMoneyEx(playerid, -700);
					Server_AddMoney(700);
					Info(playerid, "Selamat kamu telah berhasil membuat SIM");
					RemovePlayerFromVehicle(playerid);
					SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					return 1;
				}
				
			}
		}
		case CHECKPOINT_BUS:
		{
			if(pData[playerid][pSideJob] == 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 431)
				{
					if(pData[playerid][pBus] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint2, buspoint2, 5.0);
					}
					else if(pData[playerid][pBus] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint3, buspoint3, 5.0);
					}
					else if(pData[playerid][pBus] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint4, buspoint4, 5.0);
					}
					else if(pData[playerid][pBus] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint5, buspoint5, 5.0);
					}
					else if(pData[playerid][pBus] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint6, buspoint6, 5.0);
					}
					else if(pData[playerid][pBus] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint7, buspoint7, 5.0);
					}
					else if(pData[playerid][pBus] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint8, buspoint8, 5.0);
					}
					else if(pData[playerid][pBus] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint9, buspoint9, 5.0);
					}
					else if(pData[playerid][pBus] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint10, buspoint10, 5.0);
					}
					else if(pData[playerid][pBus] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint11, buspoint11, 5.0);
					}
					else if(pData[playerid][pBus] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint12, buspoint12, 5.0);
					}
					else if(pData[playerid][pBus] == 12)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 13;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint13, buspoint13, 5.0);
					}
					else if(pData[playerid][pBus] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint14, buspoint14, 5.0);
					}
					else if(pData[playerid][pBus] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint15, buspoint15, 5.0);
					}
					else if(pData[playerid][pBus] == 15)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 16;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint16, buspoint16, 5.0);
					}
					else if(pData[playerid][pBus] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint17, buspoint17, 5.0);
					}
					else if(pData[playerid][pBus] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint18, buspoint18, 5.0);
					}
					else if(pData[playerid][pBus] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint19, buspoint19, 5.0);
					}
					else if(pData[playerid][pBus] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 20;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint20, buspoint20, 5.0);
					}
					else if(pData[playerid][pBus] == 20)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 21;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint21, buspoint21, 5.0);
					}
					else if(pData[playerid][pBus] == 21)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 22;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint22, buspoint22, 5.0);
					}
					else if(pData[playerid][pBus] == 22)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 23;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint23, buspoint23, 5.0);
					}
					else if(pData[playerid][pBus] == 23)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 24;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint24, buspoint24, 5.0);
					}
					else if(pData[playerid][pBus] == 24)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 25;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint25, buspoint25, 5.0);
					}
					else if(pData[playerid][pBus] == 25)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 26;
						SetPlayerRaceCheckpoint(playerid, 2, buspoint26, buspoint26, 5.0);
					}
					else if(pData[playerid][pBus] == 26)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 27;
						SetPlayerRaceCheckpoint(playerid, 1, buspoint27, buspoint27, 5.0);
					}
					else if(pData[playerid][pBus] == 27)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pBusTime] = 360;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Bus)", 210);
						Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pBus] == 28)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 29;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus3, cpbus3, 5.0);
					}
					else if(pData[playerid][pBus] == 29)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 30;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus4, cpbus4, 5.0);
					}
					else if(pData[playerid][pBus] == 30)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 31;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus5, cpbus5, 5.0);
					}
					else if(pData[playerid][pBus] == 31)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 32;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus6, cpbus6, 5.0);
					}
					else if(pData[playerid][pBus] == 32)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 33;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus7, cpbus7, 5.0);
					}
					else if(pData[playerid][pBus] == 33)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 34;
						SetPlayerRaceCheckpoint(playerid, 2, cpbus8, cpbus8, 5.0);
					}
					else if(pData[playerid][pBus] == 34)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pBus] = 35;
						SetPlayerRaceCheckpoint(playerid, 1, cpbus9, cpbus9, 5.0);
					}
					else if(pData[playerid][pBus] == 35)
					{
						pData[playerid][pBus] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pBusTime] = 400;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Bus)", 210);
						Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_SWEEPER:
		{
			if(pData[playerid][pSideJob] == 1)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 574)
				{
					if(pData[playerid][pSweeper] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint2, sweperpoint2, 5.0);
					}
					else if(pData[playerid][pSweeper] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint3, sweperpoint3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint4, sweperpoint4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint5, sweperpoint5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint6, sweperpoint6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint7, sweperpoint7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint8, sweperpoint8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint9, sweperpoint9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint10, sweperpoint10, 5.0);
					}
					else if(pData[playerid][pSweeper] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, sweperpoint11, sweperpoint11, 5.0);
					}
					else if(pData[playerid][pSweeper] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 12;
						SetPlayerRaceCheckpoint(playerid, 1, sweperpoint12, sweperpoint12, 5.0);
					}
					else if(pData[playerid][pSweeper] == 12)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 120;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Sweeper)", 80);
						Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
					else if(pData[playerid][pSweeper] == 13)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 14;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep3, cpswep3, 5.0);
					}
					else if(pData[playerid][pSweeper] == 14)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 15;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep4, cpswep4, 5.0);
					}
					else if(pData[playerid][pSweeper] == 15)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 16;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep5, cpswep5, 5.0);
					}
					else if(pData[playerid][pSweeper] == 16)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 17;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep6, cpswep6, 5.0);
					}
					else if(pData[playerid][pSweeper] == 17)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 18;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep7, cpswep7, 5.0);
					}
					else if(pData[playerid][pSweeper] == 18)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 19;
						SetPlayerRaceCheckpoint(playerid, 2, cpswep8, cpswep8, 5.0);
					}
					else if(pData[playerid][pSweeper] == 19)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pSweeper] = 20;
						SetPlayerRaceCheckpoint(playerid, 1, cpswep9, cpswep9, 5.0);
					}
					else if(pData[playerid][pSweeper] == 20)
					{
						pData[playerid][pSweeper] = 0;
						pData[playerid][pSideJob] = 0;
						pData[playerid][pSweeperTime] = 150;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Sweeper)", 80);
						Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_FORKLIFTER:
		{
			if(pData[playerid][pSideJob] == 3)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 530)
				{
					if(pData[playerid][pForklifter] == 1)
					{
						pData[playerid][pForklifter] = 2;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 2)
					{
						pData[playerid][pForklifter] = 3;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 3)
					{
						pData[playerid][pForklifter] = 4;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 4)
					{
						pData[playerid][pForklifter] = 5;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 5)
					{
						pData[playerid][pForklifter] = 6;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 6)
					{
						pData[playerid][pForklifter] = 7;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 7)
					{
						pData[playerid][pForklifter] = 8;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 8)
					{
						pData[playerid][pForklifter] = 9;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterUnLoadStatus] = 1;
						pData[playerid][pForklifterUnLoad] = SetTimerEx("ForklifterUnLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Unloaded...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 9)
					{
						pData[playerid][pForklifter] = 10;
						TogglePlayerControllable(playerid, 0);
						pData[playerid][pForklifterLoadStatus] = 1;
						pData[playerid][pForklifterLoad] = SetTimerEx("ForklifterLoadBox", 1000, true, "i", playerid);
						PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Loading...");
						PlayerTextDrawShow(playerid, ActiveTD[playerid]);
						ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
					}
					else if(pData[playerid][pForklifter] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pForklifter] = 11;
						DestroyDynamicObject(VehicleObject[vehicleid]);
						VehicleObject[vehicleid] = INVALID_OBJECT_ID;
						SetPlayerRaceCheckpoint(playerid, 1, forpoint3, forpoint3, 4.0);
					}
					else if(pData[playerid][pForklifter] == 11)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pForklifterTime] = 80;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Forklift)", 240);
						Info(playerid, "Sidejob(Forklift) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
						return 1;
					}
				}
			}
		}
		case CHECKPOINT_MOWER:
		{
			if(pData[playerid][pSideJob] == 4)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetVehicleModel(vehicleid) == 572)
				{
					if(pData[playerid][pMower] == 1)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 2;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint2, mowerpoint2, 5.0);
					}
					else if(pData[playerid][pMower] == 2)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 3;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint3, mowerpoint3, 5.0);
					}
					else if(pData[playerid][pMower] == 3)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 4;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint4, mowerpoint4, 5.0);
					}
					else if(pData[playerid][pMower] == 4)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 5;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint5, mowerpoint5, 5.0);
					}
					else if(pData[playerid][pMower] == 5)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 6;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint6, mowerpoint6, 5.0);
					}
					else if(pData[playerid][pMower] == 6)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 7;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint7, mowerpoint7, 5.0);
					}
					else if(pData[playerid][pMower] == 7)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 8;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint8, mowerpoint8, 5.0);
					}
					else if(pData[playerid][pMower] == 8)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 9;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint9, mowerpoint9, 5.0);
					}
					else if(pData[playerid][pMower] == 9)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 10;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint10, mowerpoint10, 5.0);
					}
					else if(pData[playerid][pMower] == 10)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 11;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint11, mowerpoint11, 5.0);
					}
					else if(pData[playerid][pMower] == 11)
					{
						DisablePlayerRaceCheckpoint(playerid);
						pData[playerid][pMower] = 12;
						SetPlayerRaceCheckpoint(playerid, 2, mowerpoint12, mowerpoint12, 5.0);
					}
					else if(pData[playerid][pMower] == 12)
					{
						pData[playerid][pSideJob] = 0;
						pData[playerid][pMower] = 0;
						pData[playerid][pMowerTime] += 120;
						pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
						DisablePlayerRaceCheckpoint(playerid);
						AddPlayerSalary(playerid, "Sidejob(Mower)", 50);
						Info(playerid, "Sidejob(Mower) telah masuk ke pending salary anda!");
						RemovePlayerFromVehicle(playerid);
						SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
					}
				}
			}
		}
		case CHECKPOINT_MISC:
		{
			pData[playerid][pCheckPoint] = CHECKPOINT_NONE;
			DisablePlayerRaceCheckpoint(playerid);
		}
	}
	if(pData[playerid][pGpsActive] == 1)
	{
		pData[playerid][pGpsActive] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackCar] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan kendaraan anda!");
		pData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackHouse] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan rumah anda!");
		pData[playerid][pTrackHouse] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackVending] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan mesin vending anda!");
		pData[playerid][pTrackVending] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pTrackBisnis] == 1)
	{
		Info(playerid, "Anda telah berhasil menemukan bisnis!");
		pData[playerid][pTrackBisnis] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(pData[playerid][pMission] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		Info(playerid, "/buy , /gps(My Mission) , /storeproduct.");
	}
	if(pData[playerid][pHauling] > -1)
	{
		if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
		{
			DisablePlayerRaceCheckpoint(playerid);
			Info(playerid, "'/storegas' untuk menyetor GasOilnya!");
		}
		else
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, 335.66, 861.02, 21.01))
			{
				DisablePlayerRaceCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 336.70, 895.54, 20.40, 5.5);
				Info(playerid, "Silahkan ambil trailer dan menuju ke checkpoint untuk membeli GasOil!");
			}
			else
			{
				Error(playerid, "Kamu tidak membawa Trailer Gasnya, Silahkan ambil kembali trailernnya!");
			}
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	/*new playerState = GetPlayerState(playerid);
    if(playerState == PLAYER_STATE_ONFOOT )
    {
	    if(Kurir[playerid] == true)
	    {
            if(angkatBox[playerid] == false)
	        {
				 Error(playerid,"Silahkan bawa Box pengiriman barang, /angkatbox");
			}
			else if(angkatBox[playerid] == true)
	        {
	        RemovePlayerAttachedObject(playerid, BOX_INDEX);
			GameTextForPlayer(playerid, "~g~MELETAKKAN BARANG...", 4000, 3);
            ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
	        Unload_Timer[playerid] = SetTimerEx("PekerjaanSelesai", 5000, false, "i", playerid);
	        TogglePlayerControllable(playerid,0);
		    }
        }
	}*/
	if(pData[playerid][pHauling] > -1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.5, 336.70, 895.54, 20.40))
		{
			DisablePlayerCheckpoint(playerid);
			Info(playerid, "/buy, /gps(My Hauling), /storegas.");
		}
	}
	/*if(pData[playerid][pCP] == 1)
	{
		pData[playerid][pJobTime] = 120;
		DisablePlayerCheckpoint(playerid);
		AddPlayerSalary(playerid, "Job (Kurir)", 120);
        pData[playerid][pKurirEnd] = 0;
        pData[playerid][pCP] = 0;
		Info(playerid, "Job (Kurir) telah masuk ke pending salary anda!");
		RemovePlayerFromVehicle(playerid);
		SetTimerEx("RespawnPV", 3000, false, "d", GetPlayerVehicleID(playerid));
	}*/
	if(pData[playerid][CarryingLog] != -1)
	{
		if(GetPVarInt(playerid, "LoadingCooldown") > gettime()) return 1;
		new vehicleid = GetPVarInt(playerid, "LastVehicleID"), type[64], carid = -1;
		if(pData[playerid][CarryingLog] == 0)
		{
			type = "Metal";
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			type = "Coal";
		}
		else
		{
			type = "Unknown";
		}
		if(Vehicle_LogCount(vehicleid) >= LOG_LIMIT) return Error(playerid, "You can't load any more ores to this vehicle.");
		if((carid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(pData[playerid][CarryingLog] == 0)
			{
				pvData[carid][cMetal] += 1;
			}
			else if(pData[playerid][CarryingLog] == 1)
			{
				pvData[carid][cCoal] += 1;
			}
		}
		LogStorage[vehicleid][ pData[playerid][CarryingLog] ]++;
		Info(playerid, "MINING: Loaded %s.", type);
		ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		Player_RemoveLog(playerid);
		DisablePlayerCheckpoint(playerid);
		return 1;
	}
	if(pData[playerid][pFindEms] != INVALID_PLAYER_ID)
	{
		pData[playerid][pFindEms] = INVALID_PLAYER_ID;
		DisablePlayerCheckpoint(playerid);
	}
	if(pData[playerid][pSideJob] == 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 574)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint1))
			{
				SetPlayerCheckpoint(playerid, sweperpoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint2))
			{
				SetPlayerCheckpoint(playerid, sweperpoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint3))
			{
				SetPlayerCheckpoint(playerid, sweperpoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint4))
			{
				SetPlayerCheckpoint(playerid, sweperpoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint5))
			{
				SetPlayerCheckpoint(playerid, sweperpoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint6))
			{
				SetPlayerCheckpoint(playerid, sweperpoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint7))
			{
				SetPlayerCheckpoint(playerid, sweperpoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint8))
			{
				SetPlayerCheckpoint(playerid, sweperpoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint9))
			{
				SetPlayerCheckpoint(playerid, sweperpoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint10))
			{
				SetPlayerCheckpoint(playerid, sweperpoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint11))
			{
				SetPlayerCheckpoint(playerid, sweperpoint12, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,sweperpoint12))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pSweeperTime] = 120;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Sweeper)", 80);
				Info(playerid, "Sidejob(Sweeper) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	if(pData[playerid][pSideJob] == 2)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 431)
		{
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint1))
			{
				SetPlayerCheckpoint(playerid, buspoint2, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint2))
			{
				SetPlayerCheckpoint(playerid, buspoint3, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint3))
			{
				SetPlayerCheckpoint(playerid, buspoint4, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint4))
			{
				SetPlayerCheckpoint(playerid, buspoint5, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint5))
			{
				SetPlayerCheckpoint(playerid, buspoint6, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint6))
			{
				SetPlayerCheckpoint(playerid, buspoint7, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint7))
			{
				SetPlayerCheckpoint(playerid, buspoint8, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint8))
			{
				SetPlayerCheckpoint(playerid, buspoint9, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint9))
			{
				SetPlayerCheckpoint(playerid, buspoint10, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint10))
			{
				SetPlayerCheckpoint(playerid, buspoint11, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint11))
			{
				SetPlayerCheckpoint(playerid, buspoint12, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint12))
			{
				SetPlayerCheckpoint(playerid, buspoint13, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint13))
			{
				SetPlayerCheckpoint(playerid, buspoint14, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint14))
			{
				SetPlayerCheckpoint(playerid, buspoint15, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint15))
			{
				SetPlayerCheckpoint(playerid, buspoint16, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint16))
			{
				SetPlayerCheckpoint(playerid, buspoint17, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint17))
			{
				SetPlayerCheckpoint(playerid, buspoint18, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint18))
			{
				SetPlayerCheckpoint(playerid, buspoint19, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint19))
			{
				SetPlayerCheckpoint(playerid, buspoint20, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint20))
			{
				SetPlayerCheckpoint(playerid, buspoint21, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint21))
			{
				SetPlayerCheckpoint(playerid, buspoint22, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint22))
			{
				SetPlayerCheckpoint(playerid, buspoint23, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint23))
			{
				SetPlayerCheckpoint(playerid, buspoint24, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint24))
			{
				SetPlayerCheckpoint(playerid, buspoint25, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint25))
			{
				SetPlayerCheckpoint(playerid, buspoint26, 7.0);
			}
			if (IsPlayerInRangeOfPoint(playerid, 7.0,buspoint26))
			{
				SetPlayerCheckpoint(playerid, buspoint27, 7.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 7.0,buspoint27))
			{
				pData[playerid][pSideJob] = 0;
				pData[playerid][pBusTime] = 360;
				DisablePlayerCheckpoint(playerid);
				AddPlayerSalary(playerid, "Sidejob(Bus)", 200);
				Info(playerid, "Sidejob(Bus) telah masuk ke pending salary anda!");
				RemovePlayerFromVehicle(playerid);
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
		}
	}
	//DisablePlayerCheckpoint(playerid);
	return 1;
}

forward JobForklift(playerid);
public JobForklift(playerid)
{
	TogglePlayerControllable(playerid, 1);
	GameTextForPlayer(playerid, "~w~SELESAI!", 5000, 3);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!pCBugging[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_FIRE))
		{
			switch(GetPlayerWeapon(playerid))
			{
				case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
				{
					ptsLastFiredWeapon[playerid] = gettime();
				}
			}
		}
		else if(PRESSED(KEY_CROUCH))
		{
			if((gettime() - ptsLastFiredWeapon[playerid]) < 1)
			{
				TogglePlayerControllable(playerid, false);

				pCBugging[playerid] = true;

				GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);

				KillTimer(ptmCBugFreezeOver[playerid]);
				ptmCBugFreezeOver[playerid] = SetTimerEx("CBugFreezeOver", 1500, false, "i", playerid);
			}
		}
	}
    /*if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
        AntiBHOP[playerid] ++;
        if(pData[playerid][pRFoot] <= 70 || pData[playerid][pLFoot] <= 70)
        {
        	SetTimerEx("AppuiePasJump", 1700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 90 || pData[playerid][pLFoot] <= 90)
        {
        	SetTimerEx("AppuiePasJump", 700, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
        if(pData[playerid][pRFoot] <= 40 || pData[playerid][pLFoot] <= 40)
        {
        	SetTimerEx("AppuiePasJump", 3200, false, "i", playerid);
        	if(AntiBHOP[playerid] == 3)
        	{
        		ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        		new jpName[MAX_PLAYER_NAME];
        		GetPlayerName(playerid,jpName,MAX_PLAYER_NAME);
        		SetTimerEx("AppuieJump", 3000, false, "i", playerid);
        	}
        	return 1;
        }
    }*/
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && (newkeys & KEY_NO))
	{
	    if(pData[playerid][CarryingLumber])
		{
			Player_DropLumber(playerid);
		}
		else if(pData[playerid][CarryingBox])
		{
			Player_DropBox(playerid);
		}
		else if(pData[playerid][CarryingLog] == 0)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping metal ore.");
			DisablePlayerCheckpoint(playerid);
		}
		else if(pData[playerid][CarryingLog] == 1)
		{
			Player_DropLog(playerid, pData[playerid][CarryingLog]);
			Info(playerid, "You dropping coal ore.");
			DisablePlayerCheckpoint(playerid);
		}
	}
	if((newkeys & KEY_SECONDARY_ATTACK))
    {
		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
					return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

				if(dData[did][dLocked])
					return Error(playerid, "This entrance is locked at the moment.");
					
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				if(dData[did][dFamily] > 0)
				{
					if(dData[did][dFamily] != pData[playerid][pFamily])
						return Error(playerid, "This door only for family.");
				}
				
				if(dData[did][dVip] > pData[playerid][pVip])
					return Error(playerid, "Your VIP level not enough to enter this door.");
				
				if(dData[did][dAdmin] > pData[playerid][pAdmin])
					return Error(playerid, "Your admin level not enough to enter this door.");
					
				if(strlen(dData[did][dPass]))
				{
					new params[256];
					if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
					if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
					
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
				else
				{
					if(dData[did][dCustom])
					{
						SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					else
					{
						SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
					}
					pData[playerid][pInDoor] = did;
					SetPlayerInterior(playerid, dData[did][dIntint]);
					SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dFaction] > 0)
				{
					if(dData[did][dFaction] != pData[playerid][pFaction])
						return Error(playerid, "This door only for faction.");
				}
				
				if(dData[did][dCustom])
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				else
				{
					SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
				}
				pData[playerid][pInDoor] = -1;
				SetPlayerInterior(playerid, dData[did][dExtint]);
				SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "Interior bisnis masih kosong, atau tidak memiliki interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This bisnis is locked!");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			pData[playerid][pInBiz] = -1;
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "Interior house masih kosong, atau tidak memiliki interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			pData[playerid][pInHouse] = -1;
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);
			
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "Interior masih kosong, atau tidak memiliki interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				pData[playerid][pInFamily] = fid;	
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
		foreach(new vid : Vendings)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]) && strcmp(VendingData[vid][vendingOwner], "-"))
			{
				SetPlayerFacingAngle(playerid, VendingData[vid][vendingA]);
				ApplyAnimation(playerid, "VENDING", "VEND_USE", 10.0, 0, 0, 0, 0, 0, 1);
				SetTimerEx("VendingNgentot", 3000, false, "i", playerid);
			}
		}
	}
	//SAPD Taser/Tazer
	if(newkeys & KEY_FIRE && TaserData[playerid][TaserEnabled] && GetPlayerWeapon(playerid) == 0 && !IsPlayerInAnyVehicle(playerid) && TaserData[playerid][TaserCharged])
	{
  		TaserData[playerid][TaserCharged] = false;

	    new Float: x, Float: y, Float: z, Float: health;
     	GetPlayerPos(playerid, x, y, z);
	    PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
	    ApplyAnimation(playerid, "KNIFE", "KNIFE_3", 4.1, 0, 1, 1, 0, 0, 1);
		pData[playerid][pActivityTime] = 0;
	    TaserData[playerid][ChargeTimer] = SetTimerEx("ChargeUp", 1000, true, "i", playerid);
		PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Recharge...");
		PlayerTextDrawShow(playerid, ActiveTD[playerid]);
		ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);

	    for(new i, maxp = GetPlayerPoolSize(); i <= maxp; ++i)
		{
	        if(!IsPlayerConnected(i)) continue;
          	if(playerid == i) continue;
          	if(TaserData[i][TaserCountdown] != 0) continue;
          	if(IsPlayerInAnyVehicle(i)) continue;
			if(GetPlayerDistanceFromPoint(i, x, y, z) > 2.0) continue;
			ClearAnimations(i, 1);
			TogglePlayerControllable(i, false);
   			ApplyAnimation(i, "CRACK", "crckdeth2", 4.1, 0, 0, 0, 1, 0, 1);
			PlayerPlaySound(i, 6003, 0.0, 0.0, 0.0);

			GetPlayerHealth(i, health);
			TaserData[i][TaserCountdown] = TASER_BASETIME + floatround((100 - health) / 12);
   			Info(i, "You got tased for %d secounds!", TaserData[i][TaserCountdown]);
			TaserData[i][GetupTimer] = SetTimerEx("TaserGetUp", 1000, true, "i", i);
			break;
	    }
	}
	if (PRESSED(KEY_FIRE))
	{
		new weaponid;

		if((weaponid = GetPlayerWeaponEx(playerid)) != 0 && !pData[playerid][pAmmo][g_aWeaponSlots[weaponid]]) 
		{
			TogglePlayerControllable(playerid, 0);
			SetPlayerArmedWeapon(playerid, 0);
			TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer(playerid);

			Error(playerid, "Tidak ada amunisi di senjata ini.");
		}
		return 1;
	}
	//-----[ Bisnis ]-----
	/*if((newkeys & KEY_WALK))
	{
	    foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bLocked])
					return Error(playerid, "Bisnis Ini Sedang Tutup!");

				pData[playerid][pInBiz] = bid;
				Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
				}
			}
		}
	if((newkeys & KEY_NO))
	{
		foreach(new id : Bisnis)
		{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]))
		{
			if(bData[id][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Uang anda tidak cukup, anda tidak dapat membeli bisnis ini!.");
			if(strcmp(bData[id][bOwner], "-")) return Error(playerid, "Someone already owns this bisnis.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more bisnis.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[id][bPrice]);
			GetPlayerName(playerid, bData[id][bOwner], MAX_PLAYER_NAME);
			bData[id][bOwnerID] = pData[playerid][pID];
			bData[id][bVisit] = gettime();
			new str[522], query[500];
			format(str,sizeof(str),"[BIZ]: %s membeli bisnis id %d seharga %s!", GetRPName(playerid), id, FormatMoney(bData[id][bPrice]));
			InfoTD_MSG(playerid, 2500, "~r~Sucses");
			LogServer("Property", str);
			mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", bData[id][bOwner], bData[id][bOwnerID], bData[id][bVisit], id);
			mysql_tquery(g_SQL, query);
			Bisnis_Refresh(id);
			Bisnis_Save(id);
		}
	}
}*/
	//-----[ Vehicle ]-----	
	if((newkeys & KEY_NO ))
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			return callcmd::en(playerid, "");
		}
	}
	if((newkeys & KEY_YES ))
	{
		if(GetNearbyGarkot(playerid) >= 0)
		{
			ShowPlayerDialog(playerid, DIALOG_GARKOT, DIALOG_STYLE_MSGBOX, "Garasi Kota ", ">> {FFFF00}ParkVeh: {ffffff}Untuk Memarkir Kendaraanmu.\n>> {FFFF00}PickupVeh: {ffffff}Untuk Mengambil Kendaraanmu.","ParkVeh", "PickupVeh");
		}	
	}
    if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER && IsBulletWeapon(GetPVarInt(playerid, "switch_WeaponID")))
    {
        // Next Weapon
        if(newkeys & KEY_YES)
        {
            new curWeap = GetPVarInt(playerid, "switch_WeaponID"), weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;
            
            for(new i = weapSlot + 1; i <= 7; i++)
            {
                GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
                if(IsBulletWeapon(weapID) && weapID != curWeap)
                {
                    SetPlayerArmedWeaponEx(playerid, weapID);
                    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~Next Weapon ~>~", 1000, 3);
                    break;
                }
            }
        }
 
        // Previous Weapon
        if(newkeys & KEY_NO)
        {
            new curWeap = GetPVarInt(playerid, "switch_WeaponID"), weapSlot = GetWeaponSlot(curWeap), weapID, weapAmmo;
            
            for(new i = weapSlot - 1; i >= 2; i--)
            {
                GetPlayerWeaponData(playerid, i, weapID, weapAmmo);
                if(IsBulletWeapon(weapID) && weapID != curWeap)
                {
                    SetPlayerArmedWeaponEx(playerid, weapID);
                    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~y~~h~~<~ Previous Weapon", 1000, 3);
                    break;
                }
            }
        }
    }
	//KEY PROJEK BY BAGAS
	if((newkeys & KEY_NO ))
	{
	    for(new i = 0; i < 22; i++) 
	    {
	        PlayerTextDrawShow(playerid, PANELV3[playerid][i]);
	    }
	    PlayerTextDrawShow(playerid, KLIKEXIT[playerid]);
	    PlayerTextDrawShow(playerid, KLIKSTATS[playerid]);
	    PlayerTextDrawShow(playerid, KLIKTOYS[playerid]);
	    PlayerTextDrawShow(playerid, KLIKINV[playerid]);
	    PlayerTextDrawShow(playerid, KLIKVEH[playerid]);
	    PlayerTextDrawShow(playerid, KLIKHP[playerid]);
	    PlayerTextDrawShow(playerid, KLIKMTK[playerid]);
	    SelectTextDraw(playerid, COLOR_RED);	    
	}
	if(newkeys & KEY_WALK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1, 2796.739257, -1087.630126, 30.719810))
        {
        	ShowPlayerDialog(playerid, DIALOG_PENAMBANG1, DIALOG_STYLE_LIST, "Shine Green - Ikea", "Emas:{1DFE07}10$/Satuanya\nAluminium:{1DFE07}5$/Satuanya\nTembaga:{1DFE07}7$/Satuannya", "Select", "Cancel");
        }
	}
	if(newkeys & KEY_CROUCH)
    {
            if(GetNearbyGarkot(playerid) >= 0)
            {
            if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "Kamu harus login!");
            if(pData[playerid][pInjured] >= 1) return Error(playerid, "Kamu tidak bisa melakukan ini!");
            if(!IsPlayerInAnyVehicle(playerid)) return PermissionError(playerid);
            }
            new id = -1;
            id = GetClosestParks(playerid);

            if(id > -1)
            {
                if(CountParkedVeh(id) >= 40)
                    return Error(playerid, "Garasi Kota sudah memenuhi Kapasitas!");

                new carid = -1,
                    found = 0;

                if((carid = Vehicle_Nearest2(playerid)) != -1)
                {

                    GetVehiclePos(pvData[carid][cVeh], pvData[carid][cPosX], pvData[carid][cPosY], pvData[carid][cPosZ]);
                    GetVehicleZAngle(pvData[carid][cVeh], pvData[carid][cPosA]);
                    GetVehicleHealth(pvData[carid][cVeh], pvData[carid][cHealth]);
                    PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
                    InfoTD_MSG(playerid, 4000, "Vehicle ~r~Despawned");
                    RemovePlayerFromVehicle(playerid);
                    pvData[carid][cPark] = id;
                    SetPlayerArmedWeapon(playerid, 0);
                    found++;
                    if(IsValidVehicle(pvData[carid][cVeh]))
                    {
                        DestroyVehicle(pvData[carid][cVeh]);
                        pvData[carid][cVeh] = INVALID_VEHICLE_ID;
                    }
                }
                if(!found)
                    return Error(playerid, "Kendaraan ini tidak dapat di Park!");
            }
    }
	if(newkeys & KEY_LOOK_BEHIND)
	{
		callcmd::lock(playerid, "lockveh");
	}
	/*
	if(newkeys & KEY_WALK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1, -492.876525,-1772.059570,19.629934))
        {
        	callcmd::wehdcweydshdddf(playerid, "");
        }
	}
	if(newkeys & KEY_WALK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 9, -412.251220,-1791.600830,6.530358))
        {
        	callcmd::uwdhewvdtwedbb(playerid, "");
        }
        else if(IsPlayerInRangeOfPoint(playerid, 9, -409.752868,-1791.146606,6.512632))
        {
        	callcmd::uwdhewvdtwedbb(playerid, "");
        }
	}
 	if(newkeys & KEY_WALK)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5, -378.903869,-1830.367553,2.506488))
		{
		    callcmd::fviewefgredbde(playerid, "");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, -388.388641,-1831.794555,2.438773))
        {
        	callcmd::fviewefgredbde(playerid, "");
        }
	}*/
	//-----[ Toll System ]-----	
	if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			new forcount = MuchNumber(sizeof(BarrierInfo));
			for(new i;i < forcount;i ++)
			{
				if(i < sizeof(BarrierInfo))
				{
					if(IsPlayerInRangeOfPoint(playerid,8,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]))
					{
						if(BarrierInfo[i][brOrg] == TEAM_NONE)
						{
							if(!BarrierInfo[i][brOpen])
							{
								if(pData[playerid][pMoney] < 50)
								{
									Toll(playerid, "Uangmu tidak cukup untuk membayar toll");
								}
								else
								{
									MoveDynamicObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
									SetTimerEx("BarrierClose",5000,0,"i",i);
									BarrierInfo[i][brOpen] = true;
									Toll(playerid, "Cepat!!! Toll akan menutup Kembali setelah 5 detik");
									GivePlayerMoneyEx(playerid, -50);
									if(BarrierInfo[i][brForBarrierID] != -1)
									{
										new barrierid = BarrierInfo[i][brForBarrierID];
										MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[barrierid][brPos_A]+180);
										BarrierInfo[barrierid][brOpen] = true;

									}
								}
							}
						}
						else Toll(playerid, "Kamu tidak bisa membuka pintu Toll ini!");
						break;
					}
				}
			}
		}
		return true;		
	}
	if(GetPVarInt(playerid, "UsingSprunk"))
	{
		if(pData[playerid][pEnergy] >= 100 )
		{
  			Info(playerid, " Kamu terlalu banyak minum.");
	   	}
	   	else
	   	{
		    pData[playerid][pEnergy] += 5;
		}
	}
	// STREAMER MASK SYSTEM
	if(PRESSED( KEY_WALK ))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			if(pData[playerid][pAdmin] < 2)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(GetEngineStatus(vehicleid))
				{
					if(GetVehicleSpeed(vehicleid) <= 40)
					{
						new playerState = GetPlayerState(playerid);
						if(playerState == PLAYER_STATE_DRIVER)
						{
							SendStaffMessage(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s have been auto kicked for vehicle engine hack! /spec untuk cek", pData[playerid][pName]);
						}
					}
				}
			}	
		}
	}
	if(PRESSED( KEY_YES ))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
		{
			foreach(new did : Doors)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
							return Error(playerid, "Interior entrance masih kosong, atau tidak memiliki interior.");

						if(dData[did][dLocked])
							return Error(playerid, "This entrance is locked at the moment.");
							
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
						if(dData[did][dFamily] > 0)
						{
							if(dData[did][dFamily] != pData[playerid][pFamily])
								return Error(playerid, "This door only for family.");
						}
						
						if(dData[did][dVip] > pData[playerid][pVip])
							return Error(playerid, "Your VIP level not enough to enter this door.");
						
						if(dData[did][dAdmin] > pData[playerid][pAdmin])
							return Error(playerid, "Your admin level not enough to enter this door.");
							
						if(strlen(dData[did][dPass]))
						{
							new params[256];
							if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
							if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
							
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
						else
						{
							if(dData[did][dCustom])
							{
								SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							else
							{
								SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
							}
							pData[playerid][pInDoor] = did;
							SetPlayerInterior(playerid, dData[did][dIntint]);
							SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
							SetCameraBehindPlayer(playerid);
							SetPlayerWeather(playerid, 0);
						}
					}
				}
				if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
				{
					if(dData[did][dGarage] == 1)
					{
						if(dData[did][dFaction] > 0)
						{
							if(dData[did][dFaction] != pData[playerid][pFaction])
								return Error(playerid, "This door only for faction.");
						}
					
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
						}
						pData[playerid][pInDoor] = -1;
						SetPlayerInterior(playerid, dData[did][dExtint]);
						SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, WorldWeather);
					}
				}
			}
		}
	}
	//if(IsKeyJustDown(KEY_CTRL_BACK,newkeys,oldkeys))
	if(IsKeyJustDown(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
	{
		if(GetPVarInt(playerid, "UsingSprunk"))
		{
			DeletePVar(playerid, "UsingSprunk");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}
	if(takingselfie[playerid] == 1)
	{
		if(PRESSED(KEY_ANALOG_RIGHT))
		{
			GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] += Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
		if(PRESSED(KEY_ANALOG_LEFT))
		{
		    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
			static Float: n1X, Float: n1Y;
		    if(Degree[playerid] >= 360) Degree[playerid] = 0;
		    Degree[playerid] -= Speed;
		    n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		    n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		    SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		    SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		    SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		}
	}
	/*if(StatusCrateTerangkat == true)
    {
        if(PRESSED (KEY_JUMP))
        {
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
        }
    }*/
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//JOB KURIR
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		/*if(IsAKurirVeh(GetPlayerVehicleID(playerid)))
		{
			GameTextForPlayer(playerid, "~w~PENGANTARAN BARANG TERSEDIA /STARTKURIR", 5000, 3);
			SendClientMessage(playerid, 0x76EEC6FF, "* Tampaknya ada paket yang tidak terkirim di Burrito Anda.");
		}*/
		if(IsABaggageVeh(GetPlayerVehicleID(playerid)))
		{
			InfoTD_MSG(playerid, 8000, "/~g~startbg");
		}
	}
	if(newstate == PLAYER_STATE_WASTED && pData[playerid][pJail] < 1)
    {	
		if(pData[playerid][pInjured] == 0)
        {
            pData[playerid][pInjured] = 1;
            SetPlayerHealthEx(playerid, 99999);

            pData[playerid][pInt] = GetPlayerInterior(playerid);
            pData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

            GetPlayerPos(playerid, pData[playerid][pPosX], pData[playerid][pPosY], pData[playerid][pPosZ]);
            GetPlayerFacingAngle(playerid, pData[playerid][pPosA]);
        }
        else
        {
            pData[playerid][pHospital] = 1;
        }
	}
	if(newstate == PLAYER_STATE_PASSENGER)
    {
        new weapID = GetPlayerWeapon(playerid);
        SetPVarInt(playerid, "switch_WeaponID", weapID);
        if(IsBulletWeapon(weapID)) SendClientMessage(playerid, 0x3F9DDDFF, "WEAPON SWITCHING: {FFFFFF}Anda dapat mengunakan tombol Y atau N");
    }
	//Spec Player
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(pData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(pData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					Servers(ii, ,"%s(%i) is now on foot.", pData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
    	pData[playerid][pMarkTemp] = vehicleid;
		if(pData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
        }
		foreach (new ii : Player) if(pData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
	}
	if(oldstate == PLAYER_STATE_PASSENGER)
	{
		//TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
		TextDrawHideForPlayer(playerid, DPvehfare[playerid]);
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CARRY || GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
            return RemovePlayerFromVehicle(playerid);/*RemoveFromVehicle(playerid);*/
		
		//HBE textdraw Simple
		/*
		PlayerTextDrawHide(playerid, SPvehname[playerid]);
        PlayerTextDrawHide(playerid, SPvehengine[playerid]);
        PlayerTextDrawHide(playerid, SPvehspeed[playerid]);
		PlayerTextDrawHide(playerid, VModelTD[playerid]);
		for(new ii; ii < 7; ii++)
		{
			TextDrawHideForPlayer(playerid, VehicleTD[ii]);
		}*/
		for(new i = 0; i < 7; i++)
		{
		    PlayerTextDrawHide(playerid, VEHFIVEM[playerid][i]);
		}

		
		if(pData[playerid][pTaxiDuty] == 1)
		{
			pData[playerid][pTaxiDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "You are no longer on taxi duty!");
		}
		if(pData[playerid][pFare] == 1)
		{
			KillTimer(pData[playerid][pFareTimer]);
			Info(playerid, "Anda telah menonaktifkan taxi fare pada total: {00FF00}%s", FormatMoney(pData[playerid][pTotalFare]));
			pData[playerid][pFare] = 0;
			pData[playerid][pTotalFare] = 0;
		}
		if(pData[playerid][pIsStealing] == 1)
		{
			pData[playerid][pIsStealing] = 0;
			pData[playerid][pLastChopTime] = 0;
			Info(playerid, "Kamu gagal mencuri kendaraan ini, di karenakan kamu keluar kendaraan saat proses pencurian!");
			KillTimer(MalingKendaraan);

		}
        
		HidePlayerProgressBar(playerid, pData[playerid][spfuelbar]);
        HidePlayerProgressBar(playerid, pData[playerid][spdamagebar]);
	}
	else if(newstate == PLAYER_STATE_DRIVER)
    {
		/*if(IsSRV(vehicleid))
		{
			new tstr[128], price = GetVehicleCost(GetVehicleModel(vehicleid));
			format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "LG_E"%s", GetVehicleName(vehicleid), FormatMoney(price));
			ShowPlayerDialog(playerid, DIALOG_BUYPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
		}
		else if(IsVSRV(vehicleid))
		{
			new tstr[128], price = GetVipVehicleCost(GetVehicleModel(vehicleid));
			if(pData[playerid][pVip] == 0)
			{
				Error(playerid, "Kendaraan Khusus VIP Player.");
				RemovePlayerFromVehicle(playerid);
				//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
			}
			else
			{
				format(tstr, sizeof(tstr), ""WHITE_E"Anda akan membeli kendaraan "PINK_E"%s "WHITE_E"dengan harga "YELLOW_E"%d Coin", GetVehicleName(vehicleid), price);
				ShowPlayerDialog(playerid, DIALOG_BUYVIPPV, DIALOG_STYLE_MSGBOX, "Private Vehicles", tstr, "Buy", "Batal");
			}
		}*/
		
		foreach(new pv : PVehicles)
		{
			if(vehicleid == pvData[pv][cVeh])
			{
				if(IsABike(vehicleid) || GetVehicleModel(vehicleid) == 424)
				{
					if(pvData[pv][cLocked] == 1)
					{
						RemovePlayerFromVehicle(playerid);
						//new Float:slx, Float:sly, Float:slz;
						//GetPlayerPos(playerid, slx, sly, slz);
						//SetPlayerPos(playerid, slx, sly, slz);
						Error(playerid, "This bike is locked by owner.");
						return 1;
					}
				}
			}
		}
		
		if(IsASweeperVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_SWEEPER, DIALOG_STYLE_MSGBOX, "Side Job - Sweeper", "Anda akan bekerja sebagai pembersih jalan?", "Start Job", "Close");
		}
		if(IsABusVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_BUS, DIALOG_STYLE_MSGBOX, "Side Job - Bus", "Anda akan bekerja sebagai pengangkut penumpang bus?", "Start Job", "Close");
		}
		if(IsAForVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_FORKLIFT, DIALOG_STYLE_MSGBOX, "Side Job - Forklift", "Anda akan bekerja sebagai pemuat barang dengan Forklift?", "Start Job", "Close");
		}
		if(IsAMowerVeh(vehicleid))
		{
			ShowPlayerDialog(playerid, DIALOG_MOWER, DIALOG_STYLE_MSGBOX, "Side Job - Mower", "Anda akan bekerja sebagai Mower?", "Start Job", "Close");
		}
		if(IsABaggageVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 10 && pData[playerid][pJob2] != 10)
			{
				RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak bekerja sebagai Baggage Airport");
			}
		}
		if(IsADmvVeh(vehicleid))
        {
            if(!pData[playerid][pDriveLicApp])
            {
                RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak sedang mengikuti Tes Mengemudi");
			}
			else 
			{
				Info(playerid, "Silahkan ikuti Checkpoint yang ada di GPS mobil ini.");
				SetPlayerRaceCheckpoint(playerid, 1, dmvpoint1, dmvpoint1, 5.0);
			}
		}
		/*if(IsAKurirVeh(vehicleid))
		{
			if(pData[playerid][pJob] != 8 && pData[playerid][pJob2] != 8)
			{
				RemovePlayerFromVehicle(playerid);
                Error(playerid, "Kamu tidak bekerja sebagai Courier");
			}
		}*/
		if(IsSAPDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 1)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAPD!");
			}
		}
		if(IsGovCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 2)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAGS!");
			}
		}
		if(IsSAMDCar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 3)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SAMD!");
			}
		}
		if(IsSANACar(vehicleid))
		{
		    if(pData[playerid][pFaction] != 4)
			{
			    RemovePlayerFromVehicle(playerid);
			    Error(playerid, "Anda bukan SANEWS!");
			}
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		if(IsEngineVehicle(vehicleid) && pData[playerid][pDriveLic] <= 0)
        {
            Info(playerid, "Anda tidak memiliki surat izin mengemudi, berhati-hatilah.");
        }
		if(pData[playerid][pHBEMode] == 1)
		{
			for(new i = 0; i < 7; i++)
			{
			    PlayerTextDrawShow(playerid, VEHFIVEM[playerid][i]);
			}
			/*RefreshVModel(playerid);
			for(new ii; ii < 7; ii++)
			{
				TextDrawShowForPlayer(playerid, VehicleTD[ii]);
			}
			PlayerTextDrawShow(playerid, SPvehname[playerid]);
			PlayerTextDrawShow(playerid, SPvehengine[playerid]);
			PlayerTextDrawShow(playerid, SPvehspeed[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][spfuelbar]);
			ShowPlayerProgressBar(playerid, pData[playerid][spdamagebar]);*/
		}
		else
		{
		
		}
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(pData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(pData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
				    Servers(ii, "%s(%i) is now driving a %s(%d).", pData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid){ case 0..18, 39..54: return 1;} //invalid weapons
	if(--pData[playerid][pAmmo][g_aWeaponSlots[weaponid]]<= 0) {
		SetPlayerArmedWeapon(playerid, 0);
		pData[playerid][pAmmo][g_aWeaponSlots[weaponid]] = 0;
		Info(playerid, "Kamu kehabisan amunisi.");
	}
	switch(weaponid)
	{ 
		//invalid weapons
		case 0..18, 39..54: return 1;
	}
	if(1 <= weaponid <= 46)
	{
		if(hittype == 1 && GetDamageID[hitid] == INVALID_PLAYER_ID)
		{
			GetDamageID[hitid] = playerid;
		}
	}
	return 1;
}
stock GetVehicleSpeedKMH(vehicleid)
{
	new Float:speed_x, Float:speed_y, Float:speed_z, Float:temp_speed, round_speed;
	GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);

	temp_speed = temp_speed = floatsqroot(((speed_x*speed_x) + (speed_y*speed_y)) + (speed_z*speed_z)) * 136.666667;

	round_speed = floatround(temp_speed);
	return round_speed;
}
stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health-Health);
}
/*
stock GivePlayerArmour(playerid,Float:Armour)
{
	new Float:armour; GetPlayerArmour(playerid,armour);
	SetPlayerArmour(playerid,armour+Armour);
}*/
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
    new Float:health,
		Float:armour;

	GetPlayerHealth(damagedid, health);
	GetPlayerArmour(damagedid, armour);
	if(damagedid != INVALID_PLAYER_ID)
	{
		new Float:damage;
		switch(weaponid)
		{
		    case 0: damage = 2.0;
			case 1: damage = 5.0;
			case 2: damage = 5.0;
			case 3: damage = 5.0;
			case 4: damage = 7.0;
			case 5: damage = 5.0;
			case 6: damage = 5.0;
			case 7: damage = 5.0;
			case 8: damage = 8.0;
			case 9: damage = 1.0;
			case 14: damage = 2.0;
			case 15: damage = 5.0;
			case 16: damage = 50.0;
			case 18: damage = 20.0;
			case 22: damage = float(RandomEx(15, 20));
			case 23, 28, 29, 32: damage = float(RandomEx(17, 23));
			case 24: damage = float(RandomEx(38, 43));
			case 25, 26, 27:
			{
			    new Float: p_x, Float: p_y, Float: p_z;
			    GetPlayerPos(playerid, p_x, p_y, p_z);
			    new Float: dist = GetPlayerDistanceFromPoint(damagedid, p_x, p_y, p_z);

			    if (dist < 5.0)
					damage = float(RandomEx(50, 55));

				else if (dist < 10.0)
					damage = float(RandomEx(23, 35));

				else if (dist < 15.0)
					damage = float(RandomEx(15, 25));

				else if (dist < 20.0)
					damage = float(RandomEx(10, 15));

				else if (dist < 30.0)
					damage = float(RandomEx(5, 8));
			}
			case 30: damage = float(RandomEx(20, 25));
			case 31: damage = float(RandomEx(20, 22));
			case 33, 34: damage = float(RandomEx(70, 75));
			case 35: damage = 0.0;
			case 36: damage = 0.0;
			case 38: damage = 0.0;
		}

        if(bodypart == BODY_PART_TORSO && armour > 0.0 && (22 <= weaponid <= 38))
		{
		    if(armour - damage <= 7.0)
				SetPlayerArmour(damagedid, 0.0);
	 		else
			 	SetPlayerArmour(damagedid, armour - damage);
		}
		else
		{
		    if(health - damage <= 0.0)
				SetPlayerHealth(damagedid, 0.0);
			else
			{
				if(health <= 30.0)
				{
					SetPlayerHealth(damagedid, health - damage / 2); 
				}
				else
				{
					SetPlayerHealth(damagedid, health - damage);
				}
			}

			if(armour)
			    SetPlayerArmour(damagedid, armour);
		}
	}
	static cf[300];
	format(cf, 300, "~r~-%.2f ~w~Damage from ~r~%s", amount, GetName(playerid));
	Chat_Message(damagedid, cf);
	format(cf, 300, "~g~+%.2f Damage to ~g~%s", amount, GetName(damagedid));
	Chat_Message(playerid, cf);
	SetTimerEx("Chat_Clear", 7000, false, "i", playerid);
	SetTimerEx("Chat_Clear", 7000, false, "i", damagedid);
	return 1;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    if(pData[playerid][pSeatBelt] == 0 || pData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    	return 1;
    }
    if(pData[playerid][pSeatBelt] == 1 || pData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= dsakit;
    		pData[playerid][pLHand] -= bsakit;
    		pData[playerid][pRFoot] -= csakit;
    		pData[playerid][pRHand] -= dsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		pData[playerid][pLFoot] -= csakit;
    		pData[playerid][pLHand] -= csakit;
    		pData[playerid][pRFoot] -= dsakit;
    		pData[playerid][pRHand] -= bsakit;
    		pData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -0);
    		return 1;
    	}
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	
	if(IsAtEvent[playerid] == 0)
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			pData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			pData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			pData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			pData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			pData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			pData[playerid][pLFoot] -= bsakit;
		}

		// Custom Damage Health
		/*
		switch(weaponid)
		{
			case 26: GivePlayerHealth(playerid, -40.0); // SOS
			default: GivePlayerHealth(playerid, amount); // Default Weapon Damage
		}
		
		switch(weaponid)
		{
			case 38: GivePlayerHealth(playerid, -00.0); // MINIGUN
			default: GivePlayerHealth(playerid, amount); // DEFAULT DAMAGE WEAPON
		}
		switch(weaponid)
		{
			case 24: GivePlayerHealth(playerid, -30.0); // DESERT
			default: GivePlayerHealth(playerid, amount); // Default Weapon Damage
		}
		switch(weaponid)
		{
			case 30: GivePlayerHealth(playerid, -35.0); // AK
			default: GivePlayerHealth(playerid, amount); // Default Weapon Damage
		}
		switch(weaponid)
		{
			case 8: GivePlayerHealth(playerid, -25.0); // KATANA
			default: GivePlayerHealth(playerid, amount); // Default Weapon Damage
		}
		switch(weaponid)
		{
			case 9: GivePlayerHealth(playerid, -5.0); // Chainsaw
			default: GivePlayerHealth(playerid, amount); // Default Weapon Damage
		}

		// CUSTOM DAMAGE ARMOUR
		switch(weaponid)
		{
			case 26: GivePlayerArmour(playerid, -20.0); // SOS
			default: GivePlayerArmour(playerid, amount); // DEFAULT WEAPON DAMAGE
		}
		switch(weaponid)
		{
			case 38: GivePlayerArmour(playerid, -00.0); // MINIGUN
			default: GivePlayerArmour(playerid, amount); // DEFAULT DAMAGE WEAPON
		}
		switch(weaponid)
		{
			case 24: GivePlayerArmour(playerid, -25.0); // Desert
			default: GivePlayerArmour(playerid, amount); // DEFAULT DAMAGE WEAPON
		}
		switch(weaponid)
		{
			case 30: GivePlayerArmour(playerid, -28.0); // AK
			default: GivePlayerArmour(playerid, amount); // DEFAULT DAMAGE WEAPON
		}
		switch(weaponid)
		{
			case 8: GivePlayerArmour(playerid, -15.0); // KATANA
			default: GivePlayerArmour(playerid, amount); // DEFAULT DAMAGE WEAPON
		}
		switch(weaponid)
		{
			case 9: GivePlayerArmour(playerid, -1.0); // CHAINSHAW
			default: GivePlayerArmour(playerid, amount); // DEFAULT DAMAGE WEAPON
		}*/
	}
	else if(IsAtEvent[playerid] == 1)
	{
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			GivePlayerHealth(playerid, -90);
			SendClientMessage(issuerid, -1,"{7fffd4}[ TDM ]{ffffff} Headshot!");
		}
	}
	CreateDamageLog(playerid, Float:amount, weaponid, bodypart);
    return 1;
}
public OnPlayerUpdate(playerid)
{
	//afk_tick[playerid]++;
	if(!fly[playerid])return 1;

    new
		k, ud, lr,
        Float:hMult = 0.01,
		Float:angle,
		Float:forwd;

	GetPlayerKeys(playerid, k, ud, lr);
	GetPlayerFacingAngle(playerid, angle);

	if(ud == KEY_UP)        forwd	= VELOCITY_NORM;
	else if(ud == KEY_DOWN) forwd	=-VELOCITY_NORM;
	
	if(k & KEY_JUMP)forwd *= VELOCITY_MULT;
	if(k & KEY_SPRINT)hMult = HEIGHT_GAIN * 10;
	if(k & KEY_SPRINT && k & KEY_JUMP) hMult = HEIGHT_GAIN * 10;
	if(k & KEY_CROUCH)hMult =-HEIGHT_GAIN;


	if(k & KEY_FIRE)
	{
		if(lr == KEY_LEFT)		forwd = VELOCITY_NORM, angle	+= 90.0;
		else if(lr == KEY_RIGHT)forwd = VELOCITY_NORM, angle	-= 90.0;
	}
	else
	{
		if(lr == KEY_LEFT)		angle	+= 90.0;
		else if(lr == KEY_RIGHT)angle	-= 90.0;
		SetPlayerFacingAngle(playerid, angle);
	}
	SetPlayerHealth(playerid, 1000.0);
	SetPlayerVelocity(playerid, forwd*floatsin(-angle, degrees), forwd*floatcos(-angle, degrees), hMult);
	SetPlayerHealth(playerid, 1000.0);
	//map
	UpdateTazer(playerid);
	
	//SAPD Road Spike
	CheckPlayerInSpike(playerid);
    
	//Report ask
	//GetPlayerName(playerid, g_player_name[playerid], MAX_PLAYER_NAME);
    new SGRPMAP[520];
	new Float:X;
	new Float:Y;
	new Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	format(SGRPMAP, sizeof SGRPMAP, "%s", SGRPLOK(X, Y, Z));
	PlayerTextDrawSetString(playerid, BarMap[playerid], SGRPMAP);

	if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
	//AntiCheat
	pData[playerid][pLastUpdate] = gettime();

	//SpeedCam
	static id;
	new vehicled = Vehicle_Nearest2(playerid), query[326];
	if ((id = SpeedCam_Nearest(playerid)) != -1 && GetPlayerSpeedCam(playerid) > CamData[id][CamLimit] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && pvData[vehicled][cOwner] == pData[playerid][pID] && GetEngineStatus(vehicled) && !pData[playerid][pSpeedTime])
	{
	    if (!IsACruiser(vehicled) && !IsABoat(vehicled) && !IsAPlane(vehicled) && !IsAHelicopter(vehicled))
	    {
	 		new price = 20 + floatround(GetPlayerSpeedCam(playerid) - CamData[id][CamLimit]);
			new str[500];
	   		format(str, sizeof(str), "Kecepatan (%.0f/%.0f mph)", GetPlayerSpeedCam(playerid), CamData[id][CamLimit]);
	        SetTimerEx("HidePlayerBox", 500, false, "dd", playerid, _:ShowPlayerBox(playerid, 0xFFFFFF66));
    		format(str, sizeof(str), "{ff0000}[SpeedCam]: {ffffff}Kamu telah melebihi kecepatan dan mendapatkan denda sebesar {3BBD44}%s", FormatMoney(price));
     		SendClientMessage(playerid, -1, str);
			pvData[vehicled][cTicket] += price;

			mysql_format(g_SQL, query, sizeof(query), "UPDATE vehicle SET ticket = '%d' WHERE id = '%d'", pvData[vehicled][cTicket], pvData[vehicled][cID]);
			mysql_tquery(g_SQL, query);
			pData[playerid][pSpeedTime] = 5;
		}
	}
	return 1;
}

task VehicleUpdate[40000]()
{
	for (new i = 1; i != MAX_VEHICLES; i ++) if(IsEngineVehicle(i) && GetEngineStatus(i))
    {
        if(GetVehicleFuel(i) > 0)
        {
			new fuel = GetVehicleFuel(i);
            SetVehicleFuel(i, fuel - 15);

            if(GetVehicleFuel(i) >= 1 && GetVehicleFuel(i) <= 200)
            {
               Info(GetVehicleDriver(i), "Kendaraan ingin habis bensin, Harap pergi ke SPBU ( Gas Station )");
            }
        }
        if(GetVehicleFuel(i) <= 0)
        {
            SetVehicleFuel(i, 0);
            SwitchVehicleEngine(i, false);
        }
    }
	foreach(new ii : PVehicles)
	{
		if(IsValidVehicle(pvData[ii][cVeh]))
		{
			if(pvData[ii][cPlateTime] != 0 && pvData[ii][cPlateTime] <= gettime())
			{
				format(pvData[ii][cPlate], 32, "NoHave");
				SetVehicleNumberPlate(pvData[ii][cVeh], pvData[ii][cPlate]);
				pvData[ii][cPlateTime] = 0;
			}
			if(pvData[ii][cRent] != 0 && pvData[ii][cRent] <= gettime())
			{
				pvData[ii][cRent] = 0;
				new query[128], xuery[128];
				mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, query);

				mysql_format(g_SQL, xuery, sizeof(xuery), "DELETE FROM vstorage WHERE owner = '%d'", pvData[ii][cID]);
				mysql_tquery(g_SQL, xuery);
				if(IsValidVehicle(pvData[ii][cVeh])) DestroyVehicle(pvData[ii][cVeh]);
				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
				Iter_SafeRemove(PVehicles, ii, ii);
			}
		}
		if(pvData[ii][cClaimTime] != 0 && pvData[ii][cClaimTime] <= gettime())
		{
			pvData[ii][cClaimTime] = 0;
		}
	}
}

public OnVehicleSpawn(vehicleid)
{
	//LoadedTrash[vehicleid] = 0;
	foreach(new ii : PVehicles)
	{
		if(vehicleid == pvData[ii][cVeh] && pvData[ii][cRent] == 0 && pvData[ii][cStolen] > gettime())
		{
			if(pvData[ii][cInsu] > 0)
    		{
				pvData[ii][cStolen] = 0;
				pvData[ii][cInsu]--;
				pvData[ii][cClaim] = 1;
				pvData[ii][cClaimTime] = gettime() + (1 * 600);
				foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
        		{
            		Info(pid, "Kendaraan anda hancur dan anda masih memiliki insuransi, silahkan ambil di kantor insurance setelah 10 minute.");
				}
				if(IsValidVehicle(pvData[ii][cVeh]))
					DestroyVehicle(pvData[ii][cVeh]);

				pvData[ii][cVeh] = INVALID_VEHICLE_ID;
			}
			else
			{
				foreach(new pid : Player) if (pvData[ii][cOwner] == pData[pid][pID])
        		{
					new query[128];
					mysql_format(g_SQL, query, sizeof(query), "DELETE FROM vehicle WHERE id = '%d'", pvData[pid][cID]);
					mysql_tquery(g_SQL, query);
					if(IsValidVehicle(pvData[ii][cVeh]))
						DestroyVehicle(pvData[ii][cVeh]);

					pvData[ii][cVeh] = INVALID_VEHICLE_ID;
            		Info(pid, "Kendaraan anda hancur dan tidak memiliki insuransi.");
					Iter_SafeRemove(PVehicles, ii, ii);
				}
				pvData[ii][cStolen] = 0;
			}
			return 1;
		}
	}
	//System Vehicle Admin
	if(AdminVehicle{vehicleid})
	{
	    DestroyVehicle(vehicleid);
	    AdminVehicle{vehicleid} = false;
	}
	for(new wiu; wiu<5; wiu++) if(sirenPD[wiu][vehicleid] != 0)
	{
		DestroyDynamicObject(sirenPD[wiu][vehicleid]);
	    sirenPD[wiu][vehicleid] = 0;
	}
	if(InfoVeh[vehicleid][vSlight] != false)
    {
        InfoVeh[vehicleid][vElm] = 0;
        ToggleVehicleLightEx(vehicleid, 0);
        InfoVeh[vehicleid][vLights] = 0;
	  	InfoVeh[vehicleid][vSlight] = false;
    }
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	foreach(new i : PVehicles)
	{
		if(pvData[i][cVeh] == vehicleid)
		{
			pvData[i][cStolen] = gettime() + 15;
		}
	}
	for(new wiu; wiu<5; wiu++) if(sirenPD[wiu][vehicleid] != 0)
	{
		DestroyDynamicObject(sirenPD[wiu][vehicleid]);
	    sirenPD[wiu][vehicleid] = 0;
	}
	if(InfoVeh[vehicleid][vSlight] != false)
    {
        InfoVeh[vehicleid][vElm] = 0;
        ToggleVehicleLightEx(vehicleid, 0);
        InfoVeh[vehicleid][vLights] = 0;
	  	InfoVeh[vehicleid][vSlight] = false;
    }
	return 1;
}
ptask PlayerVehicleUpdate[200](playerid)
{
	// AFK
	/*new StringF[50];
	if(afk_tick[playerid] > 10000) afk_tick[playerid] = 1, afk_check[playerid] = 0;
	if(afk_check[playerid] < afk_tick[playerid] && GetPlayerState(playerid)) afk_check[playerid] = afk_tick[playerid], afk_time[playerid] = 0;
	if(afk_check[playerid] == afk_tick[playerid] && GetPlayerState(playerid))
	{
		afk_time[playerid]++;
		if(afk_time[playerid] > 2)
		{
			format(StringF,sizeof(StringF), "Melamun....");
			SetPlayerChatBubble(playerid, StringF, COLOR_ORANGE, 15.0, 1200);
		}
	}*/
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsValidVehicle(vehicleid))
	{
		if(!GetEngineStatus(vehicleid) && IsEngineVehicle(vehicleid))
		{	
			SwitchVehicleEngine(vehicleid, false);
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new Float:fHealth;
			GetVehicleHealth(vehicleid, fHealth);
			if(IsValidVehicle(vehicleid) && fHealth <= 350.0)
			{
				SetValidVehicleHealth(vehicleid, 300.0);
				SwitchVehicleEngine(vehicleid, false);
				InfoTD_MSG(playerid, 2500, "~r~Totalled");
			}
		}
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(pData[playerid][pHBEMode] == 1)
			{
				new Float:fDamage, fFuel, color1, color2;
				new tstr[64];
				
				GetVehicleColor(vehicleid, color1, color2);

				GetVehicleHealth(vehicleid, fDamage);
				
				//fDamage = floatdiv(1000 - fDamage, 10) * 1.42999;

				if(fDamage <= 350.0) fDamage = 0.0;
				else if(fDamage > 1000.0) fDamage = 1000.0;
				
				fFuel = GetVehicleFuel(vehicleid);
				
				if(fFuel < 0) fFuel = 0;
				else if(fFuel > 1000) fFuel = 1000;
				
				if(!GetEngineStatus(vehicleid))
				{
					PlayerTextDrawSetString(playerid, VEHFIVEM[playerid][0], "STATUS : OFF");
				}
				else
				{
					PlayerTextDrawSetString(playerid, VEHFIVEM[playerid][0], "STATUS : ON");
				}

				format(tstr, sizeof(tstr), "%i", GetVehicleFuel(vehicleid));
				PlayerTextDrawSetString(playerid, VEHFIVEM[playerid][4], tstr);

				format(tstr, sizeof(tstr), "%i", GetVehicleSpeedKMH(vehicleid));
				PlayerTextDrawSetString(playerid, VEHFIVEM[playerid][2], tstr);
				/*if(!GetEngineStatus(vehicleid))
				{
					PlayerTextDrawSetString(playerid, SPvehengine[playerid], "~r~OFF");
				}
				else
				{
					PlayerTextDrawSetString(playerid, SPvehengine[playerid], "~g~ON");
				}

				SetPlayerProgressBarValue(playerid, pData[playerid][spfuelbar], fFuel);
				SetPlayerProgressBarValue(playerid, pData[playerid][spdamagebar], fDamage);

				format(tstr, sizeof(tstr), "%s", GetVehicleName(vehicleid));
				PlayerTextDrawSetString(playerid, SPvehname[playerid], tstr);

				format(tstr, sizeof(tstr), "%.0f Mph", GetVehicleSpeed(vehicleid));
				PlayerTextDrawSetString(playerid, SPvehspeed[playerid], tstr);*/
			}
			else
			{
			
			}
		}
	}
}
/*UpdatePlayerHBE(playerid)
{
	new Float:hunger, Float:energy, Float:stress;
  	hunger = pData[playerid][pHunger] * -26.0/100;
	PlayerTextDrawTextSize(playerid, BarLapar[playerid], 25.0, hunger);
 	PlayerTextDrawShow(playerid, BarLapar[playerid]);

 	energy = pData[playerid][pEnergy] * -26.0/100;
	PlayerTextDrawTextSize(playerid, BarMinum[playerid], 25.0, energy);
 	PlayerTextDrawShow(playerid, BarMinum[playerid]);

	stress = pData[playerid][pBladder] * -26.0/100;
	PlayerTextDrawTextSize(playerid, BarStres[playerid], 25.0, stress);
 	PlayerTextDrawShow(playerid, BarStres[playerid]);

}*/
ptask PlayerUpdate[999](playerid)
{
	//Anti-Cheat Vehicle health hack
	if(pData[playerid][pAdmin] < 2)
	{
		for(new v, j = GetVehiclePoolSize(); v <= j; v++) if(GetVehicleModel(v))
		{
			new Float:health;
			GetVehicleHealth(v, health);
			if( (health > VehicleHealthSecurityData[v]) && VehicleHealthSecurity[v] == false)
			{
				if(GetPlayerVehicleID(playerid) == v)
				{
					new playerState = GetPlayerState(playerid);
					if(playerState == PLAYER_STATE_DRIVER)
					{
						SetValidVehicleHealth(v, VehicleHealthSecurityData[v]);
						SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s have been auto kicked for vehicle health hack!", pData[playerid][pName]);
						KickEx(playerid);
					}
				}
			}
			if(VehicleHealthSecurity[v] == true)
			{
				VehicleHealthSecurity[v] = false;
			}
			VehicleHealthSecurityData[v] = health;
		}
	}	
	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > pData[playerid][pMoney])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pData[playerid][pMoney]);
		//SendAdminMessage(COLOR_RED, "Possible money hacks detected on %s(%i). Check on this player. "LG_E"($%d).", pData[playerid][pName], playerid, GetPlayerMoney(playerid) - pData[playerid][pMoney]);
	}
	//Anti Armour Hacks
	new Float:A;
	GetPlayerArmour(playerid, A);
	if(pData[playerid][pAdmin] < 2)
	{
		if(A > 400)
		{
			new dc[128];
			SendStaffMessage(COLOR_RED, "[ANTICHEAT]: "GREY2_E"%s(%i) has been auto kicked for armour hacks!", pData[playerid][pName], playerid);
            format(dc, sizeof(dc), "\n<!> %s Mengunakan Armour Sebanyak %d ", pData[playerid][pName], pData[playerid][pArmour]);
		}
	}
	//Weapon AC
	if(pData[playerid][pAdmin] < 2)
	{
		if(pData[playerid][pSpawned] == 1)
		{
			if(GetPlayerWeapon(playerid) != pData[playerid][pWeapon])
			{
				pData[playerid][pWeapon] = GetPlayerWeapon(playerid);

				if(pData[playerid][pWeapon] >= 1 && pData[playerid][pWeapon] <= 45 && pData[playerid][pWeapon] != 40 && pData[playerid][pWeapon] != 2 && pData[playerid][pGuns][g_aWeaponSlots[pData[playerid][pWeapon]]] != GetPlayerWeapon(playerid))
				{
					pData[playerid][pACWarns]++;

					if(pData[playerid][pACWarns] < MAX_ANTICHEAT_WARNINGS)
					{
						new dc[128];
						SendAnticheat(COLOR_RED, "%s(%d) has possibly used weapon hacks (%s), Please to check /spec this player first!", pData[playerid][pName], playerid, ReturnWeaponName(pData[playerid][pWeapon]));
						SetWeapons(playerid); 
						format(dc, sizeof(dc),  "```\n<!> %s kemungkinan Weapon hacks (%s) ```", ReturnName(playerid), ReturnWeaponName(pData[playerid][pWeapon]));
						SendDiscordMessage(3, dc);					
					}
					else
					{
						new dc[128], PlayerIP[16];
						SendClientMessageToAllEx(COLOR_RED, "[ANTICHEAT]: %s"WHITE_E" telah dibanned otomatis oleh %s, Alasan: Weapon hacks", pData[playerid][pName], SERVER_BOT);
						format(dc, sizeof(dc),  "```\n<!> %s telah diban oleh %s\nAlasan: Weapon Hack```", ReturnName(playerid), SERVER_BOT);
						SendDiscordMessage(3, dc);

						GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
						new query[300], tmp[40], ban_time = 0;
						format(tmp, sizeof (tmp), "Weapon Hack (%s)", ReturnWeaponName(pData[playerid][pWeapon]));
						mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', %i, %d)", pData[playerid][pUCP], PlayerIP, SERVER_BOT, tmp, gettime(), ban_time);
						mysql_tquery(g_SQL, query);
						KickEx(playerid);
					}
				}
			}
		}
	}	
	//Weapon Atth
	if(NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
	{
		static weaponid, ammo, objectslot, count, index;
 
		for (new i = 2; i <= 7; i++) //Loop only through the slots that may contain the wearable weapons
		{
			GetPlayerWeaponData(playerid, i, weaponid, ammo);
			index = weaponid - 22;
		   
			if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
			{
				objectslot = GetWeaponObjectSlot(weaponid);
 
				if (GetPlayerWeapon(playerid) != weaponid)
					SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
 
				else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) RemovePlayerAttachedObject(playerid, objectslot);
			}
		}
		for (new i = 4; i <= 8; i++) if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			count = 0;
 
			for (new j = 22; j <= 38; j++) if (PlayerHasWeapon(playerid, j) && GetWeaponObjectSlot(j) == i)
				count++;
 
			if(!count) RemovePlayerAttachedObject(playerid, i);
		}
		WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
	}
	
	//Player Update Online Data
	//GetPlayerHealth(playerid, pData[playerid][pHealth]);
    //GetPlayerArmour(playerid, pData[playerid][pArmour]);
	
	if(pData[playerid][pJail] <= 0)
	{
		if(pData[playerid][pHunger] > 100)
		{
			pData[playerid][pHunger] = 100;
		}
		if(pData[playerid][pHunger] < 0)
		{
			pData[playerid][pHunger] = 0;
		}
		if(pData[playerid][pEnergy] > 100)
		{
			pData[playerid][pEnergy] = 100;
		}
		if(pData[playerid][pEnergy] < 0)
		{
			pData[playerid][pEnergy] = 0;
		}
		/*if(pData[playerid][pHealth] > 100)
		{
			SetPlayerHealthEx(playerid, 100);
		}*/
	}
	UpdatePlayerMask(playerid);
	if(pData[playerid][pHBEMode] == 1 && pData[playerid][IsLoggedIn] == true)
	{
		new string[200];

		format(string, sizeof(string), "%d", pData[playerid][pHunger]);
		PlayerTextDrawSetString(playerid, BarMakan[playerid], string );
		format(string, sizeof(string), "%d", pData[playerid][pEnergy]);
		PlayerTextDrawSetString(playerid, BarMinum[playerid], string );
		format(string, sizeof(string), "%d", pData[playerid][pLevel]);
		PlayerTextDrawSetString(playerid, BarArmor[playerid], string );
	}
	else
	{
	
	}
	
	if(pData[playerid][pHospital] == 1)
    {
		if(pData[playerid][pInjured] == 1)
		{
			SetPlayerPosition(playerid, -2028.32, -92.87, 1067.43, 275.78, 1);
		
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, playerid + 100);

			SetPlayerCameraPos(playerid, -2024.67, -93.13, 1066.78);
			SetPlayerCameraLookAt(playerid, -2028.32, -92.87, 1067.43);
			TogglePlayerControllable(playerid, 0);
			pData[playerid][pInjured] = 0;
			UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, "");
			if(pData[playerid][pWeaponLic] != 1)
			{
				ResetPlayerWeaponsEx(playerid);
			}
		}
		pData[playerid][pHospitalTime]++;
		new mstr[64];
		format(mstr, sizeof(mstr), "~n~~n~~n~~w~Recovering... %d", 15 - pData[playerid][pHospitalTime]);
		InfoTD_MSG(playerid, 1000, mstr);

		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
        if(pData[playerid][pHospitalTime] >= 15)
        {
            pData[playerid][pHospitalTime] = 0;
            pData[playerid][pHospital] = 0;
			pData[playerid][pHunger] = 50;
			pData[playerid][pEnergy] = 50;
			SetPlayerHealthEx(playerid, 50);
			pData[playerid][pBladder] = 0;
			pData[playerid][pSick] = 0;
			GivePlayerMoneyEx(playerid, -2000);
			SetPlayerHealthEx(playerid, 50);

            for (new i; i < 20; i++)
            {
                SendClientMessage(playerid, -1, "");
            }

			SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
            SendClientMessage(playerid, COLOR_WHITE, "Kamu telah keluar dari rumah sakit, kamu membayar $2000 kerumah sakit.");
            SendClientMessage(playerid, COLOR_GREY, "--------------------------------------------------------------------------------------------------------");
			
			SetPlayerPosition(playerid, 1182.8778, -1324.2023, 13.5784, 269.8747);

            TogglePlayerControllable(playerid, 1);
            SetCameraBehindPlayer(playerid);

            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
			ClearAnimations(playerid);
			pData[playerid][pSpawned] = 1;
			SetPVarInt(playerid, "GiveUptime", -1);
		}
    }
	if(pData[playerid][pInjured] == 1 && pData[playerid][pHospital] != 1)
    {
		new mstr[64], string[30];
        format(mstr, sizeof(mstr), "/death for spawn to hospital");
		InfoTD_MSG(playerid, 1000, mstr);
		format(string, sizeof(string), "(( Pingsan ))");
		UpdateDynamic3DTextLabelText(pData[playerid][pInjuredLabel], COLOR_ORANGE, string);
		
		if(GetPVarInt(playerid, "GiveUptime") == -1)
		{
			SetPVarInt(playerid, "GiveUptime", gettime());
		}
		
		if(GetPVarInt(playerid,"GiveUptime"))
        {
            if((gettime()-GetPVarInt(playerid, "GiveUptime")) > 100)
            {
                Info(playerid, "Now you can spawn, type '/death' for spawn to hospital.");
                SetPVarInt(playerid, "GiveUptime", 0);
            }
        }
		
		ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
        //ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
        //ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
        SetPlayerHealthEx(playerid, 99999);
    }
	if(pData[playerid][pInjured] == 0 && pData[playerid][pGender] != 0) //Pengurangan Data
	{
		if(++ pData[playerid][pHungerTime] >= 150)
        {
            if(pData[playerid][pHunger] > 0)
            {
                pData[playerid][pHunger]--;
            }
            else if(pData[playerid][pHunger] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pHungerTime] = 0;
        }
        if(++ pData[playerid][pEnergyTime] >= 120)
        {
            if(pData[playerid][pEnergy] > 0)
            {
                pData[playerid][pEnergy]--;
            }
            else if(pData[playerid][pEnergy] <= 0)
            {
                //SetPlayerHealth(playerid, health - 10);
          		//SetPlayerDrunkLevel(playerid, 8000);
          		pData[playerid][pSick] = 1;
            }
            pData[playerid][pEnergyTime] = 0;
        }
		if(pData[playerid][pSick] == 1)
		{
			if(++ pData[playerid][pSickTime] >= 200)
			{
				if(pData[playerid][pSick] >= 1)
				{
					new Float:hp;
					GetPlayerHealth(playerid, hp);
					SetPlayerDrunkLevel(playerid, 8000);
					ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,0,1,1,1,1,1);
					Info(playerid, "Sepertinya anda sakit, segeralah pergi ke dokter.");
					SetPlayerHealth(playerid, hp - 3);
					pData[playerid][pSickTime] = 0;
				}
			}
		}
	}
	if (pData[playerid][pSpeedTime] > 0)
	{
	    pData[playerid][pSpeedTime]--;
	}
	if(pData[playerid][pLastChopTime] > 0)
    {
		pData[playerid][pLastChopTime]--;
		new mstr[64];
        format(mstr, sizeof(mstr), "Waktu Pencurian ~r~%d ~w~detik", pData[playerid][pLastChopTime]);
        InfoTD_MSG(playerid, 1000, mstr);
	}
	//Jail Player
	if(pData[playerid][pJail] > 0)
	{
		if(pData[playerid][pJailTime] > 0)
		{
			pData[playerid][pJailTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be unjail in ~w~%d ~b~~h~seconds.", pData[playerid][pJailTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pJail] = 0;
			pData[playerid][pJailTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1482.0356,-1724.5726,13.5469,750, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E" %s(%d) have been un-jailed by the server. (times up)", pData[playerid][pName], playerid);
		}
	}
	//Arreset Player
	if(pData[playerid][pArrest] > 0)
	{
		if(pData[playerid][pArrestTime] > 0)
		{
			pData[playerid][pArrestTime]--;
			new mstr[128];
			format(mstr, sizeof(mstr), "~b~~h~You will be released in ~w~%d ~b~~h~seconds.", pData[playerid][pArrestTime]);
			InfoTD_MSG(playerid, 1000, mstr);
		}
		else
		{
			pData[playerid][pArrest] = 0;
			pData[playerid][pArrestTime] = 0;
			//SpawnPlayer(playerid);
			SetPlayerPositionEx(playerid, 1526.69, -1678.05, 5.89, 267.76, 2000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			Info(playerid, "You have been auto release. (times up)");
		}
	}
}

forward AppuieJump(playerid);
public AppuieJump(playerid)
{
    AntiBHOP[playerid] = 0;
    ClearAnimations(playerid);
    return 1;
}
forward AppuiePasJump(playerid);
public AppuiePasJump(playerid)
{
    AntiBHOP[playerid] = 0;
    return 1;
}
/*
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == 0) 
	{
        if (response) 
		{
            SetPlayerSkin(playerid, listitem);
            GameTextForPlayer(playerid, "~g~Skin Changed!", 3000, 3);
        }
    }
	if(dialogid == 1) 
	{
		if (response) 
		{
			if (GetPlayerMoney(playerid) < WEAPON_SHOP[listitem][WEAPON_PRICE]) 
			{
				SendClientMessage(playerid, 0xAA0000FF, "Not enough money to purchase this gun!");
				return callcmd::weapons(playerid);
			}
			
			GivePlayerMoney(playerid, -WEAPON_SHOP[listitem][WEAPON_PRICE]);
			GivePlayerWeapon(playerid, WEAPON_SHOP[listitem][WEAPON_ID], WEAPON_SHOP[listitem][WEAPON_AMMO]);
			
			GameTextForPlayer(playerid, "~g~Gun Purchased!", 3000, 3);
		}
	}
    return 1;
} */

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(pData[playerid][pDriveLicApp] > 0)
	{
		//new vehicleid = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(vehicleid) == 602)
		{
		    DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
		    Info(playerid, "Anda Dengan Sengaja Keluar Dari Mobil Latihan, Anda Telah "RED_E"DIDISKUALIFIKASI.");
		    RemovePlayerFromVehicle(playerid);
		    pData[playerid][pDriveLicApp] = 0;
		    SetTimerEx("RespawnPV", 3000, false, "d", vehicleid);
		}
	}
	pData[playerid][pMarkTemp] = 0;
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if (pData[playerid][pAdmin] >= 4 && pData[playerid][pAdminDuty] == 1)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
                SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
                SetPlayerPosFindZ(playerid, fX, fY, 999.0);
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);
        }
        Info(playerid, "Kamu Telah Berhasil Teleport Ke Marker Di Peta di peta.");
    }
    foreach (new i : Player)
	{
		if(pData[i][pMarkTemp] == pData[playerid][pMarkTemp] && pData[playerid][pMarkTemp] != 0 && pData[i][pMarkTemp] != 0)
		{
			SetPlayerCheckpoint(i, fX, fY, fZ, 3.0);
			Info(i, "Waypoint Sharing, Lihat pada map.");
		}
    }
    return 1;
}

stock SendDiscordMessage(channel, message[]) {
	new DCC_Channel:ChannelId;
	switch(channel)
	{
		//==[ Log Join & Leave ]
		case 0:
		{
			ChannelId = DCC_FindChannelById("1187948260082589697");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Command ]
		case 1:
		{
			ChannelId = DCC_FindChannelById("1187948400558223430");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Chat IC ]
		case 2:
		{
			ChannelId = DCC_FindChannelById("1187948400558223430");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Warning & Banned ]
		case 3:
		{
			ChannelId = DCC_FindChannelById("1176118474788052992");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Log Death ]
		case 4:
		{
			ChannelId = DCC_FindChannelById("927765834032640010");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		//==[ Ucp ]
		case 5:
		{
			ChannelId = DCC_FindChannelById("GANTI MENGGUNAKAN ID CHANNEL REGSITER UCP KALIAN");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 6://Korup
		{
			ChannelId = DCC_FindChannelById("909028255867240449");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 7://Register
		{
			ChannelId = DCC_FindChannelById("GANTI MENGGUNAKAN ID CHANNEL REGSITER UCP KALIAN");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
		case 8://Bot Admin
		{
			ChannelId = DCC_FindChannelById("909028257574301737");
			DCC_SendChannelMessage(ChannelId, message);
			return 1;
		}
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	// PHONE  TEXTDRAWS
	if(clickedid == calltd) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		
		ShowPlayerDialog(playerid, DIALOG_PHONE_DIALUMBER, DIALOG_STYLE_INPUT, "Dial Number", "Please enter the number that you wish to dial below:", "Dial", "Back");
	}
	if(clickedid == mesaagetd) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		ShowPlayerDialog(playerid, DIALOG_PHONE_SENDSMS, DIALOG_STYLE_INPUT, "Send Text Message", "Please enter the number that you wish to send a text message to:", "Dial", "Back");
	}
	if(clickedid == banktd) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		if(pData[playerid][pVip])
		{
			return ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
		}

		ShowPlayerDialog(playerid, DIALOG_IBANK, DIALOG_STYLE_LIST, "{6688FF}I-Bank", "Check Balance\nTransfer Money", "Select", "Cancel");
 		/*for(new i = 0; i < 5; i++) {
			TextDrawShowForPlayer(playerid, PhoneAtmTD[i]);
		}
		PlayerTextDrawShow(playerid, PhoneAtmPlayer[playerid]);
		TextDrawShowForPlayer(playerid, PhoneAtmTransfer);
		TextDrawShowForPlayer(playerid, PhoneAtmExit);
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);*/
	}
	if(clickedid == contactstd) 
	{
		if (pData[playerid][pPhoneStatus] == 0)
			return Error(playerid, "Your phone must be powered on.");

		if(pData[playerid][pPhoneBook] == 0)
			return Error(playerid, "You dont have a phone book.");

		ShowContacts(playerid);
	}
	if(clickedid == twittertd) 
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
	if(clickedid == apptd) 
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}

		new string[512];
		format(string, sizeof(string),"App Store\nIsi Kuota");
		ShowPlayerDialog(playerid, DIALOG_ISIKUOTA, DIALOG_STYLE_LIST,"Phone",string,"Pilih","Batal");

		//pData[playerid][pMusicType] = MUSIC_MP3PLAYER;
		//ShowDialogToPlayer(playerid, DIALOG_MP3PLAYER);
	}
	if(clickedid == phoneclosetd) 
	{
 		for(new i = 0; i < 33; i++) {
			TextDrawHideForPlayer(playerid, PhoneTD[i]);
		}
		TextDrawHideForPlayer(playerid, phoneclosetd);
		TextDrawHideForPlayer(playerid, banktd);
		TextDrawHideForPlayer(playerid, mesaagetd);
		TextDrawHideForPlayer(playerid, calltd);
		TextDrawHideForPlayer(playerid, contactstd);
		TextDrawHideForPlayer(playerid, phoneclosetd);
		TextDrawHideForPlayer(playerid, apptd);
		TextDrawHideForPlayer(playerid, twittertd);
		TextDrawHideForPlayer(playerid, gpstd);
		TextDrawHideForPlayer(playerid, settingtd);
		TextDrawHideForPlayer(playerid, cameratd);
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == settingtd)
	{
		ShowPlayerDialog(playerid, DIALOG_TOGGLEPHONE, DIALOG_STYLE_LIST, "Setting", "Phone On\nPhone Off", "Select", "Back");
	}
	if(clickedid == cameratd)
	{
		callcmd::selfie(playerid, "");
	}
	if(clickedid == gpstd)
	{
		if(pData[playerid][pPhoneStatus] == 0) 
		{
			return Error(playerid, "Handphone anda sedang dimatikan");
		}
		ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", "Disable GPS\nGeneral Location\nPublic Location\nJobs\nMy Proprties\nMy Mission", "Select", "Close");
	}
	/*// PHONE ATMTD
	if(clickedid == PhoneAtmTransfer) {
		ShowDialogToPlayer(playerid, DIALOG_ATM_TRANSFER);
	}
	if(clickedid == PhoneAtmExit) {
 		for(new i = 0; i < 5; i++) {
			TextDrawHideForPlayer(playerid, PhoneAtmTD[i]);
		}

		PlayerTextDrawHide(playerid, PhoneAtmPlayer[playerid]);
		TextDrawHideForPlayer(playerid, PhoneAtmTransfer);
		TextDrawHideForPlayer(playerid, PhoneAtmExit);
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}
	// CALLING TD
	if(clickedid == PICKUP) {
	    if(pData[playerid][pTazedTime] > 0 || pData[playerid][pInjured] > 0 || pData[playerid][pHospital] > 0 || pData[playerid][pTied] > 0 || pData[playerid][pCuffed] > 0 || pData[playerid][pJailTime] > 0)
		{
		    return SCM(playerid, COLOR_SYNTAX, "Kamu tidak dapat menggunakan ponselmu saat ini.");
		}

		SendProximityMessage(playerid, 20.0, SERVER_COLOR, "{C2A2DA}%s menekan tombol dan menjawab ponsel.", ReturnName(playerid));
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);

		pData[pData[playerid][pCallLine]][pCallStage] = 2;
		pData[playerid][pCallStage] = 2;
		PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][2]);
		PlayerTextDrawHide(pData[playerid][pCallLine], CallingPlayerTD[playerid][3]);
		TextDrawHideForPlayer(playerid, PICKUP);
		//TextDrawHideForPlayer(playerid, HANGUP);
		SCM(playerid, COLOR_WHITE, "Kamu telah menjawab panggilan tersebut. Sekarang kamu dapat berbicara dalam obrolan untuk berbicara dengan penelepon.");
		SCM(pData[playerid][pCallLine], COLOR_WHITE, "Mereka menjawab panggilan itu. Sekarang kamu dapat berbicara dalam obrolan untuk berbicara dengan mereka.");
	}
	if(clickedid == HANGUP) {
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 4; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
									}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		HangupCall(playerid, HANGUP_USER);
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == CloseCallTD) {
		for(new i = 0; i < 13; i ++)
		{
			TextDrawHideForPlayer(playerid, CallingTD[i]);
		}
		for(new g = 0; g < 4; g++) {
			PlayerTextDrawHide(playerid, CallingPlayerTD[playerid][g]);
		}
		TextDrawHideForPlayer(playerid, CloseCallTD);
		TextDrawHideForPlayer(playerid, PICKUP);
		TextDrawHideForPlayer(playerid, HANGUP);
		CancelSelectTextDraw(playerid);
	}
 	if(clickedid == Text:INVALID_TEXT_DRAW && !pData[playerid][pLogged])
	{
		SelectTextDraw(playerid, COLOR_LIGHTBLUE);
	}*/
	return 1;
}

stock RefreshPSkin(playerid)
{
    return 1;
}
public OnCustomSelectionResponse(playerid, extraid, modelid, response)
{
	switch(extraid)
	{
		case SPAWN_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1744.3411, -1862.8655, 13.3983, 270.0000, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				UpdatePlayerData(playerid);
			}
		}
		case SPAWN_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetSpawnInfo(playerid, 0, pData[playerid][pSkin], 1744.3411, -1862.8655, 13.3983, 270.0000, 0, 0, 0, 0, 0, 0);
				SpawnPlayer(playerid);
				UpdatePlayerData(playerid);
			}
		}
		case SHOP_SKIN_MALE:
	    {
	        if(response)
	        {
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}	
		case SHOP_SKIN_FEMALE:
	    {
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][0];
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				GivePlayerMoneyEx(playerid, -price);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli skin ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);
				
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);

				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");	
		}
		case VIP_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case VIP_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengganti skin ID %d.", ReturnName(playerid), modelid);
				Info(playerid, "Anda telah mengganti skin menjadi ID %d", modelid);
			}
			else 
				return Servers(playerid, "Canceled buy skin");
		}
		case SAPD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAPD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAPD_SKIN_WAR:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAGS_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAGS_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAMD_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SAMD_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SANA_SKIN_MALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case SANA_SKIN_FEMALE:
		{
			if(response)
			{
				pData[playerid][pFacSkin] = modelid;
				SetPlayerSkin(playerid, modelid);
				Servers(playerid, "Anda telah mengganti faction skin menjadi ID %d", modelid);
			}	
		}
		case TOYS_MODEL:
		{
			if(response)
			{
				new bizid = pData[playerid][pInBiz], price;
				price = bData[bizid][bP][1];
				
				GivePlayerMoneyEx(playerid, -price);
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah membeli object ID %d seharga %s.", ReturnName(playerid), modelid, FormatMoney(price));
				bData[bizid][bProd]--;
				bData[bizid][bMoney] += Server_Percent(price);
				Server_AddPercent(price);

				new query[128];
				mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET prod='%d', money='%d' WHERE ID='%d'", bData[bizid][bProd], bData[bizid][bMoney], bizid);
				mysql_tquery(g_SQL, query);
			}
			else 
				return Servers(playerid, "Canceled buy toys");
		}
		case VIPTOYS_MODEL:
		{
			if(response)
			{
				if(pData[playerid][PurchasedToy] == false) MySQL_CreatePlayerToy(playerid);
				pToys[playerid][pData[playerid][toySelected]][toy_model] = modelid;
				pToys[playerid][pData[playerid][toySelected]][toy_status] = 1;
				new finstring[750];
				strcat(finstring, ""dot"Spine\n"dot"Head\n"dot"Left upper arm\n"dot"Right upper arm\n"dot"Left hand\n"dot"Right hand\n"dot"Left thigh\n"dot"Right tigh\n"dot"Left foot\n"dot"Right foot");
				strcat(finstring, "\n"dot"Right calf\n"dot"Left calf\n"dot"Left forearm\n"dot"Right forearm\n"dot"Left clavicle\n"dot"Right clavicle\n"dot"Neck\n"dot"Jaw");
				ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""WHITE_E"Select Bone", finstring, "Select", "Cancel");
				
				SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telah mengambil object ID %d dilocker.", ReturnName(playerid), modelid);
			}
			else
				return Servers(playerid, "Canceled toys");
		}
	}
	return 1;
}	

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
    if (pData[playerid][pMaskOn]) {
		ShowPlayerNameTagForPlayer(forplayerid, playerid, 0);
		UpdatePlayerMask(playerid);
	}
	else
	    ShowPlayerNameTagForPlayer(forplayerid, playerid, 1);
	return 1;
}