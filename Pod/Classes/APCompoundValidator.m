//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "APCompoundValidator.h"



@interface APCompoundValidator ()


@property(nonatomic, strong, readwrite) NSArray *failedValidators;
@end



@implementation APCompoundValidator


#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.failedValidators = @[];
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Accessors

- (void)setValidators:(NSArray *)validators
{
    _validators = validators;
    [self setupAllValidators];
}

- (void)setValidationObject:(id)validationObject
{
    [super setValidationObject:validationObject];
    [self setupAllValidators];
}

#pragma mark - Overriden

- (void)validate
{
    [self.validators makeObjectsPerformSelector:@selector(validate)];
}

- (void)checkAllValidatorsAndUpdateState
{
    APValidatorState state = APValidatorState_Undefined;

    for (APValidator *validator in self.validators) {
        if ((validator.validationState == APValidatorState_NotValid) ||
                (validator.validationState == APValidatorState_Undefined && validator.isRequired)) {
            state = APValidatorState_NotValid;
            [self findAllNotValidValidators];
            break;
        }

        if (validator.validationState == APValidatorState_Valid) {
            state = APValidatorState_Valid;
        }
    }

    if (state == APValidatorState_Undefined && self.isRequired) {
        state = APValidatorState_NotValid;
    }

    self.validationState = state;
}

- (void)findAllNotValidValidators
{
    NSMutableArray *failed = [NSMutableArray array];
    for (APValidator *validator in self.validators) {
        if ((validator.validationState == APValidatorState_NotValid) ||
            (validator.validationState == APValidatorState_Undefined && validator.isRequired)) {
            [failed addObject:validator];
        }
    }
    self.failedValidators = [failed copy];
}

#pragma mark - Private

- (void)setupAllValidators
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];

    for (APValidator *validator in self.validators) {
        validator.validationObject = self.validationObject;
        [notificationCenter addObserver:self
                               selector:@selector(oneOfValidatorsChangedState:)
                                   name:APValidatorDidChangeStateNotification
                                 object:validator];
    }
}

#pragma mark - Notifications

- (void)oneOfValidatorsChangedState:(NSNotification *)notification
{
    [self checkAllValidatorsAndUpdateState];
}

@end