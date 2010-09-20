//
//  GLModel.mm
//  Electric2D
//
//  Created by Robert on 15/10/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#include "GLModel.h"
#include "GLTexture.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLModel::GLModel( GLVert _verts[], NSInteger _count, const GLTexture * _texture, CGPoint _center )
: GLObject( eGLObjectModel )
{
	m_texture = _texture;
	m_center = _center;
	m_rotation = 0.0f;
	m_scale = CGSizeMake(1.0f, 1.0f);
	
	m_count = _count;
	m_verts = new GLVert[_count];
	
	memcpy(m_verts, _verts, sizeof(GLVert) * _count);
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLModel::~GLModel()
{
	delete( m_verts );
	m_verts = NULL;
	m_count = 0;
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
