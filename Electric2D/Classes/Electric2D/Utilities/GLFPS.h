/*
 *  GLFPS.h
 *  ToccoRobo2-Prototype
 *
 *  Created by robert on 20/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLFPS_h__)
#define __GLFPS_h__

#import <UIKit/UIKit.h>

class GLFPS
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
		
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLFPS();
		
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLFPS();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// update the fps counter
	inline void update() { calculateFPS(); }
	
	// access the calculated fps
	inline NSInteger fps() const { return m_fps; }
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Functions
	
	// calculate the FPS value
	void calculateFPS();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	NSTimeInterval	m_lastInterval;
	NSUInteger		m_numFrames;
	NSUInteger		m_fps;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif