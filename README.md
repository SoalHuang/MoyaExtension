# MoyaExtension
### 使用库
* [Moya](https://github.com/SoalHuang/Moya.git)
* [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper.git)
* [PTFoundation](http://code.putao.io/ios_client/PTFoundation.git)

### 功能
* 按外部传入的结构更进一层解析 HTTP Body.
* 如果出错, 将标签信息打包在错误信息内, 实现自动解析 Body Data 和 自动标记错误信息.

### 使用的数据结构
```swift
public struct ResponseBox<Value> {
    
    /// 返回的原始数据
    public let response: Moya.Response
    
    /// 已经解析的数据
    public let value: Value
}
```

### 拓展标签协议
```swift
public protocol TagedTargetType: Moya.TargetType {
    
    var named: String? { get }
    var tag: Int? { get }
}
```

### MoyaProviderType 拓展方法
```swift
extension MoyaProviderType where Target : Moya.TargetType {
    
    func request<T: Mappable>(_ target: Target,
                              mapType: T.Type,
                              progress: Moya.ProgressBlock? = .none,
                              callbackQueue: DispatchQueue = .main,
                              completion: @escaping (Result<ResponseBox<T>, MoyaError>) -> Void) -> Moya.Cancellable {
        ...
    }
}

extension MoyaProviderType where Target : TagedTargetType {
    
    func request<T: Mappable>(_ target: Target,
                              mapType: T.Type,
                              progress: Moya.ProgressBlock? = .none,
                              callbackQueue: DispatchQueue = .main,
                              completion: @escaping (Result<ResponseBox<T>, MoyaError>) -> Void) -> Moya.Cancellable {
        ...
    }
}

```