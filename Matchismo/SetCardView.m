//
//  SetCardView.m
//  Matchismo
//
//  Created by Amy Bearman on 4/27/14.
//  Copyright (c) 2014 Amy Bearman. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    double width = self.bounds.size.width;
    double height = self.bounds.size.height;
    double x = self.bounds.origin.x;
    double y = self.bounds.origin.y;
    
    double widthOfShape = width - (width * (2.0/7.0));
    double heightOfShape = height / 4.5;
    double xOfShape = x + (width / 7.0);
    
    if (self.number == 1) {
        double yOfShape = y + (height/2.0) - (heightOfShape/2.0);
        CGRect boundsOfShapes = CGRectMake(xOfShape, yOfShape, widthOfShape, heightOfShape);
        
        if (self.shape == SQUIGGLE) {
            
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes withColor:self.color];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes withColor:self.color];
        }

    } else if (self.number == 2) {
        double yOfShape1 = y + (height/2.0) - ((2.33*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);

        if (self.shape == SQUIGGLE) {
            
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes1 withColor:self.color];
            [self drawDiamondWithBounds:boundsOfShapes2 withColor:self.color];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes1 withColor:self.color];
            [self drawOvalWithBounds:boundsOfShapes2 withColor:self.color];
        }
        
    } else if (self.number == 3) {
        double yOfShape1 = (height/2.0) - ((3.67*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        double yOfShape3 = yOfShape2 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);
        CGRect boundsOfShapes3 = CGRectMake(xOfShape, yOfShape3, widthOfShape, heightOfShape);
        
        if (self.shape == SQUIGGLE) {
            
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes1 withColor:self.color];
            [self drawDiamondWithBounds:boundsOfShapes2 withColor:self.color];
            [self drawDiamondWithBounds:boundsOfShapes3 withColor:self.color];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes1 withColor:self.color];
            [self drawOvalWithBounds:boundsOfShapes2 withColor:self.color];
            [self drawOvalWithBounds:boundsOfShapes3 withColor:self.color];
        }
    }
}

- (void)drawOvalWithBounds: (CGRect)bounds withColor:(UIColor *)color {
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:10.0];
    [color setFill];
    [oval fill];
}

- (void)drawDiamondWithBounds: (CGRect)bounds withColor:(UIColor *)color {
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    double x = bounds.origin.x;
    double y = bounds.origin.y;
    double width = bounds.size.width;
    double height = bounds.size.height;
    
    [diamond moveToPoint:CGPointMake(x, y + height/2.0)];
    [diamond addLineToPoint:CGPointMake(x + width/2, y)];
    [diamond addLineToPoint:CGPointMake(x + width, y + height/2)];
    [diamond addLineToPoint:CGPointMake(x + width/2, y + height)];
    [diamond closePath];
    [color setFill];
    [diamond fill];
}

//////////////////////////////////////

#pragma mark Properties

- (void)setShape:(Shape)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setShading:(Shading)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

-(void)setNumber:(NSUInteger)number {
    _number = number;
}

@end
