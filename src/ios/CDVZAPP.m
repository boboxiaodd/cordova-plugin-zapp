#import <Cordova/CDV.h>
#import "CDVZAPP.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation CDVZAPP
- (void)zlog:(CDVInvokedUrlCommand*)command
{
    NSDictionary *options = [command.arguments objectAtIndex: 0];
    NSString * url = [options valueForKey:@"url"];
    [[AlipaySDK defaultService] payOrder:url fromScheme:[self settingForKey:@"url_scheme"] callback:^(NSDictionary *resultDic) {
        [self send_event:command withMessage:resultDic Alive:NO State:YES];
    }];
}

- (id)settingForKey:(NSString*)key
{
    return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
}

- (void)send_event:(CDVInvokedUrlCommand *)command withMessage:(NSDictionary *)message Alive:(BOOL)alive State:(BOOL)state{
    if(!command) return;
    CDVPluginResult* res = [CDVPluginResult resultWithStatus: (state ? CDVCommandStatus_OK : CDVCommandStatus_ERROR) messageAsDictionary:message];
    if(alive) [res setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult: res callbackId: command.callbackId];
}

@end
