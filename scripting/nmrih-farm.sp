#include <sdktools>
#include <sourcemod>

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

public void OnPluginStart()
{
	CreateConVar("sm_farm_version", PLUGIN_VERSION, PLUGIN_DESCRIPTION, FCVAR_DONTRECORD | FCVAR_SPONLY);
}
