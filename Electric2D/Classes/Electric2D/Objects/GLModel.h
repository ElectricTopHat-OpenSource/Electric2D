//
//  GLModel.h
//  Electric2D
//
//  Created by Robert on 15/10/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLModel_h__)
#define __GLModel_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import "GLObject.h"
#import "GLColor.h"
#import "GLVert.h"
#import "Maths.h"

class GLTexture;

// -------------------------------------------------------------------
// GLModel is a simple render object made up of verts and texture
// corridantes
// -------------------------------------------------------------------
class GLModel : public GLObject
{	
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
		
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLModel( GLVert _verts[], NSInteger _vertCount, const GLTexture * _texture = nil, CGPoint _center = CGPointZero );
		
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLModel();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
		
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
		
	// set the texture object
	inline void setTexture(const GLTexture * _texture) { m_texture = _texture; };
	// access the texture object
	inline const GLTexture * texture() const { return m_texture; };
	
	// access the image alpha value
	inline float alpha() const { return m_color.alpha(); };
	// set the image alpha value
	inline void setAlpha(float _alpha) { m_color.setAlpha(_alpha); };
		
	// access the color variable
	inline const GLColor & color() const { return m_color; };
	// set the color or the font
	inline void setColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_color.setColor(_red,_green,_blue,_alpha); };
	inline void setColor(const GLColor & _color) { m_color.setColor(_color); };
	inline void setColor(const UIColor * _color) { m_color.setColor(_color); };
		
	// access the image rotation in degrees
	inline float rotation() const { return m_rotation; };
	// set the rotation of the image in degrees
	inline void setRotation(float _rotation) { m_rotation = _rotation; };
				
	// access the image scale
	inline const CGSize & scale() const { return m_scale; };
	// set the image scale
	inline void setScale(CGSize _scale) { m_scale = _scale; };
	inline void setScale(float _width, float _height) { m_scale.width = _width; m_scale.height = _height; };
	inline void setScale(float _scale) { m_scale.width = _scale; m_scale.height = _scale; };
		
	// access the center point
	inline const CGPoint & center() const { return m_center; };
	// set the center point
	inline void setCenter(CGPoint _center) { m_center = _center; };
	inline void setCenter(float _x, float _y) { m_center.x = _x; m_center.y = _y; };
	
	// access the vert count
	inline NSInteger count() const { return m_count; };
	// access the internal verts
	inline const GLVert * verts() const { return m_verts; };
	
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
		
	const GLTexture * m_texture;

	GLVert * m_verts;
	NSInteger     m_count;
	
	GLColor		m_color;
	
	float		m_rotation;
	CGSize		m_scale;
	CGPoint		m_center;
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif // __GLModel_h__