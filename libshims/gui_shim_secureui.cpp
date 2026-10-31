/*
 * SPDX-FileCopyrightText: 2026 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <gui/SurfaceComposerClient.h>

namespace android {

// libsecureuisvc_jni.so was built when createSurface took LayerMetadata by value. A free function
// with the object as its first argument has the member function's calling convention.
sp<SurfaceControl> SurfaceComposerClient_createSurface_metadataByValue(
        SurfaceComposerClient* thiz, const String8& name, uint32_t w, uint32_t h, PixelFormat format,
        int32_t flags, const sp<IBinder>& parentHandle, gui::LayerMetadata metadata,
        uint32_t* outTransformHint)
        __asm__("_ZN7android21SurfaceComposerClient13createSurfaceERKNS_7String8EjjiiRKNS_2spINS_7IBinderEEENS_3gui13LayerMetadataEPj");

sp<SurfaceControl> SurfaceComposerClient_createSurface_metadataByValue(
        SurfaceComposerClient* thiz, const String8& name, uint32_t w, uint32_t h, PixelFormat format,
        int32_t flags, const sp<IBinder>& parentHandle, gui::LayerMetadata metadata,
        uint32_t* outTransformHint) {
    return thiz->createSurface(name, w, h, format, flags, parentHandle, metadata, outTransformHint);
}

}  // namespace android
