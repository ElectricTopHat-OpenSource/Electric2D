/*
 *  GLImageBatch.mm
 *  Electric2D
 *
 *  Created by robert on 24/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLImageBatch.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLImageBatch::GLImageBatch( const GLTexture * _texture, NSUInteger _capacity, CGSize _size )
:GLObject( eGLObjectImageBatch )
,m_pool(_capacity)
{	
	m_texture = _texture;
	
	m_pointsSize = _size;
	m_pointsScale = CGSizeMake(1.0f, 1.0f);
	m_pointsRotation = 0.0f;
	
	m_points.reserve(_capacity);
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLImageBatch::~GLImageBatch()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// remove all the points from the batch and return
// them to the object pool
// --------------------------------------------------
void GLImageBatch::clear() 
{
	for ( int i=0; i<m_points.size(); i++ )
	{
		m_pool.FreeInstance(m_points[i]);
	}
	m_points.clear(); 
}

// --------------------------------------------------
// add a new point to the batch
// --------------------------------------------------
GLImageBatchPoint * GLImageBatch::add( CGPoint _center ) 
{ 
	GLImageBatchPoint * point = m_pool.NewInstance();
	if ( point )
	{
		point->setCenter( _center );
		m_points.push_back(point); 
	}
	return point; 
};

// --------------------------------------------------
// Add a batch of points
// --------------------------------------------------
void GLImageBatch::addBatch( NSInteger _count, CGPoint _center )
{
	for ( int i=0; i<_count; i++ )
	{
		add(_center);
	}	
}

// --------------------------------------------------
// remove a point using it's index
// --------------------------------------------------
void GLImageBatch::remove( NSInteger _index ) 
{ 
	m_pool.FreeInstance(m_points[_index]); m_points.erase( m_points.begin() + _index ); 
}

// --------------------------------------------------
// remove a point
// --------------------------------------------------
void GLImageBatch::remove( GLImageBatchPoint * _point ) 
{ 
	m_points.erase(std::remove(m_points.begin(), m_points.end(), _point), m_points.end()); 
	m_pool.FreeInstance(_point); 
}

#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------