//
//  GLTestSprites.m
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestSpritesView.h"
#include "GLEngine.h"
#include "GLSprite.h"

@interface GLTestSpritesView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end


@implementation GLTestSpritesView

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
	// image tests
	[self createTest];	
}

// ------------------------------------------
// 
// ------------------------------------------
- (void)dealloc 
{
	for ( int i=0; i<spritesCount; i++ )
	{
		glEngine->remove( images[i] );
		
		glEngine->releaseTexture(images[i]->texture());
		
		delete(images[i]);
	}
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

- (void) incrementFrame:(GLSprite*)_sprite
{
	NSInteger frame = _sprite->frame();
	frame++;
	if ( frame > _sprite->frameCount() )
	{
		frame = 0;
	}
	_sprite->setFrame(frame);
}

// ------------------------------------------
// create Test Objects
// ------------------------------------------
- (void) createTest
{
	NSInteger across = spritesAcross;
	NSInteger down = spritesDown;
	
	NSInteger width = 320 / across;
	NSInteger height = 480 / down;
	
	NSInteger x = width * 0.5f;
	NSInteger y = height * 0.5f;
	NSInteger counter = 0;
	for ( int i=0; i<down; i++ )
	{
		for ( int j=0; j<across; j++ )
		{
			GLSprite * image = new GLSprite(glEngine->createTextureSprite(@"TestSprite_4x4_64"));
			
			image->setCenter( x, y );
			image->setSize( width, height );

			if ( i % 2 )
			{
				[self incrementFrame:image];
			}
			
			images[counter] = image;
			counter++;
			
			glEngine->add( image );
			
			x += width;
		}
		x = width * 0.5f;
		y += height;
	}
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{
	static NSInteger frame = 0;
	frame++;
	
	NSInteger width = 320 / 10;
	NSInteger height = 480 / 20;
	
	for ( int i=0; i<spritesCount; i++ )
	{
		images[i]->setRotation( images[i]->rotation() + 1 );
		
		[self incrementFrame:images[i]];
		
		if ( i % 2 )
		{
			if ( frame % 2 )
			{
				images[i]->setSize( width, height );
			}
			else
			{
				images[i]->setSize( width * 1.5f, height * 0.5f );
			}
		}
	}	
	
	
	// render
	[self draw];
}

@end
