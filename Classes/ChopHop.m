// 2010 Rob Righter (@robrighter)

// Import the interfaces
#import "ChopHop.h"
#import "Platform.h"
#import "Chopper.h"

// A simple 'define' used as a tag
enum {
	kTagChopper = 1,
	kTagBackground = 2,
	kTagSplash = 3,
	kTagMenu = 4,
	kTagWater = 5,
	kTagScoreBoard = 6,
	kTagGameOver = 7,
	kTagComputerChopper = 8,
	
};
//Platform tags go from 90 - 97

// HelloWorld implementation
@implementation ChopHop

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChopHop *layer = [ChopHop node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		// Set it up
		self.isTouchEnabled = YES;
		CCSprite *splash = [CCSprite spriteWithFile:@"splash.png"];
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		splash.position = ccp( size.width/2, size.height/2);
		[self addChild:splash z:0 tag:kTagSplash];
		
		CCSprite *water = [CCSprite spriteWithFile:@"water.png"];
		water.position = ccp( size.width/2, size.height/2);
		[self addChild:water z:999 tag:kTagWater];
		
		CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"startbutton1.png" selectedImage:@"startbutton2.png" target:self selector:@selector(startGame:)];
		
		CCMenu *menu = [CCMenu menuWithItems:item1, nil];
		menu.position = CGPointZero;
		item1.position = ccp( (size.width/2) + 110, (size.height/2) - 60 );
		[self addChild: menu z:2 tag:kTagMenu];
		
		
		// create and initialize a Label
		CCLabel* label = [CCLabel labelWithString:@"@robrighter 2010" fontName:@"Marker Felt" fontSize:15];
		label.position =  ccp( size.width /2 , 20 );
		[self addChild: label];
		
		
		
		
	}
	return self;
}

-(void) startGame: (id) sender
{
	//CCScene *s = [CCScene node];
	
	//Remove the start button so it doenst get clicked
	[self removeChildByTag:kTagMenu cleanup:NO];
	
	// ask director the the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
	CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
	background.position = ccp( size.width/2, size.height/2);
	[self addChild:background z:5 tag:kTagBackground];
	
	platformList = [[NSMutableArray alloc] init];
	for (int i=0; i<5; i++) {
		[platformList addObject:[[Platform alloc] initWithXPosition: ((90*i)+50) TargetLayer:self Tag:(90+i) ]];
	}
	
	scoreboard = [[ScoreBoard alloc] initWithTargetLayer:self Tag:kTagScoreBoard Mode:GAME_MODE_DUEL];
	chopper = [[Chopper alloc] initWithTargetLayer:self
							   Tag:kTagChopper
							   PlatformListHandel:platformList
							   LoseTarget:self 
							   LoseSelector:@selector(gameOverCallback) 
							   ScoreBoard:scoreboard
							   ChopperNumber:1];
	
	
	
	computerChopper = [[AIChopperController alloc] initWithTargetLayer:self Tag:kTagComputerChopper PlatformListHandel:platformList ScoreBoard:scoreboard];
	gameOver = [CCSprite spriteWithFile:@"gameover.png"];
	gameOver.position = ccp( size.width/2, size.height/2);
	gameOver.visible = NO;
	[self addChild:gameOver z:999 tag:kTagGameOver];
}

-(void)gameOverCallback {
	gameOver.visible = YES;
	NSLog(@"GAME OVER CALLBACK COMPLETE");
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[chopper showTrackLine];
	
	UITouch *touch = [touches anyObject];
	 
	if( touch ) {
		 CGPoint location = [touch locationInView: [touch view]];
		 
		 // IMPORTANT:
		 // The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		 CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		[chopper updateTrackLineStartingPoint:convertedPoint];
		 
	 }
	 //return false; 
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		[chopper updateTrackLineStartingPoint:convertedPoint];
		
	}
	//return false; 
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[chopper hideTrackLine];
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		[chopper moveWithLocation:convertedPoint];
	}
	//return true;	
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
