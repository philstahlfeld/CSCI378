//
//  ImageViewController.m
//  FlickrApp
//
//  Created by Phil Stahlfeld on 2/18/13.
//  Copyright (c) 2013 Phil Stahlfeld. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
 
@end

@implementation ImageViewController
@synthesize imageView = _imageView;
@synthesize image = _image;
@synthesize scrollView = _scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imageView.image = self.image;
    self.scrollView.contentSize = self.image.size;
    self.imageView.frame = CGRectMake(0, 0, 20, 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
