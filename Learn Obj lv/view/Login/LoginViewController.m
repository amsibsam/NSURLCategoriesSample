//
//  LoginViewController.m
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "NetworkUtil.h"
#import "NSURLSession+RequestHelper.h"

@interface LoginViewController () <NetworkDelegate> {
    NetworkUtil *networkUtil;
}
@property (strong, nonatomic) IBOutlet UITextField *lbEmail;
@property (strong, nonatomic) IBOutlet UITextField *lbPassword;

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        networkUtil = [[NetworkUtil alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    networkUtil.delegate = self;
    
//    [[NSURLSession sharedSession] request:@"https://x.rajaapi.com/poe" withMethod:@"GET" completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSJSONSerialization *jsonSerialize = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
//        NSDictionary *jsonDictionary = (NSDictionary*) jsonSerialize;
//        NSString *token = [NSString stringWithFormat:@"%@", [jsonDictionary valueForKey:@"token"]];
//        NSLog(@"Got response %@", jsonDictionary);
//        NSLog(@"Token %@", token);
//    }];
    
    NSDictionary *params = @{@"nim": @"13520244022", @"password": @"13520244022"};
    [[NSURLSession sharedSession] request:@"http://crysdip.herokuapp.com/api/mahasiswa/login" withMethod:@"POST" andParams:params timeout:10 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != NULL) {
            NSJSONSerialization *jsonSerialize = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
            NSDictionary *jsonDictionary = (NSDictionary*) jsonSerialize;
            NSLog(@"response regiser %@", jsonDictionary);
        } else if (error != NULL) {
            NSLog(@"error request %@", error.userInfo);
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginDidTap:(UIButton *)sender {
    [networkUtil doNetworkRequest];
    [self.navigationController pushViewController:[[ProfileViewController alloc] init] animated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)successGetData:(NSString *)data {
    NSLog(@"success %@", data);
}

@end
