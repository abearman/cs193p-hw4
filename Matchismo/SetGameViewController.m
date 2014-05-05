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
    
    NSMutableArray *discardViews = [NSMutableArray array];
    for (int i = [self minimumNumberOfCards]; i < self.grid.minimumNumberOfCells; i++) {
        SetCardView *scView = [self.cardViews objectAtIndex:i];
        [scView removeFromSuperview];
        [discardViews addObject:scView];
    }
    [self.cardViews removeObjectsInArray:discardViews];
    self.grid.minimumNumberOfCells = [self minimumNumberOfCards];
    
    for (SetCardView *scView in self.cardViews) {
        int cardViewIndex = [self.cardViews indexOfObject:scView];
        SetCard *setCard = (SetCard *)[self.game cardAtIndex:cardViewIndex];
        scView.color = setCard.color;
        scView.number = setCard.number;
        scView.shading = setCard.shading;
        scView.shape = setCard.shape;
        scView.chosen = setCard.chosen;
        [scView setNeedsDisplay];
    }
}

- (SetCardView *)initializeCardViewWithCard:(Card *)card withRect:(CGRect)viewRect {
    SetCardView *scView = [[SetCardView alloc] initWithFrame:viewRect];
    
    SetCard *setCard = (SetCard *)card;
    scView.color = setCard.color;
    scView.number = setCard.number;
    scView.shading = setCard.shading;
    scView.shape = setCard.shape;
    scView.chosen = setCard.chosen;
    
    if (!card.matched) [self.backgroundView addSubview:scView];
    return scView;
}

- (void)resizeExistingCards: (BOOL)isAdditive {
    int index = 0;
    for (int i = 0; i < self.grid.rowCount; i++) {
        for (int j = 0; j < self.grid.columnCount; j++) {
            if (isAdditive) {
                if (index >= self.grid.minimumNumberOfCells - 3) break;
            } else {
                if (index >= self.grid.minimumNumberOfCells) break;
            }
            SetCardView *scView = [self.cardViews objectAtIndex:index];
            
            [SetCardView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                               animations:^{
                                   CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
                                   scView.frame = viewRect;
                               }
                                  completion:nil];
            index++;
        }
    }
}

- (void)displayThreeMoreCards {
    int col = (int)((self.grid.minimumNumberOfCells - 3) % self.grid.columnCount);
    int row = (int)((self.grid.minimumNumberOfCells - 3) / self.grid.columnCount);
    
    int k = 0;
    int index = (int)(self.grid.minimumNumberOfCells - 3);
    for (int i = row; i < self.grid.rowCount; i++) {
        for (int j = col; j < self.grid.columnCount; j++) {
            if (i > row) j = 0;
            if (index >= self.grid.minimumNumberOfCells) return;
            Card *card = [self.game cardAtIndex:index];
            index++;
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            SetCardView *scView = [self initializeCardViewWithCard:card withRect:CGRectMake(100, 1000, viewRect.size.width, viewRect.size.height)];
            [self.cardViews addObject:scView]; // Adds the SetCardView to the NSMutableArray
            
            [SetCardView animateWithDuration:1.0 delay:((0.2*k++))
                                     options:UIViewAnimationOptionTransitionCrossDissolve
                                  animations:^{
                                      scView.frame = viewRect;
                                  }
                                  completion:nil];
        }
    }
}

- (IBAction)getThreeMoreCards:(UIButton *)sender {
    if (![self.game drawMoreCards:3]) return;
    self.grid.minimumNumberOfCells = [self.game cardCount];
    [self resizeExistingCards:YES];
    [self displayThreeMoreCards];
}

- (void)updateAllCards {
    NSMutableArray *discardViews = [NSMutableArray array];
    NSMutableArray *discardCards = [NSMutableArray array];
    
    for (SetCardView *scView in self.cardViews) {
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:scView];
        Card *card = [self.game cardAtIndex:cardViewIndex];
        scView.chosen = card.isChosen;
        if (card.matched) {
           
            [scView removeFromSuperview];
            [discardViews addObject:scView];
            [discardCards addObject:card];
            
        } else {
            [scView setNeedsDisplay];
        }
    }
    
    [self.cardViews removeObjectsInArray:discardViews];
    [self.game discardCards:discardCards];
    self.grid.minimumNumberOfCells = [self.cardViews count];
    [self resizeExistingCards:NO];
}

- (NSUInteger)minimumNumberOfCards {
    return 12;
}

@end