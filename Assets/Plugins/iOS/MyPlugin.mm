#import <Foundation/Foundation.h>

@interface MyPlugin : NSObject
{
    NSDate *creationDate;
}
@end

@implementation MyPlugin

static MyPlugin * _sharedInstance;

+(MyPlugin*) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"Create MyPlugin Sharded instance");
        _sharedInstance = [[MyPlugin alloc] init];
    });
    return _sharedInstance;
}

-(id)init
{
    self = [super init];
    if(self)
        [self initHelper];
    return self;
}

-(void)initHelper
{
    NSLog(@"InitHelper called");
    creationDate = [NSDate date];
}

-(double)getElapsedTime
{
    return [[NSDate date] timeIntervalSinceDate:creationDate];
}
@end


extern "C"
{
    double IOSgetElapsetTime()
    {
        return [[MyPlugin sharedInstance] getElapsedTime];
    }
}

