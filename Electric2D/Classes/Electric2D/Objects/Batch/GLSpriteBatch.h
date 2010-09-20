//
//  GLSpriteBatch.h
//  Electric2D
//
//  Created by robert on 02/06/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#if !defined(__GLSpriteBatch_h__)
#define __GLSpriteBatch_h__

#import <UIKit/UIKit.h>
#import <vector>
#import <algorithm>
#import "ObjectPool.h"
#import "GLObject.h"
#import "GLSpriteBatchPoint.h"
#import "GLTextureSprite.h"

// -------------------------------------------------------------------
// GLImageBatch is a batch image render object, 
// it does nothing fancy but will fill the object
// the desired texture.
// -------------------------------------------------------------------
class GLSpriteBatch : public GLObject
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLSpriteBatch( const GLTextureSprite * _texture = nil, NSUInteger _capacity = 10, CGSize _size = CGSizeMake(32,32) );
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLSpriteBatch();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// set the texture object
	inline void setTexture(const GLTextureSprite * _texture) { m_texture = _texture; };
	// access the texture object
	inline const GLTextureSprite * texture() const { return m_texture; };
	// access the total number of frames
	inline NSUInteger frameCount() const { return m_texture->frameCount(); };
		
	// -------------------------------------------------------------
	// points overall settings
	// -------------------------------------------------------------
	
	// points master size
	inline const CGSize & pointsSize() const { return m_pointsSize; };
	inline void setPointsSize( CGSize _size ) { m_pointsSize = _size; };
	inline void setPointsSize( float _width, float _height ) { m_pointsSize.width = _width; m_pointsSize.height = _height; };
	inline void setPointsSize( float _size ) { m_pointsSize.width = _size; m_pointsSize.height = _size; };
	
	// points master scale
	inline const CGSize & pointsScale() const { return m_pointsScale; };
	inline void setPointsScale(CGSize _scale) { m_pointsScale = _scale; };
	inline void setPointsScale(float _width, float _height) { m_pointsScale.width = _width; m_pointsScale.height = _height; };
	inline void setPointsScale(float _scale) { m_pointsScale.width = _scale; m_pointsScale.height = _scale; };	
	
	// points master rotation
	inline float pointsRotation() const { return m_pointsRotation; };
	inline void setPointsRotation( float _rotation ) { m_pointsRotation = _rotation; };
	
	// points master alpha value
	inline float pointsAlpha() const { return m_pointsColor.alpha(); };
	inline void setPointsAlpha(float _alpha) { m_pointsColor.setAlpha(_alpha); };
	
	// points master color
	inline const GLColor & pointsColor() const { return m_pointsColor; };
	inline void setPointsColor(float _red, float _green, float _blue, float _alpha=1.0f) { m_pointsColor.setColor(_red,_green,_blue,_alpha); };
	inline void setPointsColor(const GLColor & _color) { m_pointsColor.setColor(_color); };
	inline void setPointsColor(const UIColor * _color) { m_pointsColor.setColor(_color); };
	
	// -------------------------------------------------------------
	
	// -------------------------------------------------------------
	// points setup and access
	// -------------------------------------------------------------
	// access the number of objects
	inline NSInteger count() const { return m_points.size(); };
	inline NSInteger capacity() const { return m_points.capacity(); };
	inline void clear();
	
	// add a new point to the batch
	GLSpriteBatchPoint * add( CGPoint _center = CGPointZero );
	
	// add a batch of points
	void addBatch( NSInteger _count, CGPoint _center = CGPointZero );
	
	// remove a point from the vector
	void remove( NSInteger _index );
	void remove( GLSpriteBatchPoint * _point );
	
	// get a points position
	inline GLSpriteBatchPoint * getPoint( NSInteger _index ) { return m_points[_index]; };
	inline const GLSpriteBatchPoint * point( NSInteger _index ) const { return m_points[_index]; };
	// -------------------------------------------------------------
	
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
	
	const GLTextureSprite * m_texture;
	
	// point variables
	// These will be used at the 
	// render stage and be multiplied
	// in with each point.
	CGSize		m_pointsSize;
	CGSize		m_pointsScale;
	float		m_pointsRotation;
	GLColor		m_pointsColor;
	
	// object pool
	ObjectPool<GLSpriteBatchPoint>	m_pool;
	
	// set off offset points.
	std::vector<GLSpriteBatchPoint*> m_points;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif
