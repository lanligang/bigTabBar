//
//  WebVc.m
//  HeroDesigners
//
//  Created by Macx on 2017/7/22.
//  Copyright © 2017年 LLG. All rights reserved.
//

#import "FileQuickLookDeleVc.h"


@interface FileQuickLookDeleVc ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation FileQuickLookDeleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
 
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return self.fileURL;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view
{
    return self.view.bounds;
}

- (void)previewControllerWillDismiss:(QLPreviewController *)controller
{
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
