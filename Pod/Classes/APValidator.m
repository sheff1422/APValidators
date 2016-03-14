//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APValidator.h"

NSString *const APValidatorDidChangeStateNotification = @"APValidatorDidChangeStateNotification";


static inline NSString *APValidatorStateToString(APValidatorState state) {
    switch (state) {
        case APValidatorState_Undefined:
            return @"Undefined";
        case APValidatorState_NotValid:
            return @"Not Valid";
        case APValidatorState_Valid:
            return @"Valid";
    }
    return nil;
}



@implementation APValidator


#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _validationState = APValidatorState_Undefined;
    }
    return self;
}

#pragma mark - Accessors

- (void)setValidationState:(APValidatorState)validationState
{
    if (_validationState == validationState) {
        return;
    }

    if ([self.delegate respondsToSelector:@selector(validatorWillChangeState:)]) {
        [self.delegate validatorWillChangeState:self];
    }

    _validationState = validationState;

    if (self.validatorStateChangedHandler) {
        self.validatorStateChangedHandler(self);
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:APValidatorDidChangeStateNotification
                                                        object:self];

    if ([self.delegate respondsToSelector:@selector(validatorDidChangeState:)]) {
        [self.delegate validatorDidChangeState:self];
    }
}

- (BOOL)isRequired
{
    if (! _required) {
        _required = NO;
    }
    return _required;
}


#pragma mark - Abstract

- (void)validate
{
    if (! self.validationObject) {
        self.validationState = self.required ? APValidatorState_NotValid : APValidatorState_Undefined;
        return;
    }
}

#pragma mark - Description

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@:  ", NSStringFromClass([self class])];
    [description appendFormat:@"validationState = %@;  ", APValidatorStateToString(self.validationState)];
    [description appendFormat:@"validationObject = %@;  ", self.validationObject ? self.validationObject : @"Nil"];
    [description appendFormat:@"isRequired = %@", self.isRequired ? @"Yes" : @"No"];
    [description appendString:@">"];
    return description;
}


@end