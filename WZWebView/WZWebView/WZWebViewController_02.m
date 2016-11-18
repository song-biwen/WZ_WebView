//
//  WZWebViewController_02.m
//  WZWebView
//
//  Created by songbiwen on 2016/11/18.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWebViewController_02.h"
#import <WebKit/WebKit.h>

#define WZLink @"https://github.com/song-biwen/WZ_WebView"

@interface WZWebViewController_02 ()
<WKNavigationDelegate>
@end

@implementation WZWebViewController_02

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WZWebViewController_02";
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"]]];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
}

#pragma mark - WKNavigationDelegate
/*
 网页即将开始加载时，调用该方法
 //必须调用decisionHandler
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlStr = navigationAction.request.URL.absoluteString;
    if ([urlStr isEqualToString:WZLink]) {
        //截取图片的点击事件
        Class class = NSClassFromString(@"WZImageClickViewController");
        id subVC = [[class alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/*
 网页加载完成之后，调用该方法
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSMutableString *mutableStr = [NSMutableString string];
    //删除导航栏的元素
    [mutableStr appendString:@"var header = document.getElementsByTagName('header')[0];header.parentNode.removeChild(header);"];
    //删除按钮
    [mutableStr appendString:@"var footer_btn = document.getElementsByClassName('footer-btn-fix')[0]; footer_btn.parentNode.removeChild(footer_btn);"];
    //删除版权
    [mutableStr appendString:@"var footer = document.getElementsByClassName('footer')[0]; footer.parentNode.removeChild(footer);"];
    
    //给图片添加点击事件
    [mutableStr appendFormat:@"var imgTag = document.getElementsByTagName('figure')[0].children[0];imgTag.onclick = function imgTagClick() {window.location.href= '%@'};",WZLink];
    //注入js删除网页相应元素
    [webView evaluateJavaScript:mutableStr completionHandler:nil];
}
@end
