//
//  NSStringAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "NSString+Additions.h"
//#import "RegexKitLite.h"
//#import "SNSwitch.h"
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
@implementation NSString (Additions)

+ (NSString *)generateGuid {
	CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString	*uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
	CFRelease(uuidObj);
	return uuidString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
	NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < self.length; ++i) {
		unichar c = [self characterAtIndex:i];
		if (![whitespace characterIsMember:c]) {
			return NO;
		}
	}
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
	return !self.length ||
	![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [query keyEnumerator]) {
		NSString* value = [query objectForKey:key];
		value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
		value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
	
	NSString* params = [pairs componentsJoinedByString:@"&"];
	if ([self rangeOfString:@"?"].location == NSNotFound) {
		return [self stringByAppendingFormat:@"?%@", params];
	} else {
		return [self stringByAppendingFormat:@"&%@", params];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSComparisonResult)versionStringCompare:(NSString *)other {
	NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
	NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
	
	// The parts before the "a"
	NSString *oneMain = [oneComponents objectAtIndex:0];
	NSString *twoMain = [twoComponents objectAtIndex:0];
	
	// If main parts are different, return that result, regardless of alpha part
	NSComparisonResult mainDiff;
	if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
		return mainDiff;
	}
	
	// At this point the main parts are the same; just deal with alpha stuff
	// If one has an alpha part and the other doesn't, the one without is newer
	if ([oneComponents count] < [twoComponents count]) {
		return NSOrderedDescending;
	} else if ([oneComponents count] > [twoComponents count]) {
		return NSOrderedAscending;
	} else if ([oneComponents count] == 1) {
		// Neither has an alpha part, and we know the main parts are the same
		return NSOrderedSame;
	}
	
	// At this point the main parts are the same and both have alpha parts. Compare the alpha parts
	// numerically. If it's not a valid number (including empty string) it's treated as zero.
	NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
	NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
	return [oneAlpha compare:twoAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSString*)md5Hash 
//{
//	return [NSString md5HexDigest:self];
//}


- (CGSize)heightWithFont:(UIFont*)withFont 
                   width:(float)width 
               linebreak:(UILineBreakMode)lineBreakMode{
	
	CGSize suggestedSize = [self sizeWithFont:withFont constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:(NSLineBreakMode)lineBreakMode];
	
	return suggestedSize;
}

- (NSString *)replacedWhiteSpacsByString:(NSString *)replaceString{
    
    if (IsNilOrNull(self) || IsNilOrNull(replaceString) ) {
        return nil;
    }
    
    NSString *memberNameRegex = @"\\s+";
    
    NSString *replace = [self stringByReplacingOccurrencesOfString:memberNameRegex withString:replaceString options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
    
    return replace;
    
}

- (NSString *)URLEvalutionEncoding
{
    NSString * result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                     (CFStringRef)self,
                                                                                     NULL,
                                                                                     (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                     kCFStringEncodingUTF8 );
	return result;

}

//- (NSString *)queryStringNoEncodeFromDictionary:(NSDictionary *)dict
//{
//    return [NSString queryStringFromDictionary:dict addingPercentEscapes:NO];
//}

//- (NSString *)passport
//{
//    if ([SNSwitch isPassportLogin])
//    {
//        NSString *str = [NSString stringWithFormat:@"%@pp", [self copy]];
//        return str;
//    }
//    else
//    {
//        NSString *str = [self copy];
//        return str;
//    }
//}

@end
