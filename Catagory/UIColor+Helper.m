//
//  UIColor+Helper.m
//  SuningEBuy
//
//  Created by song jun on 11/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (UIColor_Helper)

+ (UIColor *)uiviewBackGroundColor{
        
    return [UIColor colorWithRed:242.0/255.0
                           green:242.0/255.0
                            blue:242.0/255.0
                           alpha:1];
    
    
}

+ (UIColor*)navTintColor{
    
    UIColor *colors = RGBCOLOR(246, 242, 224);//RGBCOLOR(17, 181, 229);
    
    return colors;
}

//add by liukun

+ (UIColor *)skyBlueColor
{
    UIColor *skyBlue = RGBCOLOR(53, 79, 138);
    
    return skyBlue;
}

+ (UIColor *)darkRedColor
{
    UIColor *dardRedColor = RGBCOLOR(176, 44, 44);
    
    return dardRedColor;
}

+ (UIColor *)darkBlueColor
{
    UIColor *darkBlueColor = RGBCOLOR(30, 90, 164);
    
    return darkBlueColor;
}
+ (UIColor *)darkGrownColor{
    
    UIColor *darkGrownColor = RGBCOLOR(90, 60, 60);
    
    return darkGrownColor;
}

+ (UIColor*)flatTextColor{
    
    UIColor *colors = RGBCOLOR(99, 90, 78);
    
    return colors;
}

+ (UIColor*)darkTextColor{
    
    UIColor *colors = [UIColor colorWithRGBHex:0x313131];
    
    return colors;
}
+ (UIColor*)lightTextColor{
    
    UIColor *colors = RGBCOLOR(149, 129, 105);
    
    return colors;
}

+ (UIColor *)cellBackViewColor{
    
//    UIColor *colors = RGBCOLOR(250, 247, 237);
    UIColor *colors = [UIColor whiteColor];

    return colors;
}


/*---------------------------------------New  UI  Color------------------------------------------------*/


+ (UIColor *)light_Black_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0x313131];
    
    return colors;
}

+ (UIColor *)orange_Light_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0xfc7c26];
    
    return colors;
}

+ (UIColor *)orange_Red_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0xff4800];
    
    return colors;
}

+ (UIColor *)dark_Gray_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0x707070];
    
    return colors;
}

+ (UIColor *)light_Gray_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0xcbcaca];
    
    return colors;
}

+ (UIColor *)light_White_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0xffffff];
    
    return colors;
}

+ (UIColor *)btnTitleHotColor
{
    UIColor *colors = [UIColor colorWithRGBHex:0xfc7c26];
    
    return colors;
}

+ (UIColor *)btnTitleNormalColor
{
    UIColor *colors = [UIColor colorWithRGBHex:0x707070];
    
    return colors;
}

+ (UIColor *)cell_Back_Color
{
    UIColor *colors = [UIColor colorWithRGBHex:0xf7f7f8];
    
    return colors;
}

+ (UIColor *)view_Back_Color
{
    UIColor *colors = [self colorWithRGBHex:0xf2f2f2];
    
    return colors;
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end
