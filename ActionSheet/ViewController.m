//
//  ViewController.m
//  ActionSheet
//
//  Created by Zhao Fei on 16/9/28.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//

#import "ViewController.h"
#import "ZFActionSheet.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *btn;

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

- (IBAction)clickBtn:(id)sender {
    NSLog(@"click btn to show action sheet");
    
    ZFActionSheet *actionSheet = [ZFActionSheet actionSheetWithTitle:@"Missing country code" description:@"Your contact’s phone number is missing a country code. To add this contact, confirm or update the country code."];
    

    [actionSheet setCancelButtonWithTitle:@"Cancel" block:^{
        NSLog(@"Cancel");
    }];
    
    [actionSheet addButtonWithTitle:@"Confirm" atIndex:0 block:^{
        NSLog(@"Confirm");
    }];
    
    [actionSheet addButtonWithTitle:@"Select another country code" atIndex:1 block:^{
        NSLog(@"Select another country code");
    }];
    
    [actionSheet showInView:self.view];
}

@end
