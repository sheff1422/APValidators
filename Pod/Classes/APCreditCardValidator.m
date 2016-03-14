//
// Created by Nickolay Sheika on 05.12.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCreditCardValidator.h"



@implementation APCreditCardValidator

- (void)validate
{
    [super validate];

    if (! self.validationObject) {
        self.validationState = APValidatorState_Undefined;
        return;
    }

    if (! [self.validationObject isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"%@ validationObject should be NSString!",
                           NSStringFromClass([self class])];
    }

    NSString *validationString = self.validationObject;

    NSCharacterSet *illegalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

    NSArray *components = [validationString componentsSeparatedByCharactersInSet:illegalCharacters];
    NSString *formattedString = [components componentsJoinedByString:@""];

    if (formattedString == nil || formattedString.length < 9) {
        self.validationState = APValidatorState_NotValid;
        return;
    }

    NSMutableString *reversedString = [NSMutableString stringWithCapacity:[formattedString length]];

    [formattedString enumerateSubstringsInRange:NSMakeRange(0, [formattedString length]) options:(NSStringEnumerationReverse |NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reversedString appendString:substring];
    }];

    NSUInteger oddSum = 0, evenSum = 0;

    for (NSUInteger i = 0; i < [reversedString length]; i++) {
        NSInteger digit = [[NSString stringWithFormat:@"%C", [reversedString characterAtIndex:i]] integerValue];

        if (i % 2 == 0) {
            evenSum += digit;
        }
        else {
            oddSum += digit / 5 + (2 * digit) % 10;
        }
    }
    self.validationState = (oddSum + evenSum) % 10 == 0 ? APValidatorState_Valid : APValidatorState_NotValid;
}


@end