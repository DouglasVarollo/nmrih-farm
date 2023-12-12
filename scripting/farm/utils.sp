stock bool IsFarmMap()
{
	char currentMap[PLATFORM_MAX_PATH];

	GetCurrentMap(currentMap, sizeof(currentMap));

	return StrContains(currentMap, "mg_farm") == 0;
}
