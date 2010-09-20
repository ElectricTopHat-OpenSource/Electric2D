//
//  GLEngineLayerTypes.h
//  Electric2D
//
//  Created by Robert on 26/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLEngineLayerTypes_h__)
#define __GLEngineLayerTypes_h__

typedef enum
{
	eGLEngineOrientationPortrait = 0,
	eGLEngineOrientationPortraitUpsideDown,
	eGLEngineOrientationLandscapeLeft,
	eGLEngineOrientationLandscapeRight,
	eGLEngineOrientationiPhoneUI,
	
} eGLEngineOrientation;

typedef enum 
{
	eGLEngineLayerTypes_Invalid = -1,
	
	eGLEngineLayerTypes_0 = 0,
	eGLEngineLayerTypes_1,
	eGLEngineLayerTypes_2,
	eGLEngineLayerTypes_3,
	eGLEngineLayerTypes_4,
	eGLEngineLayerTypes_5,
	eGLEngineLayerTypes_6,
	eGLEngineLayerTypes_7,
	eGLEngineLayerTypes_8,
	
	eGLEngineLayerTypes_ui,
	
} eGLEngineLayerTypes;

const unsigned int GLEngineLayerTypesMaxNormalLayers = eGLEngineLayerTypes_8 + 1;

#endif
