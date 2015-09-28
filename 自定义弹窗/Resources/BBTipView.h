//
//  BBTipView.h
//  BlueBoxDemo
//
//  Created by 刘坤 on 12-7-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      BBTipView
 @abstract    提示信息的view
 @author      liukun
 @version     v1.0.001  12-8-29
 */
#import <UIKit/UIKit.h>
#import "SNDefines.h"

#define BBTipLabelMaxWidth      160.0f
#define BBTipTitleMaxWidth      200.0f
#define BBTipPosYGoldPoint      0

@interface BBTipView : UIView
{
    @private
    UILabel *_label;
    NSTimer *_dlgTimer;
    UIView  *_fatherView;
    CGFloat _showTime;
    NSString *_labelText;
    CGFloat _posY;
    BOOL    _dimBackground;
}

/*!
 @property      showTime
 @abstract      展示的时间，可设置
 */
@property (nonatomic, assign) CGFloat showTime;

/*!
 @property      dimBackground
 @abstract      是否显示背景渐变色
 */
@property (nonatomic, assign) BOOL dimBackground;

/*!
 @method        initWithView:message:posY:
 @abstract      初始化方法
 @param         view  所在的view
 @param         message  展示内容
 @param         posY  离superView顶部的距离
 @result        BBTipView的对象
 */
- (id)initWithView:(UIView *)view message:(NSString *)message posY:(CGFloat)posY;


- (id)initWithView:(UIView *)view title:(NSString *)title message:(NSString *)message posY:(CGFloat)posY;

/*!
 @method        show
 @abstract      弹出
 */
- (void)show;

/*!
 @method        dismiss:
 @abstract      消失
 @param         animation 消失时是否使用动画
 */
- (void)dismiss:(BOOL)animation;

@end
