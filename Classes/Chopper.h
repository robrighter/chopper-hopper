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

@end
