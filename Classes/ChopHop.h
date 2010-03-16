#import "cocos2d.h"
#import "Chopper.h"
#import "ScoreBoard.h"

// HelloWorld Layer
@interface ChopHop : CCLayer
{
	Chopper* chopper;
	ScoreBoard* scoreboard;
	NSMutableArray* platformList;
	CCSprite* gameOver;
}

+(id) scene;

@end
