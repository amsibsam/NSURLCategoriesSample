//
//  ProfileViewController.m
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) UILabel *lblName;
@property (strong, nonatomic) UILabel *lblAddress;

@end

@implementation ProfileViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lblName = [[UILabel alloc] init];
        self.lblAddress = [[UILabel alloc] init];
        
        self.lblName.translatesAutoresizingMaskIntoConstraints = false;
        self.lblAddress.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
    [self.navigationController navigationBar].translucent = NO;
    [self view].backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lblName];
    [self.view addSubview:self.lblAddress];
    
    [self lblName].text = @"Hallow";
    
    [self setupConstraint];
}

- (void)setupConstraint {
    NSArray *constraint = [[NSArray alloc] initWithObjects:
                           [_lblName.topAnchor constraintEqualToAnchor:self.view.topAnchor constant: 20],
                           [_lblName.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant: 20],
                           [_lblName.heightAnchor constraintEqualToConstant:15],
                           nil];
    [NSLayoutConstraint activateConstraints:constraint];
}

@end
