//
//  GLTestImages.mm
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestImagesView.h"
#include "GLEngine.h"
#include "GLImage.h"

@interface GLTestImagesView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end


@implementation GLTestImagesView

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
	for ( int i=0; i<imagesCount; i++ )
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

// ------------------------------------------
// create Test Objects
// ------------------------------------------
- (void) createTest
{
	NSInteger across = imagesAcross;
	NSInteger down = imagesDown;
	
	NSInteger width = 320 / across;
	NSInteger height = 480 / down;
	
	NSInteger x = width * 0.5f;
	NSInteger y = height * 0.5f;
	NSInteger counter = 0;
	for ( int i=0; i<down; i++ )
	{
		for ( int j=0; j<across; j++ )
		{
			GLImage * image = new GLImage(glEngine->createTexture(@"TestImageAlpha"));
			
			image->setCenter( x, y );
			image->setSize( width, height );
			
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
	for ( int i=0; i<imagesCount; i++ )
	{
		images[i]->setRotation( images[i]->rotation() + 1 );
	}	
	
	
	// render
	[self draw];
}

@end
