//
//  BMToolBar.h
//  BananaNews
//
//  Created by 龚涛 on 3/19/14.
//  Copyright (c) 2014 龚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QFToolBarDelegate <NSObject>

- (void)didSelectTagAtIndex:(NSUInteger)index;

@end

@interface QFToolBar : UIView
{
    NSUInteger _lastIndex;
    
    NSArray *_titleArray;
    
    UIView *_selectedView;
}

@property (nonatomic, weak) id<QFToolBarDelegate> delegate;

- (void)selectedTagAtIndex:(NSUInteger)index;

@end
