#include <morecolors>
#include <sdktools>
#include <sourcemod>

#define DAY_IN_SECONDS 300.0

#define FARM_LOG_TYPE_CHAT    1
#define FARM_LOG_TYPE_CONSOLE 2

#define PLUGIN_DESCRIPTION "Add features to the mg_farm map"
#define PLUGIN_VERSION     "1.0.6"

public Plugin myinfo =
{
	author      = "Douglas Varollo",
	description = PLUGIN_DESCRIPTION,
	name        = "[NMRiH] Farm",
	version     = PLUGIN_VERSION,
	url         = "https://github.com/DouglasVarollo/nmrih-farm"
};

ConVar CvarFarmLogType;

#include <farm/calendar.sp>
#include <farm/economy.sp>
#include <farm/utils.sp>

stock void OnButtonPressed(const char[] output, int caller, int activator, float delay)
{
	char name[MAX_TARGET_LENGTH];

	GetEntPropString(caller, Prop_Data, "m_iName", name, sizeof(name));

	InsertPurchase(activator, name);
}

stock Action Event_RoundBegin(Event event, const char[] name, bool dontBroadcast)
{
	if (!IsFarmMap())
	{
		return Plugin_Continue;
	}

	StartTrackingDays();

	return Plugin_Continue;
}

public void OnMapStart()
{
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
	UnhookEntityOutput("func_button", "OnPressed", OnButtonPressed);

	UnregisterPurchasableItems();
	UnregisterPurchases();
}

public void OnPluginStart()
{
	CreateConVar("sm_farm_version", PLUGIN_VERSION, PLUGIN_DESCRIPTION, FCVAR_DONTRECORD | FCVAR_SPONLY);

	CvarFarmLogType = CreateConVar("sm_farm_log_type", "0", "Choose the log type");

	AutoExecConfig(true, "plugin.nmrih-farm");

	HookEvent("nmrih_round_begin", Event_RoundBegin);

	LoadTranslations("nmrih-farm.phrases");
}
