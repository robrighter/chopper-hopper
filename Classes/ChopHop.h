#import "cocos2d.h"
#import "Chopper.h"
#import "ScoreBoard.h"
#import "AIChopperController.h"

// HelloWorld Layer
@interface ChopHop : CCLayer
{
	Chopper* chopper;
	ScoreBoard* scoreboard;
	NSMutableArray* platformList;
	CCSprite* gameOver;
	AIChopperController *computerChopper;
}

+(id) scene;

@end
