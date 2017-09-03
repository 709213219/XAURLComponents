//
//  ViewController.m
//  XAURLComponents
//
//  Created by 叶晓倩 on 2017/8/31.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLComponents *c = [NSURLComponents componentsWithString:@"http://www.baidu.com:8080?name=123&value=456"];
    NSLog(@"%@", c.string);
    NSLog(@"%@", c.queryItems);
    NSLog(@"%@", NSStringFromRange(c.rangeOfScheme));
    NSLog(@"%@", NSStringFromRange(c.rangeOfUser));
    NSLog(@"%@", NSStringFromRange(c.rangeOfPassword));
    NSLog(@"%@", NSStringFromRange(c.rangeOfHost));
    NSLog(@"%@", NSStringFromRange(c.rangeOfPort));
    NSLog(@"%@", NSStringFromRange(c.rangeOfPath));
    NSLog(@"%@", NSStringFromRange(c.rangeOfQuery));
    NSLog(@"%@", NSStringFromRange(c.rangeOfFragment));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
