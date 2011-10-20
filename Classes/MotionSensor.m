//
//  MotionSensor.m
//  Shion Touch
//
//  Created by Chris Karr on 4/23/10.
//  Copyright 2010 CASIS. All rights reserved.
//

#import "MotionSensor.h"


@implementation MotionSensor

@synthesize level;

- (NSString *) type
{
	return @"Motion Sensor";
}

- (NSString *) description
{
	if (level == nil)
		return @"Unknown";
	else if ([level intValue] > 0)
		return @"Currently Observing Motion";
	else
		return @"No Motion Observed";
}

- (NSString *) shortDescription
{
	if (level == nil)
		return @"Unknown";
	else if ([level intValue] > 0)
		return @"Motion Detected";
	else
		return @"No Motion";
}

- (UIColor *) color
{
	return [UIColor colorWithRed:0.725 green:0.961 blue:0.094 alpha:1.0];
}

- (CGFloat) intensity
{
	if ([self level] == nil)
		return 0.0;
	else if ([[self level] integerValue] > 0)
		return 1.0;
	else
		return 0.0;
}

- (void) addEvent:(NSDictionary *) event
{
	NSString * eventType = [event valueForKey:@"t"];
	 
	if ([eventType isEqual:@"device"])
	{
		id value = [event valueForKey:@"v"];

		if (![value isKindOfClass:[NSNumber class]])
			value = [NSNumber numberWithDouble:[value doubleValue]];
	
		self.level = value;
	 }
	
	[super addEvent:event];
}

- (id) initWithXmlElement:(DDXMLElement *) element
{
	if (self = [super initWithXmlElement:element])
	{
		NSString * remoteLevel = [[element attributeForName:@"lv"] stringValue];
		
		if (remoteLevel != nil)
		{
			NSInteger levelInteger = [remoteLevel integerValue];
			
			self.level = [NSNumber numberWithInteger:levelInteger];
		}
	}
	
	return self;
}


@end
