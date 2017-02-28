//
//  KFMemberRepository.m
//  TestForU
//
//  Created by Kif on 28.02.17.
//  Copyright © 2017 KifApp. All rights reserved.
//

#import "KFMemberRepository.h"

@interface KFMemberRepository ()

@property (strong, nonatomic) NSMutableArray *arrayOfNames;

@end

@implementation KFMemberRepository

-(id)init {
    if (self = [super init]) {
        self.arrayOfNames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addName:(NSString*)string {
    [self.arrayOfNames addObject:string];
}

- (void)deleteName:(NSUInteger)index {
    [self.arrayOfNames removeObjectAtIndex:index];
}

- (NSString*)getName:(NSUInteger)index {
    NSString* string = [self.arrayOfNames objectAtIndex:index];
    return string;
}

- (NSInteger)getCount {
    return self.arrayOfNames.count;
}

@end
