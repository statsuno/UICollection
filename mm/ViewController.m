//
//  ViewController.m
//  mm
//
//  Created by 龍野翔 on 2014/03/13.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import "ViewController.h"
#import "CellViewController.h"

@interface ViewController ()
@end

@implementation ViewController

//@synthesize collectionView = _containerView;
//@synthesize flowLayout = _flowLayout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    // ディレクトリを取得
    NSArray *docpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocumentDir = [docpaths objectAtIndex:0];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *list = [fileManager contentsOfDirectoryAtPath:DocumentDir
                                                     error:&error];
    
    // ファイルやディレクトリの一覧を表示する
    for (NSString *DocumentDir in list) {
        NSLog(@"%@", DocumentDir);
        NSData *myData;
        myData = [[NSData alloc] initWithContentsOfFile:DocumentDir];
        UIImage *img = [[UIImage alloc] initWithData:myData];
        [photo1 addObject:img];
    }
    self.array = @[photo1];
    */
    
    
     
    // collectionViewにcellのクラスを登録
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self createCollectionView];

}

-(void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *photo1 = [NSMutableArray array];
    int n=4;
    for (int i = 1; i <= n; i++) {
        NSString *filename= [NSString stringWithFormat:@"img%d.jpg",i];
        /*
        NSData *myData;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
        NSFileManager *fileManager = [NSFileManager defaultManager];
            myData = [[NSData alloc] initWithContentsOfFile:filename];
        UIImage *img = [[UIImage alloc] initWithData:myData];
        */
        [photo1 addObject:[UIImage imageNamed:filename]];
        //[photo1 addObject:img];
    }
    self.array = @[photo1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)createCollectionView
{
    /*UICollectionViewのコンテンツの設定 UICollectionViewFlowLayout*/
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(96.0, 72.0);  //表示するアイテムのサイズ
    self.flowLayout.minimumLineSpacing = 10.0f;  //セクションとアイテムの間隔
    self.flowLayout.minimumInteritemSpacing = 12.0f;  //アイテム同士の間隔
    
    /*UICollectionViewの土台を作成*/
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];  //collectionViewにcellのクラスを登録。セルの表示に使う
    
    [self.view addSubview:self.collectionView];
}


- (void)ViewWillAppear:(BOOL)animated
{
    self.navigationController.toolbarHidden = NO;
    [self.navigationController setToolbarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark UICollectionViewDelegate

/*セクションの数*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.array count];
}

/*セクションに応じたセルの数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.array objectAtIndex:section] count];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

/*セルの内容を返す*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
    imgView.frame = CGRectMake(0.0, 0.0, 96.0, 72.0);
    
    // cellにimgViewをセット
    [cell addSubview:imgView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //クリックされたらよばれる
    CellViewController *c = CellViewController.new;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:(int)indexPath.row forKey:@"KEY_K"];
    [self.navigationController pushViewController:c animated:YES];
    NSLog(@"Clicked %ld-%ld",(long)indexPath.section,(long)indexPath.row);
}


@end