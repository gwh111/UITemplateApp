//
//  FirstVC.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/3.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "OtherVC.h"

@interface OtherVC ()

@end

@implementation OtherVC

- (void)cc_viewWillLoad {
    
}

- (void)cc_viewDidLoad {
    
    // Basic shared UI, you can add more by CC_ShareUI's category.
    ccs.ui.dateLabel
    .cc_addToView(self);
    
    ccs.ui.grayLine
    .cc_addToView(self).cc_top(RH(50));
    
    ccs.ui.disabledDoneButton
    .cc_addToView(self).cc_top(RH(100));
    
    ccs.ui.closeButton
    .cc_addToView(self).cc_top(RH(150));
}

@end
