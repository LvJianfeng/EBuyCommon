//
//  ToolTipView.h
//  Wingletter5
//
//  Created by Hubert Ryan on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Additions.h"
#import "UIColor+Helper.h"

#if !__has_feature(objc_arc)

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
CFRelease(__REF); \
__REF = nil;\
}\
}

//view安全释放
#undef TTVIEW_RELEASE_SAFELY
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
CFRelease(__REF);\
__REF = nil;\
}\
}

//释放定时器
#undef TT_INVALIDATE_TIMER
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
[__TIMER release];\
__TIMER = nil;\
}

#else

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}

#endif

@protocol ToolTipViewDelegate;

@interface ToolTipView : UIView {

    @private
	UILabel *label;
	
	NSString *_labelText;
	
	float yOffset;
	
    float xOffset;
	
	UIFont *labelFont;
	
	CGRect boxRect;
	
	UIView *bkView;
	
	CGFloat   autoHideInterval;
    
    id<ToolTipViewDelegate> __weak delegate_;
    
    NSTimer *dlgTimer_;
}



@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, strong) UIFont *labelFont;

@property (nonatomic, assign) float yOffset;

@property (nonatomic, assign) float xOffset;

@property (nonatomic, assign) CGFloat autoHideInterval;

@property (nonatomic, weak) id<ToolTipViewDelegate> delegate;

@property (nonatomic, strong) NSTimer *dlgTimer;

- (id)initWithView:(UIView *)view ;

- (void)fillRoundedRect:(CGRect)rect inContext:(CGContextRef)context ;

@end


@protocol ToolTipViewDelegate <NSObject>

- (void)tipViewWasHidden:(ToolTipView *)tipView;

@end
