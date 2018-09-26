//
//  LoginViewController.m
//  Learn ObcjC
//
//  Created by MTMAC16 on 21/09/18.
//  Copyright © 2018 bism. All rights reserved.
//

#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "NSURLSession+RequestHelper.h"
#import "SingletonObject.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *lbEmail;
@property (strong, nonatomic) IBOutlet UITextField *lbPassword;

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SingletonObject sharedInstance].value = @"ok";
    NSLog(@"value: %@", [SingletonObject sharedInstance].value);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginDidTap:(UIButton *)sender {
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
@end
