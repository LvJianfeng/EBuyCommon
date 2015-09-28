//
//  BBTipView.m
//  BlueBoxDemo
//
//  Created by 刘坤 on 12-7-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BBTipView.h"

@interface BBTipView()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *fatherView;
@property (nonatomic, strong) NSTimer *dlgTimer;
@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy)   NSString *titleText;
@end

/*********************************************************************/

@implementation BBTipView
@synthesize label = _label;
@synthesize fatherView = _fatherView;
@synthesize dlgTimer = _dlgTimer;
@synthesize labelText = _labelText;
@synthesize showTime = _showTime;
@synthesize dimBackground = _dimBackground;

- (void)dealloc {
    TT_RELEASE_SAFELY(_label);
    TT_RELEASE_SAFELY(_fatherView);
    TT_INVALIDATE_TIMER(_dlgTimer);
    TT_RELEASE_SAFELY(_labelText);
    
    TT_RELEASE_SAFELY(_titleLabel);
    TT_RELEASE_SAFELY(_titleText);
}

#pragma mark -
#pragma mark tools


static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { // 1
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); // 2
    CGContextTranslateCTM (context, CGRectGetMinX(rect), // 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); // 4
    fw = CGRectGetWidth (rect) / ovalWidth; // 5
    fh = CGRectGetHeight (rect) / ovalHeight; // 6
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); // 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context); // 12
    CGContextRestoreGState(context); // 13
}

- (id)initWithView:(UIView *)view message:(NSString *)message posY:(CGFloat)posY
{
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.fatherView = view;
        self.labelText = message;
        _posY = posY;
        _dimBackground = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //每个字0.3s
        _showTime = [message length] * 0.3;
        _showTime = _showTime > 3 ? _showTime : 3;

    }
    return self;
}

- (id)initWithView:(UIView *)view title:(NSString *)title message:(NSString *)message posY:(CGFloat)posY
{
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.fatherView = view;
        self.labelText = message;
        self.titleText = title;
        _posY = posY;
        _dimBackground = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //每个字0.3s
        _showTime = ([message length] + [title length]) * 0.3;
        _showTime = _showTime > 3 ? _showTime : 3;

    }
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
        _label.font = [UIFont systemFontOfSize:17.0f];
        _label.textAlignment = UITextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)show
{
    [self.fatherView addSubview:self];
//    self.alpha = 0;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    self.alpha = 1;
//    [UIView commitAnimations];
    
    self.dlgTimer = [NSTimer scheduledTimerWithTimeInterval:_showTime
                                                     target:self 
                                                   selector:@selector(dismiss)
                                                   userInfo:nil 
                                                    repeats:NO];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         TT_INVALIDATE_TIMER(_dlgTimer);
                         [self removeFromSuperview];
                     }];
}

- (void)dismiss:(BOOL)animation
{
    if (animation) {
        [UIView animateWithDuration:0.2f
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             TT_INVALIDATE_TIMER(_dlgTimer);
                             [self removeFromSuperview];
                         }];
    }else{
        TT_INVALIDATE_TIMER(_dlgTimer);
        [self removeFromSuperview];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //无title
    if ([self.titleText length] == 0)
    {
        //计算文字的size
        CGSize labelSize = [_labelText sizeWithFont:self.label.font
                                  constrainedToSize:CGSizeMake(BBTipLabelMaxWidth, 1000)
                                      lineBreakMode:NSLineBreakByCharWrapping];
        CGSize maskSize = CGSizeMake(labelSize.width+40, labelSize.height+30);
        
        //计算框的center
        CGFloat centerY = 0;
        if (_posY)
        {
            centerY = _posY + maskSize.height;
        }
        else
        {
            //默认取黄金分割
            centerY = 0.382 * self.frame.size.height;
        }
        
        CGRect labelFrame = CGRectMake(self.frame.size.width/2-labelSize.width/2, centerY-labelSize.height/2, labelSize.width, labelSize.height);
        CGRect maskFrame = CGRectMake(self.frame.size.width/2-maskSize.width/2, centerY-maskSize.height/2, maskSize.width, maskSize.height);
        
        if (_dimBackground) {
            
            size_t gradLocationsNum = 2;
            CGFloat gradLocations[2] = {0.0f, 1.0f};
            CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.6f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGColorSpaceRelease(colorSpace);
            
            //Gradient center
            CGPoint gradCenter = CGPointMake(self.frame.size.width/2,  centerY);
            //Gradient radius
            //float gradRadius =  (self.bounds.size.height-_posY)*2;
            float gradRadius = 350;
            //Gradient draw
            CGContextDrawRadialGradient (context, gradient, gradCenter,
                                         0, gradCenter, gradRadius,
                                         kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
        }
        
        addRoundedRectToPath(context, maskFrame, 3.0f, 3.0f);
        
        CGFloat black[4] = {0.0, 0.0, 0.0, 0.7f};
        CGContextSetFillColor(context, black);
        CGContextFillPath(context);
        
        self.label.frame = labelFrame;
        self.label.text = _labelText;
        [self addSubview:self.label];
    }
    else
    {
        //title的size
        CGSize titleSize = CGSizeMake(BBTipTitleMaxWidth, 20);
        self.label.font = [UIFont systemFontOfSize:16.0f];
        //计算文字的size
        CGSize labelSize = [_labelText sizeWithFont:self.label.font
                                  constrainedToSize:CGSizeMake(BBTipTitleMaxWidth, 1000)
                                      lineBreakMode:NSLineBreakByCharWrapping];
        
        CGSize maskSize = CGSizeMake(BBTipTitleMaxWidth+40, titleSize.height+labelSize.height+30);
        
        //计算框的center
        CGFloat centerY = 0;
        if (_posY)
        {
            centerY = _posY + maskSize.height;
        }
        else
        {
            //默认取黄金分割
            centerY = 0.382 * self.frame.size.height;
        }
        
        CGRect maskFrame = CGRectMake(self.frame.size.width/2-maskSize.width/2, centerY-maskSize.height/2, maskSize.width, maskSize.height);
        CGRect titleFrame = CGRectMake(self.frame.size.width/2-titleSize.width/2, maskFrame.origin.y+13, titleSize.width, titleSize.height);
        CGRect labelFrame = CGRectMake(self.frame.size.width/2-labelSize.width/2, CGRectGetMaxY(titleFrame)+5, labelSize.width, labelSize.height);
        
        if (_dimBackground) {
            
            size_t gradLocationsNum = 2;
            CGFloat gradLocations[2] = {0.0f, 1.0f};
            CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.6f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
            CGColorSpaceRelease(colorSpace);
            
            //Gradient center
            CGPoint gradCenter = CGPointMake(self.frame.size.width/2,  centerY);
            //Gradient radius
            //float gradRadius =  (self.bounds.size.height-_posY)*2;
            float gradRadius = 350;
            //Gradient draw
            CGContextDrawRadialGradient (context, gradient, gradCenter,
                                         0, gradCenter, gradRadius,
                                         kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
        }
        
        addRoundedRectToPath(context, maskFrame, 3.0f, 3.0f);
        
        CGFloat black[4] = {0.0, 0.0, 0.0, 0.7f};
        CGContextSetFillColor(context, black);
        CGContextFillPath(context);
        
        self.titleLabel.text = _titleText;
        self.titleLabel.frame = titleFrame;
        [self addSubview:self.titleLabel];
        
        self.label.frame = labelFrame;
        self.label.text = _labelText;
        [self addSubview:self.label];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
