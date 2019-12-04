//
//  CarouselTestV.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/8/16.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CarouselTestV.h"
#import "ccs.h"

@implementation CarouselTestV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.label = ccs.Label;
     self.label.frame = self.bounds;
    
    self.label.textColor = UIColor.darkGrayColor;
    self.label.backgroundColor = UIColor.cyanColor;
    [self addSubview:self.label];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}
@end
