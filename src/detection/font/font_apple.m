#include "common/font.h"
#include "common/io/io.h"
#include "font.h"

#import <AppKit/NSFont.h>

static void generateString(FFFontResult* font)
{
    if(font->fonts[0].length > 0)
    {
        ffStrbufAppend(&font->display, &font->fonts[0]);
        ffStrbufAppendS(&font->display, " [System]");
        if(font->fonts[1].length > 0)
            ffStrbufAppendS(&font->display, ", ");
    }

    if(font->fonts[1].length > 0)
    {
        ffStrbufAppend(&font->display, &font->fonts[1]);
        ffStrbufAppendS(&font->display, " [User]");
    }
}

void ffDetectFontImpl(const FFinstance* instance, FFFontResult* result)
{
    FF_UNUSED(instance);
    ffStrbufAppendS(&result->fonts[0], [NSFont systemFontOfSize:12].familyName.UTF8String);
    ffStrbufAppendS(&result->fonts[1], [NSFont userFontOfSize:12].familyName.UTF8String);
    ffStrbufAppendS(&result->fonts[2], [NSFont monospacedSystemFontOfSize:12 weight:400].familyName.UTF8String);
    ffStrbufAppendS(&result->fonts[3], [NSFont userFixedPitchFontOfSize:12].familyName.UTF8String);
    generateString(result);
}
