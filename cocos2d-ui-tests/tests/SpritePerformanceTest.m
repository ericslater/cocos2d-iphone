#import "TestBase.h"
#import "CCNode_Private.h"

@interface SpritePerformanceTest : TestBase @end
@implementation SpritePerformanceTest

#define SPRITE_COUNT 3000
#define TILE_COUNT 37
//#define spritePopulation 10
//#define spritesheet 1

- (void) setupForThisManySprites:(int)spritePopulation spriteSheet:(BOOL)spriteSheet imageType:(NSString *)imageType percentVisible:(int)percentVisible percentOpacity:(int)percentOpacity
{
    CGSize size = [CCDirector sharedDirector].designSize;
    self.subTitle = [NSString stringWithFormat:@"TEST"];
	
    if (spriteSheet) {
        for(int i=0; i<spritePopulation; i++) {
            
            int num = arc4random()%TILE_COUNT + 1;
            CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Tiles/%02d.png", num]];
            sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
            sprite.rotation = CCRANDOM_0_1()*360;
            [self.contentNode addChild:sprite];
        }
    }
    
    else {
        for(int i=0; i<spritePopulation; i++) {
            int num = arc4random()%TILE_COUNT + 1;
            CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"TilesAtlassed/%02d.png", num]];
            sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
            sprite.rotation = CCRANDOM_0_1()*360;
            [self.contentNode addChild:sprite];
        }
    }

}



-(void)setupCallTest
{
    // declare initial values
    NSArray *spritesArr = [NSMutableArray arrayWithObjects: @100, @200, @500, @1000, @2000, @3000, nil];
    NSArray *sheetArr = [NSMutableArray arrayWithObjects: @0, @1, nil];
    NSArray *image = [NSMutableArray arrayWithObjects: @"png", @"jpg", @"pvr", nil];
    NSArray *visibility = [NSMutableArray arrayWithObjects: @100, @50, @0, nil];
    NSArray *opacity = [NSMutableArray arrayWithObjects: @100, @50, @0, nil];
    
    // if statements
    for (int n=0; n<[spritesArr count]; n++) {
        
    }
    
    
    
    
    //[self setupForThisManySprites:sprites spriteSheet:sheet imageType:image percentVisible:visibility percentOpacity:opacity];
}





- (void)setupSpritesUnbatchedUnatlassedTest
{
	self.subTitle = [NSString stringWithFormat:@"%d Sprites (unatlassed, unbatched)", SPRITE_COUNT];
	
	CGSize size = [CCDirector sharedDirector].designSize;
	
	for(int i=0; i<SPRITE_COUNT; i++){
		int num = arc4random()%TILE_COUNT + 1;
		CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Tiles/%02d.png", num]];
		sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
		sprite.rotation = CCRANDOM_0_1()*360;
		[self.contentNode addChild:sprite];
	}
}

- (void)setupSpritesUnbatchedTest
{
	self.subTitle = [NSString stringWithFormat:@"%d Sprites (atlassed, unbatched)", SPRITE_COUNT];
	
	CGSize size = [CCDirector sharedDirector].designSize;
	
	for(int i=0; i<SPRITE_COUNT; i++){
		int num = arc4random()%TILE_COUNT + 1;
		CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"TilesAtlassed/%02d.png", num]];
		sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
		sprite.rotation = CCRANDOM_0_1()*360;
		[self.contentNode addChild:sprite];
	}
}

- (void)setupSpritesUnbatchedUnatlassed2080Test
{
	self.subTitle = [NSString stringWithFormat:@"%d Sprites (20%% visible, unatlassed, unbatched)", SPRITE_COUNT];
	
	CGSize size = [CCDirector sharedDirector].designSize;
	
	for(int i=0; i<SPRITE_COUNT; i++){
		int num = arc4random()%TILE_COUNT + 1;
		CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Tiles/%02d.png", num]];
		sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
		sprite.rotation = CCRANDOM_0_1()*360;
		
		if(i < 0.8*SPRITE_COUNT) sprite.position = ccp(-1000, -1000);
		
		[self.contentNode addChild:sprite];
	}
}

- (void)setupSpritesSorted2080Test
{
	self.subTitle = [NSString stringWithFormat:@"%d Sprites (20%% visible, sorted)", SPRITE_COUNT];
	
	CGSize size = [CCDirector sharedDirector].designSize;
	
	NSMutableArray *sprites = [NSMutableArray array];
	
	for(int i=0; i<SPRITE_COUNT; i++){
		int num = arc4random()%TILE_COUNT + 1;
		CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Tiles/%02d.png", num]];
		sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
		sprite.rotation = CCRANDOM_0_1()*360;
		
		if(i < 0.8*SPRITE_COUNT) sprite.position = ccp(-1000, -1000);
		
		[sprites addObject:sprite];
	}
	
	[sprites sortUsingComparator:^(CCSprite *a, CCSprite *b){
		return (NSComparisonResult)((intptr_t)[a renderState] - (intptr_t)[b renderState]);
	}];
	
	for(CCSprite *sprite in sprites) [self.contentNode addChild:sprite];
}

- (void)setupSpritesUnbatched2080Test
{
	self.subTitle = [NSString stringWithFormat:@"%d Sprites (20%% visible, atlassed, unbatched)", SPRITE_COUNT];
	
	CGSize size = [CCDirector sharedDirector].designSize;
	
	for(int i=0; i<SPRITE_COUNT; i++){
		int num = arc4random()%TILE_COUNT + 1;
		CCSprite *sprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"TilesAtlassed/%02d.png", num]];
		sprite.position = ccp(CCRANDOM_0_1()*size.width, CCRANDOM_0_1()*size.height);
		sprite.rotation = CCRANDOM_0_1()*360;
		
		if(i < 0.8*SPRITE_COUNT) sprite.position = ccp(-1000, -1000);
		
		[self.contentNode addChild:sprite];
	}
}

@end

