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
    NSMutableArray * arrayNumbers;
}
@property (nonatomic, strong) IBOutlet UICollectionView * collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *albomPageControl;
@end

@implementation MMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayNumbers = [[NSMutableArray alloc] initWithObjects: nil];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(512, 335)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setMinimumLineSpacing:-10];
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView setPagingEnabled:YES];
    [self updateControlPageNumber];
}
//=============== Добавление нового альбома
- (IBAction)addNewItemInSection {
    [arrayNumbers insertObject:@3 atIndex:0];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    [self updateControlPageNumber];
}
//=============== Клик по элементу collectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self deleteItemAtIndexPath:indexPath];
}
//=============== Удаление выбранного альбома
- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {
    [arrayNumbers removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self updateControlPageNumber];
}
//=============== Кол-во секций в collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView  {
    return 1;
}
//=============== Кол-во элементов в collectionView
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [arrayNumbers count];
}
//=============== Формирование ячейки в collectionView
- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"Cell";
    MMalbomCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.albomImageFoto.image = [UIImage imageNamed:@"photoalbum-red.png"];
    cell.albomLabel.text = [NSString stringWithFormat:@"%d", [[arrayNumbers objectAtIndex:indexPath.row] integerValue]];
    cell.buttonClose.alpha = 0;
    
    //создание длинного нажатия на ячейку
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)];
    //интервал нажатия для вызова метода
    [longPressGesture setMinimumPressDuration:1.0];
    //привязывание нажатия к ячейке
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}
//=============== Обработка длинного нажатия на ячейку
-(void)longPressCell:(UISwipeGestureRecognizer *)gesture {
    if(UIGestureRecognizerStateBegan == gesture.state) {
        for (int i = 0; i < [arrayNumbers count]; i++) {
        }
    }
}
//=============== Определение текущей страницы для page controller
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //CGFloat pageWidth = self.collectionView.frame.size.width;
    CGFloat pageWidth = 748;
    self.albomPageControl.currentPage = self.collectionView.contentOffset.x / pageWidth;
}
//=============== Обновление кол-ва страниц для page controller
- (void)updateControlPageNumber {
    self.albomPageControl.numberOfPages = ceil((double)[arrayNumbers count] / 4); // округление к большему для кол-ва страниц
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
