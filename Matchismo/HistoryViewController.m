//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Amy Bearman on 4/18/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "HistoryViewController.h"
#import "CardGameViewController.h"
#import "SetGameViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation HistoryViewController

/* Displays each NSAttributedString in the history NSArry in the UITextView */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *str in self.history) {
        [content appendAttributedString:str];
        [content appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    [self.textView setAttributedText:content];
}

/* Prepares for segue by preserving the state of the game to send back to 
 * either the CardGameViewController or the SetGameViewController */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Back To PlayingCardGame"]) {
        CardGameViewController *cgvc = [segue destinationViewController];
        cgvc.game = self.game;
        cgvc.cardButtons = self.cardButtons;
        cgvc.scoreText = self.scoreText;
        cgvc.resultsText = self.resultsText;
        cgvc.history = self.history;

    } else if ([[segue identifier] isEqualToString:@"Back To SetGame"]) {
        SetGameViewController *sgvc = [segue destinationViewController];
        sgvc.game = self.game;
        sgvc.cardButtons = self.cardButtons;
        sgvc.scoreText = self.scoreText;
        sgvc.resultsText = self.resultsText;
        sgvc.history = self.history;
    }
}


@end
