//
//  FreezeViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "FreezeDetailVC.h"
#import "SearchWithDateC.h"
#import "FreezeDetailC.h"

@interface FreezeDetailVC ()

@property (nonatomic, retain) SearchWithDateC *searchWithDate;
@property (nonatomic, retain) FreezeDetailC *detail;
@property (nonatomic, assign) int currentPage;

@end

@implementation FreezeDetailVC

- (void)cc_viewWillLoad {
    
   self.cc_title = @"冻结明细";

   self.view.backgroundColor = HEX(#F5F5F5);
    
    _searchWithDate = [ccs init:SearchWithDateC.class];
    [self cc_registerController:_searchWithDate];
    
    _detail = [ccs init:FreezeDetailC.class];
    [self cc_registerController:_detail];
    
}

- (void)cc_viewDidLoad {
     // Do any additional setup after loading the view.
    [self update];
}

- (void)update {
    
    _detail.displayView.top = _searchWithDate.displayView.bottom + RH(5);
    _detail.displayView.height = self.cc_displayView.height - _detail.displayView.top;
    [_detail updateFreezeDetail];
}

- (void)controller:(CC_Controller *)controller searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate {
    
    CCLOG(@"%@ %@", fromDate, toDate);
    [_detail searchFromDate:fromDate toDate:toDate];
}

@end
