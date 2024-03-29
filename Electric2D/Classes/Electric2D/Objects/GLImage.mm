/*
 *  GLImage.mm
 *  Electric2D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLImage.h"
#include "GLTexture.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLImage::GLImage( const GLTexture * _texture, CGPoint _center, CGSize _size )
: GLObject( eGLObjectImage )
{
	m_texture = _texture;
	m_center = _center;
	m_rotation = 0.0f;
	m_scale = CGSizeMake(1.0f, 1.0f);
	m_textureCoordinatesLayout = eGLTextureCoordinatesLayout_LeftToRight_TopToBottom;
	
	if (( CGSizeEqualToSize(_size, CGSizeZero) ) && 
		( _texture != nil ))
	{
		m_size = _texture->size();
	}
	else
	{
		m_size = _size;
	}
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLImage::~GLImage()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// set the rect
// --------------------------------------------------
void GLImage::setRect( CGRect _rect )
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