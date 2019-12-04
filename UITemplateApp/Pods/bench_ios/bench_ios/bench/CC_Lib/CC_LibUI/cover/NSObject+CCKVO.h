//
//  NSObject+CCKVO.h
//  CoverDemo
//
//  Created by ml on 2019/10/28.
//  Copyright © 2019 Shepherd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///  Source from https://github.com/ibireme/YYCategories/blob/master/YYCategories

@interface NSObject (CCKVO)

/**
 Registers a block to receive KVO notifications for the specified key-path
 relative to the receiver.
 
 @discussion The block and block captured objects are retained. Call
 `removeObserverBlocksForKeyPath:` or `removeObserverBlocks` to release.
 
 @param keyPath The key path, relative to the receiver, of the property to
 observe. This value must not be nil.
 
 @param block   The block to register for KVO notifications.
 */
- (void)cc_addObserverBlockForKeyPath:(NSString*)keyPath
                             block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications for the property specified by a given key-path
 relative to the receiver, and release these blocks.
 
 @param keyPath A key-path, relative to the receiver, for which blocks is
 registered to receive KVO change notifications.
 */
- (void)cc_removeObserverBlocksForKeyPath:(NSString*)keyPath;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications, and release these blocks.
 */
- (void)cc_removeObserverBlocks;

@end

NS_ASSUME_NONNULL_END
