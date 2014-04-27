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
@property (strong, nonatomic) UIPinchGestureRecognizer *pinchRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic) BOOL cardsInStack;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:36 // Initialize the CardMatchingGame
                                                          usingDeck: [self createDeck]];
    
    [self.backgroundView setBackgroundColor:[UIColor clearColor]];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.grid = [[Grid alloc] init];
    [self setUpGrid];
    [self setUpCards];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    [self.backgroundView addGestureRecognizer:self.tapRecognizer];
    
    self.pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.backgroundView addGestureRecognizer:self.pinchRecognizer];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.backgroundView addGestureRecognizer:self.panRecognizer];
    [self.panRecognizer setMaximumNumberOfTouches:1];
}

/*
 * Action method to handle the event that the user clicks on "Start New Game"
 */
- (IBAction)startNewGame:(UIButton *)sender {
    [self reinitializeGame]; // Redeal all cards by reinitializing the CardMatchingGame object
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"]; // Resets the score label to 0
    [self updateAllCards];
    [self redrawCards];
    
    for (UIView *view in self.cardViews) {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut
                                  animations:^{
                                      view.frame = CGRectOffset(view.frame, 0, 500);
                                  }
                                  completion:^(BOOL finished) {
                                      [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                            view.frame = CGRectOffset(view.frame, 0, -500);
                                          }
                                      completion:nil];
                                      
                                  }];
    }
    
}

- (void)gatherCardsIntoStack {
    self.cardsInStack = YES;
    for (UIView *view in self.cardViews) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                  animations:^{
                                      view.frame = CGRectMake(10, 10, view.frame.size.width, view.frame.size.height);
                                  }
                                  completion:nil];
    }
}

- (void) panAction:(UIPanGestureRecognizer *)gesture {
    if (self.cardsInStack) {
        CGPoint translation = [gesture translationInView:gesture.view];
        gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y + translation.y);
        [gesture setTranslation:CGPointMake(0, 0) inView: gesture.view];
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self gatherCardsIntoStack];
    }
}

- (void)tapAction {
    if (self.cardsInStack) {
        int index = 0;
        self.backgroundView.frame = CGRectMake(20.0, 37.0, 280.0, 442.0); // reinit background frame
        
        for (int i = 0; i < self.grid.rowCount; i++) {
            for (int j = 0; j < self.grid.columnCount; j++) {
                UIView *view = [self.cardViews objectAtIndex:index];
                index++;
                
                [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              CGRect viewRect = [self.grid frameOfCellAtRow:i inColumn:j];
                                              view.frame = viewRect;
                                          }
                                          completion:nil];
            }
        }
        self.cardsInStack = false;
        
    } else {
        CGPoint point = [self.tapRecognizer locationInView:self.backgroundView];
        UIView *tappedView = [self.backgroundView hitTest:point withEvent:nil];
        
        int chosenCardIndex = (int)[self.cardViews indexOfObject:tappedView]; // Retrieves the index of the chosen card
        [self.game chooseCardAtIndex:chosenCardIndex]; // Update the model to reflect that a card has been chosen
        [self updateAllCards]; // Should update the UI of all card views appropriately, handled by the subclasses
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score]; // Updates the score label accordingly

    }
}

/* Reinitializes the CardMatchingGame object if the user restarts the game */
- (void)reinitializeGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                              usingDeck: [self createDeck]];
    self.game.gameMode = 0; // Default 2-card playing mode
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

- (void) setUpCards { }
- (void)updateAllCards { }
- (void) redrawCards { }
- (NSAttributedString *)titleForCard: (Card *)card { return nil; }
- (UIImage *)backgroundImageForCard:(Card *)card { return nil; }
- (Deck *)createDeck { return nil; }

@end
