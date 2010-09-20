/*
 *  GLSprint.mm
 *  Electric2D
 *
 *  Created by robert on 17/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#import "GLSprite.h"
#import "GLTextureSprite.h"
#import "Maths.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLSprite::GLSprite( const GLTextureSprite * _texture, CGPoint _center, CGSize _size )
:GLObject( eGLObjectSprite )
{
	m_texture = _texture;
	m_center = _center;
	m_rotation = 0.0f;
	m_frame = 0;
	m_scale = CGSizeMake(1.0f, 1.0f);
	m_textureCoordinatesLayout = eGLTextureCoordinatesLayout_LeftToRight_TopToBottom;
	
	if ( CGSizeEqualToSize(_size, CGSizeZero) )
	{
		if ( _texture )
		{
			m_size = _texture->frameSize(0);
		}
		else 
		{
			m_size = CGSizeMake(10.0f,10.0f);
		}
	}
	else
	{
		m_size = _size;
	}
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLSprite::~GLSprite()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// set the current frame number
// --------------------------------------------------
void GLSprite::setFrame(NSUInteger _frame) 
{ 
	m_frame = Maths::fClamp(_frame, 0, m_texture->frameCount() ); 
}

// --------------------------------------------------
// set the rect
// --------------------------------------------------
void GLSprite::setRect( CGRect _rect )
{
	m_scale	= CGSizeMake(1.0f, 1.0f);
	m_size	= _rect.size;
	
	m_center = _rect.origin;
	m_center.x += m_size.width * 0.5f;
	m_center.y += m_size.height * 0.5f;
}

#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------