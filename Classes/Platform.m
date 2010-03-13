//
//  Platform.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/8/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "Platform.h"


@implementation Platform

@synthesize sprite;

-(id) initWithXPosition: (float) xpos TargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag{
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		self.sprite = [CCSprite spriteWithFile:@"platform.png"];
		self.sprite.position = ccp( xpos, -120);
		X = xpos;
		[layer addChild:self.sprite z:10 tag:thetag];
		[self run];
	}
	return self;
}

-(void) appear {
	NSAutoreleasePool *autopool = [[NSAutoreleasePool alloc] init];
	int r = [self getRandomY];
	// and we run a new action
	id theaction = [CCSequence actions:
				 [CCMoveTo actionWithDuration:((r+200) * 0.01) position:ccp( X, r)],
				 [CCMoveTo actionWithDuration:((r+200) * 0.01) position:ccp( X, -120)],
				 //[CCCallFunc actionWithTarget:self selector:@selector(chopperLand)],
				 nil ];
	
	[self.sprite runAction: theaction];
	
	
	//[self.sprite runAction: [CCMoveTo actionWithDuration:0.3 position:ccp( X, r)]];
	//self.sprite.position = ccp( X, r);
	sleep([self getRandomHoldTime]);
	

	[NSThread detachNewThreadSelector:@selector(appear) toTarget:self withObject:nil];
	[autopool release];
	
}

-(int) getRandomHoldTime {
	// 7 is the minimum
	return (random()%2)+7;
}

-(int) getRandomY {
	return (random()%300)-(150.0f);
}

-(void) run{
	[NSThread detachNewThreadSelector:@selector(appear) toTarget:self withObject:nil];
}

@end
