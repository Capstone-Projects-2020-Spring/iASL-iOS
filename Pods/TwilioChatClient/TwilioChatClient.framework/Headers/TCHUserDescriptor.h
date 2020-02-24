//
//  TCHUserDescriptor.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

/** A snapshot in time of user information for the current user and other channel members. */
@interface TCHUserDescriptor : NSObject

/** The identity for this user. */
@property (nonatomic, copy, readonly, nullable) NSString *identity;

/** The friendly name for this user. */
@property (nonatomic, copy, readonly, nullable) NSString *friendlyName;

/** Return this user's attributes.
 
 @return The developer-defined extensible attributes for this user.
 */
- (nullable NSDictionary<NSString *, id> *)attributes;

/** Indicates whether the user is online.  Note that if TwilioChatClient indicates reachability is not enabled, this will return NO.
 
 @return YES if the user is online.
 */
- (BOOL)isOnline;

/** Indicates whether the user is notifiable.  Note that if TwilioChatClient indicates reachability is not enabled, this will return NO.
 
 @return YES if the user is notifiable.
 */
- (BOOL)isNotifiable;

/** Subscribe and obtain a full TCHUser object for this user descriptor.
 
 @param completion Completion block that will specify the result of the operation and the newly subscribed user.
 */
- (void)subscribeWithCompletion:(nullable TCHUserCompletion)completion;

@end
