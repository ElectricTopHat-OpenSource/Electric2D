//
//  GLImageBatchPoint.h
//  Electric2D
//
//  Created by Robert on 26/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLImageBatchPoint_h__)
#define __GLImageBatchPoint_h__

#import <UIKit/UIKit.h>

#import "GLColor.h"
#import "GLColors.h"

class GLImageBatchPoint
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLImageBatchPoint( CGPoint _center = CGPointZero, CGSize _scale = CGSizeMake(1.0f,1.0f), GLColor _color = GLColorWhite )
	{
		m_center	= _center;
		m_scale		= _scale;
		m_color		= _color;
		m_rotation  = 0.0f;
		m_data		= nil;
	};
	
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLImageBatchPoint()
	{
	}
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions

	inline const CGPoint &	center() const	{ return m_center; };	
	inline CGPoint &		getCenter()									{ return m_center; };
	inline void				setCenter( CGPoint _center )				{ m_center = _center; };
	inline void				setCenter( float _x, float _y )				{ m_center.x = _x; m_center.y = _y; };
	
	inline const CGSize &	scale() const								{ return m_scale; };
	inline CGSize &			getScale()									{ return m_scale; };
	inline void				setScale( CGSize _scale )					{ m_scale = _scale; };
	inline void				setScale( float _width, float _height)		{ m_scale.width = _width; m_scale.height = _height; };
	inline void				setScale( float _scale )					{ m_scale.width = _scale; m_scale.height = _scale; };
	
	inline const GLColor &	color() const								{ return m_color; };
	inline GLColor &		getColor()									{ return m_color; };
	inline void				setColor(const GLColor & _color)			{ m_color.setColor(_color); };
	inline void				setColor(const UIColor * _color)			{ m_color.setColor(_color); };
	
	inline float			alpha() const								{ return m_color.alpha(); };
	inline float &			getAlpha()									{ return m_color.getAlpha(); };
	inline void				setAlpha(float _alpha)						{ m_color.setAlpha(_alpha); };
	
	inline const float		rotation() const							{ return m_rotation; };
	inline float &			getRotation()								{ return m_rotation; };
	inline void				setRotation( float _rotation )				{ m_rotation = _rotation; };
	
	inline const void *		data() const								{ return m_data; };
	inline void *			getData()									{ return m_data; };
	inline void				setData( void * _data )						{ m_data = _data; };
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	CGPoint m_center;
	CGSize	m_scale;
	GLColor m_color;
	float	m_rotation;
	
	void *	m_data;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif