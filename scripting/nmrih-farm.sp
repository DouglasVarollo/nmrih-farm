#include <morecolors>
#include <sdktools>
#include <sourcemod>

#define DAY_IN_SECONDS 300.0

#define FARM_LOG_TYPE_CHAT    0
#define FARM_LOG_TYPE_CONSOLE 1

#define NMRIH_MAXPLAYERS 9

#define PLUGIN_DESCRIPTION "Add features to the mg_farm map"
#define PLUGIN_VERSION     "1.1.0"

public Plugin myinfo =
{
	author      = "Douglas Varollo",
	description = PLUGIN_DESCRIPTION,
	name        = "[NMRiH] Farm",
	version     = PLUGIN_VERSION,
	url         = "https://github.com/DouglasVarollo/nmrih-farm"
};

ConVar CvarFarmLogType;
ConVar CvarFarmTrackingInterval;

int   logType;
char  mapName[PLATFORM_MAX_PATH];
float trackingInterval;

#include <farm/calendar.sp>
#include <farm/economy.sp>

stock void CacheConVars()
{
	logType          = CvarFarmLogType.IntValue;
	trackingInterval = CvarFarmTrackingInterval.FloatValue;
}

stock void ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
	CacheConVars();
}

stock void OnButtonPressed(const char[] output, int caller, int activator, float delay)
{
	char name[MAX_TARGET_LENGTH];

	GetEntPropString(caller, Prop_Data, "m_iName", name, sizeof(name));

	InsertPurchase(activator, name);
}

stock void Event_RoundBegin(Event event, const char[] name, bool dontBroadcast)
{
	if (!IsFarmMap())
	{
		return;
	}

	StartTrackingDays();
}

stock bool IsFarmMap()
{
	return StrContains(mapName, "mg_farm") == 0;
}

public void OnConfigsExecuted()
{
	CacheConVars();
}

public void OnMapStart()
{
	GetCurrentMap(mapName, sizeof(mapName));

	if (!IsFarmMap())
	{
		return;
	}

	HookEntityOutput("func_button", "OnPressed", OnButtonPressed);

	RegisterPurchasableItems();
	RegisterPurchases();
}

public void OnMapEnd()
{
	if (!IsFarmMap())
	{
		return;
	}

	UnhookEntityOutput("func_button", "OnPressed", OnButtonPressed);

	UnregisterPurchasableItems();
	UnregisterPurchases();
}

public void OnPluginStart()
{
	CreateConVar("sm_farm_version", PLUGIN_VERSION, PLUGIN_DESCRIPTION, FCVAR_DONTRECORD | FCVAR_SPONLY);

	CvarFarmLogType          = CreateConVar("sm_farm_log_type", "0", "Choose the log type (0 = Chat, 1 = Console)");
	CvarFarmTrackingInterval = CreateConVar("sm_farm_tracking_interval", "1.0", "The time interval in seconds to track the purchases");

	CvarFarmLogType.AddChangeHook(ConVarChanged);
	CvarFarmTrackingInterval.AddChangeHook(ConVarChanged);

	AutoExecConfig(true, "plugin.nmrih-farm");

	CacheConVars();

	HookEvent("nmrih_round_begin", Event_RoundBegin, EventHookMode_PostNoCopy);

	LoadTranslations("nmrih-farm.phrases");
}
