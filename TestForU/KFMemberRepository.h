//
//  KFMemberRepository.h
//  TestForU
//
//  Created by Kif on 28.02.17.
//  Copyright © 2017 KifApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFMemberRepository : NSObject

- (void)addName:(NSString*)string;
- (void)deleteName:(NSUInteger)index;
- (NSString*)getName:(NSUInteger)indexPath;
- (NSInteger)getCount;
@end
