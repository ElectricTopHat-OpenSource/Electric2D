/*
 *  GLColor.mm
 *  Electric2D
 *
 *  Created by robert on 22/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLColor.h"
#import "UIColor-Expanded.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLColor::GLColor(float _red, float _green, float _blue, float _alpha)
{
	m_red = _red;
	m_green = _green;
	m_blue = _blue;
	m_alpha = _alpha;
}

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLColor::GLColor(UIColor * _color)
{
	m_red = _color.red;
	m_green = _color.green;
	m_blue = _color.blue;
	m_alpha = _color.alpha;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLColor::~GLColor()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// operator
// --------------------------------------------------
GLColor & GLColor::operator=(const UIColor * _color)
{
	m_red = _color.red;
	m_green = _color.green;
	m_blue = _color.blue;
	m_alpha = _color.alpha;	
	return *this;
}

// --------------------------------------------------
// Set the colors
// --------------------------------------------------
void GLColor::setColor(const UIColor * _color)
{
	m_red = _color.red;
	m_green = _color.green;
	m_blue = _color.blue;
	m_alpha = _color.alpha;
}

#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------