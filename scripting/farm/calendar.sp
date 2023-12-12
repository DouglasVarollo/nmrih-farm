int   currentDay;

Handle hDayTimer;

stock void PrintCurrentDay()
{
	switch (CvarFarmLogType.IntValue)
	{
		case FARM_LOG_TYPE_CHAT:
		{
			MC_PrintToChatAll("%t", "Current Day", currentDay);
		}
		case FARM_LOG_TYPE_CONSOLE:
		{
			PrintToConsoleAll("%t", "Current Day Console", currentDay);
		}
	}
}

stock void StartTrackingDays()
{
	currentDay   = 0;

	if (IsValidHandle(hDayTimer))
	{
		delete hDayTimer;
	}

	PrintCurrentDay();

	hDayTimer = CreateTimer(DAY_IN_SECONDS, Timer_DayChanged, _, TIMER_FLAG_NO_MAPCHANGE | TIMER_REPEAT);
}

stock Action Timer_DayChanged(Handle timer)
{
	currentDay++;

	PrintCurrentDay();

	return Plugin_Handled;
}
