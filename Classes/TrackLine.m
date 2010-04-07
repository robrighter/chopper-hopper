//
//  TrackLine.m
//  chopper-hopper
//
//  Created by Robert Righter on 4/6/10.
//  Copyright 2010 Medium. All rights reserved.
//

#import "TrackLine.h"


@implementation TrackLine

-(id) init {
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		startingPoint = ccp(0,0);
		stoppingPoint = ccp(0,0);
		self.visible = false;
	}
	return self;
}


-(void) updateStartingPoint: (CGPoint) p {
	startingPoint = p;
}

-(void) updateStoppingPoint: (CGPoint) p {
	stoppingPoint = p;
}

-(void) draw
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	
	// draw a simple line
	// The default state is:
	// Line Width: 1
	// color: 255,255,255,255 (white, non-transparent)
	// Anti-Aliased
	glLineWidth( 2.0f );
	glColor4ub(255,0,0,255);
	//glEnable(GL_LINE_SMOOTH);
	ccDrawLine( startingPoint, stoppingPoint );
	/**
	// line: color, width, aliased
	// glLineWidth > 1 and GL_LINE_SMOOTH are not compatible
	// GL_SMOOTH_LINE_WIDTH_RANGE = (1,1) on iPhone
	glDisable(GL_LINE_SMOOTH);
	glLineWidth( 5.0f );
	glColor4ub(255,0,0,255);
	ccDrawLine( ccp(0, s.height), ccp(s.width, 0) );
	
	// TIP:
	// If you are going to use always the same color or width, you don't
	// need to call it before every draw
	//
	// Remember: OpenGL is a state-machine.
	
	// draw big point in the center
	glPointSize(64);
	glColor4ub(0,0,255,128);
	ccDrawPoint( ccp(s.width / 2, s.height / 2) );
	
	// draw 4 small points
	CGPoint points[] = { ccp(60,60), ccp(70,70), ccp(60,70), ccp(70,60) };
	glPointSize(4);
	glColor4ub(0,255,255,255);
	ccDrawPoints( points, 4);
	
	// draw a green circle with 10 segments
	glLineWidth(16);
	glColor4ub(0, 255, 0, 255);
	ccDrawCircle( ccp(s.width/2,  s.height/2), 100, 0, 10, NO);
	
	// draw a green circle with 50 segments with line to center
	glLineWidth(2);
	glColor4ub(0, 255, 255, 255);
	ccDrawCircle( ccp(s.width/2, s.height/2), 50, CC_DEGREES_TO_RADIANS(90), 50, YES);	
	
	// open yellow poly
	glColor4ub(255, 255, 0, 255);
	glLineWidth(10);
	CGPoint vertices[] = { ccp(0,0), ccp(50,50), ccp(100,50), ccp(100,100), ccp(50,100) };
	ccDrawPoly( vertices, 5, NO);
	
	// closed purble poly
	glColor4ub(255, 0, 255, 255);
	glLineWidth(2);
	CGPoint vertices2[] = { ccp(30,130), ccp(30,230), ccp(50,200) };
	ccDrawPoly( vertices2, 3, YES);
	
	// draw quad bezier path
	ccDrawQuadBezier(ccp(0,s.height), ccp(s.width/2,s.height/2), ccp(s.width,s.height), 50);
	
	// draw cubic bezier path
	ccDrawCubicBezier(ccp(s.width/2, s.height/2), ccp(s.width/2+30,s.height/2+50), ccp(s.width/2+60,s.height/2-50),ccp(s.width, s.height/2),100);
	
	
	// restore original values
	glLineWidth(1);
	glColor4ub(255,255,255,255);
	glPointSize(1);
	 
	 **/
	
}


@end
