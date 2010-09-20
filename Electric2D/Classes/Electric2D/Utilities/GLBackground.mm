//
//  GLBackground.mm
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLBackground.h"


#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLBackground::GLBackground()
{
	m_texture = nil;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLBackground::~GLBackground()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// ----------------------------------------
// set the background texture
// ----------------------------------------
Boolean GLBackground::setTexture( const GLTexture * _texture )
{
	if ( ( _texture ) && 
		 (m_texture == nil) )
	{
		m_texture = _texture;
		return true;
	}
	
	return false;
}

// ----------------------------------------
// clear the background image
// ----------------------------------------
void GLBackground::clear()
{
	m_texture = nil;
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------
