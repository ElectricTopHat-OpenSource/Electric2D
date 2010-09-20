//
//  GLTestLineView.mm
//  Electric2D
//
//  Created by robert on 06/07/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLTestLineView.h"
#import "GLEngine.h"
#import "GLLine.h"

@interface GLTestLineView (PrivateMethods)

- (void) initialisation;

- (void) createTest;

@end

@implementation GLTestLineView

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
// create Test Objects
// ------------------------------------------
- (void) createTest
{	
	m_line = new GLLine(4);
	
	m_line->add( 0, 0 );
	m_line->add( 160, 240 );
	m_line->add( 160, 480 );
	m_line->add( 320, 0 );
	m_line->add( 200, 50 );
	m_line->setWidth( 2.0f );
	
	glEngine->add( m_line );
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
