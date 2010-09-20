//
//  GLTestView.m
//  Electric2D
//
//  Created by robert on 21/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestView.h"
#include "GLEngine.h"
#include "GLImage.h"
#include "GLSprite.h"
#include "GLLabel.h"

// -------------------------------------------------------------------
// update time defines
// -------------------------------------------------------------------
#define kUpdateFPS				60.0f // Hz
#define kUpdateSeconds			(1.0f / kUpdateFPS) // secs
#define kSkipTicks				(1000 / kUpdateFPS)
// -------------------------------------------------------------------

@interface GLTestView (PrivateMethods)

- (void) initialisation;

- (void) update;

@end


@implementation GLTestView

// ------------------------------------------
// You must implement this method
// ------------------------------------------
+ (Class)layerClass 
{
    return [CAEAGLLayer class];
}

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// intialisation via nib
// ------------------------------------------
- (id)initWithCoder:(NSCoder*)coder 
{
	if ((self = [super initWithCoder:coder])) 
	{
		// Initialization code
		[self initialisation];
	}
	return self;
}

// ------------------------------------------
// intialisation using the frame
// ------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		[self initialisation];
    }
    return self;
}

// ------------------------------------------
// 
// ------------------------------------------
- (void) initialisation
{
	// create the update timer
	updateTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateSeconds target:self selector:@selector(update) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:updateTimer forMode:NSDefaultRunLoopMode];
	
	// image tests
	
	GLImage * imageNon = new GLImage(glEngine->createTexture(@"TestImageNoAlpha"));
	GLImage * imageAlpha = new GLImage(glEngine->createTexture(@"TestImageAlpha"));
	GLImage * imageMissing = new GLImage(glEngine->createTexture(@"TestImageMissing"));
	
	imageNon->setCenter( CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height * 0.5f ) );
	imageNon->setRotation( 45.0f );
	
	imageAlpha->setCenter( CGPointMake(self.frame.size.width * 0.5f, imageAlpha->size().height * 0.5f ) );
	
	imageMissing->setCenter( CGPointMake(self.frame.size.width * 0.7f, imageAlpha->size().height * 0.5f ) );
	
	glEngine->add( imageNon );
	glEngine->add( imageAlpha );
	glEngine->add( imageMissing );
	
	testImages.push_back(imageNon);
	testImages.push_back(imageAlpha);
	testImages.push_back(imageMissing);
	
	// sprite tests
	
	GLSprite * sprite = new GLSprite(glEngine->createTextureSprite(@"TestSprite_4x4_64"));
	
	sprite->setCenter( CGPointMake(sprite->size().width * 0.5f, self.frame.size.height * 0.5f ) );
	sprite->setSize( CGSizeMake(32.0f, 32.0f) );
	
	glEngine->add( sprite );
	
	testSprites.push_back(sprite);
	
	// label tests
	
	testLabel = new GLLabel(@"Test Label");
	
	testLabel->setCenter( CGPointMake( 100.0f, 100.0f ) );
	testLabel->setText( @"TestText" );
	testLabel->setShadow( true );
	testLabel->setShadowOffset( 2, 2 );
	testLabel->setShadowColor( 1.0f, 0.0f, 0.0f );
	
	glEngine->add(testLabel);
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{
	for ( std::vector<GLImage*>::iterator it = testImages.begin(); it != testImages.end(); it++ )
	{
		GLImage * image = *it;
		
		glEngine->remove( image );
		
		glEngine->releaseTexture(image->texture());
		delete(image);
		image = nil;
	}
	testImages.clear();
	
	for ( std::vector<GLSprite*>::iterator it = testSprites.begin(); it != testSprites.end(); it++ )
	{
		GLSprite * sprite = *it;
		
		glEngine->remove( sprite );
		
		glEngine->releaseTexture(sprite->texture());
		delete(sprite);
		sprite = nil;
	}
	testSprites.clear();
	
	glEngine->remove(testLabel);
	delete(testLabel);
	testLabel=nil;
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
//
// ------------------------------------------
- (void)layoutSubviews 
{
    glEngine->rebindContext();
}

- (void) update
{
	// do things 
	for ( std::vector<GLImage*>::iterator it = testImages.begin(); it != testImages.end(); it++ )
	{
		GLImage * image = *it;
		
		image->setRotation( image->rotation() + 1.0f );
	}
	
	for ( std::vector<GLSprite*>::iterator it = testSprites.begin(); it != testSprites.end(); it++ )
	{
		GLSprite * spri = *it;
		
		spri->incrementFrame();
	}
	
	testLabel->setRotation( testLabel->rotation() - 1.0f );
	
	// render
	[self draw];
}

@end
