/*
 *  GLEngine.h
 *  Electric2D
 *
 *  Created by robert on 14/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLEngine_h__)
#define __GLEngine_h__

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/EAGLDrawable.h>
#import <QuartzCore/QuartzCore.h>

#import "GLEngineLayerTypes.h"

class GLRender;
class GLCamera;
class GLBackground;
class GLTexture;
class GLTextureSprite;
class GLObjectHierarchy;
class GLImage;
class GLSprite;
class GLModel;
class GLLabel;
class GLLine;
class GLImageBatch;
class GLSpriteBatch;

// ------------------------------------------------------
// GLEngine is a class that provides code to setup
// and create an OpenGL render view
// ------------------------------------------------------
class GLEngine
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLEngine(CAEAGLLayer * _layer, UIColor * _clearColor = nil, eGLEngineOrientation _orientation = eGLEngineOrientationPortrait, Boolean _useDepthBuffer = FALSE);
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLEngine();

#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public:	// Functions
		
	// --------------------------------------------------
	// create the Frame Buffer
	// --------------------------------------------------
	Boolean createFrameBuffer();
	
	// --------------------------------------------------
	// destroy the Frame Buffer
	// --------------------------------------------------
	void destroyFrameBuffer();
	
	// --------------------------------------------------
	// rebind the context
	// --------------------------------------------------
	void rebindContext();
	
	// --------------------------------------------------
	// Render the current scene
	// --------------------------------------------------
	void render();
	
	// --------------------------------------------------
	// height / width of the render area
	// --------------------------------------------------
	inline float height() const { return m_backingHeight; };
	inline float width() const { return m_backingWidth; };
	// --------------------------------------------------

	// --------------------------------------------------
	// Access the camrea Object
	// --------------------------------------------------
	GLCamera * camera();
	// --------------------------------------------------
	
	// --------------------------------------------------
	// access the background object
	// --------------------------------------------------
	GLBackground * background();
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLObjectHierarchy functions
	// --------------------------------------------------
	Boolean add( GLObjectHierarchy * _hierarchy, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLObjectHierarchy * _hierarchy );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLImage functions
	// --------------------------------------------------
	Boolean add( GLImage * _image, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLImage * _image );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLSprite functions
	// --------------------------------------------------
	Boolean add( GLSprite * _sprite, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLSprite * _sprite );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLModel functions
	// --------------------------------------------------
	Boolean add( GLModel * _model, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLModel * _model );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLLabel functions
	// --------------------------------------------------
	Boolean add( GLLabel * _label, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLLabel * _label );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLLine functions
	// --------------------------------------------------
	Boolean add( GLLine * _line, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLLine * _line );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLImageBatch functions
	// --------------------------------------------------
	Boolean add( GLImageBatch * _image, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLImageBatch * _image );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLSprite functions
	// --------------------------------------------------
	Boolean add( GLSpriteBatch * _sprite, eGLEngineLayerTypes _layer = eGLEngineLayerTypes_0 );
	Boolean remove( GLSpriteBatch * _sprite );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// GLTexture Functions
	// --------------------------------------------------	
	const GLTexture * createTexture( const NSString * _name );
	const GLTextureSprite * createTextureSprite( const NSString * _name );
	
	void releaseTexture( const GLTexture * _texture );
	void releaseTexture( const GLTextureSprite * _texture );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// Utility Funcions
	// --------------------------------------------------
	CGRect  viewPort();
	CGPoint viewPointToWorldPoint( const CGPoint & _point );	// Full Screen Only at this time
	
	float pixelsToWorldScale (float _pixels);
	float worldToPixelScale  (float _world);
	float pixelToWorldScale();	// pixels to world scale
	void  setPixelToWorldScale( float _scale );	// world pixel scale
	
	float fps() const;
	void displayFps( Boolean _display );
	// --------------------------------------------------
	
	// --------------------------------------------------
	// Print the stats to the console
	// --------------------------------------------------
	void printStats();
	// --------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Functions

	// initailise the GL state
	void initState();
		
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	// render layer
	CAEAGLLayer * m_layer;
	
	// GL Context
	EAGLContext * m_context;
	
	// class that will handle 
	// the rendering and management
	// of the GLObjects
	GLRender *	m_glRender;
	
	// The pixel dimensions of the backbuffer
    GLint m_backingWidth;
    GLint m_backingHeight;
	
	// OpenGL names for the renderbuffer and 
	// framebuffers used to render to this view
    GLuint m_viewRenderbuffer;
	GLuint m_viewFramebuffer;
    
    // OpenGL name for the depth buffer that 
	// is attached to viewFramebuffer, if it 
	// exists (0 if it does not exist)
    GLuint m_depthRenderbuffer;
	
	// screen orientation
	eGLEngineOrientation m_orientation;
	
	// Booleans
	Boolean m_depthBuffer;
	Boolean m_buffersCreated;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------
};

#endif
