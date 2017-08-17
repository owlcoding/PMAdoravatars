//
// Created by Pawel Maczewski on 28/07/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConfigurableItem <NSObject>

- (void)configureWithItem:(NSObject *)item;

@end