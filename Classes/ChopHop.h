#import "cocos2d.h"
#import "Chopper.h"

// HelloWorld Layer
@interface ChopHop : CCLayer
{
	Chopper* chopper;
	NSMutableArray* platformList;
}

+(id) scene;

@end
