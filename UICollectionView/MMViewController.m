//
//  MMViewController.m
//  UICollectionView
//
//  Created by Admin on 24.04.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "MMViewController.h"
#import "MMalbomCell.h"

@interface MMViewController ()
{
    NSArray * arrayNumbers;
}
@property (nonatomic, strong) IBOutlet UICollectionView * collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *albomPageControl;
@end

@implementation MMViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    arrayNumbers = [[NSArray alloc] initWithObjects:@1, @2, @3, @4, @1, @2, @3, @4, @1, @2, @3, @4, @5, nil];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(512, 335)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setMinimumLineSpacing:-10];
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.pagingEnabled = YES;
    self.albomPageControl.numberOfPages = ceil((double)[arrayNumbers count] / 4); // округление к большему для кол-ва страниц
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView  {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [arrayNumbers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"Cell";
    MMalbomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.albomImageFoto.image = [UIImage imageNamed:@"photoalbum-red.png"];
    cell.albomLabel.text = [NSString stringWithFormat:@"%d", [[arrayNumbers objectAtIndex:indexPath.row] integerValue]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //CGFloat pageWidth = self.collectionView.frame.size.width;
    CGFloat pageWidth = 748;
    self.albomPageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
