//
//  PeepingPagingViewController.m
//  LXPagingViewsDemo
//
//  Created by Stan Chang Khin Boon on 9/2/12.
//  Copyright (c) 2012 d--buzz. All rights reserved.
//

#import "PeepingPagingViewController.h"
#import "PeepingPagingView.h"
#import "PageView.h"

@implementation PeepingPagingViewController

@synthesize peepingPagingView = _peepingPagingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"PeepingPagingView";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.peepingPagingView = [[PeepingPagingView alloc] initWithFrame:self.view.bounds insetsOfPageView:UIEdgeInsetsMake(0.0f, 110.0f, 0.0f, 110.0f)];
    self.peepingPagingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.peepingPagingView setPagingViewDataSource:self delegate:self];
    [self.view addSubview:self.peepingPagingView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)theToInterfaceOrientation duration:(NSTimeInterval)theDuration {
    [self.peepingPagingView.pagingView willAnimateRotationToInterfaceOrientation:theToInterfaceOrientation duration:theDuration];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)theToInterfaceOrientation duration:(NSTimeInterval)theDuration {
    [self.peepingPagingView.pagingView willRotateToInterfaceOrientation:theToInterfaceOrientation duration:theDuration];
}

#pragma mark - PagingViewDelegate methods

- (NSInteger)numberOfItemsInPagingView:(PagingView *)thePagingView {
    return 10;
}

- (UIView<ReusableView> *)pagingView:(PagingView *)thePagingView reusableViewForPageIndex:(NSUInteger)thePageIndex withFrame:(CGRect)theFrame {
    static NSString *theIdentifier = @"PageView";
    PageView *thePageView = (PageView *)[thePagingView dequeueReusableViewWithIdentifier:theIdentifier];
    if (thePageView == nil) {
        thePageView = [[PageView alloc] initWithFrame:theFrame];
    } else {
        thePageView.frame = theFrame;
    }
    
    switch (thePageIndex % 3) {
        case 0: {
            thePageView.backgroundColor = [UIColor redColor];
        } break;
        case 1: {
            thePageView.backgroundColor = [UIColor greenColor];
        } break;
        case 2: {
            thePageView.backgroundColor = [UIColor blueColor];
        } break;
        default: {
        } break;
    }
    thePageView.textLabel.text = [NSString stringWithFormat:@"%u", thePageIndex];
    
    return thePageView;
}

@end
