//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Amy Bearman on 4/3/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "GameViewController.h"
#import "PlayingCardView.h"

@interface CardGameViewController ()
@end

#define NUM_CARDS 36;

@implementation CardGameViewController

/* Initializes UI of game for each time the CardGameViewController is loaded,
 * and sets the game mode by be 2-card playing mode */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.gameMode = 0; // 2-card playing mode, by default
}

/*
 * Method to allocate memory for the deck @property with a PlayingCardDeck
 */
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void) drawCardViews {
    int index = 0;
    for (int i = 0; i < self.grid.rowCount; i++) {
        for (int j = 0; j < self.grid.columnCount; j++) {
            Card *card = [self.game cardAtIndex:index];
            index++;
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            PlayingCardView *pcView = [[PlayingCardView alloc] initWithFrame:viewRect];
            pcView.userInteractionEnabled = YES;
            
            PlayingCard *playingCard = (PlayingCard *)card;
            pcView.suit = playingCard.suit;
            pcView.rank = playingCard.rank;
            
            [self.cardViews addObject:pcView]; // Adds the PlayingCardView to the NSMutableArray
            [self.backgroundView addSubview:pcView];
        }
    }
}

- (void)updateAllCardsChosenOrMatched {
    for (PlayingCardView *pcView in self.cardViews) {
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:pcView];
        Card *card = [self.game cardAtIndex:cardViewIndex];
        if (card.isChosen && !pcView.faceUp) {
            [self animateCardFlippingWithCard:pcView withSide:YES];
        } else if (!card.isChosen && pcView.faceUp) {
            [self animateCardFlippingWithCard:pcView withSide:NO];
        }
    }
}

- (void)flipAllCards {
    for (PlayingCardView *pcView in self.cardViews) {
        if (pcView.faceUp) {
            [self animateCardFlippingWithCard:pcView withSide:NO];
        }
    }
}

- (void) redrawCardViewsWithNewContents {
    int index = 0;
    for (PlayingCardView *pcView in self.cardViews) {
        PlayingCard *playingCard = (PlayingCard *)[self.game cardAtIndex:index];
        pcView.suit = playingCard.suit;
        pcView.rank = playingCard.rank;
        index++;
    }
}

- (void)animateCardFlippingWithCard:(PlayingCardView *)pcView withSide:(BOOL)isFaceUp {
    [PlayingCardView transitionWithView:pcView
                               duration:0.5
                                options:UIViewAnimationOptionTransitionFlipFromRight
                             animations:^{
                                 pcView.faceUp = isFaceUp;
                             } completion:nil];
}

- (NSMutableAttributedString *)getCardAttributedContents:(Card *)card {
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:card.contents];
    PlayingCard *pc = (PlayingCard *)card;
    if ([pc.suit isEqualToString:@"♥︎"] || [pc.suit isEqualToString:@"♦︎"]) {
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [contents length])];
    } else {
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [contents length])];
    }
    return contents;
}

/* Helper method that returns the title of a card: either its contents, or the empty string,
depending on whether or not the card was flipped over */
- (NSMutableAttributedString *)titleForCard:(Card *)card {
    NSMutableAttributedString *contents = [self getCardAttributedContents:card];
    return card.isChosen ? contents: [[NSMutableAttributedString alloc] initWithString:@""];
}

/* Helper method that returns the background impage of a card: either cardfront or cardback */
- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}


@end
