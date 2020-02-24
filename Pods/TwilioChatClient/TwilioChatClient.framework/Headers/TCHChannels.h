//
//  TCHChannels.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

/** Representation of a chat channel list. */
@interface TCHChannels : NSObject

/** Retrieve a list of channels currently subscribed to on the client.
 
 @return An array of all of the client's currently subscribed channels.
 */
- (nonnull NSArray<TCHChannel *> *)subscribedChannels;

/** Retrieve a sorted list of channels currently subscribed to on the client.

 @param criteria The TCHChannelSortingCriteria to order the channels by.
 @param order The TCHChannelSortingOrder direction of the sort, either ascending or descending.
 @return An array of all of the client's currently subscribed channels.
 */
- (nonnull NSArray<TCHChannel *> *)subscribedChannelsSortedBy:(TCHChannelSortingCriteria)criteria
                                                        order:(TCHChannelSortingOrder)order;

/** Retrieve a list of channel descriptors the user has a participation state on, for example invited, joined, creator.
 
 @param completion Completion block that will specify the result of the operation and a reference to the first page of user channel descriptors.  If no completion block is specified, no operation will be executed.
 */
- (void)userChannelDescriptorsWithCompletion:(nonnull TCHChannelDescriptorPaginatorCompletion)completion;

/** Retrieve a list of channel descriptors for publicly visible channels.
 
 @param completion Completion block that will specify the result of the operation and a reference to the first page of public channel descriptors.  If no completion block is specified, no operation will be executed.
 */
- (void)publicChannelDescriptorsWithCompletion:(nonnull TCHChannelDescriptorPaginatorCompletion)completion;

/** Create a new channel with the specified options.
 
 @param options Channel options for new channel whose keys are TCHChannelOption* constants. (optional - may be empty or nil)
 @param completion Completion block that will specify the result of the operation and a reference to the new channel.
 @discussion TCHChannelOptionFriendlyName - String friendly name (optional)
 @discussion TCHChannelOptionUniqueName - String unique name (optional)
 @discussion TCHChannelOptionType - Expected values are @(TCHChannelTypePublic) or @(TCHChannelTypePrivate) (optional)
 @discussion TCHChannelOptionAttributes - Expected value is an NSDictionary<NSString*,id> *, see also TCHChannel setAttributes:completion: (optional)
 */
- (void)createChannelWithOptions:(nullable NSDictionary<NSString *, id> *)options
                      completion:(nullable TCHChannelCompletion)completion;

/** Obtains a channel with the specified id or unique name.
 
 @param sidOrUniqueName Identifier or unique name for the channel.
 @param completion Completion block that will specify the result of the operation and a reference to the requested channel if it exists.
 */
- (void)channelWithSidOrUniqueName:(nonnull NSString *)sidOrUniqueName
                        completion:(nonnull TCHChannelCompletion)completion;

@end
