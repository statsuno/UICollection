//
//  CellViewController.m
//  mm
//
//  Created by 龍野翔 on 2014/03/20.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "CellViewController.h"

@interface CellViewController ()
@property long n;
@property NSString *path;
@property NSFileManager *fileManager;
@property NSString *documentsDirectory;
@end

@implementation CellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    UIBarButtonItem *right = [[UIBarButtonItem alloc]
                              initWithTitle:@"delete"
                              style:UIBarButtonItemStylePlain
                              target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItem = right;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.n = [ud integerForKey:@"KEY_K"];
    
    NSData *myData;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    NSString *filename= [NSString stringWithFormat:@"img%ld.jpg",self.n+1];
    self.path = [self.documentsDirectory stringByAppendingPathComponent:filename];
    self.fileManager = [NSFileManager defaultManager];
    BOOL success = [self.fileManager fileExistsAtPath:self.path];
    if(success) {
        myData = [[NSData alloc] initWithContentsOfFile:self.path];
    }
    
    CGRect rect = CGRectMake(10, 10, 300, 350);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    
    // 画像の読み込み
    imageView.image = [[UIImage alloc] initWithData:myData];
    
    // UIImageViewのインスタンスをビューに追加
    [self.view addSubview:imageView];
    
}


-(void)delete
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"削除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view.window];
    //[sheet showFromToolbar:self.navigationController.toolbar];
    self.navigationController.toolbarHidden = NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            NSLog(@"Red");
            NSError *error;
            // ファイルを移動
            BOOL result = [self.fileManager removeItemAtPath:self.path error:&error];
            if (result) {
                NSLog(@"ファイルを削除に成功：%@", self.path);
            } else {
                NSLog(@"ファイルの削除に失敗：%@", error.description);
            }
            for(int i=(int)self.n+1;i<5;i++){
                NSString *beforename= [NSString stringWithFormat:@"img%d.jpg",i+1];
                NSString *aftername= [NSString stringWithFormat:@"img%d.jpg",i];
                NSString *beforepath = [self.documentsDirectory stringByAppendingPathComponent:beforename];
                NSString *afterpath = [self.documentsDirectory stringByAppendingPathComponent:aftername];
                [self.fileManager moveItemAtPath:beforepath toPath:afterpath error:&error];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            [self.view removeFromSuperview];
            
            break;
        }
    
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
