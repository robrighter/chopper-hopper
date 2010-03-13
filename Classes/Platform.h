//
//  Platform.h
//  chopper-hopper
//
//  Created by Robert Righter on 3/8/10.
//  Copyright 2010 Rob Righter. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "cocos2d.h" 

@interface Platform : NSObject {
	
	NSInteger riseToPoint;
	NSInteger X;
	CCSprite *sprite;
	
}

-(id) initWithXPosition: (float) xpos TargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag;
-(void) run;

@property (retain) CCSprite *sprite;

@end
