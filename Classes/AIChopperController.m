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
		NSLog(@"##############################    Creating the AI Chopper     #############");
		chopper = [[Chopper alloc] initWithTargetLayer:layer
								   Tag:thetag
								   PlatformListHandel:theplatforms
								   LoseTarget:self
								   LoseSelector:@selector(gameOverCallback)
								   ScoreBoard:thescoreboard
								   ChopperNumber:2];
		
		
		NSLog(@"##############################    Adding the AI Chopper to layer     #############");
		
	}
	return self;
}


-(void) gameOverCallback {
	
}

@end
