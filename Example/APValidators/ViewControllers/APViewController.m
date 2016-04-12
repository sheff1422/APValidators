//
//  APViewController.m
//  APValidators
//
//  Created by Nickolay Sheika on 03/14/2016.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APViewController.h"
#import "APCompoundValidator.h"



@interface APViewController ()


@property(strong, nonatomic) IBOutlet APCompoundValidator *formValidator;


@end



@implementation APViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self.formValidator.validators enumerateObjectsUsingBlock:^(APValidator *validator, NSUInteger idx, BOOL *stop) {
//        validator.validatorStateChangedHandler = ^(APValidator *validator2) {
//            ((UITextField *) validator2.control).backgroundColor = validator2.isValid ? [UIColor greenColor] : [UIColor redColor];
//        };
//    }];
}

#pragma mark - Actions

- (IBAction)goButtonTap:(id)sender
{
    [self.formValidator validate];

    NSLog(@"self.compoundValidator = %@", self.formValidator);

    NSString *title = self.formValidator.isValid ? @"Success" : @"Failure";

    NSMutableString *message = [NSMutableString string];
    if (self.formValidator.isValid) {
        [message appendString:@"Success"];
    }
    else {
        for (NSString *errorMessage in self.formValidator.errorMessages) {
            [message appendFormat:@"%@\n", errorMessage];
        }
    }

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

@end
