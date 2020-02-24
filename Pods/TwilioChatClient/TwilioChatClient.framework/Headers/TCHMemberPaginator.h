//
//  TCHMemberPaginator.h
//  Twilio Chat Client
//
//  Copyright (c) 2018 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

#import "TCHMember.h"

/** The results paginator for members list requests. */
@interface TCHMemberPaginator : NSObject

/** The items returned by the requested operation, if any.
 
 @return The items returned by the requested operation, if any.
 */
- (nonnull NSArray<TCHMember *> *)items;

/** Determine if additional pages are available for the requested operation.
 
 @return BOOL indicating the presence of a subsequent page of results.
 */
- (BOOL)hasNextPage;

/** Request the next page of results for the current operation.
 
 @param completion The paginator completion block.  If no completion block is specified, no operation will be executed.
 */
- (void)requestNextPageWithCompletion:(nonnull TCHMemberPaginatorCompletion)completion;

@end
