//
//  AIChopperController.h
//  chopper-hopper
//
//  Created by Robert Righter on 3/19/10.
//  Copyright 2010 Medium. All rights reserved.
//
#import "cocos2d.h"
#import "ScoreBoard.h"
#import "Chopper.h"

@interface AIChopperController : NSObject {
	Chopper *chopper;
	NSMutableArray *platformList;
	ScoreBoard *scoreBoard;
	bool *isGameOver;
	bool pause;
}

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms ScoreBoard: (ScoreBoard*) thescoreboard;
-(void) run;

@end
