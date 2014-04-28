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

@property (weak, nonatomic) IBOutlet UIButton *moreCards;

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
    self.grid.minimumNumberOfCells = 12;
    for (int i = 12; i < [self.cardViews count]; i++) {
        SetCardView *scView = [self.cardViews lastObject];
        [scView removeFromSuperview];
        [self.cardViews removeLastObject];
    }

}

- (void) setUpCards {
    int numCards = 0;
    for (int i = 0; i < self.grid.rowCount; i++) {
        for (int j = 0; j < self.grid.columnCount; j++) {
            if (numCards >= self.grid.minimumNumberOfCells) break;
            numCards++;
            
            Card *card = [self.game.deck drawRandomCard];
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            SetCardView *scView = [[SetCardView alloc] initWithFrame:viewRect];

            SetCard *setCard = (SetCard *)card;
            scView.chosen = NO;
            scView.color = setCard.color;
            scView.number = setCard.number;
            scView.shading = setCard.shading;
            scView.shape = setCard.shape;

            [self.cardViews addObject:scView]; // Adds the SetCardView to the NSMutableArray
            [self.backgroundView addSubview:scView];
        }
    }
}

- (IBAction)getThreeMoreCards:(UIButton *)sender {
    NSMutableArray *setCardViews = [[NSMutableArray alloc] init];
    int numCardsToAdd = 0;
    for (int i = 0; i < 3; i++) {
        SetCard *setCard = (SetCard *)[self.game.deck drawRandomCard];
        if (setCard != nil) {
            numCardsToAdd++;
            self.grid.minimumNumberOfCells++;
            SetCardView *scView = [[SetCardView alloc] init];
            scView.chosen = NO;
            scView.color = setCard.color;
            scView.number = setCard.number;
            scView.shading = setCard.shading;
            scView.shape = setCard.shape;
            [setCardViews addObject:scView];
        }
    }
    
    int index = 0;
    int numOriginalCards = [self.cardViews count];
    
    for (int i = 0; i < self.grid.rowCount; i++) {
        for (int j = 0; j < self.grid.columnCount; j++) {
            if (index >= self.grid.minimumNumberOfCells) break;
            
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            SetCardView *scView;
            if (index < numOriginalCards) {
                // Use existing SetCardView
                scView = [self.cardViews objectAtIndex:index];
                scView.frame = viewRect; // Readjust frame of existing SetCardView
            } else {
                scView = [setCardViews lastObject];
                [setCardViews removeLastObject];
                scView.frame = viewRect;
                [self.cardViews addObject:scView]; // Adds the SetCardView to the NSMutableArray
            }
            index++;
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

@end
