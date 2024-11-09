#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

#include scripts\mp\menu;

createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
    textElem = CreateFontString( font, fontscale );
    textElem setPoint( align, relative, x, y );
    textElem.sort = sort;
    textElem.type = "text";
    textElem setText(text);
    textElem.color = color;
    textElem.alpha = alpha;
    textElem.glowColor = glowColor;
    textElem.glowAlpha = glowAlpha;
    textElem.hideWhenInMenu = true;
    textElem.foreground = true;
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, alpha, sorting, shadero)
{
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    if ( !level.splitScreen )
    {
        barElemBG.x = -2;
        barElemBG.y = -2;
    }
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.color = color;
    if(isDefined(alpha))
        barElemBG.alpha = alpha;
    else
        barElemBG.alpha = 1;
    barElemBG setShader( shadero, width , height );
    barElemBG.hidden = false;
    barElemBG.sort = sorting;
    barElemBG setPoint(align,relative,x,y);
    barElemBG.hidewheninmenu = true;
    return barElemBG;
}

addMenu(menu, title, parent)
{
    self.menu.text[menu] = [];
    self.menu.title[menu] = title;
    self.menu.parent[menu] = parent;
}

add_option(menu, text, func, input)
{
    index = self.menu.text[menu].size;
    self.menu.text[menu][index] = text;
    self.menu.func[menu][index] = func;
    self.menu.input[menu][index] = input;
}

executeFunction(f, i1, i2) //panela
{ 
    if(isDefined(i2))
        return self thread [[f]](i1, i2);
    else if(isDefined(i1))
        return self thread [[f]](i1);

    return self thread [[f]]();
}

affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
    
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}

test()
{
    self iprintln("Placeholder");
}