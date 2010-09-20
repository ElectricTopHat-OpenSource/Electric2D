/*
 *  GLFPS.mm
 *  ToccoRobo2-Prototype
 *
 *  Created by robert on 20/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLFPS.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLFPS::GLFPS()
{
	m_lastInterval	= [NSDate timeIntervalSinceReferenceDate];
	m_numFrames		= 0;
	m_fps			= 0;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLFPS::~GLFPS()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------


#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------

// -------------------------------------
// calculate the FPS value
// -------------------------------------
void GLFPS::calculateFPS()
{
	NSTimeInterval current = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval delta = -m_lastInterval - -current;
	m_numFrames++;
	if (delta >= 1.0)
	{
		m_fps = (m_numFrames/delta);
		m_numFrames = 0;
		m_lastInterval	= current;
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------