//
//  Chopper.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/10/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "Chopper.h"
#import "Platform.h"


@implementation Chopper


-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetag PlatformListHandel: (NSMutableArray*) theplatforms {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		platformList = theplatforms;
		sprite = [CCSprite spriteWithFile:@"chopper.png"];
		sprite.position = ccp( 200, 200);
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
	NSEnumerator * enumerator = [platformList objectEnumerator];
	Platform *platform;
	NSLog(@"################################################");
	while(platform = ((Platform *)[enumerator nextObject]))
    {
		NSLog(@"Chopper is (%f,%f) | Platform is (%f,%f)", sprite.position.x,sprite.position.y,platform.sprite.position.x, (platform.sprite.position.y + 170.0f));
    }
	NSLog(@"################################################");
	
	
}

@end
