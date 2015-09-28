//
//  ToolTipView.m
//  Wingletter5
//
//  Created by Hubert Ryan on 11-6-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToolTipView.h"

#define  LABELFONTSIZE   16.0f

#define MARGIN 20.0

#define PADDING 4.0

#define PI 3.14159265358979323846

@implementation ToolTipView

@synthesize labelText = _labelText;

@synthesize labelFont;

@synthesize xOffset;

@synthesize yOffset;

@synthesize autoHideInterval;

@synthesize delegate = delegate_;

@synthesize dlgTimer = dlgTimer_;

- (void)dealloc {
    TT_RELEASE_SAFELY(labelFont);
    TT_RELEASE_SAFELY(_labelText);
    TTVIEW_RELEASE_SAFELY(bkView);
    TTVIEW_RELEASE_SAFELY(label);
    TT_INVALIDATE_TIMER(dlgTimer_);
}


- (id)initWithWindow:(UIWindow *)window {
	
    return [self initWithView:window];
	
}


- (id)initWithView:(UIView *)view  {
	
	
	if (!view) {
		[NSException raise:@"MBProgressHUDViewIsNillException" 
					format:@"The view used in the MBProgressHUD initializer is nil."];
	}
	
	
	
	return [self initWithFrame:view.bounds];
	
}



- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
        self.labelFont = [UIFont boldSystemFontOfSize:LABELFONTSIZE];
        
        self.xOffset = 0.0;
		
        self.yOffset = 0.0;
		
		self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		
        // Transparent background
        self.opaque = NO;
		
        self.backgroundColor = [UIColor clearColor];
		
		
        label = [[UILabel alloc] initWithFrame:self.bounds];
		
		label.lineBreakMode = UILineBreakModeWordWrap;
		
		label.adjustsFontSizeToFitWidth = NO;
		
		label.numberOfLines = 0;
		
        bkView =  [[UIView alloc] initWithFrame:self.bounds];
		
    }
    return self;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
	
    CGRect frame = self.bounds;
		
	
    // Add label if label text was set
    if (nil != self.labelText) {
		
		CGSize dims = [self.labelText sizeWithFont:self.labelFont constrainedToSize:CGSizeMake(280, 1000.0f) lineBreakMode:NSLineBreakByWordWrapping];
		
        // Compute label dimensions based on font metrics if size is larger than max then clip the label width
        float lHeight = dims.height;
        float lWidth = dims.width;

		float bkHeight = dims.height+45;
		
        float bkWidth = dims.width+35;
		
		if(bkWidth>=300){
			
			bkWidth =300;
		}
		
		// Draw rounded HUD bacgroud rect
		CGRect bkFrame = CGRectMake(((frame.size.width - bkWidth) / 2) ,
							 ((frame.size.height - bkHeight) / 2)+self.yOffset , bkWidth, bkHeight);
        

        if(self.yOffset>0){
            
            bkFrame = CGRectMake(((frame.size.width - bkWidth) / 2) ,
                                        self.yOffset , bkWidth, bkHeight);
        }
        
        
		bkView.frame = bkFrame;
		
		bkView.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
		
		[bkView.layer setCornerRadius:10.0];
        
		[self addSubview:bkView];
		
        label.font = self.labelFont;

        label.textAlignment = UITextAlignmentCenter;
		
        label.opaque = NO;
		
        label.backgroundColor = [UIColor clearColor];
		
        label.textColor = [UIColor whiteColor];
		
        label.text = self.labelText;
		
        // Update HUD size
        if (self.width < (lWidth + 2 * MARGIN)) {
			
            self.width = lWidth + 2 * MARGIN;
			
        }
        self.height = self.height + lHeight + PADDING;
		
        // Set the label position and dimensions
        CGRect lFrame = CGRectMake(floor((frame.size.width - lWidth) / 2) + xOffset,
                                  (frame.size.height - lHeight)/2+self.yOffset,
                                   lWidth, lHeight);
        
        
        if(self.yOffset>0){
            
            lFrame = CGRectMake(floor((frame.size.width - lWidth) / 2) + xOffset,
                                self.yOffset+25,
                                lWidth, lHeight);

        }
        
        label.frame = lFrame;//CGRectMake(50,100,100,200);
		
        [self addSubview:label];
		
	}
	
	
	if (autoHideInterval > 0.0f) {
        self.dlgTimer = [NSTimer scheduledTimerWithTimeInterval:autoHideInterval 
                                                         target:self 
                                                       selector:@selector(Dismiss)
                                                       userInfo:nil 
                                                        repeats:NO];
    }
}

- (void)Dismiss{
	
	
	CGRect frame = self.frame;
	
	frame.origin.y -= 10.0;
	
	[UIView beginAnimations:nil context:nil];
	
	self.alpha = 0.0;
	
	self.frame = frame;
	
	[UIView setAnimationDelegate:self];
	
	[UIView setAnimationDidStopSelector:@selector(dismissAnimationDidStop:finished:context:)];
	
	[UIView commitAnimations];
	
	
	
}

- (void)dismissAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
	[self removeFromSuperview];
    
    TT_INVALIDATE_TIMER(dlgTimer_);
    
    if ([delegate_ respondsToSelector:@selector(tipViewWasHidden:)]) {
        [delegate_ tipViewWasHidden:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
	
	[self Dismiss];
}


- (void)drawRect2:(CGRect)rect {
    // Center HUD
    CGRect allRect = self.bounds;
	
	CGSize dims = [self.labelText sizeWithFont:self.labelFont];
	
	float lHeight = dims.height+40;
	float lWidth = dims.width+ +50;
	
	

    // Draw rounded HUD bacgroud rect
    boxRect = CGRectMake(((allRect.size.width - lWidth) / 2) ,
                                ((allRect.size.height - lHeight) / 2) , lWidth, lHeight);
	
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
	
    [self fillRoundedRect:boxRect inContext:ctxt];
	
	
	CGRect lFrame = CGRectMake(floor((allRect.size.width - dims.width) / 2) + xOffset,
							  boxRect.origin.y+ (boxRect.size.height - dims.height)/2,
							   dims.width, dims.height);
	
	
	label.frame = lFrame;
	

}


- (void)fillRoundedRect:(CGRect)rect inContext:(CGContextRef)context {
	
    float radius = 10.0f;
	
    CGContextBeginPath(context);
    CGContextSetGrayFillColor(context, 0.0, 0.9);
    CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

@end
