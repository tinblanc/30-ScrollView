//
//  TapToZoom.m
//  UIScrollViewDemo
//
//  Created by Tin Blanc on 4/19/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "TapToZoom.h"
#define ZOOM_STEP 1.5


@interface TapToZoom() <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) UIScrollView* scrollView;
@property (weak, nonatomic) UIImageView* photo;
@property (weak, nonatomic) UILabel* scaleLabel;
@end

@implementation TapToZoom

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Init scrollView
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.1;
    scrollView.maximumZoomScale = 10;
    scrollView.zoomScale = 1.0;
    scrollView.clipsToBounds = YES;
    
    UIImageView* photo = [[UIImageView alloc] initWithFrame:self.view.bounds];
    photo.image = [UIImage imageNamed:@"imac.jpg"];
    photo.contentMode = UIViewContentModeScaleAspectFill;
    
    photo.userInteractionEnabled = YES;
    photo.multipleTouchEnabled = YES;
    
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    [photo addGestureRecognizer:singleTap];
    
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(onDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [photo addGestureRecognizer:doubleTap];
    
    // Nếu không có lệnh này, thì single tap sẽ nhận rồi sau đó double tap cũng nhận
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    
    [scrollView addSubview:photo];
    [self.view addSubview:scrollView];
    
    // Sau khi scrollView, photo được gắn vào View cha, có con trỏ strong thì chúng ta mới gán vào weak property
    self.scrollView = scrollView;
    self.photo = photo;
    
    UILabel* scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    scaleLabel.textAlignment = NSTextAlignmentRight;
    scaleLabel.text = [NSString stringWithFormat:@"%2.2f", scrollView.zoomScale];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:scaleLabel];
    
    [self.navigationItem setRightBarButtonItem:barButton];
    self.scaleLabel = scaleLabel;
    
}

-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photo;
}

-(void) onTap: (UITapGestureRecognizer*) tap{
    CGPoint tapPoint = [tap locationInView:self.photo]; // lấy tọa độ tap
    float newScale = self.scrollView.zoomScale * ZOOM_STEP;
    [self zoomRectForScale: newScale withCenter: tapPoint];
}

-(void) onDoubleTap: (UITapGestureRecognizer*) tap{
    CGPoint tapPoint = [tap locationInView:self.photo]; // lấy tọa độ tap
    float newScale = self.scrollView.zoomScale / ZOOM_STEP;
    [self zoomRectForScale: newScale withCenter: tapPoint];
}

-(void) zoomRectForScale: (float) scale
              withCenter:(CGPoint) center{
    CGRect zoomRect;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    zoomRect.size.height = scrollViewSize.height / scale;
    zoomRect.size.width = scrollViewSize.width / scale;
    
    
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    [self.scrollView zoomToRect:zoomRect animated:YES];
    
    self.scaleLabel.text = [NSString stringWithFormat:@"%2.2f", self.scrollView.zoomScale];
}

@end
