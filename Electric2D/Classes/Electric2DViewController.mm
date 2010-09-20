//
//  Electric2DViewController.m
//  Electric2D
//
//  Created by robert on 28/04/2009.
//  Copyright 2009 Electric TopHat. All rights reserved.
//

#import "Electric2DViewController.h"
#import "GLTestGeneralView.h"
#import "GLTestImagesView.h"
#import "GLTestImageBatchView.h"
#import "GLTestSpritesView.h"
#import "GLTestSpriteBatchView.h"
#import "GLTestLabelsView.h"
#import "GLTestBackgroundView.h"
#import "GLTestCameraView.h"
#import "GLTestHierarchyView.h"
#import "GLTestLineView.h"
#import "GLTestWorldScaleView.h"
#import "GLTestModelView.h"

// -------------------------------------------------------------------
// update time defines
// -------------------------------------------------------------------
#define kUpdateFPS				60.0f // Hz
#define kUpdateSeconds			(1.0f / kUpdateFPS) // secs
#define kSkipTicks				(1000 / kUpdateFPS)
// -------------------------------------------------------------------

@interface Electric2DViewController (PrivateMethods)

- (void) removeSubView;
- (void) setSubView:(UIView*)_subview;

@end

@implementation Electric2DViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self removeSubView];
}

- (void) removeSubView
{
	if ( updateTimer )
	{
		[updateTimer invalidate];
		updateTimer = nil;
	}
	
	if ( subView )
	{
		[subView removeFromSuperview];
		[subView release];
		//NSLog( @"count %i\n", [subView retainCount] );
		subView = nil;
	}
}

- (void) setSubView:(UIView*)_subview
{
	if ( subView == nil )
	{
		CGRect frame = [[self view] frame];
		
		subView = _subview;
		subView = [subView initWithFrame:frame];
		[[self view] addSubview:subView];
		
		// create the update timer
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateSeconds target:subView selector:@selector(update) userInfo:nil repeats:YES];
	}
}

- (IBAction) actionShowGeneralView
{
	[self removeSubView];
	[self setSubView:[GLTestGeneralView alloc]];
}

- (IBAction) actionShowImageView
{
	[self removeSubView];
	[self setSubView:[GLTestImagesView alloc]];
}

- (IBAction) actionShowImageBatchView
{
	[self removeSubView];
	[self setSubView:[GLTestImageBatchView alloc]];
}

- (IBAction) actionShowSpriteView
{
	[self removeSubView];
	[self setSubView:[GLTestSpritesView alloc]];
}

- (IBAction) actionShowSpriteBatchView
{
	[self removeSubView];
	[self setSubView:[GLTestSpriteBatchView alloc]];
}

- (IBAction) actionShowTextView
{
	[self removeSubView];
	[self setSubView:[GLTestLabelsView alloc]];
}

- (IBAction) actionShowBackgroundView
{
	[self removeSubView];
	[self setSubView:[GLTestBackgroundView alloc]];
}

- (IBAction) actionShowCameraView
{
	[self removeSubView];
	[self setSubView:[GLTestCameraView alloc]];
}

- (IBAction) actionShowHierarchy
{
	[self removeSubView];
	[self setSubView:[GLTestHierarchyView alloc]];	
}

- (IBAction) actionShowLine
{
	[self removeSubView];
	[self setSubView:[GLTestLineView alloc]];		
}

- (IBAction) actionShowWorldScale
{
	[self removeSubView];
	[self setSubView:[GLTestWorldScaleView alloc]];
}

- (IBAction) actionShowModel
{
	[self removeSubView];
	[self setSubView:[GLTestModelView alloc]];
}

@end
