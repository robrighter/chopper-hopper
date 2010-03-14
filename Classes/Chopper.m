//
//  Chopper.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "Chopper.h"

#define PLATFORM_X_OFFSET 4.0f
#define PLATFORM_Y_OFFSET 157.0f

@implementation Chopper


-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		platformList = theplatforms;
		sprite = [CCSprite spriteWithFile:@"chopper.png"];
		sprite.position = ccp( 200, 200);
		[layer addChild:sprite z:800 tag:thetag];
		landedOn = nil;
		[self run];
	}
	return self;
}


-(void) moveWithLocation: (CGPoint) location {
	
	//reset landedOn to nil to allow the chopper to fly away
	landedOn = nil;
	
	
	if(sprite.position.x > location.x){
		sprite.rotation = -25.0f;
	}
	else {
		sprite.rotation = 25.0f;
	}
	
	// we stop the all running actions
	[sprite stopAllActions];
	
	
	
	// and we run a new action
	id landit = [CCSequence actions:
				 [CCMoveTo actionWithDuration:1 position:location],
				 [CCCallFunc actionWithTarget:self selector:@selector(chopperLand)],
				 nil ];
	
	//[chopper runAction: [CCMoveTo actionWithDuration:1 position:convertedPoint]];
	[sprite runAction: landit];
	[sprite runAction:[CCRotateTo actionWithDuration:1 angle:0.0f]];
}

-(void) chopperLand {
	NSEnumerator * enumerator = [platformList objectEnumerator];
	Platform *platform;
	NSLog(@"################################################");
	while(platform = ((Platform *)[enumerator nextObject]))
    {
		NSLog(@"Chopper is (%f,%f) | Platform is (%f,%f)", sprite.position.x,sprite.position.y,platform.sprite.position.x+4.0f, (platform.sprite.position.y+157.0f));
		if ([self isInRangeToLandOnPlatform:platform.sprite.position]) {
			NSLog(@"WITHIN RANGE OF PLATFORM...");
			[self landOnPlatform:platform];
		}
	}
	NSLog(@"################################################");
	
	
	
}

-(bool) isInRangeToLandOnPlatform: (CGPoint) platformlocation {
	CGPoint adjustedplatformlocation = CGPointMake(platformlocation.x+PLATFORM_X_OFFSET, (platformlocation.y+PLATFORM_Y_OFFSET));
	float xthresh = 30.0f;//ORIGINAL => 25.0f;
	float ythresh = 20.0f;//ORIGINAL => 10.0f;
	float xdiff = fabs(sprite.position.x-adjustedplatformlocation.x);
	float ydiff = fabs(sprite.position.y-adjustedplatformlocation.y);
	if ((xdiff < xthresh) && (ydiff < ythresh)){
		return true;
	}
	else {
		return false;
	}	
}

-(void) landOnPlatform: (Platform *) p {
	landedOn = p;
}

-(void) trackIfLanded {
	NSAutoreleasePool *autopool = [[NSAutoreleasePool alloc] init];
	CCSprite *totrack = [landedOn sprite];
	if (totrack == nil) {
		[NSThread sleepForTimeInterval:0.02];
	}
	else {
		//TRACK IT
		sprite.position = CGPointMake(totrack.position.x+PLATFORM_X_OFFSET, (totrack.position.y+PLATFORM_Y_OFFSET));
	}
	[NSThread sleepForTimeInterval:0.01];
	[NSThread detachNewThreadSelector:@selector(trackIfLanded) toTarget:self withObject:nil];
	[autopool drain];
}

-(void) stop {
	pause = true;
}

-(void) run {
	pause = false;
	[NSThread detachNewThreadSelector:@selector(trackIfLanded) toTarget:self withObject:nil];
}



@end
