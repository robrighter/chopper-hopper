//
//  ScoreBoard.h
//  chopper-hopper
//
//  Created by Robert Righter on 3/15/10.
//  Copyright 2010 Medium. All rights reserved.
//
#import "cocos2d.h"

#define GAME_MODE_DUEL 1
#define GAME_MODE_SINGLE 2

@interface ScoreBoard : NSObject {
	CCSprite *leftFuelBar;
	CCSprite *rightFuelBar;
	CCLabel *scoreLabel;
	int *score;
	
}

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetags Mode: (int) themode;
-(void) setLeftFuel: (float) value;
-(void) setRightFuel: (float) value;
-(void) incrementGameScore: (int) value;

@end
