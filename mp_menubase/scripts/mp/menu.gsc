#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

#include scripts\mp\utils;

initMenu()
{
    self.menu = spawnStruct();
    self.hud = spawnStruct();
    self.menu.opened = false;
    self thread menuButtons();
}

menuButtons()
{
    level endon("game_ended");
    for(;;)
    {
        if(!self.menu.opened)
        {
            if(self adsbuttonpressed() && self ActionSlotOneButtonPressed())
            {
                self.menu.opened = true;
                self thread menuHud();
                self _loadMenu("main");
                wait 0.2;
            }
        }
        else
        {
            if(self ActionSlotOneButtonPressed())
            {
                self.scroller--;
                self scrollUpdate();
                wait 0.1;
            }
            if(self ActionSlotTwoButtonPressed())
            {
                self.scroller++;
                self scrollUpdate();
                wait 0.1;
            }
            if(self UseButtonPressed())
            {
                self executeFunction(self.menu.func[self.menu.currentmenu][self.scroller], self.menu.input[self.menu.currentmenu][self.scroller]);
                self _loadMenu(self.menu.currentmenu);
                wait 0.3;
            }
            if(self MeleeButtonPressed())
            {
                if(self.menu.parent[self.menu.currentmenu] == "exit")
                {
                    self.menu.opened = false;
                    self thread destroyAllText();
                    self thread destroyHud();
                }
                else
                {
                    self _loadMenu(self.menu.parent[self.menu.currentmenu]);
                }
                wait 0.3;
            }
        }
        wait 0.05;
    }
    wait 0.05;
}

_loadMenu(menu)
{
    self thread menuOptions();
    self.lastscroll[self.menu.currentmenu] = self.scroller;
    self destroyAllText();
    self.menu.currentmenu = menu;

    if(!isdefined(self.lastscroll[self.menu.currentmenu]))
        self.scroller = 0;
    else
        self.scroller = self.lastscroll[self.menu.currentmenu];

    self createMenuText();
    self scrollUpdate();
    self updateBG();
}

scrollUpdate()
{
    if(self.scroller < 0)
		self.scroller = self.menu.text[self.menu.currentmenu].size - 1;
	if(self.scroller > self.menu.text[self.menu.currentmenu].size - 1)
		self.scroller = 0;
    
    foreach(option in self.hud.text)
        option.color = (1, 1, 1);
    
    self.hud.text[self.scroller].color = (1, 0, 0);
}

menuHud()
{
    if(!isdefined(self.pers["textypos"]))
        self.pers["textypos"] = -60;

    self.hud.title = createText("default", 1, "CENTER", "CENTER", 240, -75, 0, (1, 1, 1), 1, (0, 0, 0), 0, "Jelq'n & Jonk'n");
    self.hud.background = createRectangle("TOP", "CENTER", 241, -80, 127, 30, (0, 0, 0), 0.5, 0, "white");

    self.hud.topline = createRectangle("CENTER", "CENTER", 241, -80, 127, 1, (1, 0, 0), 1, 0, "white");
    self.hud.topline.foreground = true;
    self.hud.middleline = createRectangle("CENTER", "CENTER", 241, -65, 127, 1, (1, 0, 0), 1, 0, "white");
    self.hud.middleline.foreground = true;
    self.hud.bottomline = createRectangle("CENTER", "CENTER", 241, -55, 127, 1, (1, 0, 0), 1, 0, "white");
    self.hud.bottomline.foreground = true;
}

destroyHud()
{
    self.hud.title destroy();
    self.hud.background destroy();
    self.hud.topline destroy();
    self.hud.middleline destroy();
    self.hud.bottomline destroy();
}

updateBG()
{
    amt = self.menu.text[self.menu.currentmenu].size;
    self.hud.background scaleovertime(0.1, 127, 19 + (11 * amt));
    self.hud.bottomline affectElement("y", 0.1, -63 + (11 * amt));
}

createMenuText()
{
    self.hud.text = [];
    for(i = 0; i < self.menu.text[self.menu.currentmenu].size; i++)
    {
        self.hud.text[i] = createText("objective", 1, "LEFT", "CENTER", 178, self.pers["textypos"] + (11 * i), 0, (1, 1, 1), 1, (0, 0, 0), 0, self.menu.text[self.menu.currentmenu][i]);
    }
}

destroyAllText()
{
    if(isdefined(self.hud.text))
    {
        for(i = 0; i < self.hud.text.size; i++)
        {
            self.hud.text[i] destroy();
        }
    }
}

menuOptions()
{
    self addMenu("main", "Main Menu", "exit");
    self add_option("main", "Sub Menu 1", ::_loadmenu, "s1");

    self addMenu("s1", "Sub Menu 1", "main");
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
    self add_option("s1", "Test Option1", ::test);
}