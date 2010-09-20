//
//  GLLine.mm
//  Electric2D
//
//  Created by robert on 06/07/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLLine.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLLine::GLLine( NSUInteger _capacity )
:GLObject( eGLObjectLine )
{
	m_width = 1.0f;
	m_points.reserve( _capacity );
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLLine::~GLLine()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------