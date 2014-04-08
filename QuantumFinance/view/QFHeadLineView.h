//
//  QFHeadLineView.h
//  QuantumFinance
//
//  Created by 龚涛 on 4/8/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <GTCyclePageView.h>

@interface QFHeadLineView : UIView <NSFetchedResultsControllerDelegate, GTCyclePageViewDataSource, GTCyclePageViewDelegate>

@property (nonatomic, strong) GTCyclePageView *cyclePageView;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
