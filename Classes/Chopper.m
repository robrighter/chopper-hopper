//
//  Chopper.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "Chopper.h"


@implementation Chopper


-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag{
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		sprite = [CCSprite spriteWithFile:@"chopper.png"];
		sprite.position = ccp( 0, 10.0f);
		
		[layer addChild:sprite z:999 tag:thetag];
	}
	return self;
}


-(void) moveWithLocation: (CGPoint) location {
	
	if(sprite.position.x > location.x){
		sprite.rotation = -25.0f;
	}
	else {
		sprite.rotation = 25.0f;
	}
	
	// we stop the all running actions
	[sprite stopAllActions];
	
	
	
	// and we run a new action
	id landit = [CCSequence actions:
				 [CCMoveTo actionWithDuration:1 position:location],
				 [CCCallFunc actionWithTarget:self selector:@selector(chopperLand)],
				 nil ];
	
	//[chopper runAction: [CCMoveTo actionWithDuration:1 position:convertedPoint]];
	[sprite runAction: landit];
	[sprite runAction:[CCRotateTo actionWithDuration:1 angle:0.0f]];
}

-(void) chopperLand {
	
}

@end
