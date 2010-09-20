//
//  GLCamera.mm
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "GLCamera.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLCamera::GLCamera(CGPoint _position)
{
	m_position = _position;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLCamera::~GLCamera()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------