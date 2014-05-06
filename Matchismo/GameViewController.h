//
//  GameViewController.h
//  Matchismo
//
//  Created by Amy Bearman on 4/23/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Grid.h"

@class CardView;

@interface GameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

- (void)reinitializeGame:(int)currentGridSize;

// Methods to be overriden by subclasses:
- (NSAttributedString *)titleForCard: (Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (Deck *)createDeck;
- (void) setUpCards;
- (NSUInteger) minimumNumberOfCards;
- (void) setUpGrid;
- (CardView *)newCardView;

@end