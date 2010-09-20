//
//  GLSpriteBatchPoint.h
//  Electric2D
//
//  Created by robert on 30/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#if !defined(__GLSpriteBatchPoint_h__)
#define __GLSpriteBatchPoint_h__

#import "GLImageBatchPoint.h"

class GLSpriteBatchPoint : public GLImageBatchPoint
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLSpriteBatchPoint( CGPoint _center = CGPointZero, CGSize _scale = CGSizeMake(1.0f,1.0f), GLColor _color = GLColorWhite )
	: GLImageBatchPoint( _center, _scale, _color )
	{
		m_frame	= 0;
	};
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLSpriteBatchPoint()
	{
	};
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// access the frame counter
	inline NSUInteger frame() const { return m_frame; };
	
	// get the frame counter
	inline NSUInteger & getFrame() { return m_frame; };
	
	// set the frame no bounds checking
	inline void setFrame( NSUInteger _frame ) { m_frame = _frame; };
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------	
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	NSUInteger m_frame;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif