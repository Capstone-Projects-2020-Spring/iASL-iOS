//
//  TCHResult.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHError.h"

/** Result class passed via completion blocks.  Contains a boolean property, `isSuccessful`, which
 indicates the result of the operation and an error object if the operation failed.
 */
@interface TCHResult : NSObject

/** The result's TCHError if the operation failed. */
@property (nonatomic, strong, readonly, nullable) TCHError *error;

/** The result code for the operation. */
@property (nonatomic, assign, readonly) NSInteger resultCode;

/** The result descriptive text for the operation. */
@property (nonatomic, copy, readonly, nullable) NSString *resultText;

/** Indicates the success or failure of the given operation.
 
 @return Boolean YES if the operation was successful, NO otherwise.
 */
- (BOOL)isSuccessful;

@end
