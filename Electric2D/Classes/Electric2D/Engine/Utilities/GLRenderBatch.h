//
//  GLRenderBatch.h
//  Electric2D
//
//  Created by robert on 29/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLCombindedVert.h"
#import "GLColor.h"

const NSUInteger g_MaxVerts = 3000;

class GLRenderBatch 
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLRenderBatch();
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLRenderBatch();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public: // Functions
	
	inline Boolean    isUILayout() const { return m_UILayout; };
	inline void		  setUILayout(Boolean _uilayout) { m_UILayout = _uilayout; };
	
	// number of verts stored in the pipeline
	inline NSUInteger count() const { return m_count; };
	
	// add a quad
	void addQuad( const CGPoint & _min, const CGPoint & _max,const GLColor & _color );
	
	void addQuad( const CGPoint & _center, const CGSize & _size, const CGSize & _scale, float _rotation, int _textureCoordinatesLayout, const GLColor & _color );
	void addQuad( const CGPoint & _center, const CGSize & _size, const CGSize & _scale, const CGPoint & _minUV, const CGPoint & _maxUV, float _rotation, int _textureCoordinatesLayout, const GLColor & _color );
	
	void addQuad( const CGPoint & _center, float _width, float _height, float _rotation, int _textureCoordinatesLayout, const GLColor & _color );
	void addQuad( const CGPoint & _center, float _width, float _height, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha );
	void addQuad( const CGPoint & _center, float _width, float _height, const CGPoint & _minUV, const CGPoint & _maxUV, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha );
	
	void addQuad( float _x, float _y, float _width, float _height, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha );
	void addQuad( float _x, float _y, float _width, float _height, float _uvMinX, float _uvMinY, float _uvMaxX, float _uvMaxY, float _rotation, int _textureCoordinatesLayout, float _red, float _green, float _blue, float _alpha );
	
	// added a vert into the stored buffer
	void addVert( float _x, float _y, float _uvX, float _uvY, const GLColor & _color );
	void addVert( float _x, float _y, float _uvX, float _uvY, unsigned char _red, unsigned char _green, unsigned char _blue, unsigned char _alpha );
	
	// flush the current stored verts.
	void flush();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Pivate Functions
#pragma mark ---------------------------------------------------------
private: // Functions
				 
	inline void addCombinedVert( float _x, float _y, float _uvX, float _uvY, unsigned char _red, unsigned char _green, unsigned char _blue, unsigned char _alpha );
	
#pragma mark ---------------------------------------------------------
#pragma mark End Pivate Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	GLCombindedVert m_interleavedVerts[g_MaxVerts];
	NSUInteger		m_count;
	
	Boolean			m_UILayout;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};
