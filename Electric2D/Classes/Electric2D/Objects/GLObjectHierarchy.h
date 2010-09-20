//
//  GLObjectHierarchy.h
//  Electric2D
//
//  Created by Robert on 05/07/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLObjectHierarchy_h__)
#define __GLObjectHierarchy_h__

#import <UIKit/UIKit.h>
#import <vector>
#import <algorithm>
#import "GLObject.h"

class GLObjectHierarchy :  public GLObject
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLObjectHierarchy( CGPoint _center = CGPointZero, NSInteger _capacity = 1 );
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLObjectHierarchy();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
	
	// access the center point
	inline const CGPoint & center() const { return m_center; };
	// set the center point
	inline void setCenter(CGPoint _center) { m_center = _center; };
	inline void setCenter(float _x, float _y) { m_center.x = _x; m_center.y = _y; };
	
	// get the rotation ( degrees )
	inline float rotation() const { return m_rotation; };
	// set the rotation ( degrees )
	inline void setRotation(float _rotation) { m_rotation = _rotation; };
	
	// access the image scale
	inline const CGSize & scale() const { return m_scale; };
	// set the image scale
	inline void setScale(CGSize _scale) { m_scale = _scale; };
	inline void setScale(float _width, float _height) { m_scale.width = _width; m_scale.height = _height; };
	inline void setScale(float _scale) { m_scale.width = _scale; m_scale.height = _scale; };
	
	inline NSInteger count() { return m_objects.size(); };
	inline GLObject * get( NSUInteger _index ) { return m_objects[_index]; };
	
	void add( GLObject * _obj );
	void insert( GLObject * _obj, NSUInteger _index );
	void remove( GLObject * _obj );
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data 
	
	CGPoint m_center;
	float   m_rotation;
	CGSize  m_scale;   
	
	std::vector<GLObject*> m_objects;

#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif
