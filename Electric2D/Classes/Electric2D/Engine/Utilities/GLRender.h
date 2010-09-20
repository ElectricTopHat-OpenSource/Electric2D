/*
 *  GLRender.h
 *  Electric2D
 *
 *  Created by robert on 15/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#if !defined(__GLRender_h__)
#define __GLRender_h__

#import <OpenGLES/ES1/gl.h>
#import <vector>

#import "GLFPS.h"
#import "GLCamera.h"
#import "GLBackground.h"
#import "GLColor.h"
#import "GLEngineLayerTypes.h"
#import "GLRenderBatch.h"
#import "GLTextureBank.h"

class GLTexture;
class GLTextureSprite;

class GLObject;
class GLObjectHierarchy;

class GLLine;
class GLLabel;
class GLImage;
class GLSprite;
class GLModel;
class GLImageBatch;
class GLSpriteBatch;

// ------------------------------------------------------
// Base render class.
//
// ------------------------------------------------------
class GLRender
{
#pragma mark ---------------------------------------------------------
#pragma mark Constructor / Destructor
#pragma mark ---------------------------------------------------------
public: // Functions
	
	// --------------------------------------------------
	// Constructor
	// --------------------------------------------------
	GLRender();
	
	// --------------------------------------------------
	// Destructor
	// --------------------------------------------------
	~GLRender();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Constructor / Destructor
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Public Functions
#pragma mark ---------------------------------------------------------
public: // Functions
	
	inline Boolean    isUILayout() const { return m_renderBatch.isUILayout(); };
	inline void		  setUILayout(Boolean _uilayout) { m_renderBatch.setUILayout( _uilayout ); };
	
	// --------------------------------------------------
	// camera View Port
	// --------------------------------------------------
	inline const CGRect & viewPort() const { return m_viewPort; }
	// --------------------------------------------------
	
	// --------------------------------------------------
	// set the frame width and height
	// --------------------------------------------------
	inline float frameWidth() const { return m_viewPort.size.width; };
	inline float frameHeight() const { return m_viewPort.size.height; };
	// --------------------------------------------------
	
	// --------------------------------------------------
	// Clean up the render objects
	// --------------------------------------------------
	void cleanup();
	
	// --------------------------------------------------
	// Render state setup
	// --------------------------------------------------
	void setup(float _frameWidth, float _frameHeight);
	
	// --------------------------------------------------
	// Render state setup
	// --------------------------------------------------
	void teardown();
	
	// --------------------------------------------------
	// Render All contained objects the current scene
	// --------------------------------------------------
	void render();
	
	// --------------------------------------------------
	// Access the camera object
	// --------------------------------------------------
	inline GLCamera * camera() { return &m_camera; };
	// --------------------------------------------------
	
	// --------------------------------------------------
	// Access the Background object
	// --------------------------------------------------
	inline GLBackground * background() { return &m_background; };
	// --------------------------------------------------
	
	// ----------------------------------------
	// GLObject functions
	// ----------------------------------------
	Boolean add( GLObject * _object, eGLEngineLayerTypes _layer );
	Boolean remove( GLObject * _object );
	// ----------------------------------------
	
	// ----------------------------------------
	// GLTexture Functions
	// ----------------------------------------	
	inline const GLTexture * createTexture( const NSString * _name ) { return m_textures.load(_name); };
	inline const GLTextureSprite * createTextureSprite( const NSString * _name ) { return m_textures.loadSprite(_name); };
	
	inline void releaseTexture( const GLTexture * _texture ) { m_textures.release(_texture); };
	inline void releaseTexture( const GLTextureSprite * _texture ) { m_textures.release(_texture); };
	// ----------------------------------------
	
	// ----------------------------------------
	// Utility Funcions
	// ----------------------------------------
	inline float pixelsToWorldScale (float _pixels) { return _pixels / m_worldScale; };
	inline float worldToPixelScale  (float _world)  { return _world * m_worldScale; };
	
	inline float pixelToWorldScale()	{ return m_worldScale; };	// pixels to world scale
	inline void  setPixelToWorldScale( float _scale ) // world pixel scale
	{ 
		m_worldScale = _scale;  
		m_viewPort.size.width  = pixelsToWorldScale(m_width);
		m_viewPort.size.height = pixelsToWorldScale(m_height);
	};
	
	// access the fps value
	inline float fps() const { return m_fps.fps(); };
	
	// display the fps on screen
	void displayFps( Boolean _display );
	// ----------------------------------------
	
	void printStats();
	
#pragma mark ---------------------------------------------------------
#pragma mark End Public Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Protected Functions
#pragma mark ---------------------------------------------------------
protected:	// Functions
	
#pragma mark ---------------------------------------------------------
#pragma mark End Protected Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------
private: // Functions
		
	// move the render area to the camera position
	inline void setupCamera();
	
	// render the fps
	inline void renderFPS();
	
	// render the backgound or clear the bit buffer
	inline void renderbackground();
	
	// render the ui
	inline void renderUI();
	
	// render the sceen object
	inline void renderObjects();
	
	// render a single layer
	inline void renderLayer( std::vector<GLObject*> & _objects );
	
	// render a single object
	inline void renderObject( GLObject * _object );
	
	// render a hierarchy
	inline void renderHierarchy( GLObjectHierarchy * _hierarchy );
	
	// render a single GLImage
	inline void renderImage( const GLImage * _image );
	// render a single GLImageBatch
	inline void renderImageBatch( const GLImageBatch * _image );
	
	// render a single GLSprite
	inline void renderSprite( const GLSprite * _sprite );
	// render a single GLSpriteBatch
	inline void renderSpriteBatch( const GLSpriteBatch * _sprite );
	
	// render a single model
	inline void renderModel( const GLModel * _model );
	
	// render a single GLLabel
	inline void renderLabel( GLLabel * _label );
	
	// render a single GLLine
	inline void renderLine( GLLine * _line );
	
	// draw a single texture
	inline BOOL bindTexture( const GLTexture * texture );
	inline void bindTexture( NSInteger _bindID );
	
	// clean up a layer
	inline void cleanupLayer( std::vector<GLObject*> & _objects );
	
	inline void addObjectToLayer( GLObject * _object, eGLEngineLayerTypes _layer );
	inline void removeObjectFromLayer( GLObject * _object, eGLEngineLayerTypes _layer );
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------
	
#pragma mark ---------------------------------------------------------
#pragma mark Private Data
#pragma mark ---------------------------------------------------------
private: // Data
	
	// ------------------------
	// View port
	// ------------------------
	CGRect		m_viewPort;
	float		m_width;
	float		m_height;
	float		m_worldScale;
	// ------------------------
	
	// ------------------------
	// fps counter
	// ------------------------
	GLFPS		m_fps;
	GLLabel *	m_fpsLabel;
	// ------------------------
	
	// ------------------------
	// camera object
	// ------------------------
	GLCamera	m_camera;
	// ------------------------
	
	// ------------------------
	// background texture
	// ------------------------
	GLBackground m_background;
	// ------------------------
	
	// ------------------------
	// Batch Triangle Render
	// ------------------------
	GLRenderBatch	m_renderBatch;
	// ------------------------
	
	// texture bank
	GLTextureBank m_textures;
	GLuint boundTexture;
	
	// render object layers array
	std::vector<GLObject*> m_renderLayers[GLEngineLayerTypesMaxNormalLayers];
	std::vector<GLObject*> m_renderLayerUI;
	
#pragma mark ---------------------------------------------------------
#pragma mark End Private Data
#pragma mark ---------------------------------------------------------	
};

#endif