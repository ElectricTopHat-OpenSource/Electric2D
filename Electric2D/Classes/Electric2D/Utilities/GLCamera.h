//
//  GLCamera.h
//  Electric2D
//
//  Created by Robert on 25/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLCamera_h__)
#define __GLCamera_h__

#import <UIKit/UIKit.h>

// --------------------------------------------------
// GL Camera used to position the game view port
// --------------------------------------------------
class GLCamera  
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLCamera(CGPoint _position = CGPointZero);
	// --------------------------------------------------
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLCamera();
	// --------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Operator Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// --------------------------------------------------
	// operators Overloading
	// --------------------------------------------------
	GLCamera & operator=(const GLCamera& _camera)
	{
		setPosition( _camera.m_position );
		return *this;
	}
	// --------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark End Operator Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
		
	// --------------------------------------------------
	// Position Access
	// --------------------------------------------------
	inline const CGPoint & position() const			{ return m_position; };
	inline void setPosition( const CGPoint & _pos )	{ setPosition(_pos.x, _pos.y); };
	inline void setPosition( float _x, float _y )	{ m_position.x = _x; m_position.y = _y; };
	// --------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Functions
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	// camera position
	// this is the center
	// of the screen
	CGPoint m_position;
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------	
};

#endif