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
		goingUp = true;
		[layer addChild:self.sprite z:10 tag:thetag];
		[self run];
	}
	return self;
}

-(void) startingUp {
	goingUp = true;
}

-(void) startingDown {
	goingUp = false;
}

-(bool) isGoingUp {
	return goingUp;
}

-(void) appear {
	NSAutoreleasePool *autopool = [[NSAutoreleasePool alloc] init];
	int r = [self getRandomY];
	// and we run a new action
	float duration = ((r+200) * 0.017);
	id theaction = [CCSequence actions:
				 [CCCallFunc actionWithTarget:self selector:@selector(startingUp)],
				 [CCMoveTo actionWithDuration:duration position:ccp( X, r)],
				 [CCCallFunc actionWithTarget:self selector:@selector(startingDown)],
				 [CCMoveTo actionWithDuration:duration position:ccp( X, -120)],
				 nil ];
	
	[self.sprite runAction: theaction];
	
	
	//[self.sprite runAction: [CCMoveTo actionWithDuration:0.3 position:ccp( X, r)]];
	//self.sprite.position = ccp( X, r);
	[NSThread sleepForTimeInterval:duration*(2.01f)];
	[NSThread sleepForTimeInterval:((random()%70) * 0.1f)];
	//sleep([self getRandomHoldTime]);
	

	[NSThread detachNewThreadSelector:@selector(appear) toTarget:self withObject:nil];
	[autopool drain];
	
}


-(int) getRandomY {
	//return (random()%300)-(150.0f);
	return 150.0f;//uncomment to try alternate game style with full height platforms all the time
}

-(void) run{
	[NSThread detachNewThreadSelector:@selector(appear) toTarget:self withObject:nil];
}

@end
