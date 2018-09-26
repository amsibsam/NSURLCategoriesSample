//
//  ProfileViewController.m
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import "ProfileViewController.h"
#import "NetworkUtil.h"
#import "NSURLSession+RequestHelper.h"

@interface ProfileViewController ()
@property (strong, nonatomic) UIImageView *ivQR;
@property (strong, nonatomic) UITextField *tfValue;
@property (strong, nonatomic) UIButton *btnGenerate;
@property (strong, nonatomic) CIImage *ciQrImage;

@end

@implementation ProfileViewController

- (instancetype)init 
{
    self = [super init];
    if (self) {
        _ivQR = [[UIImageView alloc] init];
        _tfValue = [[UITextField alloc] init];
        _btnGenerate = [[UIButton alloc] init];
        
#pragma mark ivQR configuration
        _ivQR.translatesAutoresizingMaskIntoConstraints = false;
        _ivQR.backgroundColor = UIColor.blackColor;
        
#pragma mark tfValue configuration
        _tfValue.translatesAutoresizingMaskIntoConstraints = false;
        _tfValue.font = [UIFont systemFontOfSize:16];
        _tfValue.textAlignment = NSTextAlignmentCenter;
        _tfValue.clipsToBounds = YES;
        _tfValue.backgroundColor = UIColor.lightGrayColor;
        [_tfValue layer].cornerRadius = 8;
        
#pragma mark btnGenerate configuration
        _btnGenerate.translatesAutoresizingMaskIntoConstraints = false;
        _btnGenerate.clipsToBounds = true;
        _btnGenerate.backgroundColor = UIColor.cyanColor;
        [_btnGenerate setTitle:@"Generate" forState:UIControlStateNormal];
        [_btnGenerate setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btnGenerate setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
        [_btnGenerate layer].cornerRadius = 8;
        [_btnGenerate addTarget:self action:@selector(generateQR) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    __weak ProfileViewController *weakSelf = self;
    [[NSURLSession sharedSession] request:@"http://crysdip.herokuapp.com/api/mahasiswa/login" withMethod:@"POST" andParams:@{@"nim": @"13520244022", @"password": @"13520244022"} timeout:30 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [weakSelf generateQR];
        
        if (data != NULL) {
            NSJSONSerialization *jsonSerialize = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
            NSDictionary *jsonDictionary = (NSDictionary*) jsonSerialize;
            NSLog(@"response regiser %@", jsonDictionary);
            NSDictionary *mahasiswa = (NSDictionary*) [jsonDictionary valueForKey:@"mahasiswa"];
            NSString *alamat = (NSString*) [mahasiswa valueForKey:@"alamat"];
            
            NSLog(@"alamat %@", alamat);
        } else if (error != NULL) {
            NSLog(@"error request %@", error.userInfo);
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI {
#pragma mark INITIAL SETUP
    [self.navigationController navigationBar].translucent = NO;
    [self view].backgroundColor = [UIColor whiteColor];
    
#pragma mark ADDING SUBVIEW
    [self.view addSubview:_ivQR];
    [self.view addSubview:_tfValue];
    [self.view addSubview:_btnGenerate];
    
#pragma mark
    [self setupConstraint];
}

- (void)setupConstraint {
    NSArray *constraintArray = [[NSArray alloc] initWithObjects:
                                #pragma mark ivQR constraint
                                [_ivQR.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                [_ivQR.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],
                                [_ivQR.heightAnchor constraintEqualToConstant:100],
                                [_ivQR.widthAnchor constraintEqualToConstant:100],
                                
                                #pragma mark tfValue constraint
                                [_tfValue.topAnchor constraintEqualToAnchor:_ivQR.bottomAnchor constant:18],
                                [_tfValue.heightAnchor constraintEqualToConstant:30],
                                [_tfValue.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
                                [_tfValue.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
                                
                                #pragma mark btnGenerate constraint
                                [_btnGenerate.topAnchor constraintEqualToAnchor:_tfValue.bottomAnchor constant:10],
                                [_btnGenerate.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                [_btnGenerate.heightAnchor constraintEqualToConstant:30],
                                [_btnGenerate.widthAnchor constraintEqualToConstant:100],
                                nil
                                ];
    [NSLayoutConstraint activateConstraints:constraintArray];
}

- (void)generateQR {
    __weak NSString *value = _tfValue.text;
    NSData *qrData = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:qrData forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    _ciQrImage = filter.outputImage;
    
    _ivQR.image = [UIImage imageWithCIImage:_ciQrImage];
}

- (void)dealloc
{
    
}

@end
