//
//  GLRenderBatch.mm
//  Electric2D
//
//  Created by robert on 29/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "GLRenderBatch.h"

#import <OpenGLES/ES1/gl.h>
#import "Maths.h"

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLRenderBatch::GLRenderBatch()
{
	m_count		= 0;
	m_UILayout	= FALSE;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLRenderBatch::~GLRenderBatch()
{		
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _min, const CGPoint & _max, const GLColor & _color )
{
	unsigned char color[4] = { _color.red()*255, _color.green()*255, _color.blue()*255, _color.alpha()*255 };
		
	float minUV[2];
	float maxUV[2];
	
	if ( m_UILayout )
	{
		minUV[0] = 0; minUV[1] = 1;
		maxUV[0] = 1; maxUV[1] = 0;
	}
	else 
	{
		minUV[0] = 0; minUV[1] = 0;
		maxUV[0] = 1; maxUV[1] = 1;
	}

	
	// Triangle #1
	addCombinedVert(_min.x, _max.y, minUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(_max.x, _max.y, maxUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(_min.x, _min.y, minUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
	
	// Triangle #2
	addCombinedVert(_max.x, _max.y, maxUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(_min.x, _min.y, minUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(_max.x, _min.y, maxUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _center, const CGSize & _size, const CGSize & _scale, float _rotation, int _textureCoordinatesLayout, const GLColor & _color )
{
	addQuad( _center.x, _center.y, _size.width * _scale.width, _size.height * _scale.height, _rotation, _textureCoordinatesLayout, _color.red(), _color.green(), _color.blue(), _color.alpha() );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _center, const CGSize & _size, const CGSize & _scale, const CGPoint & _minUV, const CGPoint & _maxUV, float _rotation, int _textureCoordinatesLayout, const GLColor & _color )
{
	addQuad( _center.x, _center.y, _size.width * _scale.width, _size.height * _scale.height, _minUV.x, _minUV.y, _maxUV.x, _maxUV.y, _rotation, _textureCoordinatesLayout, _color.red(), _color.green(), _color.blue(), _color.alpha() );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _center, float _width, float _height, float _rotation, int _textureCoordinatesLayout, const GLColor & _color )
{
	addQuad( _center, _width, _height, _rotation, _textureCoordinatesLayout, _color.red(), _color.green(), _color.blue(), _color.alpha() );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _center, float _width, float _height, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha )
{
	addQuad( _center.x, _center.y, _width, _height, _rotation, _textureCoordinatesLayout, _red, _green, _blue, _alpha );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( const CGPoint & _center, float _width, float _height, const CGPoint & _minUV, const CGPoint & _maxUV, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha )
{
	addQuad( _center.x, _center.y, _width, _height, _minUV.x, _minUV.y, _maxUV.x, _maxUV.y, _rotation, _textureCoordinatesLayout, _red, _green, _blue, _alpha );
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( float _x, float _y, float _width, float _height, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha )
{
	addQuad( _x, _y, _width, _height, 0.0f, 0.0f, 1.0f, 1.0f, _rotation, _textureCoordinatesLayout, _red, _green, _blue, _alpha );	
}

// --------------------------------------------------
// add a quad 
// --------------------------------------------------
void GLRenderBatch::addQuad( float _x, float _y, float _width, float _height, float _uvMinX, float _uvMinY, float _uvMaxX, float _uvMaxY, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha )
{
	unsigned char color[4] = { _red*255, _green*255, _blue*255, _alpha*255 };
	
	float width		= _width * 0.5f;
	float height	= _height * 0.5f;
	
	Maths::CGVector2D vec45Pos = Maths::CGVector2DRotate( width, height, -Maths::Degrees2Radians(_rotation));
	Maths::CGVector2D vec45Neg = Maths::CGVector2DRotate( height, width, -Maths::Degrees2Radians(_rotation-90.0f));
	
	float topRightX		= _x + vec45Pos.x;
	float topRightY		= _y + vec45Pos.y;
	float bottomLeftX	= _x - vec45Pos.x;
	float bottomLeftY	= _y - vec45Pos.y;
	
	float topLeftX		= _x + vec45Neg.x;
	float topLeftY		= _y + vec45Neg.y;
	float bottomRightX	= _x - vec45Neg.x;
	float bottomRightY	= _y - vec45Neg.y;
	
	float minUV[2];
	float maxUV[2];
	
	if ( m_UILayout )
	{
		// flip the texture coordinates around
		switch (_textureCoordinatesLayout) 
		{
			default:
			case 0: // normal
			{
				minUV[0] = _uvMinX; minUV[1] = _uvMaxY;
				maxUV[0] = _uvMaxX; maxUV[1] = _uvMinY;
				break;
			}
			case 1: // horizontal flip
			{
				minUV[0] = _uvMaxX; minUV[1] = _uvMaxY;
				maxUV[0] = _uvMinX; maxUV[1] = _uvMinY;
				break;
			}
			case 2: // vertical flip
			{
				minUV[0] = _uvMinX; minUV[1] = _uvMinY;
				maxUV[0] = _uvMaxX; maxUV[1] = _uvMaxY;
				break;
			}
			case 3: // vertical and horizontal flip
			{
				minUV[0] = _uvMaxX; minUV[1] = _uvMinY;
				maxUV[0] = _uvMinX; maxUV[1] = _uvMaxY;
				break;
			}
		}
	}
	else 
	{
		// flip the texture coordinates around
		switch (_textureCoordinatesLayout) 
		{
			default:
			case 0: // normal
			{
				minUV[0] = _uvMinX; minUV[1] = _uvMinY;
				maxUV[0] = _uvMaxX; maxUV[1] = _uvMaxY;
				break;
			}
			case 1: // horizontal flip
			{
				minUV[0] = _uvMaxX; minUV[1] = _uvMinY;
				maxUV[0] = _uvMinX; maxUV[1] = _uvMaxY;
				break;
			}
			case 2: // vertical flip
			{
				minUV[0] = _uvMinX; minUV[1] = _uvMaxY;
				maxUV[0] = _uvMaxX; maxUV[1] = _uvMinY;
				break;
			}
			case 3: // vertical and horizontal flip
			{
				minUV[0] = _uvMaxX; minUV[1] = _uvMaxY;
				maxUV[0] = _uvMinX; maxUV[1] = _uvMinY;
				break;
			}
		}
	}
	
	// Triangle #1
	addCombinedVert(topLeftX, topLeftY, minUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(topRightX, topRightY, maxUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(bottomLeftX, bottomLeftY, minUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
	
	// Triangle #2
	addCombinedVert(topRightX, topRightY, maxUV[0], minUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(bottomLeftX, bottomLeftY, minUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
	addCombinedVert(bottomRightX, bottomRightY, maxUV[0], maxUV[1], color[0], color[1], color[2], color[3] );
}

// --------------------------------------------------
// add a vert
// --------------------------------------------------
void GLRenderBatch::addVert( float _x, float _y, float _uvX, float _uvY, const GLColor & _color )
{
	addCombinedVert(_x,_y,_uvX,_uvY,_color.red()*255,_color.green()*255,_color.blue()*255,_color.alpha()*255);
}

// --------------------------------------------------
// add a vert
// --------------------------------------------------
void GLRenderBatch::addVert( float _x, float _y, float _uvX, float _uvY, unsigned char _red, unsigned char _green, unsigned char _blue, unsigned char _alpha )
{
	addCombinedVert(_x,_y,_uvX,_uvY,_red,_green,_blue,_alpha);
}

// --------------------------------------------------
// Flush the currently stored verts
// --------------------------------------------------
void GLRenderBatch::flush()
{
	if ( m_count > 0 )
	{
		//NSLog( @"Flush Verts Count : %d", m_count );
		
		//glEnableClientState(GL_COLOR_ARRAY);
		
		// render combind verts in the following way
		glVertexPointer		(2, GL_FLOAT, sizeof(GLCombindedVert), &m_interleavedVerts[0].vert);
		glTexCoordPointer	(2, GL_FLOAT, sizeof(GLCombindedVert), &m_interleavedVerts[0].uv);
		glColorPointer		(4, GL_UNSIGNED_BYTE, sizeof(GLCombindedVert), &m_interleavedVerts[0].color);
		glDrawArrays		(GL_TRIANGLES, 0, m_count);
		
		//glDisableClientState(GL_COLOR_ARRAY);
		
		m_count = 0;
	}	
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------


#pragma mark ---------------------------------------------------------
#pragma mark Pivate Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// add a combined vert
// --------------------------------------------------
void GLRenderBatch::addCombinedVert( float _x, float _y, float _uvX, float _uvY, unsigned char _red, unsigned char _green, unsigned char _blue, unsigned char _alpha )
{
	GLCombindedVert & vert = m_interleavedVerts[m_count];
	
	vert.vert.x	= _x;
	vert.vert.y	= _y;
	
	vert.uv.x	= _uvX;
	vert.uv.y	= _uvY;
	
	vert.color.red		= _red;
	vert.color.green	= _green;
	vert.color.blue		= _blue;
	vert.color.alpha	= _alpha;
	
	m_count++;
	
	if ( m_count >= g_MaxVerts )
	{
		flush();
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark End Pivate Functions
#pragma mark ---------------------------------------------------------