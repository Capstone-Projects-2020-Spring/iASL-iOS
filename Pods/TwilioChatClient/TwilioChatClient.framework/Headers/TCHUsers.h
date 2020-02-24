//
//  TCHUsers.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"
#import "TCHUser.h"

/** Representation of a chat channel's users list. */
@interface TCHUsers : NSObject

/** Obtain a list of user descriptors for the specified channel.
 
 @param channel The channel to load the user descriptors for.
 @param completion Completion block that will specify the result of the operation and an array of user descriptors.
 */
- (void)userDescriptorsForChannel:(nonnull TCHChannel *)channel
                       completion:(nonnull TCHUserDescriptorPaginatorCompletion)completion;

/** Obtain a static snapshot of the user descriptor object for the given identity.
 
 @param identity The identity of the user to obtain.
 @param completion Completion block that will specify the result of the operation and the user descriptor.
 */
- (void)userDescriptorWithIdentity:(nonnull NSString *)identity
                        completion:(nonnull TCHUserDescriptorCompletion)completion;

/** Obtain a subscribed user object for the given identity.  If no current subscription exists for this user, this will 
 fetch the user and subscribe them.  The least recently used user object will be unsubscribed if you reach your instance's
 user subscription limit.
 
 @param identity The identity of the user to obtain.
 @param completion Completion block that will specify the result of the operation and the newly subscribed user.
 */
- (void)subscribedUserWithIdentity:(nonnull NSString *)identity
                        completion:(nonnull TCHUserCompletion)completion;

/** Obtain a reference to all currently subscribed users in the system.
 
 @return An array of subscribed TCHUser objects.
 */
- (nonnull NSArray<TCHUser *> *)subscribedUsers;

@end
