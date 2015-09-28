//
//  UIImage-Extensions.h
//  WingLetter
//
//  Created by zhaojw on 10-8-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
/*!
 @header      UIImage-Extensions
 @abstract    UIImage的类别
 @author      刘坤添加注释
 @version     v1.0  12-8-29
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

@interface UIImage (CS_Extensions)

/*!
 @abstract      从资源文件中获取的图像,功能类似于UIImage
 @discussion    返回的是alloc对象，需要在外部release
 @param         filename  文件名称
 @result        retainCount为1的UIImage
 */
+ (UIImage *)newImageFromResource:(NSString *)filename;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)resizeImage:(CGSize)targetSize;
- (UIImage *)fixOrientation:(UIImage *)aImage;

/*!
 @abstract      获取一个可拉伸的UIImage
 @param         imageName  图片名称
 @result        UIImage autorelease的对象
 */
+ (UIImage *)streImageNamed:(NSString *)imageName;
+ (UIImage *)streImageNamed:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end
