//
//  TCHMembers.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"
#import "TCHMember.h"

/** Representation of a chat channel's membership list. */
@interface TCHMembers : NSObject

/** Obtain the members of this channel.
 
 @param completion Completion block that will specify the result of the operation and a reference to the first page of members for this channel.  If no completion block is specified, no operation will be executed.
 */
- (void)membersWithCompletion:(nonnull TCHMemberPaginatorCompletion)completion;

/** Add specified username to this channel without inviting.
 
 @param identity The username to add to this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)addByIdentity:(nonnull NSString *)identity
           completion:(nullable TCHCompletion)completion;

/** Invite specified username to this channel.
 
 @param identity The username to invite to this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)inviteByIdentity:(nonnull NSString *)identity
              completion:(nullable TCHCompletion)completion;

/** Remove specified username from this channel.
 
 @param member The member to remove from this channel.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)removeMember:(nonnull TCHMember *)member
          completion:(nullable TCHCompletion)completion;

@end
