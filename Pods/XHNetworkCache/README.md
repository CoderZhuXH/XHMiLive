# XHNetworkCache
#### 一行代码将请求数据写入磁盘缓存-支持CocoaPods<br>
#### Swift版本请戳这里>>> https://github.com/CoderZhuXH/XHNetworkCacheSwift

###技术交流群(群号:537476189)

### 更新记录:
*    2016.09.04 -- v1.2.3 -->增加+(NSString *)cacheSizeFormat方法
*    2016.08.29 -- v1.2.2 -->优化<br>
*    2016.08.12 -- v1.2.1 -->增加获取缓存路径接口<br>
*    2016.07.06 -- v1.2   -->增加异步写入/更新缓存接口<br>
*    2016.07.01 -- v1.1   -->1.增加手动清除缓存接口;2.增加获取缓存大小接口<br>
*    2016.06.24 -- v1.0

## 使用方法:
### 1.(同步)写入/更新
```objc
//将数据(同步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL)
//[按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
  BOOL result = [XHNetworkCache saveJsonResponseToCacheFile:responseObject andURL:URLString];
  if(result)
  {
        NSLog(@"(同步)写入/更新缓存数据 成功");
  }
  else
  {
        NSLog(@"(同步)写入/更新缓存数据 失败");
  }

```
### 2.(异步)写入/更新
```objc
//将数据(异步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL)
//[按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
[XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject andURL:URLString completed:^(BOOL result) {
        
if(result)
{
    NSLog(@"(异步)写入/更新缓存数据 成功");
}
else
{
    NSLog(@"(异步)写入/更新缓存数据 失败");
}
        
}];

```
### 3.获取缓存数据
```objc
//获取缓存数据(参数:请求URL,返回:JSON数据)
id JsonCache = [XHNetworkCache cacheJsonWithURL:URLString];

```
### 4.获取缓存路径
```objc
//获取缓存路径
 NSString *path = [XHNetworkCache cachePath];

 ```
### 5.清除缓存
```objc
//清除缓存
[XHNetworkCache clearCache];

```

### 6.获取缓存总大小(M)
```objc
//获取缓存大小(M)
float cacheSize = [XHNetworkCache cacheSize];
//或者(以..kb/..M)形式获取
NSString *cacheSizeFormat = [XHNetworkCache cacheSizeFormat];
```
##  安装
### 1.手动添加:<br>
*   1.将 XHNetworkCache 文件夹添加到工程目录中<br>
*   2.导入 XHNetworkCache.h

### 2.CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'XHNetworkCache'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 XHNetworkCache.h

### 3.Tips
* 1.如果发现pod search XHNetworkCache 搜索出来的不是最新版本，需要在终端执行cd ~/desktop退回到desktop，然后执行pod setup命令更新本地spec缓存（需要几分钟），然后再搜索就可以了
* 2.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install

##  系统要求
*   该项目最低支持 iOS 7.0 和 Xcode 7.0

##  许可证
    XHNetworkCache 使用 MIT 许可证，详情见 LICENSE 文件