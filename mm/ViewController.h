//
//  ViewController.h
//  mm
//
//  Created by 龍野翔 on 2014/03/13.
//  Copyright (c) 2014年 龍野翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController :UICollectionViewController
//UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    //UICollectionViewFlowLayout *_flowLayout;
    //UICollectionView *_collectionView;
}

@property (retain, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (retain, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *array;

@end
