//
//  GameViewController.m
//  Matchismo
//
//  Created by Amy Bearman on 4/23/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "GameViewController.h"
#import "PlayingCard.h"
#import "SetCard.h"
#import "PlayingCardView.h"
#import "CardGameViewController.h"
#import "SetGameViewController.h"

@interface GameViewController ()

@property (strong, nonatomic) IBOutlet UIButton *startNewGame;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backgroundView setBackgroundColor:[UIColor clearColor]];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.grid = [[Grid alloc] init];
    [self setUpGrid];
    [self setUpCards];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    [self.backgroundView addGestureRecognizer:self.tapRecognizer];
}

- (void)tapAction {
    CGPoint point = [self.tapRecognizer locationInView:self.backgroundView];
    UIView *tappedView = [self.backgroundView hitTest:point withEvent:nil];
    if ([self isKindOfClass:[CardGameViewController class]]) {
        PlayingCardView *pcView = (PlayingCardView *)tappedView;
        
        [PlayingCardView transitionWithView:pcView
                                   duration:0.5
                                    options:UIViewAnimationOptionTransitionFlipFromRight
                                 animations:^{
                                     pcView.faceUp = !pcView.faceUp;
                                 } completion:nil];
        
    } else if ([self isKindOfClass:[SetGameViewController class]]) {
        
    }
}

/* Reinitializes the CardMatchingGame object if the user restarts the game */
- (void)reinitializeGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                              usingDeck: [self createDeck]];
    self.game.gameMode = 0; // Default 2-card playing mode
}

// Lazily intantiate the CardMatchingGame object
- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                                          usingDeck: [self createDeck]];
    return _game;
}

// Lazily instantiate the NSMutableArray of cardViews
- (NSMutableArray *)cardViews {
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
    return _cardViews;
}

- (void) setUpGrid {
    CGFloat width = self.backgroundView.frame.size.width;
    CGFloat height = self.backgroundView.frame.size.height;
    self.grid.size = CGSizeMake(width, height);
    self.grid.cellAspectRatio = 0.67;
    
    if ([self isKindOfClass:[CardGameViewController class]]) {
        self.grid.minimumNumberOfCells = 30;
    } else if ([self isKindOfClass:[SetGameViewController class]]) {
        self.grid.minimumNumberOfCells = 12;
    }
}

- (void) setUpCards {
    if ([self isKindOfClass:[CardGameViewController class]]) {
        for (int i = 0; i < self.grid.rowCount; i++) {
            for (int j = 0; j < self.grid.columnCount; j++) {
                Card *card = [self.game.deck drawRandomCard];
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
        
    } else if ([self isKindOfClass:[SetGameViewController class]]) { //TODO
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
}

/*
 * Action method to handle the event that the user clicks on "Start New Game"
 */
- (IBAction)startNewGame:(UIButton *)sender {
    [self reinitializeGame]; // Redeal all cards by reinitializing the CardMatchingGame object
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"]; // Resets the score label to 0
}

- (NSAttributedString *)titleForCard: (Card *)card { return nil; }
- (UIImage *)backgroundImageForCard:(Card *)card { return nil; }
- (Deck *)createDeck { return nil; }

@end
