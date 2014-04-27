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
            Card *card = [self.game.deck drawRandomCard];
            CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
            PlayingCardView *pcView = [[PlayingCardView alloc] initWithFrame:viewRect];
            
            SetCard *setCard = (SetCard *)card;
            pcView.suit = setCard.contents;
            pcView.faceUp = YES;
            
            [self.cardViews addObject:pcView]; // Adds the PlayingCardView to the NSMutableArray
            [self.backgroundView addSubview:pcView];
        }
    }
}

/* Helper method to return a NSAttributedString containing the SetCard's contents */
- (NSAttributedString *)titleForCard: (Card *)card {
    NSArray *chunks = [card.contents componentsSeparatedByString:@" "];
    NSString *symbols = [chunks firstObject];
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:symbols];
    
    NSString *color = [chunks objectAtIndex:1];
    UIColor *colorObj;
    if ([color isEqualToString:@"red"])  {
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [contents length])];
        colorObj = [UIColor redColor];
    } else if ([color isEqualToString:@"green"]) {
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, [contents length])];
        colorObj = [UIColor greenColor];
    } else if ([color isEqualToString:@"purple"]) {
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, [contents length])];
        colorObj = [UIColor purpleColor];
    }
    
    NSString *shading = [chunks objectAtIndex:2];
    //Don't do any shading for solid cards
    if ([shading isEqualToString:@"striped"]) {
        [contents addAttribute:NSForegroundColorAttributeName value:[colorObj colorWithAlphaComponent:0.3f] range:NSMakeRange(0, [contents length])];
        [contents addAttribute:NSStrokeColorAttributeName value:colorObj range:NSMakeRange(0, [contents length])];
    } else if ([shading isEqualToString:@"open"]) {
        [contents addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:-3.0] range:NSMakeRange(0, [contents length])];
        [contents addAttribute:NSStrokeColorAttributeName value:colorObj range:NSMakeRange(0, [contents length])];
        [contents addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [contents length])];
    }
    return contents;
}

/* Helper method that returns the background impage of a card: either a white, unselected card,
 or a gray, selected one. */
- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"graybox-1": @"cardfront"];
}

@end
