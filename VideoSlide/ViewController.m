//
//  ViewController.m
//  VideoSlide
//
//  Created by ken on 2018/3/23.
//  Copyright © 2018年 zchangwen. All rights reserved.
//

#import "ViewController.h"
#import "PlayerViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) UIImagePickerController *imagePickerController;
@property(nonatomic,strong) NSURL *path;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitle:@"编辑视频" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(50, 100, 100, 50)];
    [btn addTarget:self action:@selector(pressEditing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)pressEditing
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    _imagePickerController.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if (![mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        _path = info[UIImagePickerControllerMediaURL];
        [self playView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)playView
{
    PlayerViewController *vc = [[PlayerViewController alloc] init];
//    pvc.videoUrl = _videoUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
