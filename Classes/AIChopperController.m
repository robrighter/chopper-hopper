//
//  AIChopperController.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/19/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "AIChopperController.h"
#import "Chopper.h"


@implementation AIChopperController

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms ScoreBoard: (ScoreBoard*) thescoreboard {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		platformList = theplatforms;
		scoreBoard = thescoreboard;
		isGameOver = false;
		NSLog(@"##############################    Creating the AI Chopper     #############");
		chopper = [[Chopper alloc] initWithTargetLayer:layer
								   Tag:thetag
								   PlatformListHandel:theplatforms
								   LoseTarget:self
								   LoseSelector:@selector(gameOverCallback)
								   ScoreBoard:thescoreboard
								   ChopperNumber:2];
		
		
		NSLog(@"##############################    Adding the AI Chopper to layer     #############");
		[self run];
		
	}
	return self;
}


-(void) gameOverCallback {
	isGameOver = true;
}


-(void) playGame {
	NSAutoreleasePool *autopool = [[NSAutoreleasePool alloc] init];
	if (isGameOver) {
		NSLog(@"CHOPPER AI. Got game over notification");
		[autopool drain];
		return;
	}
	//Make a decision on the next move
	bool shouldlookforanotherplatform = true;
	if([chopper isLanded]){ //LANDED
		Platform* landedon = [chopper getLandedOnPlatform];
		if (landedon != nil) {
			//figure out if we should look for another platform
			shouldlookforanotherplatform = ![landedon isGoingUp]; //THIS IS JUST A TEST ########### FIX LATER <============
		}
	}
	
	if (shouldlookforanotherplatform) {
		NSEnumerator * enumerator = [platformList objectEnumerator];
		Platform *platform;
		Platform* landedon = [chopper getLandedOnPlatform];
		Platform *choosenplatform = nil;
		while(platform = ((Platform *)[enumerator nextObject]))
		{
			if (platform != landedon) {
				if (choosenplatform == nil) {
					choosenplatform = platform;
				}
				else {
					if([platform isGoingUp] && (platform.sprite.position.y < choosenplatform.sprite.position.y) ){
						choosenplatform = platform;
					}
				}

			}
		}
		
		[chopper moveWithLocation:CGPointMake(choosenplatform.sprite.position.x+PLATFORM_X_OFFSET, (choosenplatform.sprite.position.y+PLATFORM_Y_OFFSET + WATERLEVEL))];
		[NSThread sleepForTimeInterval:5.01];
	}
		
	[NSThread sleepForTimeInterval:0.01];
	[NSThread detachNewThreadSelector:@selector(playGame) toTarget:self withObject:nil];
	[autopool drain];
}



-(void) run {
	pause = false;
	[NSThread detachNewThreadSelector:@selector(playGame) toTarget:self withObject:nil];
}

@end
