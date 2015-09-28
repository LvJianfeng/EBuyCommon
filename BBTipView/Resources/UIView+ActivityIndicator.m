//
//  UIView+ActivityIndicator.m
//

#import "UIView+ActivityIndicator.h"



@implementation UIView (UIViewUtils)




- (LoadingHUDView*)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style title:(NSString*)indiTitle
{
   
 	
	LoadingHUDView *HUD = [[LoadingHUDView alloc] initWithTitle:L(indiTitle)];
	
	
	
	
	HUD.tag = activityViewTag;
	

	
    [self addSubview:HUD];
	
	
	
	HUD.top = (self.height - HUD.height)/2;
	

    HUD.left = (self.width - HUD.width)/2;
	
    
    return HUD;
}


- (LoadingHUDView*)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style
{
	return [self createActivityViewAtCenter:style title:@"Loading..."];
}



- (LoadingHUDView*)getActivityViewAtCenter
{
    UIView* view = [self viewWithTagNotDeepCounting:activityViewTag];
    if (view != nil && [view isKindOfClass:[LoadingHUDView class]]){
        return (LoadingHUDView*)view;
    }
    else {
        return nil;
    }
}

- (void)showActivityViewAtCenter
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
    if (activityView == nil){
		
        activityView = [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge title:@"Loading..."];
    
	}
	
	[activityView startAnimating];
    
}

- (void)showActivityViewAtCenter:(NSString*)indiTitle
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
    if (activityView == nil){
		
        activityView = [self createActivityViewAtCenter:UIActivityIndicatorViewStyleWhiteLarge title:indiTitle];
		
	}
	
	[activityView startAnimating];
    
}

- (void)hideActivityViewAtCenter
{
    LoadingHUDView* activityView = [self getActivityViewAtCenter];
	
	[activityView removeFromSuperview];  
	

	
           
}


- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:y];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView show];

	
}

- (void)showTipViewAtCenter:(NSString*)indiTitle{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    //默认posY为0,即黄金分割处
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:0];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView show];
	
}
- (void)showTipViewAtCenter:(NSString*)indiTitle timer:(int)aTimer
{//规定时间
    BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    //默认posY为0,即黄金分割处
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:0];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    activityView.showTime = aTimer;
    [activityView show];
}
- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message posY:(CGFloat)y
{
    BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
	activityView = [[BBTipView alloc] initWithView:self title:indiTitle message:message posY:y];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView show];
}

- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message
{
    BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
    //默认posY为0,即黄金分割处
	activityView = [[BBTipView alloc] initWithView:self title:indiTitle message:message posY:0];
    activityView.layer.zPosition = 11;
    activityView.tag = toolViewTag;
    
    [activityView show];
}


- (void)hideTipView{
	
	
	BBTipView *activityView = [self getTipView];
	
	[activityView dismiss:YES];  
		
}


- (BBTipView *)getTipView
{
    UIView* view = [self viewWithTagNotDeepCounting:toolViewTag];
	
    if (view != nil && [view isKindOfClass:[BBTipView class]]){
		
        return (BBTipView *)view;
		
    }
    else {
        return nil;
    }
}


#pragma mark -
#pragma mark hud

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    if (hud == nil){
		
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:0];
        [hud show:YES];
	}else{
        hud.labelText = indiTitle;
    }
	
	
}

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    if (hud == nil){
		
        hud = [self createHUDIndicatorViewAtCenter:indiTitle yOffset:y];
        [hud show:YES];
	}else{
        hud.labelText = indiTitle;
    }
	
	
}

- (void)hideHUDIndicatorViewAtCenter
{
    MBProgressHUD *hud = [self getHUDIndicatorViewAtCenter];
	
    [hud hide:YES];
}

- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.layer.zPosition = 10;
    hud.yOffset = y;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = indiTitle;
    [self addSubview:hud];
    hud.tag = hudViewTag;
    return hud;
}

- (MBProgressHUD *)getHUDIndicatorViewAtCenter
{
    UIView *view = [self viewWithTagNotDeepCounting:hudViewTag];
	
    if (view != nil && [view isKindOfClass:[MBProgressHUD class]]){
		
        return (MBProgressHUD *)view;
    }
    else 
    {
        return nil;
    }
}

- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag
{
    for (UIView *view in self.subviews)
    {
        if (view.tag == tag) {
            return view;
            break;
        }
    }
    return nil;
}

@end