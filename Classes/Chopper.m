//
//  Chopper.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "Chopper.h"



@implementation Chopper


-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms LoseTarget: (id) losetarget LoseSelector: (SEL) loseselector ScoreBoard: (ScoreBoard*) thescoreboard ChopperNumber:(int) choppernumber {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		chopperNumber = choppernumber;
		platformList = theplatforms;
		scoreBoard = thescoreboard;
		sprite = [CCSprite spriteWithFile:@"chopper.png"];
		sprite.position = ccp( 200, 200);
		[layer addChild:sprite z:800 tag:thetag];
		landedOn = nil;
		loseCallbackSelector = loseselector;
		loseCallbackTarget = losetarget;
		fuel = 100.0f;
		scoreTime = nil;
		[self run];
	}
	return self;
}


-(void) moveWithLocation: (CGPoint) location {
	//if your landed set the scorecard to the time spent on the platform
	if(scoreTime != nil){
		// do stuff...
		if (chopperNumber == 1) {
			[scoreBoard incrementGameScore:abs((int)[scoreTime timeIntervalSinceNow])];
		}
		scoreTime = nil;
	}
	
	//ignore the laned on platform for automatic landing until the next touch
	toIgnore = landedOn;
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
	
	//Calculate distance
	float distance = sqrt(pow(abs(sprite.position.x - location.x), 2) + pow(abs(sprite.position.y - location.y), 2));
	float duration = 0.007 * distance;
	
	// and we run a new action
	id landit = [CCSequence actions:
				 [CCMoveTo actionWithDuration:duration position:location],
				 [CCCallFunc actionWithTarget:self selector:@selector(chopperLand)],
				 nil ];
	
	//[chopper runAction: [CCMoveTo actionWithDuration:1 position:convertedPoint]];
	[sprite runAction: landit];
	[sprite runAction:[CCRotateTo actionWithDuration:duration angle:0.0f]];
}


-(void) chopperLand {
	NSEnumerator * enumerator = [platformList objectEnumerator];
	Platform *platform;
	NSLog(@"################################################");
	while(platform = ((Platform *)[enumerator nextObject]))
    {
		//OPTIMIZATION => If we get past the chopper on the x axis (plus some padding), then we can just return
		if ( (platform.sprite.position.x ) > (sprite.position.x + 25.0f)  ) {
			return;
		}
		////////////////////////////////////////////////////////////////
		
		NSLog(@"Chopper is (%f,%f) | Platform is (%f,%f)", sprite.position.x,sprite.position.y,platform.sprite.position.x+4.0f, (platform.sprite.position.y+157.0f));
		if ((platform != toIgnore) && [self isInRangeToLandOnPlatform:platform.sprite.position]) {
			NSLog(@"WITHIN RANGE OF PLATFORM...");
			[self landOnPlatform:platform];
			//Just landed, lets take the timestamp
			scoreTime = [[NSDate date] retain];
		}
	}
	NSLog(@"################################################");
	
	
	
}

-(bool) isInRangeToLandOnPlatform: (CGPoint) platformlocation {
	CGPoint adjustedplatformlocation = CGPointMake(platformlocation.x+PLATFORM_X_OFFSET, (platformlocation.y+PLATFORM_Y_OFFSET));
	float xthresh = 17.0f;//ORIGINAL => 25.0f;
	float ythresh = 10.0f;//ORIGINAL => 10.0f;
	float xdiff = fabs(sprite.position.x-adjustedplatformlocation.x);
	float ydiff = fabs(sprite.position.y-adjustedplatformlocation.y);
	if ((xdiff < xthresh) && (ydiff < ythresh)){
		return true;
	}
	else {
		return false;
	}	
}

-(bool) isGameOver {
	if (sprite.position.y < WATERLEVEL) {
		return true;
	}
	if (fuel < 0) {
		return true;
	}
	
	return false;
}

-(void) landOnPlatform: (Platform *) p {
	// we stop the all running actions
	sprite.rotation = 0;
	[sprite stopAllActions];
	landedOn = p;
}

-(bool) isLanded {
	return ([landedOn sprite] != nil);
}

-(Platform*) getLandedOnPlatform {
	return landedOn;
}

-(void) trackIfLanded {
	NSAutoreleasePool *autopool = [[NSAutoreleasePool alloc] init];
	if ([self isGameOver]) {
		NSLog(@"Game over. Calling the Lose Selector");
		[loseCallbackTarget performSelector:loseCallbackSelector];
		[autopool drain];
		return;
	}

	CCSprite *totrack = [landedOn sprite];
	if (totrack == nil) {
		fuel = fuel - 0.1f;
		if (chopperNumber == 1) {
			[scoreBoard setLeftFuel:fuel];
		}
		else if(chopperNumber == 2) {
			[scoreBoard setRightFuel:fuel];
		}
		//NSLog(@"Current Fuel Level: %f", fuel);
		[self chopperLand];
		[NSThread sleepForTimeInterval:0.09];
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
