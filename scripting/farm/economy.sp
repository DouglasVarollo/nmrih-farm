enum struct Purchase
{
	int    client;
	int    count;
	int    price;
	Handle timer;
}

StringMap purchasable;
StringMap purchases[MAXPLAYERS];

stock void InsertPurchase(int client, const char[] name)
{
	int price;

	if (!purchasable.GetValue(name, price))
	{
		return;
	}

	DataPack datapack;
	Purchase purchase;

	purchase.client = client;
	purchase.count  = 1;
	purchase.price  = price;

	if (purchases[client].GetArray(name, purchase, sizeof(purchase)))
	{
		purchase.count++;

		if (IsValidHandle(purchase.timer))
		{
			delete purchase.timer;
		}
	}

	purchase.timer = CreateDataTimer(1.0, Timer_PrintPurchase, datapack);

	WritePackCell(datapack, client);
	WritePackString(datapack, name);

	purchases[client].SetArray(name, purchase, sizeof(purchase), true);
}

stock void RegisterPurchasableItems()
{
	purchasable = new StringMap();

	purchasable.SetValue("armor_butt", 15);
	purchasable.SetValue("atm_butt", 200);
	purchasable.SetValue("bandage_butt", 5);
	purchasable.SetValue("barn_butt", 500);
	purchasable.SetValue("basement_butt", 200);
	purchasable.SetValue("basket_button_1", 150);
	purchasable.SetValue("basket_button_2", 150);
	purchasable.SetValue("basket_button_3", 150);
	purchasable.SetValue("basket_button_4", 150);
	purchasable.SetValue("bell_butt", 150);
	purchasable.SetValue("capy2_butt", 100);
	purchasable.SetValue("capy_butt", 200);
	purchasable.SetValue("car_butt", 25000);
	purchasable.SetValue("castle_butt", 150);
	purchasable.SetValue("cat_butt", 250);
	purchasable.SetValue("chainsaw_butt", 500);
	purchasable.SetValue("clock_button", 100);
	purchasable.SetValue("coffee_butt", 100);
	purchasable.SetValue("coffee_butt2", 1000);
	purchasable.SetValue("coffeebutt", 5);
	purchasable.SetValue("contract_17_butt", 250);
	purchasable.SetValue("contract_18_butt", 250);
	purchasable.SetValue("controller_butt_1", 25);
	purchasable.SetValue("controller_butt_2", 25);
	purchasable.SetValue("controller_butt_3", 25);
	purchasable.SetValue("controller_butt_4", 25);
	purchasable.SetValue("dinky_butt", 25);
	purchasable.SetValue("dog_butt", 250);
	purchasable.SetValue("duck_butt", 50);
	purchasable.SetValue("evac_axel_butt", 5000);
	purchasable.SetValue("evac_battery_butt", 5000);
	purchasable.SetValue("evac_engine_butt", 7500);
	purchasable.SetValue("evac_gas_butt", 2500);
	purchasable.SetValue("evac_muffler_butt", 2500);
	purchasable.SetValue("evac_paint_butt", 100);
	purchasable.SetValue("evac_tires_butt", 2500);
	purchasable.SetValue("evac_tools_butt", 2500);
	purchasable.SetValue("feed_butt", 10);
	purchasable.SetValue("firstaid_butt", 15);
	purchasable.SetValue("furni_ball1_butt", 10);
	purchasable.SetValue("furni_ball2_butt", 10);
	purchasable.SetValue("furni_ball3_butt", 20);
	purchasable.SetValue("furni_bench_butt", 20);
	purchasable.SetValue("furni_bike_butt", 15);
	purchasable.SetValue("furni_bust_butt", 25);
	purchasable.SetValue("furni_companion_butt", 50);
	purchasable.SetValue("furni_computer_butt", 50);
	purchasable.SetValue("furni_drawer2_butt", 25);
	purchasable.SetValue("furni_drawer_butt", 20);
	purchasable.SetValue("furni_drums_butt", 300);
	purchasable.SetValue("furni_fan_butt", 15);
	purchasable.SetValue("furni_giraffe_butt", 20);
	purchasable.SetValue("furni_glow_butt", 50);
	purchasable.SetValue("furni_guitar_butt", 200);
	purchasable.SetValue("furni_heli_butt", 50);
	purchasable.SetValue("furni_lamp_butt", 15);
	purchasable.SetValue("furni_laptop_butt", 35);
	purchasable.SetValue("furni_mic_butt", 50);
	purchasable.SetValue("furni_monitor_butt", 25);
	purchasable.SetValue("furni_plant_butt", 15);
	purchasable.SetValue("furni_skull_butt", 25);
	purchasable.SetValue("furni_snacks_butt", 15);
	purchasable.SetValue("furni_suitcase_butt", 5);
	purchasable.SetValue("furni_table_butt", 10);
	purchasable.SetValue("furni_teddy_butt", 15);
	purchasable.SetValue("game_butt_0", 25);
	purchasable.SetValue("game_butt_1", 25);
	purchasable.SetValue("game_butt_2", 25);
	purchasable.SetValue("game_butt_3", 25);
	purchasable.SetValue("game_butt_4", 25);
	purchasable.SetValue("game_butt_5", 25);
	purchasable.SetValue("game_butt_6", 25);
	purchasable.SetValue("game_butt_7", 25);
	purchasable.SetValue("game_butt_8", 25);
	purchasable.SetValue("game_butt_9", 25);
	purchasable.SetValue("gene_butt", 50);
	purchasable.SetValue("gunbutt_1022", 25);
	purchasable.SetValue("gunbutt_1022extendo", 100);
	purchasable.SetValue("gunbutt_12guage", 10);
	purchasable.SetValue("gunbutt_1892", 100);
	purchasable.SetValue("gunbutt_1911", 50);
	purchasable.SetValue("gunbutt_22ammo", 10);
	purchasable.SetValue("gunbutt_308ammo", 10);
	purchasable.SetValue("gunbutt_357", 50);
	purchasable.SetValue("gunbutt_357ammo", 10);
	purchasable.SetValue("gunbutt_45ammo", 10);
	purchasable.SetValue("gunbutt_556ammo", 10);
	purchasable.SetValue("gunbutt_762ammo", 10);
	purchasable.SetValue("gunbutt_870", 200);
	purchasable.SetValue("gunbutt_9mmammo", 10);
	purchasable.SetValue("gunbutt_arrowammo", 20);
	purchasable.SetValue("gunbutt_cz", 200);
	purchasable.SetValue("gunbutt_fal", 200);
	purchasable.SetValue("gunbutt_flare", 200);
	purchasable.SetValue("gunbutt_flareammo", 10);
	purchasable.SetValue("gunbutt_glocko", 50);
	purchasable.SetValue("gunbutt_jae", 150);
	purchasable.SetValue("gunbutt_m16", 200);
	purchasable.SetValue("gunbutt_m16carry", 200);
	purchasable.SetValue("gunbutt_m92fs", 50);
	purchasable.SetValue("gunbutt_mac10", 100);
	purchasable.SetValue("gunbutt_mk3", 25);
	purchasable.SetValue("gunbutt_mossberg500", 100);
	purchasable.SetValue("gunbutt_mp5", 100);
	purchasable.SetValue("gunbutt_sako", 100);
	purchasable.SetValue("gunbutt_sakonoscope", 100);
	purchasable.SetValue("gunbutt_sks", 100);
	purchasable.SetValue("gunbutt_superx3", 50);
	purchasable.SetValue("gunbutt_sv10", 25);
	purchasable.SetValue("gunbutt_tammo_ar2", 20);
	purchasable.SetValue("gunbutt_tammo_ball", 15);
	purchasable.SetValue("gunbutt_tammo_sniper", 30);
	purchasable.SetValue("gunbutt_tup_clip", 100);
	purchasable.SetValue("gunbutt_tup_dmg", 100);
	purchasable.SetValue("gunbutt_tup_mag", 80);
	purchasable.SetValue("gunbutt_tup_rof", 100);
	purchasable.SetValue("gunbutt_turret_blue", 500);
	purchasable.SetValue("gunbutt_turret_green", 500);
	purchasable.SetValue("gunbutt_turret_red", 500);
	purchasable.SetValue("health_box_butt", 150);
	purchasable.SetValue("lotto_butt", 5);
	purchasable.SetValue("memes_butt", 25);
	purchasable.SetValue("motel_button1", 10);
	purchasable.SetValue("motel_button2", 500);
	purchasable.SetValue("piano_butt", 300);
	purchasable.SetValue("pills_butt", 10);
	purchasable.SetValue("plinkobutt", 15);
	purchasable.SetValue("price_banana_button", 5);
	purchasable.SetValue("price_chicken_gold1_button", 500);
	purchasable.SetValue("price_chicken_gold2_button", 500);
	purchasable.SetValue("price_chicken_gold3_button", 500);
	purchasable.SetValue("price_chicken_gold4_button", 500);
	purchasable.SetValue("price_chicken_white1_button", 100);
	purchasable.SetValue("price_chicken_white2_button", 100);
	purchasable.SetValue("price_chicken_white3_button", 100);
	purchasable.SetValue("price_chicken_white4_button", 100);
	purchasable.SetValue("price_melon_button", 5);
	purchasable.SetValue("price_orange_button", 20);
	purchasable.SetValue("price_pumpkin_button", 5);
	purchasable.SetValue("price_tomato_button", 10);
	purchasable.SetValue("price_weed_button", 20);
	purchasable.SetValue("pufferfish_butt", 50);
	purchasable.SetValue("radio2_butt", 200);
	purchasable.SetValue("radio_butt", 50);
	purchasable.SetValue("respawn_butt", 10);
	purchasable.SetValue("shed_butt", 200);
	purchasable.SetValue("shed_sprinkler_butt", 500);
	purchasable.SetValue("silo_store_butt", 200);
	purchasable.SetValue("spider_butt", 5);
	purchasable.SetValue("spinner_butt", 30);
	purchasable.SetValue("sprinky_butt", 150);
	purchasable.SetValue("sprinky_butt2", 150);
	purchasable.SetValue("sprinky_butt3", 150);
	purchasable.SetValue("sprinky_butt4", 150);
	purchasable.SetValue("sprinky_butt5", 150);
	purchasable.SetValue("sprinky_butt6", 150);
	purchasable.SetValue("sprinky_butt7", 150);
	purchasable.SetValue("sprinky_butt8", 150);
	purchasable.SetValue("sword_diamond_butt", 250);
	purchasable.SetValue("sword_iron_butt", 100);
	purchasable.SetValue("sword_stone_butt", 50);
	purchasable.SetValue("sword_wood_butt", 15);
	purchasable.SetValue("teleporter_butt", 200);
	purchasable.SetValue("tendo_butt_0", 100);
	purchasable.SetValue("TNT_button", 1000);
	purchasable.SetValue("tower_store_butt", 500);
	purchasable.SetValue("transport_butt", 500);
	purchasable.SetValue("trophy_butt2", 100000);
	purchasable.SetValue("TV_button", 150);
	purchasable.SetValue("walkie_butt1", 50);
	purchasable.SetValue("walkie_butt2", 50);
	purchasable.SetValue("walkie_butt3", 50);
	purchasable.SetValue("walkie_butt4", 50);
	purchasable.SetValue("walkie_butt5", 50);
	purchasable.SetValue("walkie_butt6", 50);
	purchasable.SetValue("walkie_butt7", 50);
	purchasable.SetValue("water_can_button_1", 150);
	purchasable.SetValue("water_can_button_2", 150);
	purchasable.SetValue("water_can_button_3", 150);
	purchasable.SetValue("water_can_button_4", 150);
	purchasable.SetValue("welder_butt", 50);
	purchasable.SetValue("well_butt", 150);
	purchasable.SetValue("wind_butt", 5);
	purchasable.SetValue("wish_button", 100);
}

stock void RegisterPurchases()
{
	for (int i = 0; i < MaxClients; i++)
	{
		purchases[i] = new StringMap();
	}
}

stock Action Timer_PrintPurchase(Handle timer, DataPack datapack)
{
	ResetPack(datapack);

	int      client = ReadPackCell(datapack);
	char     name[MAX_TARGET_LENGTH];
	Purchase purchase;

	ReadPackString(datapack, name, sizeof(name));

	if (!purchases[client].GetArray(name, purchase, sizeof(purchase)))
	{
		return Plugin_Handled;
	}

	purchases[client].Remove(name);

	switch (CvarFarmLogType.IntValue)
	{
		case FARM_LOG_TYPE_CHAT:
		{
			MC_PrintToChatAll("%t", "Purchased Message", client, purchase.count, name, purchase.count * purchase.price);
		}
		case FARM_LOG_TYPE_CONSOLE:
		{
			PrintToConsoleAll("%t", "Purchased Message Console", client, purchase.count, name, purchase.count * purchase.price);
		}
	}

	return Plugin_Handled;
}

stock void UnregisterPurchasableItems()
{
	delete purchasable;
}

stock void UnregisterPurchases()
{
	for (int i = 0; i < MaxClients; i++)
	{
		delete purchases[i];
	}
}