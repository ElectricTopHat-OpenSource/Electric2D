//
//  GLTestBackgroundView.mm
//  Electric2D
//
//  Created by Robert on 29/05/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GLTestBackgroundView.h"
#include "GLEngine.h"
#include "GLTexture.h"
#include "GLImage.h"
#include "GLBackground.h"

@interface GLTestBackgroundView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestBackgroundView

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
// Initialisation
// ------------------------------------------
- (void) initialisation
{		
	// image tests
	[self createTest];	
}

// ------------------------------------------
// dealloc
// ------------------------------------------
- (void)dealloc 
{
	glEngine->remove( m_image );
	glEngine->releaseTexture(m_image->texture());
	m_image = nil;
	
	glEngine->background()->clear();
	glEngine->releaseTexture( m_background );
	m_background = nil;
	
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
	m_background = glEngine->createTexture( @"TestBackground" );
	glEngine->background()->setColor ( 1.0f, 0.0f, 0.0f );
	glEngine->background()->setTexture( m_background );
	
	m_image = new GLImage(glEngine->createTexture(@"TestImageAlpha"));
	m_image->setCenter( 100, 100 );
	m_image->setSize( 64, 64 );
	glEngine->add( m_image );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{	
	// render
	[self draw];
}

@end
