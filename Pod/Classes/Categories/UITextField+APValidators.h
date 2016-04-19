//
// Created by Nickolay Sheika on 25.11.15.
// Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APValidator;



@interface UITextField (APValidators)

/**
 *  Validator object currently attached to this text field.
 */
@property(nonatomic, strong) IBOutlet APValidator *validator;

@end