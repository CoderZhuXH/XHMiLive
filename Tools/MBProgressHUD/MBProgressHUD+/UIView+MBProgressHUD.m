//
//  UIView+MBProgressHUD.m
//  Logistics
//
//  Created by xiaohui on 16/4/13.
//  Copyright © 2016年 qiantou. All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import "MBProgressHUD.h"

@implementation UIView (MBProgressHUD)

-(void)showHUD
{
    [UIView showIn:self];
}
-(void)showHUDAndText:(NSString *)text
{
    [UIView showIn:self text:text];
}
-(void)showText:(NSString *)text
{
    MBProgressHUD *hud = [UIView showIn:self];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
}
-(void)hideHUD
{
    [UIView hideAllIn:self];
}

#pragma mark-Private
+ (MBProgressHUD *)showIn:(UIView *)view
{
    return [MBProgressHUD showIn:view enabled:NO];//可触控
}
+(MBProgressHUD *)showIn:(UIView *)view text:(NSString *)text
{
    MBProgressHUD *hud = [UIView showIn:view];
    hud.labelText =text;
    return hud;
}
+ (MBProgressHUD *)showIn:(UIView *)view enabled:(BOOL)enabled
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = enabled;
    return hud;
}
+(BOOL)hideAllIn:(UIView *)view
{
    return [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
