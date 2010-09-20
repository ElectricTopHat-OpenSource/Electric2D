/*
 *  GLObject.mm
 *  ToccoRobo2-Prototype
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#include "GLObject.h"

#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLObject::GLObject(eGLObjectTypes _objectType)
{
	m_objectType = _objectType;
	m_layerType = eGLEngineLayerTypes_Invalid;
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLObject::~GLObject()
{
}

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------