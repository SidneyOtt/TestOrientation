//
//  ViewController.m
//  TestOrientation
//
//  Created by Sidney Ott on 2016-01-19.
//  Copyright © 2016 BCSA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UIDeviceOrientation currentDeviceOrientation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];

    // Initial device orientation
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
}

// Need this for to add support for upside down
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)deviceDidRotate:(NSNotification *)notification
{
    self.currentDeviceOrientation = [[UIDevice currentDevice] orientation];
    NSLog(@"orientation change %ld",(long)self.currentDeviceOrientation);
    switch (self.currentDeviceOrientation)
    {
        {
        case UIInterfaceOrientationPortrait:
            {
                self.label.text = @"Portrait";
            }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            {
                self.label.text = @"Portrait Upside Down";
            }
            break;
        case UIInterfaceOrientationLandscapeLeft:
            {
                self.label.text = @"Landscape Left";
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            {
                self.label.text = @"Landscape Right";
            }
            break;
        default:
            break;
        }
    }

}
@end
