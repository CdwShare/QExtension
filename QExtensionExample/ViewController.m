//
//  ViewController.m
//  QExtensionExample
//
//  Created by JHQ0228 on 16/7/18.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"

#import "QExtension.h"

@interface ViewController () <QMarqueeViewDelegate>

@property (nonatomic, strong) QProgressButton *progressButton;

@property (nonatomic, strong) QTouchLockView *touchLockView;
@property (nonatomic, strong) NSMutableArray *passWordArrM;

@property (nonatomic, strong) QTouchClipView *touchClipView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;

@property (nonatomic, strong) QPaintBoardView *paintBoardView;

@property (nonatomic, strong) QCountingLabel *countingLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self nsArrayLocaleLogDemo];
    
//    [self nsDataFormDataDemo];
    
//    [self nsDictionaryLocaleLogDemo];
    
//    [self nsStringBase64Demo];
//    [self nsStringBundlePathDemo];
//    [self nsStringHashDemo];
//    [self nsStringRegexDemo];
    
//    [self uiButtonQProgressButtonDemo];
    
//    [self uiColorHexDemo];
    
//    [self uiImageDrawDemo];
//    [self uiImageGIFDemo];
//    [self uiImageQRCodeDemo];
    
//    [self uiViewFrameDemo];
//    [self uiViewQPageViewDemo];
//    [self uiViewQPaintBoardViewDemo1];
//    [self uiViewQPaintBoardViewDemo2];
//    [self uiViewQTouchClipViewDemo];
//    [self uiViewQTouchLockViewDemo];
    [self uiViewQMarqueeViewDemo];
    
//    [self uiViewControllerQQRCodeDemo];
    
//    [self qCountingLabelDemo1];
//    [self qCountingLabelDemo2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


#pragma mark - NSArray+QExtension

#pragma mark LocaleLog

- (void)nsArrayLocaleLogDemo {
    
    NSArray *localeArray = @[@"hello", @"你好", @"欢迎"];
    
    NSLog(@"%@", localeArray);
}


#pragma mark - NSData+QExtension

#pragma mark FormData

- (void)nsDataFormDataDemo {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = self.view.center;
    [button setTitle:@"开始上传文件" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(uploadFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)uploadFile {
    
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload-m.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 格式化上传的文件数据
    
//    NSData *formData = [self fileFormDataWithRequest1:request];
//    NSData *formData = [self fileFormDataWithRequest2:request];
    
//    NSData *formData = [self fileFormDataWithRequest3:request];
//    NSData *formData = [self fileFormDataWithRequest4:request];
//    NSData *formData = [self fileFormDataWithRequest5:request];
//    NSData *formData = [self fileFormDataWithRequest6:request];
    
//    NSData *formData = [self fileFormDataWithRequest7:request];
//    NSData *formData = [self fileFormDataWithRequest8:request];
//    NSData *formData = [self fileFormDataWithRequest9:request];
    NSData *formData = [self fileFormDataWithRequest10:request];
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request
                                                fromData:formData
                                       completionHandler:^(NSData * _Nullable data,
                                                           NSURLResponse * _Nullable response,
                                                           NSError * _Nullable error) {
       NSLog(@"文件上传成功：\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

// 文件上传拼接，指定文件数据
- (NSData *)fileFormDataWithRequest1:(NSMutableURLRequest *)request {
    
    NSMutableData *formData = [NSMutableData data];
    
    // 设置分割字符串
    static NSString *boundary = @"uploadBoundary";
    
    // 设置请求头
    [formData q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
    
    // 添加文件
    NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    [formData q_appendPartWithFileData:filedata
                          fileBoundary:boundary
                                  name:@"userfile"
                              fileName:@"test1.png"
                              mimeType:@"image/png"];
    
    // 添加文本内容
    [formData q_appendPartWithText:@"QianChia_test1" textName:@"username" fileBoundary:boundary];
    
    // 添加结束分隔符
    [formData q_appendPartEndingWithFileBoundary:boundary];
    
    return formData;
}

// 文件上传拼接，指定文件路径
- (NSData *)fileFormDataWithRequest2:(NSMutableURLRequest *)request {
    
    NSMutableData *formData = [NSMutableData data];
    
    // 设置分割字符串
    static NSString *boundary = @"uploadBoundary";
    
    // 设置请求头
    [formData q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
    
    // 添加文件
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    [formData q_appendPartWithFileURL:fileURL
                         fileBoundary:boundary
                                 name:@"userfile"
                             fileName:@"test2.png"
                             mimeType:@"image/png"];
    
    // 添加文本内容
    [formData q_appendPartWithText:@"QianChia_test2" textName:@"username" fileBoundary:boundary];
    
    // 添加结束分隔符
    [formData q_appendPartEndingWithFileBoundary:boundary];
    
    return formData;
}

// 单文件上传封装，指定文件数据，不带文本内容
- (NSData *)fileFormDataWithRequest3:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                            fileData:filedata
                                                name:@"userfile"
                                            fileName:@"test3.png"
                                            mimeType:@"image/png"];
    
    return formData;
}

// 单文件上传封装，指定文件路径，不带文本内容
- (NSData *)fileFormDataWithRequest4:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                            fileURL:fileURL
                                                name:@"userfile"
                                            fileName:@"test4.png"
                                            mimeType:@"image/png"];
    
    return formData;
}

// 单文件上传封装，指定文件数据，带文本内容
- (NSData *)fileFormDataWithRequest5:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                                text:@"QianChia_test5"
                                            textName:@"username"
                                            fileData:filedata
                                                name:@"userfile"
                                            fileName:@"test5.png"
                                            mimeType:@"image/png"];
    
    return formData;
}

// 单文件上传封装，指定文件路径，带文本内容
- (NSData *)fileFormDataWithRequest6:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                                text:@"QianChia_test6"
                                            textName:@"username"
                                             fileURL:fileURL
                                                name:@"userfile"
                                            fileName:@"test6.png"
                                            mimeType:@"image/png"];
    
    return formData;
}

// 多文件上传封装，指定文件数据，不带文本内容
- (NSData *)fileFormDataWithRequest7:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSData *filedata1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    NSData *filedata2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                           fileDatas:@[filedata1, filedata2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test7.png", @"test7.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    return formData;
}

// 多文件上传封装，指定文件路径，不带文本内容
- (NSData *)fileFormDataWithRequest8:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSURL *fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    NSURL *fileURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                            fileURLs:@[fileURL1, fileURL2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test8.png", @"test8.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];

    return formData;
}

// 多文件上传封装，指定文件数据，带文本内容
- (NSData *)fileFormDataWithRequest9:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSData *filedata1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    NSData *filedata2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                               texts:@[@"QianChia_test9"]
                                           textNames:@[@"username"]
                                           fileDatas:@[filedata1, filedata2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test9.png", @"test9.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    return formData;
}

// 多文件上传封装，指定文件路径，带文本内容
- (NSData *)fileFormDataWithRequest10:(NSMutableURLRequest *)request {
    
    // 添加文件
    NSURL *fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    NSURL *fileURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
    NSData *formData = [NSData q_formDataWithRequest:request
                                               texts:@[@"QianChia_test10"]
                                           textNames:@[@"username"]
                                            fileURLs:@[fileURL1, fileURL2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test10.png", @"test10.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    return formData;
}


#pragma mark - NSDictionary+QExtension

#pragma mark LocaleLog

- (void)nsDictionaryLocaleLogDemo {
    
    NSDictionary *localeDictionary = @{@"key1":@"value1", @"key2":@"你好", @"键3":@"欢迎", };
    
    NSLog(@"%@", localeDictionary);
}


#pragma mark - NSString+QExtension

#pragma mark Base64

- (void)nsStringBase64Demo {
    
    NSString *str = @"hello world";
    
    // Base64 编码
    NSString *base64Str = [str q_base64Encode];
    NSLog(@"base64Str: %@", base64Str);
    
    // Base64 解码
    NSString *asciiStr = [base64Str q_base64Decode];
    NSLog(@"asciiStr: %@", asciiStr);
    
    // 服务器基本授权字符串编码
    NSString *authStr = [str q_basic64AuthEncode];
    NSLog(@"authStr: %@", authStr);
}


#pragma mark BundlePath

- (void)nsStringBundlePathDemo {
    
    NSString *filePath = @"~/Desktop/file.txt";
    
    // 拼接文档路径
    
    NSString *documentPath = [filePath q_appendDocumentPath];
    NSLog(@"documentPath: \n%@\n\n", documentPath);
    
    NSString *md5DocumentPath = [filePath q_appendMD5DocumentPath];
    NSLog(@"md5DocumentPath: \n%@\n\n", md5DocumentPath);
    
    // 拼接缓存路径
    
    NSString *cachePath = [filePath q_appendCachePath];
    NSLog(@"cachePath: \n%@\n\n", cachePath);
    
    NSString *md5CachePath = [filePath q_appendMD5CachePath];
    NSLog(@"md5CachePath: \n%@\n\n", md5CachePath);
    
    // 拼接临时路径
    
    NSString *tempPath = [filePath q_appendTempPath];
    NSLog(@"tempPath: \n%@\n\n", tempPath);
    
    NSString *md5TempPath = [filePath q_appendMD5TempPath];
    NSLog(@"md5TempPath: \n%@\n\n", md5TempPath);
}

#pragma mark Hash

- (void)nsStringHashDemo {
    
    NSString *str = @"hello world";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    // 散列
    
    NSString *md5Str = [str q_md5String];
    NSLog(@"md5Str: %@", md5Str);
    
    NSString *sha1Str = [str q_sha1String];
    NSLog(@"sha1Str: %@", sha1Str);
    
    NSString *sha224Str = [str q_sha224String];
    NSLog(@"sha224Str: %@", sha224Str);
    
    NSString *sha256Str = [str q_sha256String];
    NSLog(@"sha256Str: %@", sha256Str);
    
    NSString *sha384Str = [str q_sha384String];
    NSLog(@"sha384Str: %@", sha384Str);
    
    NSString *sha512Str = [str q_sha512String];
    NSLog(@"sha512Str: %@\n\n", sha512Str);
    
    // hmac 散列
    
    NSString *hmacMD5Str = [str q_hmacMD5StringWithKey:@"yourKey"];
    NSLog(@"hmacMD5Str: %@", hmacMD5Str);
    
    NSString *hmacSHA1Str = [str q_hmacSHA1StringWithKey:@"yourKey"];
    NSLog(@"hmacSHA1Str: %@", hmacSHA1Str);
    
    NSString *hmacSHA224Str = [str q_hmacSHA224StringWithKey:@"yourKey"];
    NSLog(@"hmacSHA224Str: %@", hmacSHA224Str);
    
    NSString *hmacSHA256Str = [str q_hmacSHA256StringWithKey:@"yourKey"];
    NSLog(@"hmacSHA256Str: %@", hmacSHA256Str);
    
    NSString *hmacSHA384Str = [str q_hmacSHA384StringWithKey:@"yourKey"];
    NSLog(@"hmacSHA384Str: %@", hmacSHA384Str);
    
    NSString *hmacSHA512Str = [str q_hmacSHA512StringWithKey:@"yourKey"];
    NSLog(@"hmacSHA512Str: %@\n\n", hmacSHA512Str);
    
    // 时间戳 MD5 散列
    
    NSString *timeStr = [str q_timeMD5StringWithKey:@"yourKey"];
    NSLog(@"timeStr: %@\n\n", timeStr);
    
    // 文件 散列
    
    NSString *fileMD5Str = [filePath q_fileMD5Hash];
    NSLog(@"fileMD5Str: %@", fileMD5Str);
    
    NSString *fileSHA1Str = [filePath q_fileSHA1Hash];
    NSLog(@"fileSHA1Str: %@", fileSHA1Str);
    
    NSString *fileSHA256Str = [filePath q_fileSHA256Hash];
    NSLog(@"fileSHA256Str: %@", fileSHA256Str);
    
    NSString *fileSHA512Str = [filePath q_fileSHA512Hash];
    NSLog(@"fileSHA512Str: %@", fileSHA512Str);
}

#pragma mark Regex

- (void)nsStringRegexDemo {
    
    // 验证手机号码的有效性
    
    NSString *mobileNum1 = @"15188886666";
    BOOL isValidMobileNum1 = [mobileNum1 q_isValidMobileNum];
    NSLog(@"MobileNum1: %zi", isValidMobileNum1);
    
    NSString *mobileNum2 = @"19188886666";
    BOOL isValidMobileNum2 = [mobileNum2 q_isValidMobileNum];
    NSLog(@"MobileNum2: %zi", isValidMobileNum2);
    
    // 验证邮箱的有效性
    
    NSString *emailAddress1 = @"qianchia@icloud.com";
    BOOL isValidEmailAddress1 = [emailAddress1 q_isValidEmailAddress];
    NSLog(@"EmailAddress1: %zi", isValidEmailAddress1);
    
    NSString *emailAddress2 = @"qian@chia@icloud.com";
    BOOL isValidEmailAddress2 = [emailAddress2 q_isValidEmailAddress];
    NSLog(@"EmailAddress2: %zi", isValidEmailAddress2);
}


#pragma mark - UIButton+QExtension

#pragma mark QProgressButton

- (void)uiButtonQProgressButtonDemo {
    
    // 创建进度按钮
    QProgressButton *progressButton = [QProgressButton q_progressButtonWithFrame:CGRectMake(100, 100, 100, 50)
                                                                           title:@"开始下载"
                                                                       lineWidth:10
                                                                       lineColor:[UIColor blueColor]
                                                                       textColor:[UIColor redColor]
                                                                 backgroundColor:[UIColor yellowColor]
                                                                         isRound:YES];
    
    // 设置按钮点击事件
    [progressButton addTarget:self action:@selector(progressUpdate:) forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮添加到当前控件显示
    [self.view addSubview:progressButton];
    
    self.progressButton = progressButton;
}

- (void)progressUpdate:(UISlider *)slider {
    
    // 模拟下载
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(dateUpdate:)
                                   userInfo:nil
                                    repeats:YES];
    
    // 移除按钮点击事件放置重复点击
    [self.progressButton removeTarget:self action:@selector(progressUpdate:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dateUpdate:(NSTimer *)timer {
    
    static float progress = 0;
    
    if (progress < 1) {
        
        progress = (progress + 0.001 > 1) ? : (progress + 0.001);
        
        // 设置按钮的进度值
        self.progressButton.progress = progress;
    
    } else {
        
        [timer invalidate];
        
        // 设置按钮的进度终止标题，一旦设置了此标题进度条就会停止
        self.progressButton.stopTitle = @"下载完成";
    }
}


#pragma mark - UIColor+QExtension

#pragma mark Hex

- (void)uiColorHexDemo {
    
//    self.view.backgroundColor = [UIColor blueColor];
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 100, 100)];
    [self.view addSubview:vi];
    
    // 由十六进制颜色值创建 RGB 颜色值
//    UIColor *color = [UIColor colorWithHexString:@"0Xc83c23"];
    
    UIColor *color = [UIColor colorWithHexString:@"0Xc83c23" alpha:0.5];
    
    vi.backgroundColor = color;
}


#pragma mark - UIImage+QExtension

#pragma mark Draw

- (void)uiImageDrawDemo {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.view.bounds.size.height - 100, 100, 50);
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(drawButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect frame1 = CGRectMake(20, 40, self.view.bounds.size.width - 40, self.view.bounds.size.width - 40);
    UIImageView *imv1 = [[UIImageView alloc] initWithFrame:frame1];
    imv1.layer.borderWidth = 1;
//    imv1.image = [UIImage imageNamed:@"demo5"];
    imv1.image = [UIImage imageNamed:@"demo2.jpg"];
    [self.view addSubview:imv1];
    self.imageView1 = imv1;
    
    CGRect frame2 = CGRectMake(20, 40, self.view.bounds.size.width - 40, (self.view.bounds.size.width - 40) * 1.5);
    UIImageView *imv2 = [[UIImageView alloc] initWithFrame:frame2];
    imv2.layer.borderWidth = 1;
    imv2.hidden = YES;
    [self.view addSubview:imv2];
    self.imageView2 = imv2;
}

- (void)drawButtonClick {
    
//    [self imageDrawDemo1];
//    [self imageDrawDemo2];
//    [self imageDrawDemo3];
//    [self imageDrawDemo4];
    [self imageDrawDemo5];
//    [self imageDrawDemo6];
}

- (void)imageDrawDemo1 {
    
    // 截取全屏幕图
    UIImage *image = [UIImage q_imageWithScreenShot];
    
    self.imageView2.image = image;
    
    self.imageView1.hidden = YES;
    self.imageView2.hidden = NO;
}

- (void)imageDrawDemo2 {
    
    // 截取指定视图控件屏幕图
    UIImage *image = [UIImage q_imageWithScreenShotFromView:self.imageView1];
    
    self.imageView2.image = image;
    
    self.imageView1.hidden = YES;
    self.imageView2.hidden = NO;
}

- (void)imageDrawDemo3 {
    
    // 调整图片的尺寸
    UIImage *image = [UIImage imageNamed:@"demo2.jpg"];
    UIImage *newImage = [image q_imageByScalingAndCroppingToSize:CGSizeMake(200, 200)];
    
    self.imageView1.contentMode = UIViewContentModeTopLeft;
    self.imageView1.image = newImage;
}

- (void)imageDrawDemo4 {
    
    // 裁剪圆形图片
    UIImage *image = [UIImage imageNamed:@"demo2.jpg"];
    UIImage *newImage = [image q_imageByCroppingToRound];
    
    self.imageView1.image = newImage;
}

- (void)imageDrawDemo5 {
    
    // 添加图片水印
    
    // 设置水印文本属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:50];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor redColor] colorWithAlphaComponent:0.2];
    textAttrs[NSStrokeWidthAttributeName] = @5;
    
    // 添加图片水印
    UIImage *image = [UIImage imageNamed:@"demo2.jpg"];
    UIImage *newImage = [image q_imageWithWaterMarkString:@"QianChia"
                                               attributes:textAttrs
                                                    image:[UIImage imageNamed:@"demo5"]
                                                    frame:CGRectMake(30, 300, 50, 50)];
    
    self.imageView1.image = newImage;
}

- (void)imageDrawDemo6 {
    
    // 添加图片水印
    UIImage *image = [UIImage imageNamed:@"demo8"];
    UIImage *newImage = [image q_imageWithWaterMarkString:nil
                                               attributes:nil
                                                    image:[UIImage imageNamed:@"demo5"]
                                                    frame:CGRectMake(-1, -1, 88, 88)];
    
    self.imageView1.image = newImage;
}

#pragma mark GIF

- (void)uiImageGIFDemo {
    
    CGRect frame1 = CGRectMake(20, 200, self.view.bounds.size.width - 40, (self.view.bounds.size.width - 40) / 3 * 2);
    UIImageView *imv1 = [[UIImageView alloc] initWithFrame:frame1];
    imv1.layer.borderWidth = 1;
    [self.view addSubview:imv1];
    self.imageView1 = imv1;
    
//    [self imageGIFDemo1];
    [self imageGIFDemo2];
}

- (void)imageGIFDemo1 {
    
    // 通过名称加载 gif 图片，不需要写扩展名
    self.imageView1.image = [UIImage q_gifImageNamed:@"demo3"];
}

- (void)imageGIFDemo2 {
    
    // 通过数据加载 gif 图片
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo3" ofType:@"gif"]];
    
    self.imageView1.image = [UIImage q_gifImageWithData:imageData];
}

#pragma mark QRCode

- (void)uiImageQRCodeDemo {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.view.bounds.size.height - 100, 200, 50);
    [button setTitle:@"生成/识别" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(qrCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect frame1 = CGRectMake(20, 40, self.view.bounds.size.width - 40, self.view.bounds.size.width - 40);
    UIImageView *imv1 = [[UIImageView alloc] initWithFrame:frame1];
    imv1.layer.borderWidth = 1;
    [self.view addSubview:imv1];
    self.imageView1 = imv1;
}

- (void)qrCodeButtonClick {
    
//    [self createQRCodeDemo1];
//    [self createQRCodeDemo2];
//    [self createQRCodeDemo3];
//    [self createQRCodeDemo4];
    [self createQRCodeDemo5];
}

- (void)createQRCodeDemo1 {
    
    // 生成二维码
    UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
                                                   headIcon:nil
                                                      color:nil
                                                  backColor:nil];
    
    self.imageView1.image = qrImage;
}

- (void)createQRCodeDemo2 {
    
    // 生成二维码
    UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
                                                   headIcon:[UIImage imageNamed:@"demo6"]
                                                      color:[UIColor blackColor]
                                                  backColor:[UIColor whiteColor]];

    NSData *data = UIImagePNGRepresentation(qrImage);
    [data writeToFile:@"/Users/JHQ0228/Desktop/Images/pic.png" atomically:YES];
    
    self.imageView1.image = qrImage;
}

- (void)createQRCodeDemo3 {
    
    // 生成指定图片大小的二维码
    UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
                                                  imageSize:CGSizeMake(2048, 2048)
                                                   headIcon:[UIImage imageNamed:@"demo6"]
                                                   headFrame:CGRectMake(819, 819, 410, 410)
                                                      color:nil
                                                  backColor:nil];
    
    NSData *data = UIImagePNGRepresentation(qrImage);
    [data writeToFile:@"/Users/JHQ0228/Desktop/Images/pic.png" atomically:YES];
    
    self.imageView1.image = qrImage;
}

- (void)createQRCodeDemo4 {
    
    // 创建图片，添加长按手势
    self.imageView1.image = [UIImage imageNamed:@"demo4"];
    self.imageView1.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dealLongPress:)];
    [self.imageView1 addGestureRecognizer:longPress];
}

- (void)dealLongPress:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        UIImageView *pressedImageView = (UIImageView *)gesture.view;
        UIImage *image = pressedImageView.image;
        
        // 识别图片中的二维码
        NSString *result = [image q_stringByRecognizeQRCode];
        
        [[[UIAlertView alloc] initWithTitle:@"Succeed"
                                    message:result
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }
}

- (void)createQRCodeDemo5 {
    
    // 生成指定图片大小的条形码
    UIImage *qrImage = [UIImage q_imageWithBarCodeFromString:@"QianChia"
                                                   imageSize:CGSizeMake(1024, 512)
                                                         red:0
                                                       green:0.4
                                                        blue:0.6];
    
    NSData *data = UIImagePNGRepresentation(qrImage);
    [data writeToFile:@"/Users/JHQ0228/Desktop/Images/pic.png" atomically:YES];
    
    self.imageView1.image = qrImage;
}


#pragma mark - UIView+QExtension

#pragma mark Frame

- (void)uiViewFrameDemo {
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    [UIView animateWithDuration:2 animations:^{
        
        // 直接设置控件的位置尺寸值
        
        view.x = 20;
        view.y = 200;
        view.width = 200;
        view.height = 100;
        
        view.centerX = 160;
        view.centerY = 300;
        
        view.size = CGSizeMake(100, 200);
    }];
}

#pragma mark QPageView

- (void)uiViewQPageViewDemo {
    
    [self qPageViewDemo1];
    [self qPageViewDemo2];
}

- (void)qPageViewDemo1 {
    
    // 创建分页视图控件
    CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width / 2);
    
    QPageView *pageView = [[QPageView alloc] initWithFrame:frame];
    
    // 设置显示的图片
    pageView.imageNames = @[@"page_00", @"page_01", @"page_02", @"page_03", @"page_04"];
    
    // 设置页码视图的颜色
    pageView.currentPageIndicatorColor = [UIColor redColor];
    pageView.pageIndicatorColor = [UIColor greenColor];
    
    // 设置页码视图的位置
    pageView.pageIndicatorPosition = QPageIndicatorPositionRight;
    
    // 设置是否隐藏页码视图
    pageView.hidePageIndicator = NO;
    
    // 设置滚动方向
    pageView.scrollDirectionPortrait = YES;
    
    [self.view addSubview:pageView];
}

- (void)qPageViewDemo2 {
    
    // 设置显示的图片
    NSArray *imageNameArr = @[@"page_00", @"page_01", @"page_02", @"page_03", @"page_04"];
    
    // 创建分页视图控件
    CGRect frame = CGRectMake(0, 50 + self.view.bounds.size.width / 2,
                              self.view.bounds.size.width, self.view.bounds.size.width / 2);
    
    QPageView *pageView = [QPageView q_pageViewWithFrame:frame
                                              imageNames:imageNameArr
                                              autoScroll:YES
                                          autoScrollTime:3.0
                                   pageIndicatorPosition:QPageIndicatorPositionCenter];
    
    [self.view addSubview:pageView];
}


#pragma mark QPaintBoardView

// 绘制简单画板
- (void)uiViewQPaintBoardViewDemo1 {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    undoButton.frame = CGRectMake(20, 280, 50, 30);
    [undoButton setTitle:@"撤销" forState:UIControlStateNormal];
    [undoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [undoButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [undoButton addTarget:self action:@selector(undoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:undoButton];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(100, 280, 50, 30);
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(180, 280, 50, 30);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    // 创建简单画板
    
    CGRect frame = CGRectMake(20, 50, self.view.bounds.size.width - 40, 200);
    
    QPaintBoardView *paintBoardView = [QPaintBoardView q_paintBoardViewWithFrame:frame];
    
    // 可选属性值设置
    paintBoardView.paintLineWidth = 5;                         // default is 1
    paintBoardView.paintLineColor = [UIColor redColor];        // default is blackColor
    paintBoardView.paintBoardColor = [UIColor cyanColor];      // default is whiteColor
    
    [self.view addSubview:paintBoardView];
    self.paintBoardView = paintBoardView;
}

- (void)undoButtonClick {
    
    // 撤销绘画结果
    [self.paintBoardView q_back];
}

- (void)clearButtonClick {
    
    // 清除绘画结果
    [self.paintBoardView q_clear];
}

- (void)saveButtonClick {
    
    // 获取绘画结果
    UIImage *image = [self.paintBoardView q_getPaintImage];
    
    if (image) {
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:@"/Users/JHQ0228/Desktop/Images/pic.png" atomically:YES];
    }
}

// 绘制画板
- (void)uiViewQPaintBoardViewDemo2 {
    
    // 创建画板
    QPaintBoardView *paintBoard = [QPaintBoardView q_paintBoardViewWithFrame:self.view.bounds
                                                                   lineWidth:0
                                                                   lineColor:nil
                                                                  boardColor:nil
                                                                 paintResult:^(UIImage * _Nullable image) {
                                                                     
         if (image) {
             NSData *data = UIImagePNGRepresentation(image);
             [data writeToFile:@"/Users/JHQ0228/Desktop/Images/pic.png" atomically:YES];
         }
     }];
    
    [self.view addSubview:paintBoard];
}


#pragma mark QTouchClipView

- (void)uiViewQTouchClipViewDemo {
    
    CGRect ivFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:ivFrame];
    imageView.image = [UIImage imageNamed:@"demo9.jpg"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    CGRect toolFrame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44);
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:toolFrame];
    UIBarButtonItem *clipButton = [[UIBarButtonItem alloc] initWithTitle:@"选择截屏"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(clipButtonClik)];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(clearButtonClik)];
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                       target:nil
                                       action:nil];
    toolBar.items = @[clipButton, flexibleButton, clearButton];
    [self.view addSubview:toolBar];
}

- (void)clearButtonClik {
    [self.touchClipView removeFromSuperview];
}

- (void)clipButtonClik {
    
    // 创建手势截屏视图
    QTouchClipView *touchClipView = [QTouchClipView q_touchClipViewWithView:self.imageView
                                                                 clipResult:^(UIImage * _Nullable image) {
                                                                     
        // 获取处理截屏结果
        if (image) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
    
    // 添加手势截屏视图
    [self.view addSubview:touchClipView];
    
    self.touchClipView = touchClipView;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    [[[UIAlertView alloc] initWithTitle:nil
                                message:@"截取成功，已存储到相册中"
                               delegate:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil] show];
}


#pragma mark QTouchLockView

- (void)uiViewQTouchLockViewDemo {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.view.bounds.size.height - 50, 50, 30);
    [button setTitle:@"清除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(qTouchLockClearButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, self.view.bounds.size.height - 50, 50, 30);
    [button1 setTitle:@"查看" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button1 addTarget:self action:@selector(qTouchLockCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    [self qTouchLockViewDemo];
}

- (void)qTouchLockClearButtonClick {
    
    // 清除密码
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df removeObjectForKey:@"touchLock"];
    [df synchronize];
    
    self.touchLockView.alertLabel.text = @"清除密码成功";
}

- (void)qTouchLockCheckButtonClick {
    
    // 查看密码
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *password = [df objectForKey:@"touchLock"];
    
    self.touchLockView.alertLabel.text = password;
}

- (void)qTouchLockViewDemo {
    
    // 初始化密码设置临时存放数组
    self.passWordArrM = [NSMutableArray arrayWithCapacity:2];
    
    // 设置 frame
    CGFloat margin = 50;
    CGFloat width = self.view.bounds.size.width - margin * 2;
    CGRect frame = CGRectMake(margin, 200, width, width);
    
    // 创建手势锁视图界面，获取滑动结果
    QTouchLockView *touchLockView = [QTouchLockView q_touchLockViewWithFrame:frame
                                                                  pathResult:^(BOOL isSucceed, NSString * _Nonnull result) {
    
        // 处理手势触摸结果
        [self dealTouchResult:result isSucceed:isSucceed];
    }];
    
    [self.view addSubview:touchLockView];
    self.touchLockView = touchLockView;
}

- (void)dealTouchResult:(NSString *)result isSucceed:(BOOL)isSucceed {
    
    // 处理手势触摸结果
    
    if (isSucceed) {
        
        // 判读密码是否存在
        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
        
        if ([df objectForKey:@"touchLock"] == nil) {
            
            // 设置手势锁
            
            [self.passWordArrM addObject:result];
            
            if (self.passWordArrM.count == 1) {
                self.touchLockView.alertLabel.text = @"请再设置一次";
            }
            
            if (self.passWordArrM.count == 2) {
                if ([self.passWordArrM[0] isEqualToString:self.passWordArrM[1]]) {
                    
                    // 存储密码
                    [df setValue:self.passWordArrM[0] forKey:@"touchLock"];
                    [df synchronize];
                    
                    self.touchLockView.alertLabel.text = @"手势密码设置成功";
                    
                } else {
                    
                    // 两次滑动结果不一致
                    [self.passWordArrM removeAllObjects];
                    
                    self.touchLockView.alertLabel.text = @"两次滑动的结果不一致，请重新设置";
                }
            }
            
        } else {
            
            // 解锁
            
            if ([result isEqualToString:[df objectForKey:@"touchLock"] ]) {
                self.touchLockView.alertLabel.text = @"解锁成功";
            } else {
                self.touchLockView.alertLabel.text = @"密码不正确，请重试";
            }
        }
        
    } else {
        
        // 滑动点数过少
        self.touchLockView.alertLabel.text = result;
    }
}

#pragma mark QMarqueeView

- (void)uiViewQMarqueeViewDemo {
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    [self qMarqueeViewDemo1];
    [self qMarqueeViewDemo2];
    [self qMarqueeViewDemo3];
    [self qMarqueeViewDemo4];
    [self qMarqueeViewDemo5];
    [self qMarqueeViewDemo6];
    
    [self qMarqueeViewDemo7];
}

- (void)qMarqueeViewDemo1 {
    
    // 设置显示的内容
    NSArray *showList = @[@"1. Hello World",
                          @"2. 欢迎大家关注哦！",
                          @"3. GitHub：QianChia",
                          @"4. 新浪微博：QianChia0123",
                          @"5. 个人博客：cnblogs.com/QianChia"];
    
    // 创建滚动视图
    CGRect frame = CGRectMake(0, 50, self.view.bounds.size.width, 30);
    QMarqueeView *marqueeView = [[QMarqueeView alloc] initWithFrame:frame];
    
    
    // 设置代理，响应滚动视图点击
    marqueeView.delegate = self;
    
    // 设置显示的内容
    marqueeView.contentTexts = showList;
    marqueeView.contentTextColor = [UIColor whiteColor];
    marqueeView.contentTextFont = [UIFont boldSystemFontOfSize:18];
    
    // 设置动画时间
    marqueeView.animationDuration = 0.2;
    
    // 设置动画方向
    marqueeView.animationDirection = QMarqueeViewDirectionUp;
    
    marqueeView.backgroundColor = [UIColor colorWithRed:102/255.0f green:133/255.0f blue:253/255.0f alpha:1];
    [self.view addSubview:marqueeView];
    
    // 开始滚动
    [marqueeView q_startAnimation];
}

- (void)qMarqueeViewDemo2 {
    
    // 设置显示的内容
    NSArray *showList = @[@"1. Hello World",
                          @"2. 欢迎大家关注哦！",
                          @"3. GitHub：QianChia",
                          @"4. 新浪微博：QianChia0123",
                          @"5. 个人博客：cnblogs.com/QianChia"];
    
    // 创建滚动视图
    CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, 30);
    QMarqueeView *marqueeView = [[QMarqueeView alloc] initWithFrame:frame];
    
    // 设置代理，响应滚动视图点击
    marqueeView.delegate = self;
    
    // 设置显示的内容
    marqueeView.contentTexts = showList;
    marqueeView.contentTextColor = [UIColor whiteColor];
    marqueeView.contentTextFont = [UIFont boldSystemFontOfSize:18];
    
    // 设置动画时间
    marqueeView.animationDuration = 0.5;
    
    // 设置显示的内容对齐方式
    marqueeView.contentTextAlign = NSTextAlignmentCenter;
    
    // 设置动画方向
    marqueeView.animationDirection = QMarqueeViewDirectionUp;
    
    marqueeView.backgroundColor = [UIColor colorWithRed:102/255.0f green:133/255.0f blue:253/255.0f alpha:1];
    [self.view addSubview:marqueeView];
    
    // 开始滚动
    [marqueeView q_startAnimation];
}

- (void)qMarqueeViewDemo3 {
    
    // 设置显示的内容
    NSArray *showList = @[@"Hello World"];
    
    // 创建滚动视图
    CGRect frame = CGRectMake(30, 150, self.view.bounds.size.width - 150, 30);
    QMarqueeView *marqueeView = [[QMarqueeView alloc] initWithFrame:frame];
    
    // 设置显示的内容
    marqueeView.contentTexts = showList;
    marqueeView.contentImage = [UIImage imageNamed:@"waring2"];
    
    // 设置动画时间，0 不滚动
    marqueeView.animationDuration = 0;
    
    marqueeView.layer.cornerRadius = 15;
    marqueeView.layer.masksToBounds = YES;
    marqueeView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:marqueeView];
    
    // 开始滚动
    [marqueeView q_startAnimation];
}

- (void)qMarqueeViewDemo4 {
    
    // 设置显示的内容
    NSArray *showList = @[@"GitHub：QianChia"];
    
    // 创建滚动视图
    CGRect frame = CGRectMake(30, 200, self.view.bounds.size.width - 150, 30);
    QMarqueeView *marqueeView = [[QMarqueeView alloc] initWithFrame:frame];
    
    // 设置显示的内容
    marqueeView.contentTexts = showList;
    marqueeView.contentImage = [UIImage imageNamed:@"waring2"];
    
    // 设置动画时间
    marqueeView.animationDuration = 0.5;
    
    marqueeView.layer.cornerRadius = 15;
    marqueeView.layer.masksToBounds = YES;
    marqueeView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:marqueeView];
    
    // 开始滚动
    [marqueeView q_startAnimation];
}

- (void)qMarqueeViewDemo5 {
    
    // 设置显示的内容
    NSArray *showList = @[@"新浪微博：QianChia0123"];
    
    // 创建滚动视图，开始滚动
    CGRect frame = CGRectMake(30, 250, self.view.bounds.size.width - 100, 30);
    QMarqueeView *marqueeView = [QMarqueeView q_marqueeViewWithFrame:frame
                                                               texts:showList
                                                               color:[UIColor whiteColor]
                                                                font:nil
                                                               image:[UIImage imageNamed:@"waring1"]
                                                            duration:1.0
                                                           direction:QMarqueeViewDirectionDown
                                                               align:NSTextAlignmentCenter
                                                              target:self];
    
    marqueeView.layer.cornerRadius = 15;
    marqueeView.layer.masksToBounds = YES;
    marqueeView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:marqueeView];
}

- (void)qMarqueeViewDemo6 {
    
    // 设置显示的内容
    NSArray *showList = @[@"个人博客：cnblogs.com/QianChia"];
    
    // 创建滚动视图，开始滚动
    CGRect frame = CGRectMake(30, 300, self.view.bounds.size.width - 60, 30);
    QMarqueeView *marqueeView = [QMarqueeView q_marqueeViewWithFrame:frame
                                                               texts:showList
                                                               color:[UIColor whiteColor]
                                                                font:nil
                                                               image:[UIImage imageNamed:@"waring1"]
                                                            duration:0.5
                                                           direction:QMarqueeViewDirectionUp
                                                               align:NSTextAlignmentLeft
                                                              target:self];
    
    marqueeView.layer.cornerRadius = 15;
    marqueeView.layer.masksToBounds = YES;
    marqueeView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:marqueeView];
}

- (void)qMarqueeViewDemo7 {
    
    // 设置显示的内容
//    NSArray *showList = @[@"1. Hello World",
//                          @"2. 欢迎大家关注哦！",
//                          @"3. GitHub：QianChia",
//                          @"4. 新浪微博：QianChia0123",
//                          @"5. 个人博客：cnblogs.com/QianChia"];
    
    NSArray *showList = @[@"1. Hello World",
                          @"2. 欢迎大家关注哦！"];
    
//    NSArray *showList = @[@"1. Hello World"];
    
    // 创建滚动视图
    CGRect frame = CGRectMake(0, 350, self.view.bounds.size.width, 30);
    QMarqueeView *marqueeView = [[QMarqueeView alloc] initWithFrame:frame];
    
    
    // 设置代理，响应滚动视图点击
    marqueeView.delegate = self;
    
    // 设置显示的内容
    marqueeView.contentTexts = showList;
    marqueeView.contentTextColor = [UIColor whiteColor];
    marqueeView.contentTextFont = [UIFont boldSystemFontOfSize:18];
    
    // 设置动画时间
    marqueeView.animationDuration = 5.0;
    
    // 设置动画方向
    marqueeView.animationDirection = QMarqueeViewDirectionLeft;
    
    marqueeView.backgroundColor = [UIColor colorWithRed:102/255.0f green:133/255.0f blue:253/255.0f alpha:1];
    [self.view addSubview:marqueeView];
    
    // 开始滚动
    [marqueeView q_startAnimation];
}





















/// 跑马灯内容点击协议方法
- (void)didClickContentAtIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
}


#pragma mark - UIViewController+QExtension

#pragma mark QQRCode

- (void)uiViewControllerQQRCodeDemo {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, self.view.bounds.size.height - 50, 100, 30);
    [button setTitle:@"二维码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(qQRCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)qQRCodeButtonClick {
    
    // 创建二维码扫描视图控制器
    QQRCode *qrCode = [QQRCode q_qrCodeWithResult:^(BOOL isSucceed, NSString *result) {
        
        if (isSucceed) {
            
            [[[UIAlertView alloc] initWithTitle:@"Succeed"
                                        message:result
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
            
        } else {
            
            [[[UIAlertView alloc] initWithTitle:@"Failed"
                                        message:result
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
        }
    }];
    
    // 设置我的二维码信息
    qrCode.myQRCodeInfo = @"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X";
    qrCode.headIcon = [UIImage imageNamed:@"demo6"];
    
    // 打开扫描视图控制器
    [self presentViewController:qrCode animated:YES completion:nil];
}


#pragma mark - UILabel+QExtension

#pragma mark QCountingLabel

- (void)qCountingLabelDemo1 {
    
    [self.countingLabel removeFromSuperview];
    
    // 创建 QCountingLabel 对象
    self.countingLabel = [[QCountingLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 120)];
    [self.view addSubview:self.countingLabel];
    
    // 常规设置，QCountingLabel 继承 UILabel, 设置和 UILabel 一样
    self.countingLabel.center = self.view.center;
    self.countingLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.countingLabel.font = [UIFont systemFontOfSize:50];
    self.countingLabel.textColor = [UIColor redColor];
    self.countingLabel.textAlignment = NSTextAlignmentCenter;
    
//    [self countingLabelDemo1];
//    [self countingLabelDemo2];
//    [self countingLabelDemo3];
    [self countingLabelDemo4];
}

- (void)countingLabelDemo1 {
    
    // 设置文本样式
    self.countingLabel.format = @"%d";
    
    // 设置变化范围及动画时间
    [self.countingLabel q_countFromValue:10 toValue:1000 withDuration:1.0f];
}

- (void)countingLabelDemo2 {
    
    // 设置文本样式，使用 block 可以根据不同的值设置多种不同的样式
    self.countingLabel.formatBlock = ^NSString *(CGFloat value) {
        
        NSInteger years = value / 12;
        NSInteger months = (NSInteger)value % 12;
        
        if (years == 0) {
            
            return [NSString stringWithFormat: @"%ld 个月", (long)months];
            
        } else {
            
            return [NSString stringWithFormat: @"%ld 年, %ld 个月", (long)years, (long)months];
        }
    };
    
    // 设置文本变化方式，默认为 EaseInOut
    self.countingLabel.method = QCountingMethodLinear;
    
    // 设置变化范围及动画时间
    [self.countingLabel q_countFromValue:0 toValue:50 withDuration:15.0f];
    
    // 设置变化完成时的回调
    self.countingLabel.completionBlock = ^void () {
        
        NSLog(@"completion");
    };
}

- (void)countingLabelDemo3 {
    
    // 设置文本样式
    self.countingLabel.format = @"%.2f";
    
    // 设置变化范围及动画时间
    [self.countingLabel q_countFromValue:0 toValue:3198.23 withDuration:1.0f];
}

- (void)countingLabelDemo4 {
    
    // 设置文本样式
    self.countingLabel.format = @"%.2f";
    
    // 设置分隔符样式
    self.countingLabel.positiveFormat = @"###,###.##";
    
    // 设置变化范围及动画时间
    [self.countingLabel q_countFromValue:0 toValue:3048.64 withDuration:1.0f];
}

- (void)qCountingLabelDemo2 {
    
    [self.countingLabel removeFromSuperview];
    
    // 创建 QCountingLabel 对象
    self.countingLabel = [QCountingLabel q_countingLabelWithFrame:CGRectMake(50, 100, 300, 100)
                                                           format:@"%f"
                                                   positiveFormat:@"###,###.##"
                                                           method:QCountingMethodEaseOut
                                                        fromValue:20
                                                          toValue:3048.64
                                                     withDuration:10.0f 
                                                       completion:^{
        
        NSLog(@"completion");
    }];
    
    [self.view addSubview:self.countingLabel];
    
    // 常规设置
    self.countingLabel.center = self.view.center;
    self.countingLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.countingLabel.font = [UIFont systemFontOfSize:50];
    self.countingLabel.textColor = [UIColor redColor];
    self.countingLabel.textAlignment = NSTextAlignmentCenter;
}



@end

