@import Darwin;
@import Foundation;
@import MachO;

#import <mach-o/fixup-chains.h>
#import "vm_unaligned_copy_switch_race.h"
#import "overwriter.h"
#import "troller.h"
#import "fun/thanks_opa334dev_htrowii.h"
#include "util.h"
#import "fun/vnode.h"

NSString* getLunchd(void) {
    return jbroot(@"lunchd");
}

bool overwrite_patchedlaunchd_kfd(void) {
    // ayo whats this – bomberfish
//    SwitchSysBin(getVnodeAtPathByChdir("/System/Library/CoreServices/SpringBoard.app"), "SpringBoard", "/var/jb/SprangBoard");
    printf("[i] performing launchd hax\n");
    SwitchSysBin(getVnodeAtPathByChdir("/sbin"), "launchd", getLunchd().UTF8String);
    printf("[i] launchd haxed\n");
    return true;
}
