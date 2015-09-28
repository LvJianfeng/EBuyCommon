//
//  SNGraphics.m
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "SNGraphics.h"

void CGContextAddRoundCornerToPath(CGContextRef context, CGRect rect, CGFloat cornerRadius)
{
    CGContextSaveGState(context);
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextMoveToPoint(context, minX, midY);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, cornerRadius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, cornerRadius);
    CGContextClosePath(context);
    
    CGContextRestoreGState(context);
}

void CGContextAddCircleRectToPath(CGContextRef context, CGRect rect)
{
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextSetShouldAntialias(context, true);
	CGContextSetAllowsAntialiasing(context, true);
	CGContextAddEllipseInRect(context, rect);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

CGRect CGRectFromSize( CGSize size )
{
    return CGRectMake( 0, 0, size.width, size.height );
};

CGPoint CGRectGetCenter( CGRect rect )
{
    return CGPointMake( CGRectGetMidX( rect ), CGRectGetMidY( rect ) );
};

@implementation SNGraphics

@end
