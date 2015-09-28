//
//  ToolTipView.h
//  Wingletter5
//
//  Created by Hubert Ryan on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
