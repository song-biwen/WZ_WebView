//
//  WZWebViewController_01.m
//  WZWebView
//
//  Created by songbiwen on 2016/11/18.
//  Copyright © 2016年 songbiwen. All rights reserved.
//

#import "WZWebViewController_01.h"

#define WZLink @"https://github.com/song-biwen/WZ_WebView"
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
 网页即将开始加载时，调用该方法

 可以监听网页里面的所有网络请求
 
 ———— 实现js间接调用oc
 @param webView <#webView description#>
 @param request <#request description#>
 @param navigationType <#navigationType description#>
 @return yes 表示网络请求成功，no 表示阻止网络请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr isEqualToString:WZLink]) {
        Class class = NSClassFromString(@"WZImageClickViewController");
        id subVC = [[class alloc] init];
        [self.navigationController pushViewController:subVC animated:YES];
        return NO;
    }
    return YES;
}
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
    
    //给图片添加点击事件
    [mutableStr appendFormat:@"var imgTag = document.getElementsByTagName('figure')[0].children[0];imgTag.onclick = function imgTagClick() {window.location.href= '%@'};",WZLink];
    //注入js删除网页相应元素
    [webView stringByEvaluatingJavaScriptFromString:mutableStr];
}

@end
