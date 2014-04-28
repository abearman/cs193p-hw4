//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Amy Bearman on 4/21/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetGameViewController.h"
#import "GameViewController.h"
#import "SetCardDeck.h"
#import "PlayingCardView.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

#define NUM_CARDS 12;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.gameMode = 1; // 3-card playing mode, by default
}

/* Method to allocate memory for the deck @property with a SetCardDeck */
- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

/* Overrides the GameViewController to make sure the game-mode is set to 3-card
 * mode when the game is restarted */
- (void)reinitializeGame {
    [super reinitializeGame];
    self.game.gameMode = 1;
}

- (void) setUpCards {
    for (int i = 0; i < self.grid.rowCount; i++) {
        for (int j = 0; j < self.grid.columnCount; j++) {
            Card *card = [self.game cardAtIndex:i];
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            SetCardView *scView = [[SetCardView alloc] initWithFrame:viewRect];

            SetCard *setCard = (SetCard *)card;
            scView.chosen = NO;
            scView.color = setCard.color;
            scView.number = setCard.number;
            scView.shading = setCard.shading;
            scView.shape = setCard.shape;

            [self.cardViews addObject:scView]; // Adds the PlayingCardView to the NSMutableArray
            [self.backgroundView addSubview:scView];
        }
    }
}

- (void)updateAllCards {
    for (SetCardView *scView in self.cardViews) {
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:scView];
        Card *card = [self.game cardAtIndex:cardViewIndex];
        if (card.isChosen) {
            scView.chosen = YES;
            [scView setNeedsDisplay];
        } else {
            scView.chosen = NO;
            [scView setNeedsDisplay];
        }
    }
}

- (void) redrawCards {
    int index = 0;
    for (SetCardView *scView in self.cardViews) {
        SetCard *setCard = (SetCard *)[self.game cardAtIndex:index];
        scView.number = setCard.number;
        scView.shape = setCard.shape;
        scView.shading = setCard.shading;
        scView.color = setCard.color;
        index++;
    }
}

- (NSUInteger)minimumNumberOfCards {
    return 12;
}

@end
