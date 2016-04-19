//
//  ContentSizeBasic.m
//  UIScrollViewDemo
//
//  Created by Tin Blanc on 4/18/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "ContentSizeBasic.h"

@implementation ContentSizeBasic
{
    UIScrollView* scrollView;
    UIImageView* photo;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage* image = [UIImage imageNamed:@"twd.jpg"];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width - 16, 300)];
    scrollView.backgroundColor = [UIColor grayColor];
    
    scrollView.contentSize = CGSizeMake(image.size.width, image.size.height);
    
    scrollView.bounces = true;
    
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    
    
    
    photo = [[UIImageView alloc] initWithImage:image];
    photo.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [scrollView addSubview:photo];
    
    [self.view addSubview:scrollView];
    
}

@end
