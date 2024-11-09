#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

#include scripts\mp\menu;
#include scripts\mp\utils;

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if(!player is_bot())
        {
            player thread onplayerspawned();
            player thread initmenu();
        }
        else if(player is_bot())
        {
            player thread onbotspawned();
        }
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(self.first)
        {
            self freezecontrols(false);
            self iprintln("Press [{+speed_throw}] & [{+actionslot 1}] to ^1Open Menu!^7");
        }
    }
}

onBotSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(self.first)
        {
            self.first = false;
        }
    }
}