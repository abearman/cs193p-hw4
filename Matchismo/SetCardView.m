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
    
    UIColor *colorToUse = (self.chosen)? [UIColor lightGrayColor] : [UIColor whiteColor];
    [colorToUse setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [self.roundedRect stroke];
    
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
            [self drawSquiggleWithBounds:boundsOfShapes];
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes];
        }

    } else if (self.number == 2) {
        double yOfShape1 = y + (height/2.0) - ((2.33*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);

        if (self.shape == SQUIGGLE) {
            [self drawSquiggleWithBounds:boundsOfShapes1];
            [self drawSquiggleWithBounds:boundsOfShapes2];
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes1];
            [self drawDiamondWithBounds:boundsOfShapes2];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes1];
            [self drawOvalWithBounds:boundsOfShapes2];
        }
        
    } else if (self.number == 3) {
        double yOfShape1 = (height/2.0) - ((3.67*heightOfShape)/2.0);
        double yOfShape2 = yOfShape1 + (1.33*heightOfShape);
        double yOfShape3 = yOfShape2 + (1.33*heightOfShape);
        
        CGRect boundsOfShapes1 = CGRectMake(xOfShape, yOfShape1, widthOfShape, heightOfShape);
        CGRect boundsOfShapes2 = CGRectMake(xOfShape, yOfShape2, widthOfShape, heightOfShape);
        CGRect boundsOfShapes3 = CGRectMake(xOfShape, yOfShape3, widthOfShape, heightOfShape);
        
        if (self.shape == SQUIGGLE) {
            [self drawSquiggleWithBounds:boundsOfShapes1];
            [self drawSquiggleWithBounds:boundsOfShapes2];
            [self drawSquiggleWithBounds:boundsOfShapes3];
        } else if (self.shape == DIAMOND) {
            [self drawDiamondWithBounds:boundsOfShapes1];
            [self drawDiamondWithBounds:boundsOfShapes2];
            [self drawDiamondWithBounds:boundsOfShapes3];
        } else if (self.shape == OVAL) {
            [self drawOvalWithBounds:boundsOfShapes1];
            [self drawOvalWithBounds:boundsOfShapes2];
            [self drawOvalWithBounds:boundsOfShapes3];
        }
    }
}

- (void)drawSquiggleWithBounds: (CGRect)bounds {
    UIBezierPath *squiggle = [UIBezierPath bezierPath];
    [squiggle moveToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/4), bounds.origin.y+(bounds.size.height/4))];
    // Curved top line
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/2), bounds.origin.y+(bounds.size.height)/4) controlPoint:CGPointMake(bounds.origin.x+(3*bounds.size.width/8), bounds.origin.y)];
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+(3*bounds.size.width/4), bounds.origin.y+(bounds.size.height)/4) controlPoint:CGPointMake(bounds.origin.x+(5*(bounds.size.width/8)), bounds.origin.y+3*bounds.size.height/8)];
    // Curved bump at right
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+(3*bounds.size.width/4), bounds.origin.y+(bounds.size.height*3/4)) controlPoint:CGPointMake(bounds.origin.x+bounds.size.width, bounds.origin.y+bounds.size.height/8)];
    // Curved bottom line
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/2), bounds.origin.y+3*(bounds.size.height)/4) controlPoint:CGPointMake(bounds.origin.x+(5*(bounds.size.width/8)), bounds.origin.y+bounds.size.height)];
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+bounds.size.width/4, bounds.origin.y+3*(bounds.size.height)/4) controlPoint:CGPointMake(bounds.origin.x+(3*bounds.size.width/8), bounds.origin.y+5*bounds.size.height/8)];
    // Curved bump at left
    [squiggle addQuadCurveToPoint:CGPointMake(bounds.origin.x+(bounds.size.width/4), bounds.origin.y+(bounds.size.height)/4) controlPoint:CGPointMake(bounds.origin.x, bounds.origin.y+7*bounds.size.height/8)];
    [squiggle closePath];
    [self setShadingAndColor:squiggle];
}

- (void)drawDiamondWithBounds: (CGRect)bounds {
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
    [self setShadingAndColor:diamond];
}

- (void)drawOvalWithBounds: (CGRect)bounds {
    UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:(bounds.size.width / 5.0)];
    [self setShadingAndColor:oval];
}

- (void)setShadingAndColor: (UIBezierPath *)path {
    [self.color setFill];
    if (self.shading == SOLID) {
        [path fill];
    } else if (self.shading == STRIPED) {
        CGContextSaveGState(UIGraphicsGetCurrentContext()); {
            [path addClip];
            CGContextRotateCTM(UIGraphicsGetCurrentContext(), M_PI/4); // Draw all the lines diagonally
            for (int i = -1000; i < 1000; i++) {
                CGRect rect = {i*2,-1000,1,2000};
                [[UIBezierPath bezierPathWithRect:rect] fill];
            }
        } CGContextRestoreGState(UIGraphicsGetCurrentContext());
    } else if (self.shading == OPEN) {
        // Do nothing, because we'll set the stroke later
    }
    [self.color setStroke];
    [path stroke];
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
