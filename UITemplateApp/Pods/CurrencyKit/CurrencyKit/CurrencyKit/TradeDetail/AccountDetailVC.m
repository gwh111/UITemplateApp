//
//  AccountDetailViewController.m
//  CurrencyKit
//
//  Created by gwh on 2019/11/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AccountDetailVC.h"
#import "SearchWithDateC.h"
#import "AccountDetailC.h"

@interface AccountDetailVC ()

@property (nonatomic, retain) SearchWithDateC *searchWithDate;
@property (nonatomic, retain) AccountDetailC *detail;

@end

@implementation AccountDetailVC

- (void)cc_viewWillLoad {
    
   self.cc_title = @"收支明细";

   self.view.backgroundColor = HEX(#F5F5F5);
    
    _searchWithDate = [ccs init:SearchWithDateC.class];
    [self cc_registerController:_searchWithDate];
    
    _detail = [ccs init:AccountDetailC.class];
    [self cc_registerController:_detail];
    
}

- (void)cc_viewDidLoad {
     // Do any additional setup after loading the view.
    [self update];
}

- (void)update {
    
    _detail.displayView.top = _searchWithDate.displayView.bottom + RH(5);
    _detail.displayView.height = self.cc_displayView.height - _detail.displayView.top;
    [_detail updateAccountDetail];
}

- (void)controller:(CC_Controller *)controller searchFromDate:(NSString *)fromDate toDate:(NSString *)toDate {
    
    CCLOG(@"%@ %@", fromDate, toDate);
    [_detail searchFromDate:fromDate toDate:toDate];
}

@end
