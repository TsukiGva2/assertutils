#ifndef __MYTEMPO_CERROR_H__
#define __MYTEMPO_CERROR_H__

#ifdef __cplusplus
extern "C" {
#endif

#include "config/config.h"

void log_ok(const char* msg, const char* fn, const char* file, int line);
void log_status(const char* msg, const char* fn, const char* file, int line);

#ifndef __RELEASE__
void log_err(const char* msg, const char* fn, const char* file, int line);
void log_warn(const char* msg, const char* fn, const char* file, int line);

void log_errf(const char* fn, const char* file, int line, const char* msg, ...);
#endif

void log_warnf(const char* fn, const char* file, int line, const char* msg, ...);

#ifndef __RELEASE__
#define ERR(msg) log_err(msg, __func__, __FILE__, __LINE__)
#define WARN(msg) log_warn(msg, __func__, __FILE__, __LINE__)

#define NICE(msg) log_ok(msg, __func__, __FILE__, __LINE__)
#define INFO(msg) log_status(msg, __func__, __FILE__, __LINE__)

#define ERRF(msg, ...) log_errf(__func__, __FILE__, __LINE__, msg, __VA_ARGS__)
#define WARNF(msg, ...) log_warnf(__func__, __FILE__, __LINE__, msg, __VA_ARGS__)
#else
#define ERR(msg) do{}while(0)
#define WARN(msg) do{}while(0)

#define NICE(msg) log_ok(msg, __func__, "?", -1)
#define INFO(msg) log_status(msg, __func__, "?", -1)

#define ERRF(fmt) do{}while(0)
#define WARNF(fmt) do{}while(0)
#endif


#ifdef __cplusplus
}
#endif

#endif

