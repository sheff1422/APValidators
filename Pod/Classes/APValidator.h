//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APValidator;

typedef NS_ENUM(NSUInteger, APValidatorState) {
    APValidatorState_Undefined = 0,
    APValidatorState_NotValid,
    APValidatorState_Valid
};

typedef void (^APValidatorStateChangeHandler)(APValidator *validator);
extern NSString *const APValidatorDidChangeStateNotification;


@protocol APDataValidatorDelegate <NSObject>

@optional
- (void)validatorWillChangeState:(APValidator *)validator;
- (void)validatorDidChangeState:(APValidator *)validator;

@end



@interface APValidator : NSObject


/**
 *  Back link to control
 */
@property(nonatomic, weak) id control;

/**
 *  Object to validate
 */
@property(nonatomic, strong) id validationObject;

/**
 *  Delegate
 */
@property(nonatomic, weak) IBOutlet id <APDataValidatorDelegate> delegate;

/**
 *  Validator is required or not
 *
 *  @default NO
 */
@property(nonatomic, assign, getter=isRequired) IBInspectable BOOL required;

/**
 *  An array of validation error messages for failed validation
 */
@property(copy, nonatomic, readonly) NSArray *errorMessages;

/**
 *  If set, the block runs when validation state changes
 */
@property(copy, nonatomic) APValidatorStateChangeHandler validatorStateChangedHandler;

/**
 *  Current validation state
 */
@property(nonatomic, assign) APValidatorState validationState;

/**
 *  Called to validate current validation object
 */
- (void)validate;

@end