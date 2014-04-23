//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Amy Bearman on 4/18/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface HistoryViewController : UIViewController
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSArray *cardButtons;
@property (strong, nonatomic) NSString *scoreText;
@property (strong, nonatomic) NSAttributedString *resultsText;
@property (strong, nonatomic) NSMutableArray *history;
@end
