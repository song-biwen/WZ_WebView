//
//  WZWebViewController_01.m
//  WZWebView
//
//  Created by songbiwen on 2016/11/18.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWebViewController_01.h"

@interface WZWebViewController_01 ()
<UIWebViewDelegate>
@end

@implementation WZWebViewController_01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WZWebViewController_01";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]]];
    webView.delegate = self;
    [self.view addSubview:webView];
}


#pragma mark -UIWebViewDelegate

/**
 网页加载完成之后，调用该方法

 @param webView <#webView description#>
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSMutableString *mutableStr = [NSMutableString string];
    //删除导航栏的元素
    [mutableStr appendString:@"var header = document.getElementsByTagName('header')[0];header.parentNode.removeChild(header);"];
    //删除按钮
    [mutableStr appendString:@"var footer_btn = document.getElementsByClassName('footer-btn-fix')[0]; footer_btn.parentNode.removeChild(footer_btn);"];
    //删除版权
    [mutableStr appendString:@"var footer = document.getElementsByClassName('footer')[0]; footer.parentNode.removeChild(footer);"];
    //注入js删除网页相应元素
    [webView stringByEvaluatingJavaScriptFromString:mutableStr];
}

@end
