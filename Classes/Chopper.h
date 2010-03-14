//
//  Chopper.h
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//
#import "cocos2d.h"
#import "Platform.h"


@interface Chopper : NSObject {
	CCSprite *sprite;
	NSMutableArray *platformList;
	Platform *landedOn;
	bool pause;
	
}

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms;
-(void) moveWithLocation: (CGPoint) location;

@property (retain) CCSprite *sprite;

@end
