//
//  GLObjectTypes.h
//  Electric2D
//
//  Created by Robert on 03/06/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#if !defined(__GLObjectTypes_h__)
#define __GLObjectTypes_h__

typedef enum 
{
	eGLObjectImage = 0,
	eGLObjectSprite,
	eGLObjectLabel,
	eGLObjectLine,
	eGLObjectModel,
		
	eGLObjectImageBatch,
	eGLObjectSpriteBatch,
	
	eGLObjectHierarchy,
	
} eGLObjectTypes;

typedef enum
{
	eGLTextureCoordinatesLayout_LeftToRight_TopToBottom = 0,  /// Normal
	eGLTextureCoordinatesLayout_RightToLeft_TopToBottom,      /// Flip Horizontally
	eGLTextureCoordinatesLayout_LeftToRight_BottomToTop,	  /// Flip Vertically
	eGLTextureCoordinatesLayout_RightToLeft_BottomToTop,	  /// Flip Both Axis
	
} eGLTextureCoordinatesLayout;

#endif