//
//  SNGraphics.h
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "SNDefines.h"

//画四角圆角
SN_EXTERN void CGContextAddRoundCornerToPath(CGContextRef context, CGRect rect, CGFloat cornerRadius);
//画圆形区域
SN_EXTERN void CGContextAddCircleRectToPath(CGContextRef context, CGRect rect);

SN_EXTERN CGRect CGRectFromSize(CGSize size);
SN_EXTERN CGPoint CGRectGetCenter(CGRect rect);

@interface SNGraphics : NSObject

@end
