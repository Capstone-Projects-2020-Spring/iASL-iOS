//
//  TCHMember.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

/** Representation of a Member on a chat channel. */
@interface TCHMember : NSObject

/** The unique identifier for this member. */
@property (nonatomic, copy, readonly, nullable) NSString *sid;

/** The identity for this member. */
@property (nonatomic, strong, readonly, nullable) NSString *identity;

/** The type of this member. */
@property (nonatomic, readonly) TCHMemberType type;

/** Index of the last Message the Member has consumed in this Channel. */
@property (nonatomic, copy, readonly, nullable) NSNumber *lastConsumedMessageIndex;

/** Timestamp the last consumption updated for the Member in this Channel. */
@property (nonatomic, copy, readonly, nullable) NSString *lastConsumptionTimestamp;

/** Timestamp the last consumption updated for the Member in this Channel as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *lastConsumptionTimestampAsDate;

/** Return this member's attributes.

 @return The developer-defined extensible attributes for this member.
 */
- (nullable NSDictionary<NSString *, id> *)attributes;

/** Set this member's attributes.

 @param attributes The new developer-defined extensible attributes for this member. (Supported types are NSString, NSNumber, NSArray, NSDictionary and NSNull)
 @param completion Completion block that will specify the result of the operation.
 */
- (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attributes
           completion:(nullable TCHCompletion)completion;

/** Obtain a static snapshot of the user descriptor object for this member.
 
 @param completion Completion block that will specify the result of the operation and the user descriptor.
 */
- (void)userDescriptorWithCompletion:(nonnull TCHUserDescriptorCompletion)completion;

/** Obtain a subscribed user object for the member.  If no current subscription exists for this user, this will
 fetch the user and subscribe them.  The least recently used user object will be unsubscribed if you reach your instance's
 user subscription limit.
 
 @param completion Completion block that will specify the result of the operation and the newly subscribed user.
 */
- (void)subscribedUserWithCompletion:(nonnull TCHUserCompletion)completion;

@end
