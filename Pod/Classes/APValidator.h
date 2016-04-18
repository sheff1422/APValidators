//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APValidator;

typedef void (^APValidatorStateChangeHandler)(APValidator *validator);
extern NSString *const APValidatorStateChangedNotification;



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
 *  Stores error message for invalid state
 */
@property(nonatomic, copy) IBInspectable NSString *errorMessage;

/**
 *  Delegate
 */
@property(nonatomic, weak) IBOutlet id <APDataValidatorDelegate> delegate;

/**
 *  If set, the block runs when validation state changes
 */
@property(copy, nonatomic) APValidatorStateChangeHandler validatorStateChangedHandler;

/**
 *  Current validation state
 */
@property(nonatomic, assign, getter=isValid, readonly) BOOL valid;

/**
 *  Called to validate current validation object
 */
- (void)validate;

@end