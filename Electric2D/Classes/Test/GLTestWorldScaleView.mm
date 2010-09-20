//
//  GLTestWorldScaleView.mm
//  Electric2D
//
//  Created by Robert on 07/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLTestWorldScaleView.h"
#import "GLEngine.h"
#import "GLLine.h"
#import "GLCamera.h"
#import "Maths.h"

@interface GLTestWorldScaleView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestWorldScaleView

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
	glEngine->remove( m_line );	
	delete( m_line );
	m_line = nil;
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// ------------------------------------------
// create Test Image Objects
// ------------------------------------------
- (void) createTest
{	
	m_line = new GLLine(4);
	
	m_line->add( 0, 0 );
	m_line->add( 160, 240 );
	m_line->add( 160, 480 );
	m_line->add( 320, 0 );
	m_line->setWidth( 2.0f );
	
	glEngine->add( m_line );
}

// ------------------------------------------
// Update functions
// ------------------------------------------
- (void) update
{	
	static Boolean scaleDown = true;
	float smallScale = 1.0f / 230.0f;
	float scale = glEngine->pixelToWorldScale();
	
	if (scaleDown)
	{
		scale -= 0.01f;
		if ( scale <= smallScale )
		{
			scaleDown = false;
		}
	}
	else // scale up
	{
		scale += 0.01f;
		if ( scale >= 1.0f )
		{
			scaleDown = true;
		}
	}
	
	glEngine->setPixelToWorldScale(scale);
	
	CGRect viewPort = glEngine->viewPort();
	CGPoint screenCenter = CGPointMake( viewPort.size.width * 0.5f, viewPort.size.height * 0.5f );
	glEngine->camera()->setPosition( screenCenter );
	
	// render
	[self draw];
}

@end
