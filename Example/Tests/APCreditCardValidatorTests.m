//
//  APCreditCardValidatorTests.m
//  APValidators
//
//  Created by Nickolay Sheika on 4/18/16.
//  Copyright (c) 2016 Nickolay Sheika. All rights reserved.
//

#import "APStringValidatorTestCase.h"
#import "APCreditCardValidator.h"



@interface APCreditCardValidatorTests : APStringValidatorTestCase

@end



@implementation APCreditCardValidatorTests


- (void)setUp
{
    [super setUp];

    self.validator = [APCreditCardValidator new];
}

#pragma mark - Tests

- (void)testEmptyValidationObject
{
    // given
    self.validator.validationObject = nil;

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beFalsy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeInvalid);
}

- (void)testValidationObjectIsShorterThanNine
{
    // given
    self.validator.validationObject = @"12345678";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beFalsy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeInvalid);
}

- (void)testVISA
{
    // given
    self.validator.validationObject = @"4012888888881881";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeVisa);
}

- (void)testVISA_Short
{
    // given
    self.validator.validationObject = @"4222222222222";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeVisa);
}

- (void)testMasterCard
{
    // given
    self.validator.validationObject = @"5555555555554444";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeMastercard);
}

- (void)testAMEX
{
    // given
    self.validator.validationObject = @"378282246310005";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeAmex);
}

- (void)testDiscover
{
    // given
    self.validator.validationObject = @"6011111111111117";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeDiscover);
}

- (void)testDinersClub
{
    // given
    self.validator.validationObject = @"30569309025904";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeDinersClub);
}

- (void)testJCB
{
    // given
    self.validator.validationObject = @"3566002020360505";

    // call
    [self.validator validate];

    // verifications
    expect(self.validator.isValid).to.beTruthy();
    expect(((APCreditCardValidator *)self.validator).creditCardType).to.equal(APCreditCardTypeJCB);
}

@end
