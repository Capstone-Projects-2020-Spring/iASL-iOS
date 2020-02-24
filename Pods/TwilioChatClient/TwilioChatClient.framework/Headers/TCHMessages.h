//
//  TCHMessages.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"
#import "TCHMessage.h"
#import "TCHMessageOptions.h"

/** Representation of a chat channel's message list. */
@interface TCHMessages : NSObject

/** Index of the last Message the User has consumed in this Channel. */
@property (nonatomic, copy, readonly, nullable) NSNumber *lastConsumedMessageIndex;

/** Sends a message to the channel.
 
 @param options Message options.
 @param completion Completion block that will specify the result of the operation and a reference to the new message.
 */
- (void)sendMessageWithOptions:(nonnull TCHMessageOptions *)options
                    completion:(nullable TCHMessageCompletion)completion;

/** Removes the specified message from the channel.
 
 @param message The message to remove.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)removeMessage:(nonnull TCHMessage *)message
           completion:(nullable TCHCompletion)completion;

/** Fetches the most recent `count` messages.  This will return locally cached messages if they are all available or may require a load from the server.
 
 @param count The number of most recent messages to return.
 @param completion Completion block that will specify the result of the operation as well as the requested messages if successful.  If no completion block is specified, no operation will be executed.
 */
- (void)getLastMessagesWithCount:(NSUInteger)count
                      completion:(nonnull TCHMessagesCompletion)completion;

/** Fetches at most `count` messages including and prior to the specified `index`.  This will return locally cached messages if they are all available or may require a load from the server.

 @param index The starting point for the request.
 @param count The number of preceeding messages to return.
 @param completion Completion block that will specify the result of the operation as well as the requested messages if successful.  If no completion block is specified, no operation will be executed.
 */
- (void)getMessagesBefore:(NSUInteger)index
                withCount:(NSUInteger)count
               completion:(nonnull TCHMessagesCompletion)completion;

/** Fetches at most `count` messages including and subsequent to the specified `index`.  This will return locally cached messages if they are all available or may require a load from the server.
 
 @param index The starting point for the request.
 @param count The number of succeeding messages to return.
 @param completion Completion block that will specify the result of the operation as well as the requested messages if successful.  If no completion block is specified, no operation will be executed.
 */
- (void)getMessagesAfter:(NSUInteger)index
               withCount:(NSUInteger)count
              completion:(nonnull TCHMessagesCompletion)completion;

/** Returns the message with the specified index.
 
 @param index The index of the message.
 @param completion Completion block that will specify the result of the operation as well as the requested message if successful.  If no completion block is specified, no operation will be executed.
 */
- (void)messageWithIndex:(nonnull NSNumber *)index
              completion:(nonnull TCHMessageCompletion)completion;

/** Returns the oldest message starting at index.  If the message at index exists, it will be returned otherwise the next oldest message that presently exists will be returned.
 
 @param index The index of the last message reported as read (may refer to a deleted message).
 @param completion Completion block that will specify the result of the operation as well as the requested message if successful.  If no completion block is specified, no operation will be executed.
 */
- (void)messageForConsumptionIndex:(nonnull NSNumber *)index
                        completion:(nonnull TCHMessageCompletion)completion;

/** Set the last consumed index for this Member and Channel.  Allows you to set any value, including smaller than the current index.
 
 @param index The new index.
 @deprecated See setLastConsumedMessageIndex:completion:
 */
- (void)setLastConsumedMessageIndex:(nonnull NSNumber *)index __attribute__((deprecated("setLastConsumedMessageIndex: has been deprecated please use setLastConsumedMessageIndex:completion: instead")));

/** Set the last consumed index for this Member and Channel.  Allows you to set any value, including smaller than the current index.
 
 @param index The new index.
 @param completion Optional completion block that will specify the result of the operation and an updated unconsumed message count for the user on this channel.
 */
- (void)setLastConsumedMessageIndex:(nonnull NSNumber *)index completion:(nullable TCHCountCompletion)completion;

/** Update the last consumed index for this Member and Channel.  Only update the index if the value specified is larger than the previous value.
 
 @param index The new index.
 @deprecated See advanceLastConsumedMessageIndex:completion:
 */
- (void)advanceLastConsumedMessageIndex:(nonnull NSNumber *)index __attribute__((deprecated("advanceLastConsumedMessageIndex: has been deprecated please use advanceLastConsumedMessageIndex:completion: instead")));

/** Update the last consumed index for this Member and Channel.  Only update the index if the value specified is larger than the previous value.
 
 @param index The new index.
 @param completion Optional completion block that will specify the result of the operation and an updated unconsumed message count for the user on this channel.
 */
- (void)advanceLastConsumedMessageIndex:(nonnull NSNumber *)index completion:(nullable TCHCountCompletion)completion;

/** Update the last consumed index for this Member and Channel to the max message currently on this device.

 @deprecated See setAllMessagesConsumed:completion:
 */
- (void)setAllMessagesConsumed __attribute__((deprecated("setAllMessagesConsumed has been deprecated please use setAllMessagesConsumedWithCompletion: instead")));

/** Update the last consumed index for this Member and Channel to the max message currently on this device.

 @param completion Optional completion block that will specify the result of the operation and an updated unconsumed message count for the user on this channel.
 */
- (void)setAllMessagesConsumedWithCompletion:(nullable TCHCountCompletion)completion;

/** Reset the last consumed index for this Member and Channel to no messages consumed.

 @deprecated See setNoMessagesConsumed:completion:
 */
- (void)setNoMessagesConsumed __attribute__((deprecated("setNoMessagesConsumed has been deprecated please use setNoMessagesConsumedWithCompletion: instead")));

/** Reset the last consumed index for this Member and Channel to no messages consumed.
 
 @param completion Optional completion block that will specify the result of the operation and an updated unconsumed message count for the user on this channel.
 */
- (void)setNoMessagesConsumedWithCompletion:(nullable TCHCountCompletion)completion;

@end
