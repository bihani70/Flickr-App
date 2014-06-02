//
//  JTCollectionViewController.m
//  JasonTable
//
//  Created by Ravi Bihani on 29/11/13.
//  Copyright (c) 2013 Mr Ravi Bihani. All rights reserved.
//

#import "JTCollectionViewController.h"
#import "cell.h"

@interface JTCollectionViewController ()

@end

@implementation JTCollectionViewController

- (void)viewDidLoad
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
   // [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MainCell"];
    //[_collectionView setBackgroundColor:[UIColor redColor]];
    self.title = @"Flickr Recent Photos";
    [self.view addSubview:_collectionView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    //UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    UIImage* abc=[UIImage imageNamed:@"coffee.png"];
    //self.cellImage=abc;
    cell.muImage.image=abc;
   // cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

@end
