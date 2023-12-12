#include <morecolors>
#include <sdktools>
#include <sourcemod>

#define FARM_LOG_TYPE_CHAT    1
#define FARM_LOG_TYPE_CONSOLE 2

#define MAX_MESSAGE_LENGTH 128

#define PLUGIN_DESCRIPTION "Add features to the mg_farm map"
#define PLUGIN_VERSION     "1.0.0"

public Plugin myinfo =
{
	author      = "Douglas Varollo",
	description = PLUGIN_DESCRIPTION,
	name        = "[NMRiH] Farm",
	version     = PLUGIN_VERSION,
	url         = "https://github.com/DouglasVarollo/nmrih-farm"
};

ConVar CvarFarmDayInSeconds;
ConVar CvarFarmLogType;

#include <farm/calendar.sp>
#include <farm/utils.sp>

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
}

public void OnPluginStart()
{
	CreateConVar("sm_farm_version", PLUGIN_VERSION, PLUGIN_DESCRIPTION, FCVAR_DONTRECORD | FCVAR_SPONLY);

	CvarFarmDayInSeconds = CreateConVar("sm_farm_day_in_seconds", "300.0", "The length of the day in seconds");
	CvarFarmLogType      = CreateConVar("sm_farm_log_type", "0", "Choose the log type");

	AutoExecConfig(true, "plugin.nmrih-farm");

	HookEvent("nmrih_round_begin", Event_RoundBegin);

	LoadTranslations("nmrih-farm.phrases");
}
