//
//  Chopper.h
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//
#import "cocos2d.h"
#import "Platform.h"
#import "ScoreBoard.h"

#define PLATFORM_X_OFFSET 4.0f
#define PLATFORM_Y_OFFSET 157.0f
#define WATERLEVEL 48.0f

@interface Chopper : NSObject {
	CCSprite *sprite;
	NSMutableArray *platformList;
	Platform *landedOn;
	Platform *toIgnore;
	bool pause;
	SEL loseCallbackSelector;
	id loseCallbackTarget;
	float fuel;
	ScoreBoard *scoreBoard;
	NSDate *scoreTime;
	int chopperNumber;
	
}

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms LoseTarget: (id) losetarget LoseSelector: (SEL) loseselector ScoreBoard: (ScoreBoard*) thescoreboard ChopperNumber:(int) choppernumber;
-(void) moveWithLocation: (CGPoint) location;
-(void) run;
-(void) landOnPlatform: (Platform *) p;
-(void) trackIfLanded;
-(bool) isInRangeToLandOnPlatform: (CGPoint) platformlocation;
-(bool) isGameOver;
-(bool) isLanded;
-(Platform*) getLandedOnPlatform;

@end
