//
//  ScoreBoard.m
//  chopper-hopper
//
//  Created by Robert Righter on 3/15/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "ScoreBoard.h"

#define FUEL_BAR_WIDTH 237
#define LEFT_FUEL_X 119
#define RIGHT_FUEL_X 361
#define FUEL_BAR_Y 305
//119
@implementation ScoreBoard

-(id) initWithTargetLayer: (CCLayer *) layer Tag:(NSInteger) thetags Mode: (int) themode {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		leftFuelBar = [CCSprite spriteWithFile:@"fuelbar1.png"];
		leftFuelBar.position = ccp( LEFT_FUEL_X, FUEL_BAR_Y);
		[layer addChild:leftFuelBar z:950];
		
		rightFuelBar = [CCSprite spriteWithFile:@"fuelbar2.png"];
		rightFuelBar.position = ccp( RIGHT_FUEL_X, FUEL_BAR_Y);
		[layer addChild:rightFuelBar z:950];
		
		score  = 0;
		scoreLabel = [CCLabel labelWithString:@"SCORE: 0" fontName:@"Marker Felt" fontSize:15];
		scoreLabel.position =  ccp( 40 , 280 );
		[layer addChild:scoreLabel z:6];
		
	}
	return self;
}

-(void) setLeftFuel: (float) value {
	
	leftFuelBar.position = ccp( ((FUEL_BAR_WIDTH/100.0f)*value)-LEFT_FUEL_X ,FUEL_BAR_Y);
}

-(void) setRightFuel: (float) value {
	rightFuelBar.position = ccp( ((FUEL_BAR_WIDTH/100.0f)*value)+RIGHT_FUEL_X ,FUEL_BAR_Y);
	//ccp(rightFuelBar.position.x + ((FUEL_BAR_WIDTH/100.0f)*value),FUEL_BAR_Y);	
}

-(void) incrementGameScore: (int) value {
	score = score + value;
	[scoreLabel setString:[NSString stringWithFormat:@"SCORE: %d",score]];
}



@end
