//
//  UIView+ActivityIndicator.h
//
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"

#import "LoadingHUDView.h"

#import "ToolTipView.h"

#import "BBTipView.h"

#import "UIView+Additions.h"

#define activityViewTag                0x98751234
#define hudViewTag                     0x98751235
#define toolViewTag                    0x98751255

@interface UIView (UIViewUtils) 

- (void)showActivityViewAtCenter;

- (void)showActivityViewAtCenter:(NSString*)indiTitle;

- (void)hideActivityViewAtCenter;

- (LoadingHUDView *)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style;

- (LoadingHUDView *)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style title:(NSString*)indiTitle;

- (LoadingHUDView *)getActivityViewAtCenter;



- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y;

- (void)showTipViewAtCenter:(NSString*)indiTitle;
- (void)showTipViewAtCenter:(NSString*)indiTitle timer:(int)aTimer;
- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message posY:(CGFloat)y;
- (void)showTipViewAtCenter:(NSString *)indiTitle message:(NSString *)message;

- (void)hideTipView;

- (BBTipView *)getTipView;



- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle;
- (void)hideHUDIndicatorViewAtCenter;
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)getHUDIndicatorViewAtCenter;


- (UIView *)viewWithTagNotDeepCounting:(NSInteger)tag;

@end


