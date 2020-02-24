//
//  TCHUserDescriptorPaginator.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

#import "TCHUserDescriptor.h"

/** The results paginator for user descriptors list requests. */
@interface TCHUserDescriptorPaginator : NSObject

/** The items returned by the requested operation, if any.
 
 @return The items returned by the requested operation, if any.
 */
- (nonnull NSArray<TCHUserDescriptor *> *)items;

/** Determine if additional pages are available for the requested operation.
 
 @return BOOL indicating the presence of a subsequent page of results.
 */
- (BOOL)hasNextPage;

/** Request the next page of results for the current operation.
 
 @param completion The paginator completion block.  If no completion block is specified, no operation will be executed.
 */
- (void)requestNextPageWithCompletion:(nonnull TCHUserDescriptorPaginatorCompletion)completion;

@end
