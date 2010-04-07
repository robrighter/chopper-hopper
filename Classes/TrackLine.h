//
//  TrackLine.h
//  chopper-hopper
//
//  Created by Robert Righter on 4/6/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "cocos2d.h"

@interface TrackLine : CCNode {

	CGPoint startingPoint;
	CGPoint stoppingPoint;
	
}


-(void) updateStartingPoint: (CGPoint) p; 

@end
