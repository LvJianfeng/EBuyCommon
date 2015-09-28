//
//  BBAlertView.h
//  BlueBoxDemo
//
//  Created by 刘坤 on 12-6-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      BBAlertView
 @abstract    自定义的AlertView
 @author      刘坤
 @version     v2.0  12-11-5
 @discussion  这是一个自定义的AlertView，类似于系统的UIAlertView,好处是可以自定义UI,
              1、实现时采用了新创建的window, 可使改控件不至于被其他view挡住。
              2、有一个保存alertView的栈，可同时弹出多个alertView，切不会因此重叠
              3、12-11-5 ,添加字段判断在确定后是否应该消失
              4、12-11-15, 添加可以设置文本对齐方式的属性
              5、12-11-17, 添加大数据量文本的兼容
              6、13-01-15, 添加NSObject注入方法
 */

#import <UIKit/UIKit.h>

@interface NSObject (BBAlert)

- (void)alertCustomDlg:(NSString *)message;

- (void)dismissAllCustomAlerts;

@end

/*!
 @enum      BBAlertViewStyle
 @abstract  alertView的style，通过style来确定UI, 现在只有两种UI
 */
typedef enum {
    BBAlertViewStyleDefault,        //苏宁ebuy里面用
    BBAlertViewStyle1,              //图书里面用的
    BBAlertViewStyleCustomView,     //可放入自定义的view
    BBAlertViewStyleLottery,        //彩票里面使用
    BBAlertViewStyleMessageFilter   //精准营销
}BBAlertViewStyle;

#if NS_BLOCKS_AVAILABLE
typedef void (^BBBasicBlock)(void);
#endif

@protocol BBAlertViewDelegate;

@interface BBAlertView : UIView
{
@private
    id <BBAlertViewDelegate> __weak _delegate;
    UILabel   *_titleLabel;
    UILabel   *_bodyTextLabel;
    UITextView *_bodyTextView;
    UIView    *_customView;
    UIView    *_contentView;
    UIView    *_backgroundView;
    BOOL    _visible;
    BOOL    _dimBackground;
    UIInterfaceOrientation _orientation;
    BBAlertViewStyle   _style;
#if NS_BLOCKS_AVAILABLE
    BBBasicBlock    _cancelBlock;
    BBBasicBlock    _confirmBlock;
#endif
}

/*!
 是否正在显示
 */
@property (nonatomic, readonly, getter=isVisible) BOOL visible;

/*!
 背景是否有渐变背景, 默认YES
 */
@property (nonatomic, assign) BOOL dimBackground;       //是否渐变背景，默认YES

/*!
 背景视图，覆盖全屏的，默认nil
 */
@property (nonatomic, strong) UIView *backgroundView;   //背景view, 可无
@property (nonatomic, assign) BBAlertViewStyle style;

/*!
 在点击确认后,是否需要dismiss, 默认YES
 */
@property (nonatomic, assign) BOOL shouldDismissAfterConfirm;

/*!
 文本对齐方式
 */
@property (nonatomic, assign) UITextAlignment contentAlignment;


@property (nonatomic, weak) id<BBAlertViewDelegate> delegate;

/*!
 @abstract      点击取消按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击取消后执行的程序块
 */
- (void)setCancelBlock:(BBBasicBlock)block;

/*!
 @abstract      点击确定按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击确定后执行的程序块
 */
- (void)setConfirmBlock:(BBBasicBlock)block;

/*!
 @abstract      初始话方法，默认的style：BBAlertViewStyleDefault
 @param         title  标题
 @param         message  内容
 @param         delegate  代理
 @param         cancelButtonTitle  取消按钮title
 @param         otherButtonTitle  其他按钮，如确定
 @result        BBAlertView的对象
 */
- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message
           delegate:(id <BBAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitle;

/*!
 @abstract      user this to init with content view
 */
- (id)initWithContentView:(UIView *)contentView;

/*!
 @abstract      初始话方法，默认的style：BBAlertViewStyleDefault
 @param         style  UI类型
 @param         title  标题
 @param         message  内容
 @param         customView 自定义的view,位于内容和button的中间（不常用），一般设为nil
 @param         delegate  代理
 @param         cancelButtonTitle  取消按钮title
 @param         otherButtonTitle  其他按钮，如确定
 @result        BBAlertView的对象
 */
- (id)initWithStyle:(BBAlertViewStyle)style
              Title:(NSString *)title 
            message:(NSString *)message
         customView:(UIView *)customView
           delegate:(id <BBAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitle;

/*!
 @abstract      弹出
 */
- (void)show;


- (void)dismiss;

@end

/*********************************************************************/

@protocol BBAlertViewDelegate <NSObject>

@optional

- (void)alertView:(BBAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)didRotationToInterfaceOrientation:(BOOL)Landscape view:(UIView*)view alertView:(BBAlertView *)aletView;
@end
