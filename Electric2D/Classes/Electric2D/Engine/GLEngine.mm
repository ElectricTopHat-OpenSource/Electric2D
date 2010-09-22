/*
 *  GLEngine.cpp
 *  Electric2D
 *
 *  Created by robert on 14/04/2009.
 *  Copyright 2009 Electric TopHat. All rights reserved.
 *
 */

#import "GLEngine.h"
#import "GLRender.h" 

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Constructor
// --------------------------------------------------
GLEngine::GLEngine(CAEAGLLayer * _layer, UIColor * _clearColor, eGLEngineOrientation _orientation, Boolean _useDepthBuffer)
{	
	// grab the layer pointer
	m_layer = [_layer retain];
	
	m_layer.opaque = YES;
	m_layer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], 
																		    kEAGLDrawablePropertyRetainedBacking, 
																			kEAGLColorFormatRGB565, 
																			kEAGLDrawablePropertyColorFormat, 
																			nil];
	
	// Allocate the OpenGL context
	m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	
	// set the current Context
	[EAGLContext setCurrentContext:m_context];
	
	GLColor clearColor( _clearColor );
	glClearColor(clearColor.red(), clearColor.green(), clearColor.blue(), 0.0f);
	
	m_glRender = new GLRender();
	
	// init the other variables
	m_orientation = _orientation;
	m_depthBuffer = _useDepthBuffer;
	m_buffersCreated = NO;
	m_backingWidth = _layer.bounds.size.width;
	m_backingHeight = _layer.bounds.size.height;
	m_viewRenderbuffer = 0;
	m_viewFramebuffer = 0;
	m_depthRenderbuffer = 0;	
}

// --------------------------------------------------
// Destructor
// --------------------------------------------------
GLEngine::~GLEngine()
{
	// clean up the render objects
	// before we taredown the gl context
	m_glRender->cleanup();
	delete(m_glRender);
	m_glRender = nil;
	
	[m_layer release];
	
	if ([EAGLContext currentContext] == m_context) 
	{
        [EAGLContext setCurrentContext:nil];
    }
	[m_context release];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// create the Frame Buffer
// --------------------------------------------------
Boolean GLEngine::createFrameBuffer()
{
	if ( m_buffersCreated == NO )
	{
		glGenRenderbuffersOES(1, &m_viewRenderbuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_viewRenderbuffer);
		
		[m_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:m_layer];
		
		glGenFramebuffersOES(1, &m_viewFramebuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, m_viewFramebuffer);
		
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, m_viewRenderbuffer);
		
		glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &m_backingWidth);
		glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &m_backingHeight);
		
		if (m_depthBuffer) 
		{
			glGenRenderbuffersOES(1, &m_depthRenderbuffer);
			glBindRenderbufferOES(GL_RENDERBUFFER_OES, m_depthRenderbuffer);
			glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, m_backingWidth, m_backingHeight);
			glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, m_depthRenderbuffer);
		}
		
		if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) 
		{
			NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
			return NO;
		}
    
		initState();
		
		m_buffersCreated = YES;
		return YES;
	}
    return NO;
}

// --------------------------------------------------
// destroy the Frame Buffer
// --------------------------------------------------
void GLEngine::destroyFrameBuffer()
{
	m_glRender->teardown();
	
	glDeleteFramebuffersOES(1, &m_viewFramebuffer);
    glDeleteRenderbuffersOES(1, &m_viewRenderbuffer);
    
    if(m_depthRenderbuffer) 
	{
        glDeleteRenderbuffersOES(1, &m_depthRenderbuffer);
    }
	
	m_backingWidth = 0;
	m_backingHeight = 0;
	m_viewFramebuffer = 0;
	m_viewRenderbuffer = 0;
	m_depthRenderbuffer = 0;
	m_buffersCreated = NO;
}

// --------------------------------------------------
// rebind the context
// --------------------------------------------------
void GLEngine::rebindContext()
{
	// force the context to be set
	[EAGLContext setCurrentContext:m_context];
	
	// rebuild the frame buffers
    destroyFrameBuffer();
    createFrameBuffer();
    
	// force a redraw.
	render();
}

// --------------------------------------------------
// Render the current scene
// --------------------------------------------------
void GLEngine::render()
{	
	//glMatrixMode(GL_MODELVIEW);	
    //glLoadIdentity();
	
	// Render objects
	m_glRender->render();
	
	// force the reder buffer to be displayed
    [m_context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// --------------------------------------------------
// Access the camrea Object
// --------------------------------------------------
GLCamera * GLEngine::camera() 
{ 
	return m_glRender->camera(); 
}
// --------------------------------------------------

// --------------------------------------------------
// access the background object
// --------------------------------------------------
GLBackground * GLEngine::background() 
{ 
	return m_glRender->background(); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLObjectHierarchy functions
// --------------------------------------------------
Boolean GLEngine::add( GLObjectHierarchy * _hierarchy, eGLEngineLayerTypes _layer )			
{ 
	return m_glRender->add((GLObject*)_hierarchy,_layer); 
}

Boolean GLEngine::remove( GLObjectHierarchy * _hierarchy )
{ 
	return m_glRender->remove((GLObject*)_hierarchy); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLImage functions
// --------------------------------------------------
Boolean GLEngine::add( GLImage * _image, eGLEngineLayerTypes _layer )			
{ 
	return m_glRender->add((GLObject*)_image,_layer); 
}

Boolean GLEngine::remove( GLImage * _image )
{ 
	return m_glRender->remove((GLObject*)_image); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLSprite functions
// --------------------------------------------------
Boolean GLEngine::add( GLSprite * _sprite, eGLEngineLayerTypes _layer )
{ 
	return m_glRender->add((GLObject*)_sprite,_layer); 
}

Boolean GLEngine::remove( GLSprite * _sprite )
{ 
	return m_glRender->remove((GLObject*)_sprite); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLModel functions
// --------------------------------------------------
Boolean GLEngine::add( GLModel * _model, eGLEngineLayerTypes _layer )
{ 
	return m_glRender->add((GLObject*)_model,_layer); 
}

Boolean GLEngine::remove( GLModel * _model )
{ 
	return m_glRender->remove((GLObject*)_model); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLSprite functions
// --------------------------------------------------
Boolean GLEngine::add( GLLabel * _label, eGLEngineLayerTypes _layer )
{ 
	return m_glRender->add((GLObject*)_label,_layer); 
}

Boolean GLEngine::remove( GLLabel * _label )
{ 
	return m_glRender->remove((GLObject*)_label); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLLine functions
// --------------------------------------------------
Boolean GLEngine::add( GLLine * _line, eGLEngineLayerTypes _layer )
{
	return m_glRender->add((GLObject*)_line,_layer); 
}

Boolean GLEngine::remove( GLLine * _line )
{
	return m_glRender->remove((GLObject*)_line);
}
// --------------------------------------------------

// --------------------------------------------------
// GLImageBatch functions
// --------------------------------------------------
Boolean GLEngine::add( GLImageBatch * _image, eGLEngineLayerTypes _layer )
{
	return m_glRender->add((GLObject*)_image,_layer);
}

Boolean GLEngine::remove( GLImageBatch * _image )
{
	return m_glRender->remove((GLObject*)_image); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLSprite functions
// --------------------------------------------------
Boolean GLEngine::add( GLSpriteBatch * _sprite, eGLEngineLayerTypes _layer )
{
	return m_glRender->add((GLObject*)_sprite,_layer);
}

Boolean GLEngine::remove( GLSpriteBatch * _sprite )
{
	return m_glRender->remove((GLObject*)_sprite); 
}
// --------------------------------------------------

// --------------------------------------------------
// GLTexture Functions
// --------------------------------------------------
const GLTexture * GLEngine::createTexture( const NSString * _name )
{ 
	return m_glRender->createTexture(_name); 
}

const GLTextureSprite * GLEngine::createTextureSprite( const NSString * _name )
{ 
	return m_glRender->createTextureSprite(_name); 
}

void GLEngine::releaseTexture( const GLTexture * _texture )
{	
	m_glRender->releaseTexture(_texture); 
}

void GLEngine::releaseTexture( const GLTextureSprite * _texture )
{	
	m_glRender->releaseTexture(_texture); 
}
// --------------------------------------------------

// --------------------------------------------------
// access the view port
// --------------------------------------------------
CGRect GLEngine::viewPort()
{
	const CGRect & viewPort = m_glRender->viewPort();
	const CGPoint & pos = camera()->position();
	float x = -((viewPort.size.width*0.5f) - pos.x);
	float y = -((viewPort.size.height*0.5f) - pos.y);
	
	return CGRectMake(x, y, viewPort.size.width, viewPort.size.height);
}

// --------------------------------------------------
// View point translated in a world point
// --------------------------------------------------
CGPoint GLEngine::viewPointToWorldPoint( const CGPoint & _point )
{
	// TODO : take into account that we don't fully cover the screen
	const CGRect & viewPort = m_glRender->viewPort();
	
	const CGPoint & pos = camera()->position();
	float x = -((viewPort.size.width*0.5f) - pos.x);
	float y = -((viewPort.size.height*0.5f) - pos.y);
	
	return CGPointMake( x + _point.x, y + _point.y );
}

// --------------------------------------------------
// change pixels to the world scale
// --------------------------------------------------
float GLEngine::pixelsToWorldScale (float _pixels)
{
	return m_glRender->pixelsToWorldScale( _pixels );
}

// --------------------------------------------------
// change the world scale to pixels
// --------------------------------------------------
float GLEngine::worldToPixelScale  (float _world)
{
	return m_glRender->worldToPixelScale( _world );
}

// --------------------------------------------------
// return the pixel to world scale factor
// --------------------------------------------------
float GLEngine::pixelToWorldScale()
{
	return m_glRender->pixelToWorldScale();
}

// --------------------------------------------------
// set the pixel to world scale factor
// --------------------------------------------------
void GLEngine::setPixelToWorldScale( float _scale )
{
	m_glRender->setPixelToWorldScale( _scale );
}

// --------------------------------------------------
// get the fps
// --------------------------------------------------
float GLEngine::fps() const	
{ 
	return m_glRender->fps(); 
}
// --------------------------------------------------
// get the fps
// --------------------------------------------------
void GLEngine::displayFps( Boolean _display )
{ 
	m_glRender->displayFps(_display); 
}

// --------------------------------------------------
// print the stats to the log file or console window
// --------------------------------------------------
void GLEngine::printStats()
{
	m_glRender->printStats();
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark Private Functions
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// initailise the GL state
// --------------------------------------------------
void GLEngine::initState()
{
	glViewport(0, 0, m_backingWidth, m_backingHeight);
		
	glMatrixMode(GL_PROJECTION);	
    glLoadIdentity();
	m_glRender->setUILayout( FALSE );
	switch ( m_orientation )
	{
		default:
		case eGLEngineOrientationPortrait:
		{
			glOrthof(0, m_backingWidth, 0, m_backingHeight, -1, 1);
			break;
		}
		case eGLEngineOrientationPortraitUpsideDown:
		{
			glRotatef(-180,0,0,1);
			glOrthof(0, m_backingWidth, 0, m_backingHeight, -1, 1);
			break;
		}
		case eGLEngineOrientationLandscapeLeft:
		{
			glRotatef(-90,0,0,1);
			glOrthof(0, m_backingWidth, 0, m_backingHeight, -1, 1);
			break;
		}
		case eGLEngineOrientationLandscapeRight:
		{
			glRotatef(90,0,0,1);
			glOrthof(0, m_backingWidth, 0, m_backingHeight, -1, 1);
			break;
		}
		case eGLEngineOrientationiPhoneUI:
		{
			glOrthof(0, m_backingWidth, m_backingHeight, 0, -1, 1);
			m_glRender->setUILayout( TRUE );
			break;
		}
	}
	
    glMatrixMode(GL_MODELVIEW);	
    glLoadIdentity();
	
	m_glRender->setup(m_backingWidth, m_backingHeight);
}

#pragma mark ---------------------------------------------------------
#pragma mark End Private Functions
#pragma mark ---------------------------------------------------------