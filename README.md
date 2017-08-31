# XAURLComponents
在低版本可以直接使用NSURLComponents的所有高版本属性和方法


NSURLComponents的一些属性在高版本才可以使用，例如：

@property (nullable, readonly, copy) NSString *string NS_AVAILABLE(10_10, 8_0);

@property (readonly) NSRange rangeOfScheme NS_AVAILABLE(10_11, 9_0);

@property (nullable, copy) NSArray\<NSURLQueryItem \*\> \*queryItems NS_AVAILABLE(10_10, 8_0);

等等。这些属性在较低版本中是无法使用的，此库可以在低版本中也能使用这些属性。

###使用方法:直接拷贝导入

直接将XAURLComponents文件下的NSURLComponents+XAMatch.h/.m，XAURLQueryItem.h/.m拷贝到工程中即可，无需改动代码。